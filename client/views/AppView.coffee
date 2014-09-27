class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button><button class="redeal-button">Redeal</button>

    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>

  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .redeal-button": -> @model.get('dealerHand').revealHand()

  initialize: ->
    player = @model.get 'playerHand'
    dealer = @model.get 'dealerHand'
    console.log dealer
    player.on 'add', ->
      console.log player.scores()
      ##x = player.scores()[0]
      dealer.models[0].flip() if player.scores()[0] > 21
    ##on ('revealHand', ->
      ##console.log "hello dealer"
    @render()



  render: ->
    console.log "render is called"
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
