package jive;

import jive.geom.Metric;
import jive.geom.IntDimension;
import jive.geom.MetricDimension;
import jive.gestures.Gestures;
import jive.gestures.PanGesture;
import jive.gestures.SwipeGesture;
import jive.gestures.core.Gesture;
import jive.gestures.core.GestureState;
import jive.gestures.core.Touch;
import jive.gestures.events.GestureEvent;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.display.Sprite;

import motion.easing.Cubic;
import motion.Actuate;
import motion.actuators.IGenericActuator;


using jive.geom.MetricHelper;

class Swiper extends ScrolledContainer {
    private var currentIndex: Int;
    private var isHolded: Bool;
    private var prevX: Float;
    private var initX: Float;
    private var gestures: Gestures;
    private var pan: PanGesture;
    private var swipe:SwipeGesture;

    private static var GAP:Int = 100;

    private static var POWER: Float = 0.8;
    private static var MIN_SPEED: Float = 0.16;
    private static var ANIMATION_TIME: Float = 0.3;

    private var pool:Array<Component>;
    private var actuator: IGenericActuator;
    private var isInAnimationProcess:Bool;

    public function new() {
        super();

        Gestures.init();

        pool = new Array<Component>();

        currentIndex = 0;

        isInAnimationProcess = false;

        pan = new PanGesture(this);
        pan.direction = PanGesture.HORIZONTAL;
        pan.gesturesShouldRecognizeSimultaneously = panShouldRecognizeSimultaneously;

        pan.name = 'swiperPan';
        
        pan.addEventListener(GestureEvent.GESTURE_BEGAN, function(event:GestureEvent){
            Actuate.stop(actuator);
        });
        pan.addEventListener(GestureEvent.GESTURE_CHANGED, onPan);
        pan.addEventListener(GestureEvent.GESTURE_ENDED, onPanEnded);

    }

    function onPan(event:GestureEvent) {
        if (displayObjectContainer.x >= 0 || displayObjectContainer.x <= -absoluteWidth * (children.length - 1)) { 
            var sign = pan.offsetX >= 0 ? 1 : -1;
            displayObjectContainer.x += sign * Math.pow(Math.abs(pan.offsetX), POWER);
            return;
        } 

        displayObjectContainer.x += pan.offsetX;
    }

    function onPanEnded(event:GestureEvent) {
        var index = currentIndex;

        if (Math.abs(pan.velX) > MIN_SPEED) {
            if (pan.velX < 0) {
                if(currentIndex < children.length - 1 && displayObjectContainer.x <= -currentIndex * absoluteWidth)
                    currentIndex ++ ;
            } else {
                if(currentIndex > 0 && displayObjectContainer.x >= -currentIndex * absoluteWidth)
                    currentIndex -- ;
            }
        } else {
            if (displayObjectContainer.x <= -absoluteWidth / 3 - currentIndex * absoluteWidth){
                // to right
                if(currentIndex < children.length - 1)
                    currentIndex ++ ;
            } else if (displayObjectContainer.x >= absoluteWidth / 3 - currentIndex * absoluteWidth) {
                // to left
                if(currentIndex > 0)
                    currentIndex -- ;
            }             
        }

        animate(index);
    }

    function animate(index: Int) {
        var ci = currentIndex; // closure

        var current = children.get(index);
        var animation = {
            x: displayObjectContainer.x
        };

        isInAnimationProcess = true;

        actuator = Actuate.tween(animation, ANIMATION_TIME, {
            x: - ci * absoluteWidth
        })
        .ease(Cubic.easeOut)
        .onUpdate(function(){
            displayObjectContainer.x = animation.x;
        }).onComplete(function(){

            isInAnimationProcess = false;

            actuator = null;

            if (ci < index) {
                // to left 
                var c = children.get(index+1);
                if (c != null)
                    displayObjectContainer.removeChild(c.displayObject);
                    
                if (ci > 0) {
                    layoutChildren();
                }
            } else if (ci > index) {
                // to right

                var c = children.get(index-1);
                if (c != null)
                    displayObjectContainer.removeChild(c.displayObject);

                if (ci < children.length - 1) {
                    layoutChildren();
                }
            }

        });
    }

    //----------------------------------
    // Begin of IGestureDelegate implementation
    //----------------------------------
    public function swipeShouldRecognizeSimultaneously(gesture:Gesture, otherGesture:Gesture):Bool {
        return otherGesture == pan;
    }
    public function panShouldRecognizeSimultaneously(gesture:Gesture, otherGesture:Gesture):Bool {
        return otherGesture == swipe;
    }
    //----------------------------------
    // End of IGestureDelegate implementation
    //----------------------------------

    override public function append(child: Component) {
        child.width = Metric.percent(100);
        child.height = Metric.percent(100);
        child.x = Metric.percent(GAP * children.length);

        children.add(child);
        child.parent = this;
        child.repaint();

        layoutChildren();
    }

    override public function insert(index:Int, child:Component) {
        child.width = Metric.percent(100);
        child.height = Metric.percent(100);

        children.add(child, index);
        child.parent = this;
        child.repaint();

        layoutChildren(true);
    }

    override public function remove(child: Component) {
        super.remove(child);
        layoutChildren(true);
    }

    private function layoutChildren(relocate: Bool = false) {
        if (relocate) {
            var index = 0;
            for (child in children) {
                child.x = Metric.percent(GAP * index);
                child.repaint();
                index ++;
            }
        }

        for (d in [-1, 1, 0]) {
            var target = children.get(currentIndex + d);
            if (null != target && displayObjectContainer.getChildIndex(target.displayObject) < 0) {
                displayObjectContainer.addChild(target.displayObject);
                target.repaint();
            }
        }
    }

    /**
    * paints only previous, current and next children
    * isn't used standart paint method of children cause
    * custom coordinates are necessary
    **/

    override public function paint(size: IntDimension):IntDimension {
        var np = needsPaint;

        var result = super.processPaint(size);

        if (childrenNeedRepaint) {
            childrenNeedRepaint = false;
            for (d in [-1, 1, 0]) {
                var target = children.get(currentIndex + d);
                if (null != target) {
                    target.paint(calcPaintDimension(size));
                }
            }
        }

        return result;
    }
}