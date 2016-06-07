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
        //pan.addEventListener(GestureEvent.GESTURE_CANCELLED, onPanStopAnimation);
        //pan.addEventListener(GestureEvent.GESTURE_FAILED, onPanStopAnimation);
    }


    private function onPanStopAnimation(event: GestureEvent){
        Actuate.stop(animation);
    }
    private function onPan(event: GestureEvent){
        // var prev = displayObjectContainer.scrollRect.y;
        
        // displayObjectContainer.scrollRect = new Rectangle(0, prev - pan.offsetY, absoluteWidth, absoluteHeight);
        displayObjectContainer.y += pan.offsetY;

        // accountVelocity(Std.int(pan.offsetY));
    }

    // private function accountVelocity(diffY: Int) {
    //     var newTime: Int = Std.int(Lib.getTimer() / 20);
    //     if (lastTime < newTime) {
    //         if (yTicks.length > 1 && (diffY - yTicks[yTicks.length - 1]) * (yTicks[yTicks.length - 1] - yTicks[0]) < 0) {
    //             yTicks.splice(0, yTicks.length);
    //         }
    //         yTicks.push(diffY);
    //         lastTime = newTime;
    //         if (yTicks.length > 50) yTicks.shift();
    //     }
    // }

    private function onPanEnded(e: MouseEvent) {
        if (children.length > 0) {

            var childMaxY: Int = Std.int(Math.max(0, children.get(0).absoluteHeight - absoluteHeight));

            animation = {
                // y: displayObjectContainer.scrollRect.y
                y: displayObjectContainer.y
            };

            if (Math.abs(pan.velY) > 0.1) {
                //calc path
                // var diff: Int = Std.int(displayObjectContainer.scrollRect.y + absoluteHeight * 0.1 * (lastTime - firstTime) / (yTicks.length + 2));
                var diff: Int = Std.int(displayObjectContainer.y + absoluteHeight * pan.velY * 0.3);

                Actuate.tween(animation, 1, {y : diff}).ease(Cubic.easeOut).onUpdate(function() {
                    // if (animation.y >= Std.int(absoluteHeight * 0.05)) {
                    //     animation.y = Std.int(absoluteHeight * 0.05);
                    //     Actuate.stop(animation);
                    // }
                    // if (animation.y <= - childMaxY - Std.int(absoluteHeight * 0.05)) {
                    //     animation.y = - childMaxY - Std.int(absoluteHeight * 0.05);
                    //     Actuate.stop(animation);
                    // }
                    // displayObjectContainer.scrollRect = new Rectangle(0, animation.y, absoluteWidth, absoluteHeight);

                    if (animation.y > 0) {
                        animation.y = 0;
                        Actuate.stop(animation);
                    }
                    if (animation.y <= - childMaxY) {
                        animation.y = - childMaxY;
                        Actuate.stop(animation);
                    }

                    displayObjectContainer.y = Std.int(animation.y);

                    // if (displayObjectContainer.scrollRect.y < 0) {
                    // if (displayObjectContainer.y > 0) {
                    //     Actuate.tween(animation, 0.2, {y : 0}).onUpdate(function() {
                    //         // displayObjectContainer.scrollRect = new Rectangle(0, animation.y, absoluteWidth, absoluteHeight);
                    //         displayObjectContainer.y = Std.int(animation.y);
                    //     });
                    // // } else if (displayObjectContainer.scrollRect.y > childMaxY) {
                    // } else if (displayObjectContainer.y < -childMaxY) {
                    //     Actuate.tween(animation, 0.2, {y : -childMaxY}).onUpdate(function() {
                    //         // displayObjectContainer.scrollRect = new Rectangle(0, animation.y, absoluteWidth, absoluteHeight);
                    //         displayObjectContainer.y = Std.int(animation.y);
                    //     });
                    // }
                });
            }

            if (displayObjectContainer.y > 0) {
                Actuate.tween(animation, 0.2, {y : 0}).onUpdate(function() {
                    // displayObjectContainer.scrollRect = new Rectangle(0, animation.y, absoluteWidth, absoluteHeight);
                    displayObjectContainer.y = Std.int(animation.y);
                });
            } else if (displayObjectContainer.y < -childMaxY) {
                Actuate.tween(animation, 0.2, {y : -childMaxY}).onUpdate(function() {
                    // displayObjectContainer.scrollRect = new Rectangle(0, animation.y, absoluteWidth, absoluteHeight);
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
