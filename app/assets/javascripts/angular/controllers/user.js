// var myApp = angular.module('games', ['Devise']);

movesApp.config(function(AuthProvider) { // Configure Auth service with AuthProvider
});


movesApp.controller('UserController', ['$scope', 'Auth', function($scope, Auth) {

  $scope.current_user = 'no user retrieved yet';
  $scope.current_users = [];

  $scope.getUser = function() {
    console.log("getting user");

    Auth.currentUser().then(function(user) {
      // User was logged in, or Devise returned
      // previously authenticated session.
      console.log(user.email); // => {id: 1, ect: '...'}
      $scope.current_user = user.email;
      $scope.current_users.push(user.email);
    }, function(error) {
      // unauthenticated error
      console.log("unauthenticated")
    });
  }

  /*
  $scope.getUsers = function() {
    //
    $scope.current_users;
  }
  */

}]);
