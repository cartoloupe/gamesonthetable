# This code creates the moves controller, which is used in game.html.erb
movesApp.controller 'MovesController', [
  'MoveResource'
  '$scope'
  'dispatcher'
  (MoveResource, $scope, dispatcher) ->
    $scope.circle_cx = 50;
    $scope.circle_cy = 50;

    dispatcher.bind 'moves', 'reddot', (coordinate) ->
      console.log 'moves reddot from game.coffee:'
      console.log [coordinate.cx, coordinate.cy]
      $scope.circle_cx = coordinate.cx
      $scope.circle_cy = coordinate.cy
      return

    # Get all of the moves from the server. Just a regular http get.
    MoveResource.all (moves) ->
      #console.log("success");
      $scope.moves = moves
      return

    MoveResource.onCreate (move) ->
      #console.log(move);
      $scope.moves.push move
      return

    $scope.newMove = new MoveResource

    $scope.saveMove = ->
      #console.log('click saveMove');
      $scope.newMove.save (move) ->
        #console.log(move);
        # $scope.moves.push(move);
        $scope.newMove = new MoveResource
        return
      return

    $scope.destroyMove = ->
      #console.log('click destroyMove');
      $scope.newMove.destroy()
      return

    $scope.svg_style = "";

    $('svg').draggable
      stop: ->
        svg = $('svg')
        circle = $('svg circle')
        style = svg.attr('style')
        dispatcher.trigger 'moves.moving', (cx: 150, cy: 150)
        return

    $('.another-move').on 'click', (d, i) ->
      a = $('.another-move').text()
      delta = parseInt(a)
      submitMove parseInt(a)
      circle = $('svg circle')
      circle_cx = parseInt(circle.attr('cx'))
      circle_cy = parseInt(circle.attr('cy'))
      new_circle_cx = circle_cx + delta
      new_circle_cy = circle_cy
      circle.attr 'cx', new_circle_cx
      circle.attr 'cy', new_circle_cy
      circle.remove()
      $('svg').append circle
      dispatcher.trigger 'moves.moving', (cx: new_circle_cx, cy: new_circle_cy)
      $scope.circle_cx = new_circle_cx;
      $scope.circle_cy = new_circle_cy;
      return

    width = 300
    height = 300
    radius = 20

#    update = (data) ->
#      d3.select('.blackdot')
#        .data(data)
#        .enter().append('circle')
#          .attr('r', radius)
#          .attr('cx', (d) -> d.cx)
#          .attr('cy', (d) -> d.cy)
#      return

    dragmove = (d) ->
      console.log 'drag it'
      d3.select(this)
        .attr('cx', d.x = Math.max(radius, Math.min(width - radius, d3.event.x)))
        .attr('cy', d.y = Math.max(radius, Math.min(height - radius, d3.event.y)))
      return

#    dragEnd = (d) ->
#      console.log 'this is: '
#      console.log this
#      cx = d3.select(this).attr('cx')
#      cy = d3.select(this).attr('cy')
#      dispatcher.trigger 'moves.moving', (cx: cx, cy: cy)
#      return

    drag = d3.behavior.drag().origin((d) -> d)
      .on('drag', dragmove)
      #.on('dragend', dragEnd)


    svg = d3.select('body .dotsection').append('div')
      .selectAll('svg').data([{x: 250, y: 250}])
      .enter().append('svg')
        .attr('class', 'blackdot')
        .attr('width', width)
        .attr('height', height)
        .style('border', '10px')
        .style('border-style', 'solid')

    svg.append('circle')
      .attr('r', radius)
      .attr('cx', (d) -> d.x)
      .attr('cy', (d) -> d.y)
      .call(drag)



    return
]

submitMove = (value) ->
  $.post '/moves', move: number_of_moves: value
  return

movesList = (message) ->
  return


$(document).ready ->

  $('#submit-move').on 'click', ->
    submitMove $('#new-move').val()
    return

  return

