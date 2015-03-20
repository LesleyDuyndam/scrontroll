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
    var defaults, direction;
    defaults = {
      'y': 'atTop',
      'x': 'atLeft',
      'yChanged': true,
      'xChanged': true
    };
    if (prev_event === void 0) {
      return defaults;
    }
    direction = {
      'y': this_event.y >= prev_event.y ? 'down' : 'up',
      'x': this_event.x >= prev_event.x ? 'right' : 'left'
    };
    direction.yChanged = direction.y !== prev_event.direction.y ? true : false;
    direction.xChanged = direction.x !== prev_event.direction.x ? true : false;
    return direction;
  };

}).call(this);

(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;


  /*
  
    Speed factory
  
  
    Gets the current and previous event as a argument. It calculates the scroll speed per second
    and returns the results as an object { x: int, y: int }.
  
    int = PPS ( Pixels per Second )
  
    returns { x: int, y: int }
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


  /*
  
    Average speed factory
  
  
    Gets the complete event array. It calculates the average scroll speed per second
    and returns the results as an object { x: int, y: int }.
  
    int = PPS ( Pixels per Second )
  
    returns { x: int, y: int }
   */

  root.average_speed = function(event_index, max_decimals) {
    var buffer, event, fn, i, len;
    max_decimals = max_decimals !== void 0 ? parseInt(max_decimals) : 3;
    console.dir(event_index);
    buffer = {
      x: 0,
      y: 0
    };
    fn = function(event) {
      buffer.y += event.speed.y;
      return buffer.x += event.speed.x;
    };
    for (i = 0, len = event_index.length; i < len; i++) {
      event = event_index[i];
      fn(event);
    }
    if (max_decimals) {
      return {
        y: parseFloat((buffer.y / event_index.length).toFixed(max_decimals)),
        x: parseFloat((buffer.x / event_index.length).toFixed(max_decimals))
      };
    } else {
      return {
        y: parseInt(buffer.y / event_index.length),
        x: parseInt(buffer.x / event_index.length)
      };
    }
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
      this.window = $(window);
      this.channel = {};
      if (options) {
        this.autostart = options.autostart;
      }
      if (this.autostart === void 0) {
        this.autostart = true;
      }
    }


    /*
    
      Check if a channel has been created
     */

    INIT.prototype.channelExist = function(name) {
      return Array.isArray(this.channel[name]);
    };


    /*
    
      Push subscribers callback to the channel[ name ]
     */

    INIT.prototype.subscribe = function(name, callback) {
      if (!this.channelExist(name)) {
        this.channel[name] = [];
      }
      return this.channel[name].push(callback) - 1;
    };

    INIT.prototype.unsubscribe = function(name, subscription_id) {
      if (this.channelExist(name)) {
        return this.channel[name][subscription_id] = null;
      }
      return false;
    };


    /*
    
      Broadcast scroll data to subscribers
     */

    INIT.prototype.broadcast = function(name, data) {
      var callback, i, len, ref;
      if (this.channelExist(name)) {
        ref = this.channel[name];
        for (i = 0, len = ref.length; i < len; i++) {
          callback = ref[i];
          callback(data);
        }
        return data;
      }
      return false;
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
    }


    /*
    
      Pull needed data from event OBJECT and return new OBJECT
     */

    TRACKER.prototype.extractCore = function(event) {
      return {
        'y': event.currentTarget ? event.currentTarget.pageYOffset : event.target.pageYOffset,
        'x': event.currentTarget ? event.currentTarget.pageXOffset : event.target.pageXOffset,
        'timeStamp': event.timeStamp
      };
    };


    /*
    
      Start listening for scroll events
    
      Return false if tracker is already running
     */

    TRACKER.prototype.start = function() {
      if (this.active) {
        return false;
      }
      this.window.scroll((function(_this) {
        return function(event) {
          var event_id;
          event_id = _this.index.push(_this.extractCore(event)) - 1;
          return _this.broadcast('tracker', event_id);
        };
      })(this));
      return this.active = true;
    };


    /*
    
      Stop listening for scroll events
     */

    TRACKER.prototype.stop = function() {
      if (this.active) {
        this.window.off('scroll');
        this.active = false;
      }
      return true;
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
   */

  root.ENGINE = (function(superClass) {
    extend(ENGINE, superClass);

    function ENGINE() {
      this.router = bind(this.router, this);
      ENGINE.__super__.constructor.apply(this, arguments);
      this.subscribe('tracker', this.router);
    }


    /*
    
      @router() | Run tasks
    
      - Delegates input to the factories
      - Adds factory output to event in the @index[]
      - Broadcast event key when done, so subscribers know something changed
     */

    ENGINE.prototype.router = function(event_id) {
      var prev_event, this_event;
      this_event = this.index[event_id];
      prev_event = this.index[event_id - 1];
      if (this.channelExist('direction') || this.channelExist('vertical-direction') || this.channelExist('horizontal-direction')) {
        this_event.direction = root.direction(this_event, prev_event);
        if (this.channelExist('direction')) {
          if (this_event.direction.xChanged || this_event.direction.yChanged) {
            this.broadcast('direction', this_event);
          }
        }
        if (this.channelExist('horizontal-direction')) {
          if (this_event.direction.xChanged) {
            this.broadcast('horizontal-direction', this_event.direction.x);
          }
        }
        if (this.channelExist('vertical-direction')) {
          if (this_event.direction.yChanged) {
            this.broadcast('vertical-direction', this_event.direction.y);
          }
        }
      }
      if (this.channelExist('speed')) {
        this_event.speed = root.speed(this_event, prev_event);
        if (this_event.speed > 0) {
          this.broadcast('speed', this_event);
        }
      }
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
   */

  root.SCRONTROLL = (function(superClass) {
    extend(SCRONTROLL, superClass);

    function SCRONTROLL() {
      this.watch = bind(this.watch, this);
      SCRONTROLL.__super__.constructor.apply(this, arguments);
      if (this.autostart) {
        this.start();
      }
    }

    SCRONTROLL.prototype.watch = function(name, callback) {
      return this.subscribe(name, callback);
    };

    return SCRONTROLL;

  })(root.ENGINE);

}).call(this);
