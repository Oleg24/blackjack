class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png"/>'

  initialize: ->
    @model.on 'change', => @render

    @render()

  render: ->
    @$el.children().detach().end().html
    console.log @model.get 'revealed'
    @$el.html @template @model.attributes if @model.get 'revealed'
    @$el.addClass 'covered' unless @model.get 'revealed'
