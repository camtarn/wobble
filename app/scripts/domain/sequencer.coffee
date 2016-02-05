class Sequencer
  constructor: ( @sounds ) ->
    # Timeline contains tuples of
    # { soundId, ticks }
    # One tick is 1/1000 of a quarter note, so 1ms at 60bpm
    # Browser timing accuracy isn't that great, so it's a bit
    # of an approximate measure.
    @timeline = []
    @tempo = 120

  add: ({ soundId, ticks }) ->
    note = { soundId, ticks }
    insertAt = _.sortedIndex( @timeline, note, 'ticks' )
    @timeline.splice( insertAt, 0, note )

  remove: ( note ) =>
    @timeline.splice( _.indexOf( note ), 1 )
  



angular.module('wobbleApp')
  .service( 'sequencer', [ 'sounds', Sequencer ] )
