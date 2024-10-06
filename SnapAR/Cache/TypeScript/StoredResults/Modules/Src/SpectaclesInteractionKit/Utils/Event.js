"use strict";
/**
 * Event class with typed event arguments
 */
Object.defineProperty(exports, "__esModule", { value: true });
class Event {
    constructor(...callbacks) {
        this.subscribers = callbacks.filter((cb) => cb !== undefined);
    }
    /**
   * Register an event handler
   *
   * @param handler to register
   */
    add(handler) {
        this.subscribers.push(handler);
    }
    /**
   * Unregister an event handler
   *
   * @param handler to remove
   */
    remove(handler) {
        this.subscribers = this.subscribers.filter((h) => {
            return h !== handler;
        });
    }
    /**
   * Invoke the event and notify handlers
   *
   * @param arg Event args to pass to the handlers
   */
    invoke(arg) {
        this.subscribers.forEach((handler) => {
            handler(arg);
        });
    }
    /**
   * Construct an object to serve as the publicApi of this
   * event. This makes it so an event can be used as "pre-bound"
   * function, and also prevents "invoke" from being called externally
   */
    publicApi() {
        const event = this;
        /**
     * @param callback
     */
        function add(callback) {
            event.add(callback);
            return () => event.remove(callback);
        }
        /**
     * @param callback
     */
        function remove(callback) {
            event.remove(callback);
        }
        add.remove = remove;
        add.add = add; // can be called as a method or directly
        return add;
    }
}
exports.default = Event;
//# sourceMappingURL=Event.js.map