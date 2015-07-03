#= require spec_helper
#= require games_controller

# This is the approach from http://blog.zerosum.org/2014/01/17/rails-angular-jasmine.html

describe 'GamesController', ->
  beforeEach ->
    @controller('GamesController', { $scope: @scope })

    @Game = @model('Game')
    @games = [new @Game({id: 1, name: 'first game'}), new @Game({id: 2, name: 'second game'})]

    @http.whenGET('/games.json').respond(200, @games)
    @http.flush()

  it 'loads an initial list of games', ->
    expect(@scope.games.length).toBe(2)
