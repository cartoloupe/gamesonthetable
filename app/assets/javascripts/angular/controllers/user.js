var myApp = angular.module('games', ['Devise']);

myApp.config(function(AuthProvider) { // Configure Auth service with AuthProvider 
});


myApp.controller('user', ['$scope', 'Auth', function($scope, Auth) {

  $scope.greeting = 'no user logged in yet';

  // Auth.currentUser().then(function(user) { 
  // 	// User was logged in, or Devise returned 
  // 	// previously authenticated session. 
  // 	console.log(user); // => {id: 1, ect: '...'} 
  // 	}, function(error) { 
  // 	// unauthenticated error
  // 	console.log("unauthenticated")
  // });


  $scope.getUser = function() {
  	console.log("getting user");

	  Auth.currentUser().then(function(user) { 
	  	// User was logged in, or Devise returned 
	  	// previously authenticated session. 
	  	console.log(user.email); // => {id: 1, ect: '...'}
	  	$scope.greeting = user.email;
	  	}, function(error) { 
	  	// unauthenticated error
	  	console.log("unauthenticated")
	  });  	
  }

}]);
