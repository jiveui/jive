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

    public function append(child: Component) {
        children.add(child);
        child.parent = this;
        child.repaint();
    }

    public function insert(index: Int, child: Component) {
        children.add(child, index);
        child.parent = this;
        child.repaint();
    }

    public function remove(child: Component) {
        children.remove(child);
        child.parent = null;

        repaint();
    }

    public function removeAll() {
        for (child in children) {
            child.parent = null;
        }

        children.remove();

        repaint();
    }

    override public function paint(size: PaintDimension): IntDimension {
        super.paint(size);

        if (childrenNeedRepaint) {
            childrenNeedRepaint = false;
            for (c in children) {
                c.paint(size);
            }
        }

        return new IntDimension(Std.int(displayObject.width), Std.int(displayObject.height));
    }

    public function repaintChildren() {
        childrenNeedRepaint = true;
        if (parent != null) parent.repaintChildren();
    }
}