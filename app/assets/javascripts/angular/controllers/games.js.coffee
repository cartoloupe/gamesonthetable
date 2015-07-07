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
#    Create or delete a game.
#    Edit a game.
#
# Philosphical question:
# 1. Should we mix and match regular Rails with angular? I.E. should we use
# (exclusively) the angular router versus the rails router?
#
# 2. How do we want to work websockets into our controllers? I.E. if we are using
# ngResource, what would we need websockets for?


movesApp.controller 'GamesCtrl', ['$scope', '$http', 'dispatcher', ($scope, $http, dispatcher) ->
  $scope.games = []

  $scope.getGames = () ->
    $http.get('/games.json').success (data) ->
      console.log "Success"
      console.log JSON.stringify(data)
      $scope.games = data
      return

  # $scope.setTimers = () ->
  #   # $('timer')[0].stop();
  #   console.log "Setting timers"
  #   x = angular.element($('timer')[0]);
  #   x.attr('endTimeAttr', '67236450052');
  #   # $('timer')[0].setCountdown(300);
  #   $('timer')[0].start();

    return


  $scope.getGames()    # Get initial list of games
  dispatcher.bind('games', 'reload', (data) ->
    $scope.getGames()
  )
]



$(document).ready ->
  $('#datetimepicker1').datetimepicker()
