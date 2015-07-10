# This code creates the moves controller, which is used in game.html.erb
movesApp.controller 'MovesController', [
  'MoveResource'
  '$scope'
  'dispatcher'
  (MoveResource, $scope, dispatcher) ->

    dispatcher.bind 'moves', 'reddot', (coordinate) ->
      console.log 'moves reddot from game.coffee'
      console.log coordinate
      $scope.circle_cx = coordinate.cx
      $scope.circle_cy = coordinate.cy

    dispatcher.bind 'moves', 'dragged', (style) ->
      console.log 'moves dragged from game.coffee'
      console.log style
      $scope.svg_style = style

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

    $scope.circle_cx = 150;
    $scope.circle_cy = 150;
    $scope.svg_style = "";

    $('svg').draggable
      stop: ->
        svg = $('svg')
        circle = $('svg circle')
        style = svg.attr('style')
        console.log 'style is'
        console.log style
        dispatcher.trigger 'moves.dragged', style
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

