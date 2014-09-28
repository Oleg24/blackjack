class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="redeal-button">Redeal</button>
    <span class="gameText"></span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>

  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @playerStand(true)
    "click .redeal-button": -> @model.get('dealerHand').revealHand()

  playerStand: (dealerShouldPlay) ->
    player = @model.get 'playerHand'
    dealer = @model.get 'dealerHand'
    dealer.models[0].flip()
    ##while(dealercardScore > 17)
    if dealer.scores()[1]
      dealer.hit() while dealer.scores()[1] < 17 if dealerShouldPlay
      dealer.hit() while dealer.scores()[0] < 17 and dealer.scores()[1] > 21 if dealerShouldPlay
    else
      dealer.hit() while dealer.scores()[0] < 17 if dealerShouldPlay


    @calcWinner()

  initialize: ->
    @render()
    player = @model.get 'playerHand'
    dealer = @model.get 'dealerHand'
    that = @
    @$('.gameText').html "Blackjack!" if player.scores()[1] == 21
    player.on 'add', ->
      that.playerStand(false) if player.scores()[0] > 21
      ##@calcWinner() if player.scores()[0] > 21

  calcWinner: ->
    player = @model.get 'playerHand'
    dealer = @model.get 'dealerHand'
    console.log "CalcWinner getting called"
    playerScore = player.scores()[0]
    dealerScore = dealer.scores()[0]

    if player.scores()[1] and player.scores()[1] <= 21
       playerScore = player.scores()[1]

    if dealer.scores()[1] and dealer.scores()[1] <= 21
       dealerScore = dealer.scores()[1]

    console.log playerScore
    console.log dealerScore
    @$('.gameText').html "You win!!!!!" if playerScore > dealerScore and playerScore <= 21 or dealerScore > 21
    @$('.gameText').html "Quit Gambling" if dealerScore > playerScore and dealerScore <= 21 or playerScore > 21
    @$('.gameText').html "Pushed" if dealerScore == playerScore

  render: ->
    console.log "AppView is rendering"
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
