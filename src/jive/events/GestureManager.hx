package jive.events;

import haxe.Timer;
import motion.easing.Quart;
import motion.actuators.IGenericActuator;
import motion.Actuate;
import org.aswing.geom.IntPoint;
import org.aswing.AsWingManager;
import flash.events.Event;
import flash.geom.Point;
import flash.events.TouchEvent;
import flash.ui.MultitouchInputMode;
import flash.ui.Multitouch;
import org.aswing.Component;

class GestureManager {

    private var component: Component;

    private var touchBeginCoords: Map<Int,Point>;
    private var touchPrevCoords: Map<Int,Point>;
    private var touchCoords: Map<Int,Point>;
    private var touchBeginTimes: Map<Int,Float>;
    private var touchTimes: Map<Int,Float>;
    private var touchMoves: Map<Int, Array<Point>>;

    private var actuator: IGenericActuator;
    private var magneticBorderSize: Int;

    private var curActuatorState: Dynamic;
    private var goalActuatorState: Dynamic;


    public function new(c: Component, magneticBorderSize: Int = 0) {
        component = c;
        this.magneticBorderSize = magneticBorderSize;

        goalActuatorState = {x: 0, y:0};
        curActuatorState = {x: 0, y:0};

        clearTouches();

        if (Multitouch.supportsTouchEvents)
        {
            // If so, set the input mode and hook up our event handlers
            // TOUCH_POINT means simple touch events will be dispatched,
            // rather than gestures or mouse events
            Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

            component.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
            component.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
            component.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);

            component.addEventListener(Event.ADDED_TO_STAGE, function(e) {
                component.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
                component.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
            });
        }
    }

    private function onTouchBegin(e:TouchEvent):Void {
        if (null != actuator) {
            Actuate.stop(actuator);
            actuator = null;
        }
        removeOldTouches();

        touchBeginCoords.set(e.touchPointID, new Point(e.stageX, e.stageY));
        touchCoords.set(e.touchPointID, new Point(e.stageX, e.stageY));
        touchPrevCoords.set(e.touchPointID, new Point(e.stageX, e.stageY));
        touchBeginTimes.set(e.touchPointID, Timer.stamp());
        touchTimes.set(e.touchPointID, Timer.stamp());
        touchMoves.set(e.touchPointID, new Array<Point>());
    }

    private function onTouchMove(e:TouchEvent):Void {
        if (!touchBeginCoords.exists(e.touchPointID)) return;

        touchPrevCoords.set(e.touchPointID, touchCoords.get(e.touchPointID));

        touchMoves.get(e.touchPointID).push(new Point(Std.int(e.stageX - touchPrevCoords.get(e.touchPointID).x), Std.int(e.stageY - touchPrevCoords.get(e.touchPointID).y)));
        touchCoords.set(e.touchPointID, new Point(e.stageX, e.stageY));

        var count = Lambda.count(touchBeginCoords, function(c) {return true;});

        var a: Array<Int> = [];
        for(k in touchBeginCoords.keys()) {
            a.push(k);
        }

        if (count == 2) {
            var scaleX = 1 +
                (Math.abs(touchCoords.get(a[0]).x - touchCoords.get(a[1]).x) - Math.abs(touchPrevCoords.get(a[0]).x - touchPrevCoords.get(a[1]).x))
                / component.getWidth();
            var scaleY = 1 +
                (Math.abs(touchCoords.get(a[0]).y - touchCoords.get(a[1]).y) - Math.abs(touchPrevCoords.get(a[0]).y - touchPrevCoords.get(a[1]).y))
                / component.getHeight();

            var offsetX = (touchCoords.get(a[0]).x + touchCoords.get(a[1]).x - (touchPrevCoords.get(a[0]).x + touchPrevCoords.get(a[1]).x))/2;
            var offsetY = (touchCoords.get(a[0]).y + touchCoords.get(a[1]).y - (touchPrevCoords.get(a[0]).y + touchPrevCoords.get(a[1]).y))/2;

            var localCoords = component.globalToComponent(new IntPoint(
                Std.int((touchPrevCoords.get(a[0]).x + touchPrevCoords.get(a[1]).x)/2),
                Std.int((touchPrevCoords.get(a[0]).y + touchPrevCoords.get(a[1]).y)/2)
            ));

            component.dispatchEvent(new TransformGestureEvent(TransformGestureEvent.GESTURE_ZOOM, true, false, null, localCoords.x, localCoords.y, scaleX, scaleY, 0, offsetX, offsetY));
        } else if (count == 1) {
            var offsetX = touchCoords.get(a[0]).x - touchPrevCoords.get(a[0]).x;
            var offsetY = touchCoords.get(a[0]).y - touchPrevCoords.get(a[0]).y;

            var localCoords = component.globalToComponent(new IntPoint(
                Std.int(touchPrevCoords.get(a[0]).x),
                Std.int(touchPrevCoords.get(a[0]).y)
            ));
            component.dispatchEvent(new TransformGestureEvent(TransformGestureEvent.GESTURE_PAN, true, false, null, localCoords.x, localCoords.y, 1, 1, 0, offsetX, offsetY));
        }

        touchTimes.set(e.touchPointID, Timer.stamp());
    }

    private function onTouchEnd(e:TouchEvent):Void {
        if (!touchBeginCoords.exists(e.touchPointID)) return;

        var count = Lambda.count(touchBeginCoords, function(c) {return true;});

        if (count == 1) {

            var offsetY = 0.0;
            var offsetX = 0.0;

            var moves: Array<Point> = touchMoves.get(e.touchPointID);

            for(i in 0...Std.int(Math.min(10, moves.length))) {
                var p = moves.pop();
                offsetY += p.y;
                offsetX += p.x;
            }

            var localCoords = component.globalToComponent(new IntPoint(
                Std.int(touchPrevCoords.get(e.touchPointID).x),
                Std.int(touchPrevCoords.get(e.touchPointID).y)
            ));

            if (magneticBorderSize > 0) {
                var temp = 0.0;
                if (Math.abs(offsetY % magneticBorderSize) > magneticBorderSize / 2) {
                    offsetY = Math.abs(Std.int(offsetY/magneticBorderSize))*offsetY + (if (offsetY > 0) 1 else -1) * (magneticBorderSize - Math.abs(offsetY % magneticBorderSize));
                } else {
                    offsetY = Math.abs(Std.int(offsetY/magneticBorderSize))*offsetY + (-1) * offsetY % magneticBorderSize;
                }
                offsetY += (goalActuatorState.y - curActuatorState.y) % magneticBorderSize;
            }

            var prev = {x: 0, y: 0};
            var cur = {x: 0, y: 0};
            var actuationTime = if (Math.abs(offsetY) > magneticBorderSize) 1.5 else 0.05;
            goalActuatorState = {x: offsetX, y: offsetY};

            actuator = Actuate
                        .tween(cur, actuationTime, goalActuatorState)
                        .ease(Quart.easeOut)
                        .onUpdate(function() {
                            component.dispatchEvent(new TransformGestureEvent(TransformGestureEvent.GESTURE_PAN, true, false, null,
                                localCoords.x, localCoords.y, 1, 1, 0, Math.floor(cur.x - prev.x), Math.floor(cur.y - prev.y)));

                            prev.x = Math.floor(cur.x);
                            prev.y = Math.floor(cur.y);
                            curActuatorState = {x: prev.x, y: prev.y};
                        })
                        .onComplete(function() {
                            component.dispatchEvent(new TransformGestureEvent(TransformGestureEvent.GESTURE_PAN, true, false, "COMPLETED",
                                localCoords.x, localCoords.y, 1, 1, 0, 0, 0));
                        });
        }
        clearTouches();
    }

    private function clearTouches() {
        touchBeginCoords = new Map<Int,Point>();
        touchPrevCoords = new Map<Int,Point>();
        touchCoords = new Map<Int,Point>();
        touchBeginTimes = new Map<Int,Float>();
        touchTimes = new Map<Int,Float>();
        touchMoves = new Map<Int, Array<Point>>();
    }

    private function removeOldTouches() {
        var idsToRemove = [];
        var now = Timer.stamp();

        for(k in touchTimes.keys()) {
            if (now - touchTimes.get(k) > 0.15) idsToRemove.push(k);
        }

        for(id in idsToRemove) {
            touchBeginCoords.remove(id);
            touchPrevCoords.remove(id);
            touchCoords.remove(id);
            touchTimes.remove(id);
            touchBeginTimes.remove(id);
            touchMoves.remove(id);
        }
    }
}
