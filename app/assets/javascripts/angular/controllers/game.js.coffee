# This code creates the moves controller, which is used in game.html.erb
movesApp.controller 'MovesController', [
  'MoveResource'
  '$scope'
  (MoveResource, $scope) ->
    #console.log(MoveResource);
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

    return
]
