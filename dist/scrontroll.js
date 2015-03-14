
/*
  EXAMPLE Class
 */

(function() {
  var TRACKER;

  TRACKER = (function() {
    function TRACKER() {
      this.subscribers = [];
    }

    TRACKER.prototype.broadcast = function() {};

    TRACKER.prototype.subscribe = function(callback) {
      return this.subscribers.push(callback);
    };

    return TRACKER;

  })();

}).call(this);

(function() {


}).call(this);
