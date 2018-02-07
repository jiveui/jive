package jive;

import openfl.Lib;
import org.aswing.JPanel;
import org.aswing.JViewport;
import org.aswing.Container;
import org.aswing.Component;
import org.aswing.JScrollPane;
import org.aswing.geom.IntDimension;
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

class Swiper extends Container {

    private var wrap: JPanel;

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

        wrap = new JPanel();
        addChild(wrap);

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
        if (wrap.x >= 0 || wrap.x <= -this.width * (children.length - 1)) {
            var sign = pan.offsetX >= 0 ? 1 : -1;
            wrap.x += sign * Math.pow(Math.abs(pan.offsetX), POWER);
            return;
        } 

        wrap.x += pan.offsetX;
    }

    function onPanEnded(event:GestureEvent) {
        var index = currentIndex;

        trace(index);
        trace(wrap.x);
        trace(width);
        if (Math.abs(pan.velX) > MIN_SPEED) {
            if (pan.velX < 0) {
                if(index < pool.length - 1 && wrap.x <= -index * this.width)
                    index ++ ;
            } else {
                if(index > 0 && wrap.x >= -index * this.width)
                    index -- ;
            }
        } else {
            if (wrap.x <= -this.width / 3 - index * this.width){
                // to right
                if(index < pool.length - 1)
                    index ++ ;
            } else if (wrap.x >= this.width / 3 - index * this.width) {
                // to left
                if(index > 0)
                    index -- ;
            }             
        }
        trace(index);
        animate(index);
    }

    function animate(newIndex: Int) {
        var oldIndex = currentIndex; // closure

        var animation = {
            x: wrap.x
        };

        isInAnimationProcess = true;

        actuator = Actuate.tween(animation, ANIMATION_TIME, {
            x: - newIndex * this.width
        })
        .ease(Cubic.easeOut)
        .onUpdate(function(){
            wrap.x = animation.x;
        }).onComplete(function(){

            isInAnimationProcess = false;
            actuator = null;
            currentIndex = newIndex;

            if (oldIndex > newIndex) {
                // to left 
                var c = pool[oldIndex+1];
                if (c != null)
                    wrap.remove(c);
                    
                if (oldIndex > 0) {
                    placeChildren();
                }
            } else if (oldIndex < newIndex) {
                // to right

                var c = pool[oldIndex-1];
                if (c != null)
                    wrap.remove(c);

                if (oldIndex < pool.length - 1) {
                    placeChildren();
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

    override public function append(com:Component, constraints:Dynamic=null): Void {
        pool.push(com);
        placeChildren(true);
    }

    override public function insert(i:Int, com:Component, constraints:Dynamic=null): Void {
        pool.insert(i, com);
        placeChildren(true);
    }

    override public function remove(com:Component): Component{
        super.remove(com);
        placeChildren(true);
        return com;
    }

    private function placeChildren(relocate: Bool = false) {
        trace(pool);
        if (relocate) {
            var index = 0;
            for (child in pool) {
                child.x = index * Std.int(width);
                trace(child.x);
                index++;
            }
        }
        for (d in [-1, 1, 0]) {
            var target = pool[currentIndex + d];
            trace(target);
            if (null != target && wrap.getChildIndex(target) < 0) {
                trace(target);
                wrap.append(target);
            }
        }
    }
}