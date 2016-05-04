package jive;

import jive.geom.Metric;
import jive.geom.IntDimension;
import jive.geom.MetricDimension;

class Flow extends EmptyLayout {

    public function new() {
        super();
    }

/*    override private function calcPaintDimension(size: MetricDimension): MetricDimension {
        return new MetricDimension(_width, _height);
    }

    override public function paint(size: MetricDimension): IntDimension {
        for (child in children) {
            var childSize: IntDimension = child.dimension;
            if (!child.paint(calcPaintDimension(size)).equals(childSize)) {
                needsLayout = true;
            }
        }

        layout();

        return IntDimension.createNullDimension();
    }*/

    override private function layout() {
        if (needsLayout) {
            needsLayout = false;
            for (child in children) {
                child.displayObject.x = child.absoluteX;
                child.displayObject.y = child.absoluteY;
            }
        }
    }
}