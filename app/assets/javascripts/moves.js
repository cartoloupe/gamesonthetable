$(document).ready(function() {

  var dispatcher = new WebSocketRails(window.location.host + '/websocket');
  dispatcher.subscribe("create");
  dispatcher.bind('create', function() {
    return
  })

  $('#submit-move').on('click', function() {
    submitMove($('#new-move').val());
  });
  
  $('.another-move').on('click', function(d,i) {
    var a = $('.another-move').text();
    console.log("submitting " + a);
    var delta = parseInt(a);
    submitMove(parseInt(a));
    var circle = $('svg circle');
    var circle_cx = parseInt(circle.attr("cx"));
    circle.attr("cx", circle_cx + delta);
    circle.remove();
    $('svg').append(circle);
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
