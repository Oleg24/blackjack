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
    ##on ('revealHand', ->
      ##console.log "hello dealer"
    @render()

  render: ->
    console.log "render is called"
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
