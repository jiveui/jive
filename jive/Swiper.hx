package jive;

import jive.geom.Metric;
import jive.geom.IntDimension;
import jive.geom.MetricDimension;
import jive.events.GestureManager;

using jive.geom.MetricHelper;

class Swiper extends Container {
    private var currentIndex:Int;
    private var gestureManager:GestureManager;

    // for debug 
    private static var GAP:Int = 100;

    public function new() {
        super();
        currentIndex = 0;
        gestureManager = new GestureManager(this);
    }

    override public function append(child:Component) {

        child.width = Metric.percent(100);
        child.height = Metric.percent(100);

        // if (currentIndex == 0 && children.length == 0) {
        // displayObjectContainer.addChild(child.displayObject);
        // trace('First added');
        // }
        // TODO: separate function to display wanted childs  
        if (children.length - 1 == currentIndex) {
            child.x = Metric.percent(GAP);
            // trace('Second added');
        }

        children.add(child);
        if (children.length - 1 >= currentIndex - 1 && children.length - 1 <= currentIndex + 1)
            displayObjectContainer.addChild(child.displayObject);
        child.parent = this;
        child.repaint();
    }
    /**
    * paints only previous, current and next children
    * isn't used standart paint method of children cause
    * custom coordinates are necessary
    **/

    override public function paint(size:MetricDimension):IntDimension {
        super.paint(size);

        if (childrenNeedRepaint) {
            childrenNeedRepaint = false;

            for (d in [-1, 0, 1]) {
                var target = children.get(currentIndex - d);
                if (null != target) {
                    target.x = Metric.percent(d * GAP);
                    target.paint(calcPaintDimension(size));
                    trace(d * GAP);
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