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

    composers = new Array()

    composers = [
      'direction',
      'horizontal-direction',
      'vertical-direction'
    ]

    @addComposer composers, root.direction_composer


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
  router: ( @event_id ) =>


    for channel_key, channel of @composers_name_register
      @composers_callback_register[ channel_key ] channel, @index, @event_id, ( channel_name, data )=>
        @broadcast( channel_name, data )

#   Return the current event_id
    event_id