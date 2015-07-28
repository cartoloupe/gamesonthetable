# This code creates the moves controller, which is used in game.html.erb
movesApp.controller 'MovesController', [
  'MoveResource'
  '$scope'
  'dispatcher'
  (MoveResource, $scope, dispatcher) ->

    width = 250
    height = 250

    $scope.trail = []
    $scope.del_x = []
    $scope.del_y = []
    $scope.e_del_x = 0
    $scope.e_del_y = 0
    $scope.trailHead = 0

    $scope.trianglePoints = (x,y,r) ->
      point1 = ''+x+','+(y-r)+' '
      point2 = ''+(x - 0.866 * r)+','+(y+r/2.0)+' '
      point3 = ''+(x + 0.866 * r)+','+(y+r/2.0)+' '
      points = point1 + point2 + point3
      points

    $scope.squarePoints = (x,y,r) ->
      a = 0.707
      b = a*r
      point1 = ''+(x - b)+','+(y - b)+' '
      point2 = ''+(x - b)+','+(y + b)+' '
      point3 = ''+(x + b)+','+(y + b)+' '
      point4 = ''+(x + b)+','+(y - b)+' '
      points = point1 + point2 + point3 + point4
      points

    $scope.circlePoints = (x,y) ->
      {cx: x, cy: y}

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
        .transition()
          .duration(500)

      entering = dots.enter()
      entering.append((d, i) ->
        if d.type == 'square'
          svg.append('polygon')
            .attr('r', d.r)
            .attr('points', $scope.squarePoints(1.0 * d.x, 1.0 * d.y, 1.0 * d.r))
            .node()
        else if d.type == 'triangle'
          svg.append('polygon')
            .attr('r', d.r)
            .attr('points', $scope.trianglePoints(1.0 * d.x, 1.0 * d.y, 1.0 * d.r))
            .node()
        else
          c = $scope.circlePoints(1.0 * d.x, 1.0 * d.y)
          svg.append('circle')
            .attr('r', d.r)
            .attr('cx', c.cx)
            .attr('cy', c.cy)
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
      x = d3.event.x
      y = d3.event.y
      type = d3.select(this).attr('type')
      r = d3.select(this).attr('r')

      d3.select(this)
        .attr('x', d.x = x)
        .attr('y', d.y = y)

      if type == 'triangle'
        d3.select(this)
          .attr('points', $scope.trianglePoints(x, y, r))
      else if type == 'square'
        d3.select(this)
          .attr('points', $scope.squarePoints(x, y, r))
      else
        c = $scope.circlePoints(x, y)
        d3.select(this)
          .attr('cx', c.cx)
          .attr('cy', c.cy)

      $scope.trail.push([x, y])
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


      if nearLeftEdge(x,y,r)
        d3.select(this)
          .attr('r', 20)

      if nearTopEdge(x,y,r)
        d3.select(this)
          .attr('r', 50)

      if nearRightEdge(x,y,r)
        d3.select(this)
          .attr('r', 100)

      return

    by_addition = (x,y) -> x+y

    nearLeftEdge = (x,y,r) ->
      leftSide = x
      if leftSide < 2
        true
      else
        false

    nearTopEdge = (x,y,r) ->
      topSide = y
      if topSide < 2
        true
      else
        false

    nearRightEdge = (x,y,r) ->
      rightSide = x
      if width - rightSide < 1
        true
      else
        false

    nearBottomEdge = (x,y,r) ->
      bottomSide = y
      if height - bottomSide < 1
        true
      else
        false

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
      x = dragged.attr('x')
      y = dragged.attr('y')
      r = dragged.attr('r')
      id = dragged.attr('dataid')

      updatee = $scope.circleData.filter((d) ->
        return id == d.dataid
      )[0]
      updatee.x = x
      updatee.y = y
      updatee.r = r

      if nearBottomEdge(x,y,r)
        $scope.circleData.splice( $scope.circleData.indexOf(updatee), 1);

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
      $scope.circleData.push({type: 'circle', dataid: ""+dataid, x: 30, y: 30, r: 20 })
      updatedot($scope.circleData)

    $('.add-square').click ->
      dataid = $scope.circleData.length
      $scope.circleData.push({type: 'square', dataid: ""+dataid, x: 50, y: 50, r: 20 })
      updatedot($scope.circleData)

    $('.add-triangle').click ->
      dataid = $scope.circleData.length
      $scope.circleData.push({type: 'triangle', dataid: ""+dataid, x: 50, y: 50, r: 20 })
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

