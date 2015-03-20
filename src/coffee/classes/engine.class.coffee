root = exports ? this

###

  ENGINE Class
  extends TRACKER class

###

class root.ENGINE extends root.TRACKER
  constructor: () ->
    super

#   Ask tracker to be notified when scroll event is triggered and execute @supervisor
    @subscribe 'tracker', @router


  @addComposer [
    'direction',
    'horizontal-direction',
    'vertical-direction'
  ], root.direction_composer

#  @addComposer [
#    'speed',
#    'average-speed'
#  ], root.speed_composer

  ###

    @router() | Run tasks

    - Delegates input to the factories
    - Adds factory output to event in the @index[]
    - Broadcast event key when done, so subscribers know something changed


  ###
  router: ( event_id ) =>

    # give direction OBJECT as argument

    # @todo: Is this how a coffeescript loop with counter works?
    index_number for composer_name in @composer_register
      do ( index_number, composer_name ) ->

        # Let the composer of subscribed channels calculate the output
        @composer[ index_number ] composer_name, event_id, ( name, data ) =>

          # Broadcast the output to the subscribers
          @broadcast name data

#   Return the current event_id
    event_id