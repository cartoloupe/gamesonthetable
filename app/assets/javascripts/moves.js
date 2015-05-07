$(document).ready(function() {

  var dispatcher = new WebSocketRails(window.location.host + '/websocket');
  dispatcher.subscribe("create");
  dispatcher.bind('create', function () {
    return 
  })

  $('#submit-move').on('click', function() {
    dispatcher.trigger("create", {
      moves: 3
    });
  });
});


// function submitMove () {
//   console.log("Clicked");
// }


function movesList(message) {
  return
}
