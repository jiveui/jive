package jive;

import jive.geom.Metric;

class Flow extends EmptyLayout {

    public function new() {
        super();
    }

    override private function layout() {
        if (needsLayout) {
            needsLayout = false;
            var x:Float = 0;
            var y:Float = 0;
            for (child in children) {
                // child.displayObject.x = x;
                // child.displayObject.y = y;
                child.x = Metric.absolute(Std.int(x));
                child.y = Metric.absolute(Std.int(y));
                // x += child.absoluteWidth;
                y+=child.absoluteHeight;
            }
            height = Metric.absolute(Std.int(y));
        }
    }
}