# This code creates the moves controller, which is used in game.html.erb
movesApp.controller 'MovesController', [
  'MoveResource'
  '$scope'
  'dispatcher'
  (MoveResource, $scope, dispatcher) ->
    $scope.circle_cx = 50;
    $scope.circle_cy = 50;

    updatedot = (data) ->
      console.log ['updatedot: ', data]
      dots = d3.select('.blacksection svg').selectAll('circle .blackdot')
        .data(data, (d) ->
          d
        )

      dots
        .enter()
        .append('circle')
          .attr('class', 'blackdot')
          .attr('r', radius)
          .attr('cx', (d) -> d.cx)
          .attr('cy', (d) -> d.cy)
          .call(drag)

      dots.exit().remove()
      return

    dispatcher.bind 'moves', 'reddot', (coordinate) ->
      $scope.circle_cx = coordinate.cx
      $scope.circle_cy = coordinate.cy
      updatedot([coordinate, {cx: 10, cy: 20}])
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

    width = 300
    height = 300
    radius = 20

    dragmove = (d) ->
      d3.select(this)
        .attr('cx', d.x = Math.max(radius, Math.min(width - radius, d3.event.x)))
        .attr('cy', d.y = Math.max(radius, Math.min(height - radius, d3.event.y)))
      return

    dragEnd = (d) ->
      cx = d3.select(this).attr('cx')
      cy = d3.select(this).attr('cy')
      console.log ['triggerring to moves.moving: ', cx, cy]
      dispatcher.trigger 'moves.moving', (cx: cx, cy: cy)
      return

    drag = d3.behavior.drag()
      .on('drag', dragmove)
      .on('dragend', dragEnd)

    svg = d3.select('body .dotsection').append('div')
        .attr('class', 'blacksection')
        .append('svg')
        .attr('width', width)
        .attr('height', height)
        .style('border', '10px')
        .style('border-style', 'solid')

    svg.selectAll('circle.blackdot')
      .data([{cx: 50, cy: 50}])
      .enter()
      .append('circle')
      .attr('class', 'blackdot')
      .attr('r', radius)
      .attr('cx', (d) -> d.cx)
      .attr('cy', (d) -> d.cy)
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

