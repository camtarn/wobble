angular.module('wobbleApp')
  .controller 'LoadingCtrl', [ '$scope', '$location', 'sounds', ( ( $scope, $location, sounds ) ->
    queue = new createjs.LoadQueue()
    queue.installPlugin( createjs.Sound )
    queue.loadFile( sound ) for sound in sounds
    queue.on 'complete', ->
      $scope.$apply ->
        $location.path( '/main' )
        $location.replace()
  ) ]
