angular.module('wobbleApp')
  .factory 'sounds', ->
    sounds = for type in [ 'bd', 'tom', 'snr' ]
      for num in [ 1..4 ]
        { id: type + num, src: "/sounds/#{type}#{num}.mp3" }
    _.flatten( sounds )

