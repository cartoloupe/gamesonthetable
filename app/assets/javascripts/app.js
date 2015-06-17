// (function(ng) {



  var movesApp = angular.module("moves", ['Devise', 'timer'])
  movesApp.run(function() {
    //console.log('movesApp');

  });

  movesApp.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] =
      $('meta[name=csrf-token]').attr('content')
  }]);

  // (I think) This code creates a service constructor named
  // "dispatcher." This service, when invoked:
  //
  // 1. Uses WebSocketRails to opens and subscribes to a channel.
  // 2. Add a function that is invoked when a channel is opened.
  // 3. Returns an instance of Dispatcher that has the following functions:
  //    * bind(channelName, eventName, callBack)
  //    * trigger()
  //
  //

  movesApp.service('dispatcher', ['$rootScope', function($rootScope) {
    var dispatcher = new WebSocketRails(window.location.host + '/websocket');
    //console.log(dispatcher);
    dispatcher.on_open = function(data) {
      console.log('Connection has been established: ', data);
    }

    var Dispatcher = function() {
      //    var createChannel = function (channelName) {
      //     return dispatcher.subscribe(channelName);
      //   }
      this.bind = function(channelName, eventName, callBack) {
        var channel = dispatcher.subscribe(channelName);
        channel.bind(eventName, function(data) {
          $rootScope.$apply(function() {
            callBack(data);
          })
        });
      },
      this.trigger = function(channelName, someObject) {
        dispatcher.trigger(channelName, someObject);
      }

    }
    return new Dispatcher();
  }]);

  // This code creates a factory that is used in the MoveController below. The
  // factory can create a service called MoveResource that has the following
  // functionality:
  //
  // Has an instance variable (or is it a data type?) called number_of_moves. This
  // number_of_moves is the value that of the move. +5, -10, etc.
  //
  // Has a method called "all" that gets all moves from the server. This method calls
  // a callback function on successful retrieval of the moves.
  //
  // Has a method called "onCreate" that uses the dispatcher service (above) to
  // connect a websocket channel to handler. I.E. if we receive a message from the
  // server, the handler, which is a passed in function, gets invoked.
  //
  // Has a function called "save" that saves the moves to the server. (It sends the entire
  // list of moves?)
  //
  // Has a function called "destroy" which sends a websocket moves.destroy to the server.
  //
  // Only the destroy function seems to use websockets.
  //
  // Why didn't we just use ngResource? It doesn't have websockets functionality, but
  // what do we want to use that for?

  movesApp.factory('MoveResource', ['$http', 'dispatcher', function($http, dispatcher) {
    var MoveResource = function(number_of_moves) {
      this.number_of_moves = number_of_moves;
    }

    // var channel = dispatcher.subscribe('moves');
    // channel.bind('create', function(move) {
    //   console.log(this, arguments);
    // })

    MoveResource.all = function(successCallBack) {
      return $http.get('/moves.json').success(function(movesData) {
        var moves = movesData.map(function(move) {
          return new MoveResource(move.number_of_moves);
        });
        console.log(moves);
        successCallBack(moves);
      })
    }

    MoveResource.onCreate = function(handler) {
      dispatcher.bind('moves', 'create', function(moveData) {
        //console.log("moveData:");
        //console.log(moveData);
        var move = new MoveResource(moveData.number_of_moves);
        // $rootScope.$apply(function() {
        handler(move);
        // });
      });
    }

    MoveResource.prototype.save = function(successCallBack) {
      console.log('saving moves');
      return $http.post('/moves.json', this).success(function(moveData) {
        var move = new MoveResource(moveData.number_of_moves);
        successCallBack(move);
      });
    };

    MoveResource.prototype.destroy = function(successCallBack) {
      dispatcher.trigger('moves.destroy', {});
    };


    return MoveResource;
  }])

  // This code creates the moves controller, which is used in game.html.erb
  movesApp.controller('MovesController', ['MoveResource', '$scope', function(MoveResource, $scope) {
    //console.log(MoveResource);

    // Get all of the moves from the server. Just a regular http get.
    MoveResource.all(function(moves) {
      //console.log("success");
      $scope.moves = moves;
    });

    MoveResource.onCreate(function(move) {
      //console.log(move);
      $scope.moves.push(move);
    })

    $scope.newMove = new MoveResource();

    $scope.saveMove = function() {
      //console.log('click saveMove');
      $scope.newMove.save(function(move) {
        //console.log(move);
        // $scope.moves.push(move);
        $scope.newMove = new MoveResource();
      });
    }

    $scope.destroyMove = function() {
      //console.log('click destroyMove');
      $scope.newMove.destroy();
    }

  }]);


// })(angular);
