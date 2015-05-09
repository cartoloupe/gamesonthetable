$(document).ready(function() {

  var dispatcher = new WebSocketRails(window.location.host + '/websocket');
  dispatcher.subscribe("create");
  dispatcher.bind('create', function() {
    return
  })

  $('#submit-move').on('click', function() {
    submitMove($('#new-move').val());
  });
});


function submitMove(value) {
  $.post("/moves", {
    move: {number_of_moves: value}
  });
}


function movesList(message) {
  return
}
