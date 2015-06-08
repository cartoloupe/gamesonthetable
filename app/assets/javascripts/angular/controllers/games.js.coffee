movesApp.controller 'GamesCtrl', ['$scope', '$http', ($scope, $http) ->
	$scope.games = []

	$scope.getGames = () ->
		console.log("getting user");

		$http.get('/games.json').success (data) ->
			console.log "Success"
			console.log JSON.stringify(data)
			$scope.games = data
			return

	$scope.getGames()		# Get initial list of games

]

