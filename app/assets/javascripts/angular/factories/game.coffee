angular.module("movesApp")
  .factory "Game", ($resource) ->
    $resource "/games.json/:id",
      { id: "@id" },
      { update: { method: "PUT" }}
