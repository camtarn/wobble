angular.module('wobbleApp')
  .controller 'MainCtrl', [ '$scope', 'sounds', 'sequencer', ( ( $scope, sounds, sequencer ) ->
    $scope.sequencer = sequencer
    $scope.sounds = ( sound.id for sound in sounds )
    $scope.newNote = {}
    $scope.add = ->
      sequencer.add( $scope.newNote )
      $scope.newNote = {}
  ) ]
