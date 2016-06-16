package jive;

import motion.Actuate;
import motion.easing.Cubic;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.Lib;
import jive.gestures.PanGesture;
import jive.gestures.Gestures;
import jive.gestures.events.GestureEvent;

class Scroll extends ScrolledContainer {

    private static var POWER: Float = 0.8;
    private static var INERTIAL_TIME: Float = 0.8;
    private static var BACK_TIME: Float = 0.2;
    private static var MIN_VELOCITY: Float = 0.1;
    private static var VELOCITY_MULTIPLIER: Float = 800;

    private var pan: PanGesture;
    private var lastY: Int;
    private var lastTime: Int;
    private var yTicks: Array<Int>;
    private var animation: Dynamic;

    public function new() {
        super();

        yTicks = new Array();

        Gestures.init();

        pan = new PanGesture(this);
        pan.direction = PanGesture.VERTICAL;

        pan.name = 'scrollPan';

        pan.addEventListener(GestureEvent.GESTURE_BEGAN, onPanStopAnimation);
        pan.addEventListener(GestureEvent.GESTURE_CHANGED, onPan);
        pan.addEventListener(GestureEvent.GESTURE_ENDED, onPanEnded);
    }


    private function onPanStopAnimation(event: GestureEvent){
        Actuate.stop(animation);
    }

    private function onPan(event: GestureEvent){
        var childMaxY: Int = Std.int(Math.max(0, children.get(0).absoluteHeight - absoluteHeight));

        if (displayObjectContainer.y >= 0 || displayObjectContainer.y <= -childMaxY) { 
            var sign = pan.offsetY >= 0 ? 1 : -1;
            displayObjectContainer.y += sign * Math.pow(Math.abs(pan.offsetY), POWER);
            return;
        } 

        displayObjectContainer.y += pan.offsetY;
    }

    private function onPanEnded(e: MouseEvent) {
        if (children.length > 0) {

            var childMaxY: Int = Std.int(Math.max(0, children.get(0).absoluteHeight - absoluteHeight));

            animation = {
                y: displayObjectContainer.y
            };

            var vel: Float = pan.velY / absoluteHeight * VELOCITY_MULTIPLIER;

            if (Math.abs(vel) > MIN_VELOCITY) {
                var diff: Int = Std.int(displayObjectContainer.y + absoluteHeight * vel);
                Actuate.tween(animation, Math.abs(vel) <= 1 ? INERTIAL_TIME : INERTIAL_TIME * Math.abs(vel), {y : diff}).ease(Cubic.easeOut).onUpdate(function() {
                    if (animation.y > 0) {
                        animation.y = 0;
                        Actuate.stop(animation);
                    }
                    if (animation.y <= -childMaxY) {
                        animation.y = -childMaxY;
                        Actuate.stop(animation);
                    }
                    displayObjectContainer.y = Std.int(animation.y);
                });
            }

            if (displayObjectContainer.y > 0) {
                Actuate.tween(animation, BACK_TIME, {y : 0}).ease(Cubic.easeOut).onUpdate(function() {
                    displayObjectContainer.y = Std.int(animation.y);
                });
            } else if (displayObjectContainer.y < -childMaxY) {
                Actuate.tween(animation, BACK_TIME, {y : -childMaxY}).ease(Cubic.easeOut).onUpdate(function() {
                    displayObjectContainer.y = Std.int(animation.y);
                });
            }


        }
    }

    override public function append(child:Component) {
        if (children.length > 0) {
            remove(children.get(0));
        }
        children.add(child);
        child.parent = this;
        displayObjectContainer.addChild(child.displayObject);
        child.repaint();
    }

    override public function insert(index:Int, child:Component) {
        append(child);
    }

    override public function remove(child:Component) {
        if (children.get(0) == child) {
            children.remove(child);
            displayObjectContainer.removeChild(child.displayObject);
            child.parent = null;
            repaint();
        }
    }
}
