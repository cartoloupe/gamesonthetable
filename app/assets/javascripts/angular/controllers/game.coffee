# This code creates the moves controller, which is used in game.html.erb
movesApp.controller 'MovesController', [
  'MoveResource'
  '$scope'
  'dispatcher'
  (MoveResource, $scope, dispatcher) ->

    width = 500
    height = 500
    radius = 20

    trianglePoints = (x,y) ->
      point1 = ''+x+','+(y-radius)+' '
      point2 = ''+(x - 0.866 * radius)+','+(y+radius/2.0)+' '
      point3 = ''+(x + 0.866 * radius)+','+(y+radius/2.0)+' '
      points = point1 + point2 + point3
      console.log 'tp'
      console.log points
      points

    svg = d3.select('body .dotsection').append('div')
        .attr('class', 'blacksection')
        .append('svg')
        .attr('width', width)
        .attr('height', height)
        .style('border', '10px')
        .style('border-style', 'solid')

    updatedot = (data) ->
      svg = d3.select('.blacksection svg')
      dots = svg.selectAll('.items')
        .data(data, ((d) -> 1000 * d.cx + d.cy ))

      dots.attr('class', 'blackdot items')
        .call(drag)
        .attr('r', radius)
        .transition()
          .duration(500)
        .attr('cx', (d) -> d.cx)
        .attr('cy', (d) -> d.cy)

      entering = dots.enter()
      entering.append((d, i) ->
        console.log [d,i]
        if d.type == 'rect'
          svg.append('rect')
            .attr('x', d.x)
            .attr('y', d.y)
            .attr('width', d.width)
            .attr('height', d.height)
            .node()
        else if d.type == 'triangle'
          svg.append('polygon')
            .attr('points', trianglePoints(d.x, d.y))
            .attr('x', d.x)
            .attr('y', d.y)
            .node()
        else
          svg.append('circle')
            .attr('r', d.r)
            .node()
      )
        .attr('class', 'blackdot items')
        .attr('dataid', (d, i) -> i)
        .attr('type', (d) -> d.type)
        .attr('stroke', 'white')
        .call(drag)
        .transition()
          .duration(1000)
          .attr('cx', (d) -> d.cx)
          .attr('cy', (d) -> d.cy)

      dots.exit()
          .transition()
            .duration(500)
            .attr('r', 0)
          .remove()
      return

    dispatcher.bind 'moves', 'reddot', (data) ->
      $scope.circleData = data
      updatedot(data)
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
      console.log d3.select(this).attr('type')
      if d3.select(this).attr('type') == 'triangle'
        d3.select(this)
          .attr('points', trianglePoints(d3.event.x, d3.event.y))
      else
        d3.select(this)
          .attr('cx', d.x = Math.max(radius, Math.min(width - radius, d3.event.x)))
          .attr('cy', d.y = Math.max(radius, Math.min(height - radius, d3.event.y)))
          .attr('x', d.x = Math.max(radius, Math.min(width - radius, d3.event.x)))
          .attr('y', d.y = Math.max(radius, Math.min(height - radius, d3.event.y)))

      return

    dragEnd = (d) ->
      dragged = d3.select(this)
      cx = dragged.attr('cx')
      cy = dragged.attr('cy')
      id = dragged.attr('dataid')
      updatee = $scope.circleData.filter((d) ->
        return id == d.dataid
      )[0]
      updatee.cx = cx
      updatee.cy = cy


      dispatcher.trigger 'moves.moving', $scope.circleData
      return

    drag = d3.behavior.drag()
      .on('drag', dragmove)
      .on('dragend', dragEnd)

    $scope.circleData = [ ]
    updatedot($scope.circleData)

    $('.add-circle').click ->
      dataid = $scope.circleData.length
      $scope.circleData.push({dataid: ""+dataid, cx: 30, cy: 30, r: 20})
      updatedot($scope.circleData)

    $('.add-rect').click ->
      dataid = $scope.circleData.length
      $scope.circleData.push({type: 'rect', dataid: ""+dataid, x: 50, y: 50, width: 30, height: 30})
      updatedot($scope.circleData)

    $('.add-triangle').click ->
      dataid = $scope.circleData.length
      $scope.circleData.push({type: 'triangle', dataid: ""+dataid, x: 50, y: 50, width: 30, height: 30})
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

