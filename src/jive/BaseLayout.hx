package jive;

import jive.geom.IntDimension;

class BaseLayout extends Conatainer {

    private var needsLayout: Bool;

    public function new() {
        super();
    }

    override public function paint(size: IntDimension) {
        suepet.paint(size);
        if (needsLayout) {
            layout();
        }
        needsLayout = false;
    }

    private function layout() {
        for (c in children) {
            c.displayObject.x = c.x.toAbsolute(this);
            c.displayObject.y = c.y.toAbsolute(this);
        }
    }

    public function relayout() {
        needsLayout = true;
        if (null != parent) {
            parent.relayout();
        }
    }
}
