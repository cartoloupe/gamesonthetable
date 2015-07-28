# This code creates the moves controller, which is used in game.html.erb
movesApp.controller 'MovesController', [
  'MoveResource'
  '$scope'
  'dispatcher'
  (MoveResource, $scope, dispatcher) ->

    width = 500
    height = 500
    radius = 20

    $scope.trail = []
    $scope.del_x = []
    $scope.del_y = []
    $scope.e_del_x = 0
    $scope.e_del_y = 0
    $scope.trailHead = 0

    $scope.trianglePoints = (x,y) ->
      point1 = ''+x+','+(y-radius)+' '
      point2 = ''+(x - 0.866 * radius)+','+(y+radius/2.0)+' '
      point3 = ''+(x + 0.866 * radius)+','+(y+radius/2.0)+' '
      points = point1 + point2 + point3
      points

    $scope.squarePoints = (x,y) ->
      a = 0.707
      b = a*radius
      point1 = ''+(x - b)+','+(y - b)+' '
      point2 = ''+(x - b)+','+(y + b)+' '
      point3 = ''+(x + b)+','+(y + b)+' '
      point4 = ''+(x + b)+','+(y - b)+' '
      points = point1 + point2 + point3 + point4
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
        .data(data, ((d) -> 1000 * d.x + d.y ))

      dots.attr('class', 'blackdot items')
        .call(drag)
        .attr('r', radius)
        .transition()
          .duration(500)
        .attr('cx', (d) -> d.cx)
        .attr('cy', (d) -> d.cy)

      entering = dots.enter()
      entering.append((d, i) ->
        if d.type == 'square'
          svg.append('polygon')
            .attr('points', $scope.squarePoints(1.0 * d.x, 1.0 * d.y))
            .node()
        else if d.type == 'triangle'
          svg.append('polygon')
            .attr('points', $scope.trianglePoints(1.0 * d.x, 1.0 * d.y))
            .node()
        else
          svg.append('circle')
            .attr('r', d.r)
            .node()
      )
        .attr('class', 'blackdot items')
        .attr('x', (d) -> d.x)
        .attr('y', (d) -> d.y)
        .attr('dataid', (d, i) -> i)
        .attr('type', (d) -> d.type)
        .attr('fill', (d) -> d.fill)
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
      type = d3.select(this).attr('type')
      if type == 'triangle'
        d3.select(this)
          .attr('points', $scope.trianglePoints(d3.event.x, d3.event.y))
      else if type == 'square'
        d3.select(this)
          .attr('points', $scope.squarePoints(d3.event.x, d3.event.y))
      else
        d3.select(this)
          .attr('cx', d.x = Math.max(radius, Math.min(width - radius, d3.event.x)))
          .attr('cy', d.y = Math.max(radius, Math.min(height - radius, d3.event.y)))

      d3.select(this)
        .attr('x', d.x = Math.max(radius, Math.min(width - radius, d3.event.x)))
        .attr('y', d.y = Math.max(radius, Math.min(height - radius, d3.event.y)))


      $scope.trail.push([d3.event.x, d3.event.y])
      $scope.trailHead = $scope.trailHead + 1
      if $scope.trail.length > 1
        trail = $scope.trail.slice(-2)
        $scope.del_x.push trail[0][0] - trail[1][0]
        $scope.del_y.push trail[0][1] - trail[1][1]
        $scope.e_del_x = $scope.del_x.reduce by_addition
        $scope.e_del_y = $scope.del_y.reduce by_addition

      if is_circle()
        newColor = switchColor()
        d3.select(this).attr('style', 'fill:'+ newColor)
        id = d3.select(this).attr('dataid')
        updatee = $scope.circleData.filter((d) ->
          return id == d.dataid
        )[0]
        updatee.fill = newColor
        resetTrail()

      return

    by_addition = (x,y) -> x+y

    is_circle = () ->
      if $scope.trailHead < 20
        return false

      if Math.abs($scope.e_del_x) < 30 && Math.abs($scope.e_del_y) < 30
        return true
      else
        return false


    switchColor = do ->
      colors = ['red', 'green', 'blue', 'black']
      i = colors.length
      inner = ->
        i = ( i + 1 ) % colors.length
        return colors[i]

    resetTrail = ->
      $scope.trail = []
      $scope.trailHead = 0
      $scope.del_x = []
      $scope.del_y = []
      $scope.e_del_x = 0
      $scope.e_del_y = 0

    dragEnd = (d) ->
      dragged = d3.select(this)
      cx = dragged.attr('cx')
      cy = dragged.attr('cy')
      x = dragged.attr('x')
      y = dragged.attr('y')
      id = dragged.attr('dataid')
      updatee = $scope.circleData.filter((d) ->
        return id == d.dataid
      )[0]
      updatee.cx = cx
      updatee.cy = cy
      updatee.x = x
      updatee.y = y

      resetTrail()

      dispatcher.trigger 'moves.moving', $scope.circleData
      return


    drag = d3.behavior.drag()
      .on('drag', dragmove)
      .on('dragend', dragEnd)

    $scope.circleData = [ ]
    updatedot($scope.circleData)

    $('.add-circle').click ->
      dataid = $scope.circleData.length
      $scope.circleData.push({type: 'circle', dataid: ""+dataid, x: 30, y: 30, cx: 30, cy: 30, r: 20})
      updatedot($scope.circleData)

    $('.add-square').click ->
      dataid = $scope.circleData.length
      $scope.circleData.push({type: 'square', dataid: ""+dataid, x: 50, y: 50 })
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

