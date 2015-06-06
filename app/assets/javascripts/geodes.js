$(function() {

  $(".draggable").draggable();
  $('#gTriangle').click(function() {
          $('body').append('<svg class="draggable" height="60" width="60">  <polygon points="10,50 25,10 50,50" /></svg>');
          $('svg').draggable();
        });

  $('.color').click(function() {
          colors = ['green', 'red', 'blue', 'yellow', 'black'];
          a = $('.color > polygon')[0];
          i = 1 * a.attributes['color'].value;
          //console.log(a.attributes['color'].value);
          $('.color > polygon').css('fill', colors[i]);
          a.attributes['color'].value = ((++i) % 5 );
          console.log(a.attributes['color'].value);

          currentFill = a.style['fill'];
          if (currentFill == 'rgb(255, 0, 0)'){
                    //console.log('red');
                  } else {
                            //console.log('no');
                          }
          //console.log(a.style['fill']);
        });
});
