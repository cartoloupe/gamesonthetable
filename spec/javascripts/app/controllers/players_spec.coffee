#= require spec_helper
#= require players

# This is the approach from http://blog.zerosum.org/2014/01/17/rails-angular-jasmine.html

describe 'PlayersCtrl', ->
  beforeEach ->
    @controller('PlayersCtrl', { $scope: @scope })

    @players = [{id: 1, name: 'A'}, {id: 3, name: 'B'}]

    @http.whenGET(/.*/).respond(200, @players)
    @http.flush()

  it 'loads an initial list of players', ->
    expect(@scope.players.length).toBe(2)
