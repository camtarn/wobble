describe 'Sequencer', ->
  $timeout = sequencer = null

  beforeEach module( 'wobbleApp' )
  beforeEach module ( $provide ) ->
    $provide.decorator '$timeout', ( $delegate ) ->
      $timeout = sinon.spy( $delegate )
      $timeout.cancel = sinon.spy( $delegate.cancel )
      $timeout
    undefined # return value required by Angular

  it 'exists', ->
    inject ( sequencer ) ->
      expect( sequencer ).not.toBeNull()

