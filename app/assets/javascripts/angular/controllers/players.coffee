# Used by game#show
#
# Very similar to the games controller (games.js.coffee)
#
# 1. Get a list of players for this game from the server. Use a standard RESTful index.
# 2. Be notified that the list of players needs updated. Websocket event
#

movesApp.controller 'PlayersCtrl', ['$scope', '$http', 'dispatcher', ($scope, $http, dispatcher) ->
	$scope.players = []

	$scope.getPlayers = () ->

		# Note that we don't want to use the Angular $location because that's for working
		# with Angular paths. We're not using that (at the moment). So, we'll use the
		# jquery get the path.

		# Get the game id
		g_id =  $(location).attr('pathname').split('/')[2];

		$http.get('/players.json?game_id='+g_id).success (data) ->
			console.log "Successfully retrieved players"
			console.log JSON.stringify(data)
			$scope.players = data
			return

		return

	$scope.getPlayers()		# Get initial list of players

	dispatcher.bind('players', 'reload', (data) ->
		$scope.getPlayers()
	)
]
