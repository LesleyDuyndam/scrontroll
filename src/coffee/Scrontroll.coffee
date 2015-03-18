root = exports ? this

###

  SCRONTROLL Class
  extends ENGINE class

###

class root.SCRONTROLL extends root.ENGINE
  constructor: () ->
    super

    # Start registering scroll events
    if @autostart
      @start()




  watch: ( name, callback ) =>
    @subscribe( name, callback )
