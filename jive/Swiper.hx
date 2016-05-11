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

import motion.Actuate;
import motion.actuators.IGenericActuator;


using jive.geom.MetricHelper;

class Swiper extends Container {
    private var currentIndex: Int;
    private var isHolded: Bool;
    private var prevX: Float;
    private var initX: Float;
    private var gestures: Gestures;
    private var pan: PanGesture;
    private var swipe:SwipeGesture;

    // for debug 
    private static var GAP:Int = 100;
    private var pool:Array<Component>;
    private var actuator: IGenericActuator;
    private var isInAnimationProcess:Bool;

    public function new() {
        super();

        Gestures.init();

        pool = new Array<Component>();

        currentIndex = 0;

        isInAnimationProcess = false;

        pan = new PanGesture();
        pan.direction = PanGesture.HORIZONTAL;

        swipe = new SwipeGesture();
        swipe.direction = SwipeGesture.HORIZONTAL;
        swipe.gestureShouldBegin = gestureShouldBegin;
        swipe.gestureShouldReceiveTouch = gestureShouldReceiveTouch;
        swipe.gesturesShouldRecognizeSimultaneously = gesturesShouldRecognizeSimultaneously;


        gestures = new Gestures(this);
        gestures.gesturesManager.addGesture(pan);
        gestures.gesturesManager.addGesture(swipe);

        // addEventListener(MouseEvent.MOUSE_DOWN, touchDownHandler);
        /*addEventListener(MouseEvent.MOUSE_MOVE, touchMoveHandler);
        addEventListener(MouseEvent.MOUSE_UP, touchUpHandler);
        addEventListener(MouseEvent.MOUSE_OUT, touchUpHandler);*/

        pan.addEventListener(GestureEvent.GESTURE_BEGAN, function(event:GestureEvent){
            // trace('stop animation');
            Actuate.stop(actuator);
            //onPan(event);
        });
        pan.addEventListener(GestureEvent.GESTURE_CHANGED, onPan);
        pan.addEventListener(GestureEvent.GESTURE_ENDED, onPanEnded);
        // pan.addEventListener(GestureEvent.GESTURE_FAILED, onPan);
        // pan.addEventListener(GestureEvent.GESTURE_CANCELLED, onPan);

        swipe.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onSwipe);

        //swipe.addEventListener(GestureEvent.GESTURE_FAILED, onSwipeFailed);
        //swipe.addEventListener(GestureEvent.GESTURE_ENDED, onSwipeFailed);
        //swipe.addEventListener(GestureEvent.GESTURE_CANCELLED, onSwipeFailed);
    }

    function onPan(event:GestureEvent) 
    {
        var i = 0;
        var current = children.get(currentIndex);
        // if ( current.absoluteX + pan.offsetX > - absoluteWidth / 3  && current.absoluteX + pan.offsetX < 2 * absoluteWidth / 3 ) 
        //for (c in pool) {
        // trace('onPan = ' + event.newState);

        for(d in [-1,0,1]) {    
            var c = children.get(currentIndex + d);
            if (c != null) {
                c.x = Metric.absolute(Std.int(c.absoluteX + pan.offsetX));
                c.paint(null);
            }
        }
            // trace('Child ' + (++i) + ':' + Std.int(c.absoluteX + pan.offsetX));
        //}
    }

    function onPanEnded(event:GestureEvent) {
        // trace('pan ended, currentIndex = $currentIndex');
        if (!isInAnimationProcess) {
            var index = currentIndex;
            var current = children.get(currentIndex);        
            // sync changes
            if (current.absoluteX <= -absoluteWidth / 3 ){
                // to right
                if(currentIndex < children.length - 1)
                    currentIndex ++ ;
            } else if (current.absoluteX >= absoluteWidth / 3) {
                // to left
                if(currentIndex > 0)
                    currentIndex -- ;
            } 
            animate(index);
        }
    }

    function onSwipe(event:GestureEvent)
    {
        // trace("swipe! " + swipe.offsetX);
        if (!isInAnimationProcess){
            var index = currentIndex;
            if (swipe.offsetX < 0) {
                // to right
                if(currentIndex < children.length - 1)
                    currentIndex ++ ;
            } else {
                // to right
                if(currentIndex > 0)
                    currentIndex -- ;
            }
            animate(index);
        }
        //TweenMax.to(menu, 1, {bezierThrough:[{scaleX:2}, {scaleX:1}]});
    }

    function animate(index: Int) {

        // Actuate.stop(actuator);

        // trace('index=$index, currentIndex=$currentIndex');
        
        var ci = currentIndex; // closure

        var current = children.get(index);
        var animation = {
            x: current.absoluteX 
        };

        isInAnimationProcess = true;

        actuator = Actuate.tween(animation, 0.6, {
            x: (index - ci) * absoluteWidth
        }).onUpdate(function(){
            for(d in [-1,0,1]) {
                var c = children.get(index + d);
                if (c != null)
                    c.x = Metric.absolute(Std.int(animation.x + d * absoluteWidth));
            }
        }).onComplete(function(){

            isInAnimationProcess = false;

            actuator = null;

            // trace('animation completed');
            if (ci < index) {
                // to left 
                var c = children.get(index+1);
                if (c != null)
                    displayObjectContainer.removeChild(c.displayObject);
                    
                if (ci > 0) {
                    var target = children.get(ci - 1);
                    target.x = Metric.percent(-GAP);
                    displayObjectContainer.addChild(target.displayObject);
                    displayObjectContainer.setChildIndex(target.displayObject, 0);
                    target.paint(null);
                }
            } else if (ci > index) {
                // to right

                var c = children.get(index-1);
                if (c != null)
                    displayObjectContainer.removeChild(c.displayObject);

                if (ci < children.length - 1) {
                    var target = children.get(ci + 1);
                    target.x = Metric.percent(GAP);
                    pool.push(target);
                    displayObjectContainer.addChild(target.displayObject);
                    target.paint(null);
                }

            }   
        });
    }

    //----------------------------------
    // Begin of IGestureDelegate implementation
    //----------------------------------
    public function gestureShouldReceiveTouch(gesture:Gesture, touch:Touch):Bool
    {
        return true;
    }
    
    public function gestureShouldBegin(gesture:Gesture):Bool
    {
        return true;
    }
    
    public function gesturesShouldRecognizeSimultaneously(gesture:Gesture, otherGesture:Gesture):Bool
    {
        return true;
    }
    //----------------------------------
    // End of IGestureDelegate implementation
    //----------------------------------

    private function touchDownHandler(event:MouseEvent) {
        // Actuate.stop(actuator);
        if (!isHolded) {
            initX = event.localX;
            prevX = event.localX;
            isHolded = true;
        }
    }

    override public function append(child: Component) {
        child.width = Metric.percent(100);
        child.height = Metric.percent(100);

        // if (currentIndex == 0 && children.length == 0) {
        // displayObjectContainer.addChild(child.displayObject);
        // trace('First added');
        // }
        //if (children.length - 1 == currentIndex) {
            // child.x = Metric.percent(GAP);
        // }

        children.add(child);
        // if (children.length - 1 >= currentIndex - 1 && children.length - 1 <= currentIndex + 1)
           //  displayObjectContainer.addChild(child.displayObject);
        child.parent = this;
        child.repaint();

        //childrenNeedRepaint = true;
        layoutChildren();
    }

    private function layoutChildren() {

        for (d in [-1, 0, 1]) {
            var target = children.get(currentIndex + d);
            if (null != target && displayObjectContainer.getChildIndex(target.displayObject) < 0) {
                target.x = Metric.percent(d * GAP);
                displayObjectContainer.addChild(target.displayObject);
                pool.push(target);
                //trace('Child $d: ' + target.absoluteX + ' | ' + absoluteWidth);
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
        

        super.paint(size);

        // for debug ? make for every component
        if (np) {
            displayObjectContainer.graphics.beginFill(0x009900, 0.2);
            displayObjectContainer.graphics.drawRect(0, 0, absoluteWidth, absoluteHeight);
            displayObjectContainer.graphics.endFill();
        }

        // if (childrenNeedRepaint) {
        //     childrenNeedRepaint = false;

        //     for (d in [-1, 0, 1]) {
        //         var target = children.get(currentIndex + d);
        //         if (null != target) {
        //             target.x = Metric.percent(d * GAP);
        //             target.paint(calcPaintDimension(size));
        //         }

        //     }
        // }

        return new IntDimension(Std.int(displayObjectContainer.width), Std.int(displayObjectContainer.height));
    }
}