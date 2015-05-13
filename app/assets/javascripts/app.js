// (function(ng) {
  var movesApp = angular.module("moves", [])
  movesApp.run(function() {
    console.log('movesApp');

  });
  movesApp.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] =
      $('meta[name=csrf-token]').attr('content')
  }]);


  movesApp.service('dispatcher', ['$rootScope', function($rootScope) {
    var dispatcher = new WebSocketRails(window.location.host + '/websocket');
    console.log(dispatcher);
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
      }
    }
    return new Dispatcher();
  }]);

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

    return MoveResource;
  }])

  movesApp.controller('user', ['$scope', function($scope) {
    $scope.greeting = 'user1';

  }]);



  movesApp.controller('MovesController', ['MoveResource', '$scope', function(MoveResource, $scope) {
    console.log(MoveResource);
    MoveResource.all(function(moves) {
      console.log("success");
      $scope.moves = moves;
    });

    MoveResource.onCreate(function(move) {
      console.log(move);
      $scope.moves.push(move);
    })

    $scope.newMove = new MoveResource();

    $scope.saveMove = function() {
      console.log('click saveMove');
      $scope.newMove.save(function(move) {
        console.log(move);
        // $scope.moves.push(move);
        $scope.newMove = new MoveResource();
      });
    }
  }]);

  movesApp.controller('user', ['$scope', function($scope){
    $scope.greeting = 'user1';
  }]);


// })(angular);
