
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
  var TRACKER;

  TRACKER = (function() {
    function TRACKER(options) {
      this.options = options;
      this.window = $(window);
      console.dir(this.window);
      this.active = false;
      this.subscribers = [];
      this.counter = 0;
      if (this.options.autostart === void 0 || this.options.autostart === true) {
        this.start();
      }
    }

    TRACKER.prototype.start = function() {
      this.window.scroll((function(_this) {
        return function(event) {
          return _this.broadcast(event);
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

    TRACKER.prototype.subscribe = function(callback) {
      return this.subscribers.push(callback);
    };

    TRACKER.prototype.broadcast = function(event) {
      var callback, i, len, ref, results;
      this.counter++;
      ref = this.subscribers;
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

(function() {


}).call(this);
