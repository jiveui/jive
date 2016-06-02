package jive;

import jive.geom.IntDimension;

class EmptyLayout extends Container {

    private var needsLayout: Bool;

    public function new() {
        super();

        relayout();
    }

    override public function append(child: Component) {
        relayout();
        super.append(child);
    }

    override public function insert(index: Int, child: Component) {
        relayout();
        super.insert(index, child);
    }

    override public function remove(child: Component) {
        relayout();
        super.remove(child);
    }

    override public function paint(size: IntDimension): IntDimension {
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
    }
}