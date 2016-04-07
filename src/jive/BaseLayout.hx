package jive;

import jive.geom.IntDimension;
import jive.geom.PaintDimension;

class BaseLayout extends Container {

    private var needsLayout: Bool;

    public function new() {
        super();
    }

    override public function paint(size: PaintDimension): IntDimension {
        super.paint(size);
        if (needsLayout) {
            layout();
        }
        needsLayout = false;
    }

    private function layout() {
        /*for (c in children) {
            c.displayObject.x = c.x.toAbsolute(this);
            c.displayObject.y = c.y.toAbsolute(this);
        }*/
    }

    public function relayout() {
        needsLayout = true;
        repaintChildren();
    }
}
