package jive.events;

import flash.events.Event;

class GestureEvent extends Event {
    public static var GESTURE_TWO_FINGER_TAP : String = "GESTURE_TWO_FINGER_TAP";

    public var localX: Float;
    public var localY: Float;

    public function new(type : String, bubbles : Bool = true, cancelable : Bool = false, ?phase : String, localX : Float = 0, localY : Float = 0, ctrlKey : Bool = false, altKey : Bool = false, shiftKey : Bool = false) {
        super(if (null != type) type else GESTURE_TWO_FINGER_TAP, bubbles, cancelable);
        this.localX = localX;
        this.localY = localY;
    }
}
