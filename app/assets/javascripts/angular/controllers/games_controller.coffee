# Used by select_game.html
#
# Needs for the controller from select_game.html:
#
# 1. Get a list of games from the server. Use a standard RESTful index.
# 2. Be notified that the list of games needs updated. Websocket event
# 3. Receive new information on particular game.
#
#
# Don't need to (these are done using other regular rails activities):
#
#		Create or delete a game.
#		Edit a game.
#
# Philosphical question:
# 1. Should we mix and match regular Rails with angular? I.E. should we use
# (exclusively) the angular router versus the rails router?
#
# 2. How do we want to work websockets into our controllers? I.E. if we are using
# ngResource, what would we need websockets for?
#
# Old $http version
# $scope.games = []
#
# $scope.getGames = () ->
# 	$http.get('/games.json').success (data) ->
# 		console.log "Success"
# 		console.log JSON.stringify(data)
# 		$scope.games = data
# 		return
#
# 	return

movesApp.controller 'GamesController', ['$scope', '$http', 'dispatcher', 'Game', ($scope, $http, dispatcher, Game) ->

	$scope.load = ->
	  $scope.games = Game.query()

	# $scope.joinGame = (event) ->
	# 	console.log "In joinGame"
	# 	# console.log JSON.stringify(event)
	# 	data = JSON.stringify({game_id: "1"})
	# 	console.log data
	# 	$http.post("/players/join", data).success((data, status) ->
	# 		console.log "In success"
	# 		# console.log JSON.stringify(data)
	# 		# console.log JSON.stringify(status)
	# 		return
	# 	).error (resp) ->
	# 		console.log JSON.stringify(resp)
	# 		return
	# 	return

	$scope.addGame = (data) ->
	  Game.save data, (game) ->
	    $scope.games.push(new Game(game))
	    $scope.game = new Game()

	$scope.completeGame = (game) ->
	  game.completed_at = new Date()
	  game.$update {}, ->
	    $scope.games.remove(game)

	$scope.load()

	dispatcher.bind('games', 'reload', (data) ->
		$scope.load()
	)
]
