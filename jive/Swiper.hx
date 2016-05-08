package jive;

import jive.geom.Metric;
import jive.geom.IntDimension;
import jive.geom.MetricDimension;
import jive.events.GestureManager;
import openfl.events.Event;
import openfl.events.MouseEvent;

using jive.geom.MetricHelper;

class Swiper extends Container {
    private var currentIndex: Int;
    private var isHolded: Bool;
    private var prevX: Float;
    private var initX: Float;

    // for debug 
    private static var GAP:Int = 100;

    public function new() {
        super();
        currentIndex = 0;

        addEventListener(MouseEvent.MOUSE_DOWN, touchDownHandler);
        addEventListener(MouseEvent.MOUSE_MOVE, touchMoveHandler);
        addEventListener(MouseEvent.MOUSE_UP, touchUpHandler);
        addEventListener(MouseEvent.MOUSE_OUT, touchUpHandler);
        
        // TODO: add inertial moving
    }

    private function touchDownHandler(event:MouseEvent) {
        if (!isHolded) {
            initX = event.localX;
            prevX = event.localX;
            isHolded = true;
        }
    }

    private function touchMoveHandler(event:MouseEvent) {
        if (isHolded) {
            var dx = event.localX - prevX;
            prevX = event.localX;

            //for(c in children)
            trace(dx);
            var i = 0;

            var current = children.get(currentIndex);

            if ( current.absoluteX + dx > -0.9 * absoluteWidth  && current.absoluteX + dx < 0.9 * absoluteWidth ) {
                for(d in [-1, 0, 1]) {
                    var target = children.get(currentIndex + d);
                    if (null != target) {
                        target.x = Metric.absolute(Std.int(target.absoluteX + dx));    
                        target.paint(null);
                        trace('Child $d:' + Std.int(target.absoluteX + dx));
                    }
                }    
            }


            
        }
    }

    private function touchUpHandler(event:MouseEvent) {
        if (isHolded) {
            var dx = event.localX - prevX;
        }
        isHolded = false;
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
                trace('Child $d: ' + target.absoluteX + ' | ' + absoluteWidth);
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

        if (childrenNeedRepaint) {
            childrenNeedRepaint = false;

            for (d in [-1, 0, 1]) {
                var target = children.get(currentIndex + d);
                if (null != target) {
                    target.x = Metric.percent(d * GAP);
                    target.paint(calcPaintDimension(size));
                }

            }
        }

        return new IntDimension(Std.int(displayObjectContainer.width), Std.int(displayObjectContainer.height));
    }

    private function paintPrev() {
        var target = children.get(currentIndex - 1);
        if (null != target) {
            target.x = Metric.percent(-GAP);
            target.repaint();
        }
    }

    private function paintCurrent() {
        var target = children.get(currentIndex);
        if (null != target) {
            target.x = Metric.percent(0);
            target.repaint();
        }
    }

    private function paintNext() {
        var target = children.get(currentIndex + 1);
        if (null != target) {
            target.x = Metric.percent(GAP);
            target.repaint();
        }
    }
}