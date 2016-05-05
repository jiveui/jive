package jive;

import jive.geom.Metric;
import jive.geom.IntDimension;
import jive.geom.MetricDimension;

class Flow extends EmptyLayout {

    public function new() {
        super();
    }

    override private function layout() {
        if (needsLayout) {
            needsLayout = false;
            var x: Float = 0;
            var y: Float = 0;
            for (child in children) {
                child.displayObject.x = x;
                child.displayObject.y = y;
                x+=child.absoluteWidth;
                //y+=child.absoluteHeight;
            }
        }
    }
}