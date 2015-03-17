
/*
  TRACKER Class

  1. Registers the scroll callbacks
  2. Start/ Stop tracking
  3. Call callbacks on event

  arguments = {
    autostart: boolean
  }
 */

(function() {
  var TRACKER,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  TRACKER = (function() {
    function TRACKER(options) {
      this.broadcast = bind(this.broadcast, this);
      this.subscribe = bind(this.subscribe, this);
      this.index = [];
      this.current_key = 0;
      if (options) {
        this.autostart = options.autostart;
      }
      if (this.autostart === void 0) {
        this.autostart = true;
      }
      this.window = $(window);
      this.active = false;
      this.counter = 0;
      this.subscribers = {
        'tracker': []
      };
      if (this.autostart) {
        this.start();
      }
    }


    /*
    
      Add subscribers callback function to call on broadcast
     */

    TRACKER.prototype.subscribe = function(name, callback) {
      return this.subscribers[name].push(callback);
    };


    /*
    
      Broadcast scroll event_key to subscribers
     */

    TRACKER.prototype.broadcast = function(name, event_key) {
      var callback, i, len, ref, results;
      this.counter++;
      ref = this.subscribers[name];
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        callback = ref[i];
        results.push(callback(event_key));
      }
      return results;
    };


    /*
    
      Pull needed data from event object and return new object
     */

    TRACKER.prototype.disassemble = function(event) {
      return {
        'x': event.target.pageXOffset,
        'y': event.target.pageYOffset,
        'timeStamp': event.timeStamp
      };
    };


    /*
    
      Store the event in the @index[]
      Set the current_key to the new key
     */

    TRACKER.prototype.storeEvent = function(event) {
      return this.current_key = this.index.push(event) - 1;
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
          var event, event_key;
          event = _this.disassemble(rawEvent);
          event_key = _this.storeEvent(event);
          return _this.broadcast('tracker', event_key);
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

  })();

}).call(this);


/*
  PROCESSOR Class
  extends TRACKER class

  Receives new input from the TRACKER and processes it to usable data
 */

(function() {
  var ENGINE,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  ENGINE = (function(superClass) {
    extend(ENGINE, superClass);

    function ENGINE() {
      this.supervisor = bind(this.supervisor, this);
      ENGINE.__super__.constructor.apply(this, arguments);
      this.subscribers.engine = [];
      this.subscribe('tracker', this.supervisor);
    }

    ENGINE.prototype.calc_direction = function(event_key) {
      var defaults, last_event, this_event;
      defaults = {
        'x': 'down',
        'y': 'right'
      };
      if (event_key === 0) {
        return defaults;
      }
      last_event = this.index[event_key - 1];
      this_event = this.index[event_key];
      return {
        'x': this_event.x >= last_event.x ? 'down' : 'up',
        'y': this_event.y >= last_event.y ? 'right' : 'left'
      };
    };

    ENGINE.prototype.calc_speed = function(event_key) {
      var defaults, distance, last_event, this_event, time;
      defaults = {
        'x': 0,
        'y': 0
      };
      if (event_key === 0) {
        return defaults;
      }
      last_event = this.index[event_key - 1];
      this_event = this.index[event_key];
      time = this_event.timeStamp - last_event.timeStamp;
      distance = {
        'x': Math.abs(this_event.x - last_event.x),
        'y': Math.abs(this_event.y - last_event.x)
      };
      return {
        'x': (distance.x / time) * 1000,
        'y': (distance.y / time) * 1000
      };
    };

    ENGINE.prototype.supervisor = function(event_key) {
      this.index[event_key].direction = this.calc_direction(event_key);
      this.index[event_key].speed = this.calc_speed(event_key);
      return this.broadcast('engine', event_key);
    };

    return ENGINE;

  })(TRACKER);

}).call(this);


/*
  PROCESSOR Class
  extends TRACKER class

  Receives new input from the TRACKER and processes it to usable data
 */

(function() {
  var SCRONTROLL,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  SCRONTROLL = (function(superClass) {
    extend(SCRONTROLL, superClass);

    function SCRONTROLL() {
      this.watcher = bind(this.watcher, this);
      this.watch = bind(this.watch, this);
      SCRONTROLL.__super__.constructor.apply(this, arguments);
      this.subscribers.direction = [];
      this.subscribe('engine', this.watcher);
    }

    SCRONTROLL.prototype.watch = function(name, callback) {
      return this.subscribe(name, callback);
    };

    SCRONTROLL.prototype.watcher = function(event_key) {
      console.dir(this.index[event_key]);
      if (event_key === 0 || this.index[event_key].direction.x !== this.index[event_key - 1].direction.x) {
        return this.broadcast('direction', this.index[event_key].direction.x);
      }
    };

    return SCRONTROLL;

  })(ENGINE);

}).call(this);
