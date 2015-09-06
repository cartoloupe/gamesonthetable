messageServices = angular.module('messageServices', [ 'ngResource' ])

messageServices.factory 'Message', [
  '$resource'
  ($resource) ->
    $resource '/messages/:id.json'
]
