package jive;

import jive.geom.IntDimension;
import jive.geom.MetricHelper;

using jive.geom.MetricHelper;

class Container extends Component {

    private var needsLayout: Bool;
    private var childrenNeedRepaint: Bool;

    public var children: Collection<Component>;

    public function new() {
        super();
        children = new Collection();
    }

    override public function paint(size: IntDimension) {
        if (childrenNeedRepaint) {
            for (c in children) {
                c.paint(size);
            }
        }
        needsPaint = false;
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

    public function repaintChildren() {
        childrenNeedRepaint = true;
        if (parent != null) parent.repaintChildren();
    }
}