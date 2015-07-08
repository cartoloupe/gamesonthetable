// var myApp = angular.module('games', ['Devise']);

movesApp.config(function(AuthProvider) { // Configure Auth service with AuthProvider
});


movesApp.controller('UserController', ['$scope', 'Auth', 'dispatcher', function($scope, Auth, dispatcher) {

  $scope.current_user = '...';
  $scope.current_users = [];

  $scope.getUser = function() {

    Auth.currentUser().then(function(user) {
      // User was logged in, or Devise returned
      // previously authenticated player.
      //console.log(user.email); // => {id: 1, ect: '...'}
      $scope.current_user = user.email;

      // only add user to current_users if they don't already exist
      if ($scope.current_users.indexOf(user.email) == -1){
        $scope.current_users.push(user.email);
      }

      dispatcher.trigger('user.logged_in', {user: user});
    }, function(error) {
      // unauthenticated error
      console.log("unauthenticated")
    });
  }

  dispatcher.bind('user', 'logged_in', function(user) {
    // only add user to current_users if they don't already exist
    if ($scope.current_users.indexOf(user.email) == -1){
      $scope.current_users.push(user.email);
    }
    console.log('user logged_in from user.js');
  });

}]);
