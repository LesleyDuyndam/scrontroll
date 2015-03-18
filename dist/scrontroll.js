(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;


  /*
  
    direction() factory
  
    Gets the current and previous event as a argument. It calculates the scroll direction
    and returns the results as an object.
  
    returns {
     y : atTop || up || atBottom || down
     x : atLeft || left || atRight || right
   */

  root.direction = function(this_event, prev_event) {
    var defaults;
    defaults = {
      'y': 'atTop',
      'x': 'atLeft'
    };
    if (prev_event === void 0) {
      return defaults;
    }
    return {
      'y': this_event.y >= prev_event.y ? 'down' : 'up',
      'x': this_event.x >= prev_event.x ? 'right' : 'left'
    };
  };

}).call(this);

(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;


  /*
  
    direction factory
  
    Gets the current and previous event as a argument. It calculates the scroll direction
    and returns the results as an object.
  
    returns {
     y : atTop || up || atBottom || down
     x : atLeft || left || atRight || right
   */

  root.speed = function(this_event, prev_event) {
    var defaults, time;
    defaults = {
      'y': 0,
      'x': 0
    };
    if (prev_event === void 0) {
      return defaults;
    }
    time = this_event.timeStamp - prev_event.timeStamp;
    return {
      'y': (Math.abs(this_event.y - prev_event.x) / time) * 1000,
      'x': (Math.abs(this_event.x - prev_event.x) / time) * 1000
    };
  };

}).call(this);

(function() {
  var root,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;


  /*
  
    INIT Class
  
    1. TRACKER | receives new input on scroll event from event listener
   */

  root.INIT = (function() {
    function INIT(options) {
      this.broadcast = bind(this.broadcast, this);
      this.subscribe = bind(this.subscribe, this);
      this.window = $(window);
      this.channel = {};
      if (options) {
        this.autostart = options.autostart;
      }
      if (this.autostart === void 0) {
        this.autostart = true;
      }
      this.counter = 0;
    }


    /*
    
      Create a new channel where functions can subscribe callbacks to
     */

    INIT.prototype.addChannel = function(name) {
      if (!this.channel[name]) {
        return this.channel[name] = [];
      } else {
        return false;
      }
    };


    /*
    
      Add subscribers callback function to call on broadcast
     */

    INIT.prototype.subscribe = function(name, callback) {
      return this.channel[name].push(callback);
    };


    /*
    
      Broadcast scroll event_id to subscribers
     */

    INIT.prototype.broadcast = function(name, event_id) {
      var callback, i, len, ref, results;
      this.counter++;
      ref = this.channel[name];
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        callback = ref[i];
        results.push(callback(event_id));
      }
      return results;
    };

    return INIT;

  })();

}).call(this);

(function() {
  var root,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;


  /*
  
    TRACKER Class
    extends INIT class
  
    Receives new input on scroll event from event listener,
   */

  root.TRACKER = (function(superClass) {
    extend(TRACKER, superClass);

    function TRACKER() {
      TRACKER.__super__.constructor.apply(this, arguments);
      this.index = [];
      this.active = false;
      this.addChannel('tracker');
      if (this.autostart) {
        this.start();
      }
    }


    /*
    
      Pull needed data from event OBJECT and return new OBJECT
     */

    TRACKER.prototype.disassemble = function(event) {
      return {
        'y': event.currentTarget ? event.currentTarget.pageYOffset : event.target.pageYOffset,
        'x': event.currentTarget ? event.currentTarget.pageXOffset : event.target.pageXOffset,
        'timeStamp': event.timeStamp
      };
    };


    /*
    
      Store the event in the @index[]
      return the event_id
     */

    TRACKER.prototype.storeEvent = function(event) {
      return this.index.push(event) - 1;
    };


    /*
    
      Start listening for scroll events
     */

    TRACKER.prototype.start = function() {
      if (this.active) {
        return false;
      }
      this.window.scroll((function(_this) {
        return function(rawEvent) {
          var event, event_id;
          event = _this.disassemble(rawEvent);
          event_id = _this.storeEvent(event);
          return _this.broadcast('tracker', event_id);
        };
      })(this));
      return this.active = true;
    };


    /*
    
      Stop listening for scroll events
     */

    TRACKER.prototype.stop = function() {
      this.window.off('scroll');
      return this.active = false;
    };


    /*
    
      Trigger a scroll event manually
     */

    TRACKER.prototype.trigger = function() {
      return this.window.trigger('scroll');
    };

    return TRACKER;

  })(root.INIT);

}).call(this);

(function() {
  var root,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;


  /*
  
    ENGINE Class
    extends TRACKER class
    
    Receives new input on scroll event from the TRACKER
   */

  root.ENGINE = (function(superClass) {
    extend(ENGINE, superClass);

    function ENGINE() {
      this.supervisor = bind(this.supervisor, this);
      ENGINE.__super__.constructor.apply(this, arguments);
      this.addChannel('engine');
      this.subscribe('tracker', this.supervisor);
    }


    /*
    
      @supervisor() | Run tasks
    
      - Delegates input to the factories
      - Adds factory output to event in the @index[]
      - Broadcast event key when done, so subscribers know something changed
     */

    ENGINE.prototype.supervisor = function(event_id) {
      var prev_event, this_event;
      this_event = this.index[event_id];
      prev_event = this.index[event_id - 1];
      this_event.direction = root.direction(this_event, prev_event);
      this_event.speed = root.speed(this_event, prev_event);
      this.broadcast('engine', event_id);
      return event_id;
    };

    return ENGINE;

  })(root.TRACKER);

}).call(this);

(function() {
  var root,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;


  /*
  
    SCRONTROLL Class
    extends ENGINE class
  
    SCRONTROLL
      - receives a notification from the 'engine' when a new event has been triggered and processed.
   */

  root.SCRONTROLL = (function(superClass) {
    extend(SCRONTROLL, superClass);

    function SCRONTROLL() {
      this.watch = bind(this.watch, this);
      this.controller = bind(this.controller, this);
      SCRONTROLL.__super__.constructor.apply(this, arguments);
      this.addChannel('direction');
      this.subscribe('engine', this.controller);
    }


    /*
    
       @controller() | Check conditions and broadcast changes if needed
    
       arguments
         event_id = String
    
       returns
         event_id = String || FALSE = boolean
     */

    SCRONTROLL.prototype.controller = function(event_id) {
      if (event_id === 0 || this.index[event_id].direction.y !== this.index[event_id - 1].direction.y) {
        this.broadcast('direction', this.index[event_id].direction.y);
        return this.index[event_id].direction.y;
      }
      return false;
    };


    /*
    
      @watch() | Extend the @subscribe() method to a usable API Method.
    
      The function you pass as the second argument will be called every time the subscribed
      event ( name ) gets broadcasted by the controller.
    
      
    
      arguments
        name = 'String'
        callback = function( data )
    
      returns
        callback_id = 'Int'
     */

    SCRONTROLL.prototype.watch = function(name, callback) {
      return this.subscribe(name, callback);
    };

    return SCRONTROLL;

  })(root.ENGINE);

}).call(this);
