# This code creates the moves controller, which is used in game.html.erb
movesApp.controller 'MovesController', [
  'MoveResource'
  '$scope'
  'dispatcher'
  (MoveResource, $scope, dispatcher) ->

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

    $scope.circle_cx = 150;
    $scope.circle_cy = 150;

    $('.another-move').on 'click', (d, i) ->
      console.log([d,i])
      a = $('.another-move').text()
      delta = parseInt(a)
      submitMove parseInt(a)
      circle = $('svg circle')
      circle_cx = parseInt(circle.attr('cx'))
      new_circle_cx = circle_cx + delta
      circle.attr 'cx', new_circle_cx
      circle.remove()
      $('svg').append circle
      dispatcher.trigger 'moves.moving', cx: new_circle_cx
      $scope.circle_cx = new_circle_cx;
      return

    dispatcher.bind 'moves', 'reddot', (coordinate) ->
      console.log 'moves reddot from game.js.coffee'
      console.log coordinate
      $scope.circle_cx = coordinate

    return
]

submitMove = (value) ->
  $.post '/moves', move: number_of_moves: value
  return

movesList = (message) ->
  return


$(document).ready ->
  #dispatcher = new WebSocketRails(window.location.host + '/websocket')

  $('#submit-move').on 'click', ->
    submitMove $('#new-move').val()
    return

  return

# ---
# generated by js2coffee 2.0.4








