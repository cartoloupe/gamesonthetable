// This code creates the moves controller, which is used in game.html.erb
movesApp.controller('MovesController', ['MoveResource', '$scope', function(MoveResource, $scope) {
  //console.log(MoveResource);

  // Get all of the moves from the server. Just a regular http get.
  MoveResource.all(function(moves) {
    //console.log("success");
    $scope.moves = moves;
  });

  MoveResource.onCreate(function(move) {
    //console.log(move);
    $scope.moves.push(move);
  })

  $scope.newMove = new MoveResource();

  $scope.saveMove = function() {
    //console.log('click saveMove');
    $scope.newMove.save(function(move) {
      //console.log(move);
      // $scope.moves.push(move);
      $scope.newMove = new MoveResource();
    });
  }

  $scope.destroyMove = function() {
    //console.log('click destroyMove');
    $scope.newMove.destroy();
  }

}]);
