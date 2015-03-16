
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
      this.subscribe = bind(this.subscribe, this);
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
    
      Broadcast scroll event to subscribers
     */

    TRACKER.prototype.broadcast = function(name, event) {
      var callback, i, len, ref, results;
      this.counter++;
      ref = this.subscribers[name];
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        callback = ref[i];
        results.push(callback(event));
      }
      return results;
    };


    /*
    
      Pull needed data from event object and return new object
     */

    TRACKER.prototype.disassemble = function(event) {
      return {
        'offset': {
          'x': event.target.pageXOffset,
          'y': event.target.pageYOffset
        },
        'timeStamp': event.timeStamp
      };
    };


    /*
    
      Start listening for scroll events
     */

    TRACKER.prototype.start = function() {
      if (this.active) {
        return false;
      }
      this.window.scroll((function(_this) {
        return function(event) {
          return _this.broadcast('tracker', _this.disassemble(event));
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
  var PROCESSOR,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  PROCESSOR = (function(superClass) {
    extend(PROCESSOR, superClass);

    function PROCESSOR() {
      this.index = [];
      PROCESSOR.__super__.constructor.apply(this, arguments);
      this.subscribers.processor = [];
      this.subscribe('tracker', (function(_this) {
        return function(event) {
          var key;
          key = _this.index.push(event) - 1;
          return _this.broadcast('processor', _this.index[key]);
        };
      })(this));
    }

    return PROCESSOR;

  })(TRACKER);

}).call(this);

(function() {


}).call(this);
