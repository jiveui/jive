package jive.events;

class TransformGestureEvent extends GestureEvent {
    public static var GESTURE_PAN:String = "GESTURE_PAN";
    public static var GESTURE_ROTATE:String = "GESTURE_ROTATE";
    public static var GESTURE_SWIPE:String = "GESTURE_SWIPE";
    public static var GESTURE_ZOOM:String = "GESTURE_ZOOM";

    public var offsetX:Float;
    public var offsetY:Float;
    public var rotation:Float;
    public var scaleX:Float;
    public var scaleY:Float;
    public var phase:String;

    public function new(type:String, bubbles:Bool = true, cancelable:Bool = false, ?phase:String, localX:Float = 0, localY:Float = 0, scaleX:Float = 1, scaleY:Float = 1, rotation:Float = 0, offsetX:Float = 0, offsetY:Float = 0, ctrlKey:Bool = false, altKey:Bool = false, shiftKey:Bool = false) {
        this.scaleX = scaleX;
        this.scaleY = scaleY;
        this.offsetX = offsetX;
        this.offsetY = offsetY;
        this.phase = phase;
        super(type, bubbles, cancelable, phase, localX, localY);
    }
}
