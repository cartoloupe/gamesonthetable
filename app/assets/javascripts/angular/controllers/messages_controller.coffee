# Used by geodes and game#show
#
# Very similar to the games controller (games_controller.coffee)
#
# 1. Get a list of the most recent chat messages (user, comment, time)
# 2. Send a chat message
# 3. Receive a notice that there is a new chat message
#

movesApp.controller 'MessagesController', ['$scope', '$http', 'dispatcher', \
'Message', ($scope, $http, dispatcher, Message) ->

  $scope.messages = []
  $scope.message_to_send = ""

  console.log "Initializing Chat Controller"

  $scope.getMessages = () ->

    console.log "Getting Messages"
    # Note that we don't want to use the Angular $location because that's for
    # working with Angular paths. We're not using that (at the moment). So,
    # we'll use the jquery get the path.

    # Get the game id
    g_id =  $(location).attr('pathname').split('/')[2]

    Message.query (data) ->
      $scope.messages = data
      # TODO: Restrict the query to the current game
      console.log "Successfully retrieved messages"
      console.log JSON.stringify($scope.messages)
      return

    return

  $scope.sendMessage = () ->
    g_id =  $(location).attr('pathname').split('/')[2]  # Get the game id
    console.log "Sending chat for game " + g_id
    data = {game_id: g_id, the_text: $scope.message_to_send}
    console.log JSON.stringify(data)
    Message.save(data)    # The Rails app will fill in user_id and time
    $scope.message_to_send = ""
    return

  $scope.getMessages()    # Get initial list of messages

  dispatcher.bind('chat', 'reload', (data) ->
    $scope.getMessages()
  )
]
