class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @score = 0;
    if @collection.scores()[1]
      @score = @collection.scores()[0] + "/" + @collection.scores()[1]
    else
      @score = @collection.scores()[0]
    @collection.on 'add change', =>
      if @collection.scores()[1]
        console.log "ace exists"
        if @collection.scores()[1] > 21
          @score = @collection.scores()[0]
        else
          @score = @collection.scores()[0].toString() + "/" + @collection.scores()[1].toString()
      else
        console.log "ace does not exist"
        @score = @collection.scores()[0]

      @render()

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    ##@$('.score').text @collection.scores()[0]
    @$('.score').text @score


