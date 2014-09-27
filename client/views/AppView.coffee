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
    dealer = @model.get 'dealerHand'
    dealer.models[0].flip()
    ##while(dealercardScore > 17)
    dealer.hit() while dealer.scores()[0] < 17 if dealerShouldPlay
    # dealerShouldPlay ?
    #   while dealer.scores()[0] < 17
    #     console.log "dealershouldPlay loop"
    #     dealer.hit()


    @calcWinner()

  initialize: ->
    player = @model.get 'playerHand'
    dealer = @model.get 'dealerHand'
    that = @
    player.on 'add', ->
      that.playerStand(false) if player.scores()[0] > 21
      ##@calcWinner() if player.scores()[0] > 21
    @render()

  calcWinner: ->
    console.log "CalcWinner getting called"
    player = @model.get 'playerHand'
    dealer = @model.get 'dealerHand'
    console.log player.scores()[0]
    console.log dealer.scores()[0]
    @$('.gameText').html "You win!!!!!" if player.scores()[0] > dealer.scores()[0] and player.scores()[0] <= 21 or dealer.scores()[0] > 21
    @$('.gameText').html "Quit Gambling" if dealer.scores()[0] > player.scores()[0] and dealer.scores()[0] <= 21 or player.scores()[0] > 21
    @$('.gameText').html "Pushed" if dealer.scores()[0] == player.scores()[0]

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
