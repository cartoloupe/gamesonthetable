#= require movesapp
#= require angular-mocks

beforeEach(module('movesApp'))

beforeEach inject (_$httpBackend_, _$compile_, $rootScope, $controller, $location, $injector, $timeout) ->
  @scope = $rootScope.$new()
  @http = _$httpBackend_
  @compile = _$compile_
  @location = $location
  @controller = $controller
  @injector = $injector
  @timeout = $timeout
  @model = (name) =>
    @injector.get(name)

afterEach ->
  @http.resetExpectations()
  @http.verifyNoOutstandingExpectation()
