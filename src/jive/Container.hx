package jive;

import jive.geom.IntDimension;
import jive.geom.MetricHelper;

using jive.geom.MetricHelper;

class Container extends Component {

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
        childrenNeedRepaint = false;
    }

    public function repaintChildren() {
        childrenNeedRepaint = true;
        if (parent != null) parent.repaintChildren();
    }
}