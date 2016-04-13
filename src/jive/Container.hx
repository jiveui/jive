package jive;

import flash.display.Sprite;
import flash.display.DisplayObject;
import jive.geom.IntDimension;
import jive.geom.PaintDimension;

class Container extends Component {

    private var childrenNeedRepaint: Bool;

    public var displayObjectContainer(get, null): Sprite;
    private function get_displayObjectContainer(): Sprite {
        if (null == displayObjectContainer) {
            displayObjectContainer = createDisplayObjectContainer();
        }
        return displayObjectContainer;
    }

    private function createDisplayObjectContainer(): Sprite {
        return new Sprite();
    }

    override private function createDisplayObject(): DisplayObject {
        return displayObjectContainer;
    }

    public var children: Collection<Component>;

    public function new() {
        super();
        children = new Collection();
    }

    public function append(child: Component) {
        children.add(child);
        displayObjectContainer.addChild(child.displayObject);
        child.parent = this;
        child.repaint();
    }

    public function insert(index: Int, child: Component) {
        children.add(child, index);
        displayObjectContainer.addChildAt(child.displayObject, index);
        child.parent = this;
        child.repaint();
    }

    public function remove(child: Component) {
        children.remove(child);
        displayObjectContainer.removeChild(child.displayObject);
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