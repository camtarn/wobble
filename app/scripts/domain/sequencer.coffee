class Sequencer
  UI_UPDATE_TICKS = 250

  # One tick is 1/1000 of a quarter note, so 1ms at 60bpm
  # Browser timing accuracy isn't that great, so it's a bit
  # of an approximate measure.
  TICKS_PER_BEAT = 1000

  constructor: ( @$timeout, @player, @sounds ) ->
    # Timeline contains tuples of
    # { soundId, ticks }
    @timeline = []
    @tempo = 120
    @patternLength = 16
    @position = 0 # in ticks
    @playing = false
    @_currentTimeout = null

  add: ({ soundId, ticks }) ->
    note = { soundId, ticks }
    insertAt = _.sortedIndex( @timeline, note, 'ticks' )
    @timeline.splice( insertAt, 0, note )

  remove: ( note ) =>
    @timeline.splice( _.indexOf( @timeline, note ), 1 )

  rewind: ->
    @stop()
    @position = 0
  
  seek: ( position ) ->
    ticksInTimeline = @patternLength * TICKS_PER_BEAT
    if position > ticksInTimeline
      position = position - ticksInTimeline
    @position = position
    if @playing
      @_triggerNotes()
      @_waitUntilNextUpdate()

  play: ->
    @playing = true
    @_triggerNotes()
    @_waitUntilNextUpdate()

  stop: ->
    @$timeout.cancel( @_currentTimeout ) if @_currentTimeout
    @playing = false

  _triggerNotes: ->
    notes = _.filter( @timeline, ( note ) => note.ticks == @position )
    for note in notes
      @player.play( note.soundId )

  _waitUntilNextUpdate: ->
    @$timeout.cancel( @_currentTimeout ) if @_currentTimeout

    nextNote = _.find( @timeline, ( note ) => note.ticks > @position )
    if !@timeline.length
      ticksTilNextEvent = UI_UPDATE_TICKS
    else
      if nextNote
        ticksTilNextNote = nextNote.ticks - @position
      else
        nextNote = _.first( @timeline )
        ticksTilEndOfTimeline = @patternLength * TICKS_PER_BEAT - @position
        ticksTilNextNote = ticksTilEndOfTimeline + nextNote.ticks
      ticksTilNextEvent = Math.min( ticksTilNextNote, UI_UPDATE_TICKS )
    msTilNextEvent = @_ticksToMs( ticksTilNextEvent )

    @_currentTimeout = @$timeout( ( =>
      @seek( @position + ticksTilNextEvent )
    ), msTilNextEvent )

  _ticksToMs: ( ticks ) ->
    beatsPerSecond = @tempo / 60
    beats = ticks / TICKS_PER_BEAT
    beats / beatsPerSecond * 1000



angular.module('wobbleApp')
  .service( 'sequencer', [ '$timeout', 'player', 'sounds', Sequencer ] )
