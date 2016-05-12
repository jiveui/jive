package jive;

import motion.Actuate;
import motion.easing.Cubic;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.Lib;
import jive.gestures.PanGesture;
import jive.gestures.Gestures;
import jive.gestures.events.GestureEvent;

class Scroll extends Container {
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


        pan.addEventListener(GestureEvent.GESTURE_BEGAN, onPanStopAnimation);
        //pan.addEventListener(GestureEvent.GESTURE_CANCELLED, onPanStopAnimation);
        //pan.addEventListener(GestureEvent.GESTURE_FAILED, onPanStopAnimation);
        pan.addEventListener(GestureEvent.GESTURE_CHANGED, onPan);
        pan.addEventListener(GestureEvent.GESTURE_ENDED, mouseUp);

        addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
    }


    private function onPanStopAnimation(event: GestureEvent){
        Actuate.stop(animation);
    }
    private function onPan(event: GestureEvent){
        var prev = displayObjectContainer.scrollRect.y;
        displayObjectContainer.scrollRect = new Rectangle(0, prev - pan.offsetY, absoluteWidth, absoluteHeight);
        accountVelocity(Std.int(pan.offsetY));
    }

    private function accountVelocity(diffY: Int) {
        var newTime: Int = Std.int(Lib.getTimer() / 20);
        if (lastTime < newTime) {
            if (yTicks.length > 1 && (diffY - yTicks[yTicks.length - 1]) * (yTicks[yTicks.length - 1] - yTicks[0]) < 0) {
                yTicks.splice(0, yTicks.length);
            }
            yTicks.push(diffY);
            lastTime = newTime;
            if (yTicks.length > 50) yTicks.shift();
        }
    }

    override private function set_parent(c:Container):Container {
        super.set_parent(c);

        displayObjectContainer.graphics.lineStyle(1, 0);
        displayObjectContainer.graphics.beginFill(0, 0);
        displayObjectContainer.graphics.drawRect(0, 0, absoluteWidth, absoluteHeight - 1);

        return c;
    }

    private function mouseDown(e: MouseEvent) {
        //Actuate.stop(animation);
        // if (children.length > 0) {
        //     lastY = Std.int(e.stageY + displayObjectContainer.scrollRect.y);
        //     lastTime = Std.int(Lib.getTimer() / 20);
        //     yTicks.push(lastY);
        //     Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
        //     Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
        //     // displayObjectContainer.startDrag(false, new Rectangle(0, -absoluteHeight, 0, absoluteHeight));
        // }
    }

    private function mouseUp(e: MouseEvent) {
        if (children.length > 0) {
            Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
            Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);

            var childMaxY: Int = Std.int(Math.max(0, children.get(0).absoluteHeight - absoluteHeight));

            animation = {
                y: displayObjectContainer.scrollRect.y
            };

            if (yTicks.length > 1) {
                var firstTime: Int = yTicks.shift();
                var lastTime: Int = yTicks.pop();

                //calc path
                var diff: Int = Std.int(displayObjectContainer.scrollRect.y + absoluteHeight * 0.1 * (lastTime - firstTime) / (yTicks.length + 2));

                Actuate.tween(animation, 1, {y : diff}).ease(Cubic.easeOut).onUpdate(function() {
                    if (animation.y <= - Std.int(absoluteHeight * 0.05)) {
                        animation.y = - Std.int(absoluteHeight * 0.05);
                        Actuate.stop(animation);
                    }
                    if (animation.y >= childMaxY + Std.int(absoluteHeight * 0.05)) {
                        animation.y = childMaxY + Std.int(absoluteHeight * 0.05);
                        Actuate.stop(animation);
                    }
                    displayObjectContainer.scrollRect = new Rectangle(0, animation.y, absoluteWidth, absoluteHeight);

                    if (displayObjectContainer.scrollRect.y < 0) {
                        Actuate.tween(animation, 0.2, {y : 0}).onUpdate(function() {
                            displayObjectContainer.scrollRect = new Rectangle(0, animation.y, absoluteWidth, absoluteHeight);
                        });
                    } else if (displayObjectContainer.scrollRect.y > childMaxY) {
                        Actuate.tween(animation, 0.2, {y : childMaxY}).onUpdate(function() {
                            displayObjectContainer.scrollRect = new Rectangle(0, animation.y, absoluteWidth, absoluteHeight);
                        });
                    }
                });
            }

            if (displayObjectContainer.scrollRect.y < 0) {
                Actuate.tween(animation, 0.2, {y : 0}).onUpdate(function() {
                    displayObjectContainer.scrollRect = new Rectangle(0, animation.y, absoluteWidth, absoluteHeight);
                });
            } else if (displayObjectContainer.scrollRect.y > childMaxY) {
                Actuate.tween(animation, 0.2, {y : childMaxY}).onUpdate(function() {
                    displayObjectContainer.scrollRect = new Rectangle(0, animation.y, absoluteWidth, absoluteHeight);
                });
            }
        }
    }

    private function mouseMove(e: MouseEvent) {
        if (children.length > 0) {
            var childMaxY: Int = Std.int(Math.max(0, children.get(0).absoluteHeight - absoluteHeight));
            var diffY: Int = Std.int(lastY - e.stageY);

            // change 1/2 in Math.pow for more space behind the screen. e.g. 0.8

            if (diffY < 0) {
                diffY = - Std.int(Math.pow(-diffY, 1 / 2));
            }

            if (diffY > childMaxY) {
                diffY = childMaxY + Std.int(Math.pow(diffY - childMaxY, 1 / 2));
            }

            displayObjectContainer.scrollRect = new Rectangle(0, diffY, absoluteWidth, absoluteHeight);

            var newTime: Int = Std.int(Lib.getTimer() / 20);
            if (lastTime < newTime) {
                if (yTicks.length > 1 && (diffY - yTicks[yTicks.length - 1]) * (yTicks[yTicks.length - 1] - yTicks[0]) < 0) {
                    yTicks.splice(0, yTicks.length);
                }
                yTicks.push(diffY);
                lastTime = newTime;
                if (yTicks.length > 50) yTicks.shift();
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

    /*function onPan(event:GestureEvent) {
        if (children.length > 0) {
            trace(displayObject.scrollRect.y - pan.offsetY);
            children.get(0).displayObject.scrollRect = new Rectangle(0, children.get(0).displayObject.scrollRect.y - pan.offsetY, children.get(0).absoluteWidth, children.get(0).absoluteHeight);
        }
    }*/
}
