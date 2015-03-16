
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
      console.dir(this.autostart);
      this.window = $(window);
      console.dir(this.window);
      this.active = false;
      this.subscribers = {
        'tracker': []
      };
      this.counter = 0;
      if (this.autostart === void 0 || this.autostart === true) {
        this.start();
      }
    }

    TRACKER.prototype.start = function() {
      this.window.scroll((function(_this) {
        return function(event) {
          return _this.broadcast('tracker', event);
        };
      })(this));
      return this.active = true;
    };

    TRACKER.prototype.stop = function() {
      this.window.off('scroll');
      return this.active = false;
    };

    TRACKER.prototype.trigger = function() {
      return this.window.trigger('scroll');
    };

    TRACKER.prototype.subscribe = function(name, callback) {
      return this.subscribers[name].push(callback);
    };

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
      PROCESSOR.__super__.constructor.apply(this, arguments);
      this.subscribers.processor = [];
      this.subscribe('tracker', (function(_this) {
        return function(event) {
          console.dir(event);
          event = 'Oeps, event is overriden by the PROCESSOR';
          return _this.broadcast('processor', event);
        };
      })(this));
      this.subscribe('processor', function(event) {
        console.log('Event passed by processor subscribers');
        return console.dir(event);
      });
    }

    return PROCESSOR;

  })(TRACKER);

}).call(this);

(function() {


}).call(this);
