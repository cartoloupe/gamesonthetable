# This code creates the moves controller, which is used in game.html.erb
movesApp.controller 'MovesController', [
  'MoveResource'
  '$scope'
  'dispatcher'
  (MoveResource, $scope, dispatcher) ->
    $scope.circle_cx = 50;
    $scope.circle_cy = 50;

    width = 300
    height = 300
    radius = 20

    svg = d3.select('body .dotsection').append('div')
        .attr('class', 'blacksection')
        .append('svg')
        .attr('width', width)
        .attr('height', height)
        .style('border', '10px')
        .style('border-style', 'solid')

    updatedot = (data) ->
      console.log 'updatedot: '
      console.log data
      dots = d3.select('.blacksection svg').selectAll('circle')
        .data(data, ((d) -> 1000 * d.cx + d.cy ))

      dots.attr('class', 'blackdot')
        .call(drag)
        .transition()
          .duration(1000)
        .attr('r', radius)
        .attr('cx', (d) -> d.cx)
        .attr('cy', (d) -> d.cy)

      dots.enter().append('circle')
          .attr('class', 'blackdot')
          .attr('r', 0)
          .call(drag)
          .transition()
            .duration(1000)
            .attr('cx', (d) -> d.cx)
            .attr('cy', (d) -> d.cy)
            .attr('r', radius)

      dots.exit()
          .transition()
            .duration(1000)
            .attr('r', 0)
          .remove()
      return

    dispatcher.bind 'moves', 'reddot', (coordinates) ->
      $scope.circle_cx = coordinates[0].cx
      $scope.circle_cy = coordinates[0].cy
      updatedot(coordinates)
      return

    # Get all of the moves from the server. Just a regular http get.
    MoveResource.all (moves) ->
      $scope.moves = moves
      return

    MoveResource.onCreate (move) ->
      $scope.moves.push move
      return

    $scope.newMove = new MoveResource

    $scope.saveMove = ->
      $scope.newMove.save (move) ->
        # $scope.moves.push(move);
        $scope.newMove = new MoveResource
        return
      return

    $scope.destroyMove = ->
      $scope.newMove.destroy()
      return

    dragmove = (d) ->
      d3.select(this)
        .attr('cx', d.x = Math.max(radius, Math.min(width - radius, d3.event.x)))
        .attr('cy', d.y = Math.max(radius, Math.min(height - radius, d3.event.y)))

      return

    dragEnd = (d) ->
      cx = d3.select(this).attr('cx')
      cy = d3.select(this).attr('cy')
      $scope.circleData.push({cx: cx, cy: cy})
      if ($scope.circleData.length > 5)
        $scope.circleData.shift()

      dispatcher.trigger 'moves.moving', $scope.circleData
      return

    drag = d3.behavior.drag()
      .on('drag', dragmove)
      .on('dragend', dragEnd)

    $scope.circleData = [ {cx: 150, cy: 150}, {cx: 250, cy: 250}, {cx: 30, cy: 10} ]
    updatedot($scope.circleData)

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

