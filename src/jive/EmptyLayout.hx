package jive;

import jive.geom.Metric;
import jive.geom.IntDimension;
import jive.geom.IntDimension;
import jive.geom.MetricDimension;

class EmptyLayout extends Container {

    private var needsLayout: Bool;

    public function new() {
        super();

        needsLayout = false;
    }

    override private function calcPaintDimension(size: MetricDimension): MetricDimension {
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
    }

    private function layout() {
        if (needsLayout) {
            needsLayout = false;
            for (child in children) {
                child.displayObject.x = child.absoluteX;
                child.displayObject.y = child.absoluteY;
            }
        }
    }

    public function relayout() {
        needsLayout = true;
        repaintChildren();
    }
}