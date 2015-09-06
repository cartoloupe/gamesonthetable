angular.module('movesApp').directive 'updateModelOnEnterKeyPressed', ->
  {
    restrict: 'A'
    require: 'ngModel'
    link: (scope, elem, attrs, ngModelCtrl) ->
      elem.bind 'keyup', (e) ->
        if e.keyCode == 13
          ngModelCtrl.$commitViewValue()
        return
      return

  }

# http://stackoverflow.com/a/31962540/1797331
angular.module('movesApp').directive 'scrollToBottom', [
  '$timeout'
  ($timeout) ->
    {
      scope: myData: '='
      link: ($scope, element, attrs) ->
        $scope.$watch 'myData', ->
          $timeout (->
            # You might need this timeout to be sure its run after DOM render.
            my_obj = document.getElementById('scroll-div-id')
            my_obj.scrollTop = my_obj.scrollHeight
            # TODO: Figure out how to use the passed in element
            return
          ), 0, false
          return
        return

    }
]
