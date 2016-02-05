angular.module('wobbleApp')
  .controller 'MainCtrl', () ->
    queue = new createjs.LoadQueue()
    queue.installPlugin( createjs.Sound )
    for type in [ 'bd', 'tom', 'snr' ]
      for num in [ 1..4 ]
        queue.loadFile( id: type + num, src: "/sounds/#{type}#{num}.mp3" )
