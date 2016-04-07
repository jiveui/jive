package jive;

import jive.geom.IntDimension;
import jive.geom.PaintDimension;

class Container extends Component {

    private var childrenNeedRepaint: Bool;

    public var children: Collection<Component>;

    public function new() {
        super();
        children = new Collection();
    }

    override public function paint(size: PaintDimension): IntDimension {
        if (needsPaint) {
            if (childrenNeedRepaint) {
                for (c in children) {
                    c.paint(size);
                }
            }
            needsPaint = false;
        }
    }

    public function repaintChildren() {
        childrenNeedRepaint = true;
        if (parent != null) parent.repaintChildren();
    }
}