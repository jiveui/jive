package jive;

import jive.geom.Metric;
import flash.display.Sprite;
import flash.display.DisplayObject;
import jive.geom.IntDimension;

using jive.geom.MetricHelper;

@:children("jive.Component")
class Container extends Component {

    private var childrenNeedRepaint:Bool;

    public var displayObjectContainer(get, null):Sprite;

    private function get_displayObjectContainer():Sprite {
        if (null == displayObjectContainer) {
            displayObjectContainer = createDisplayObjectContainer();
            displayObject = displayObjectContainer;
        }
        return displayObjectContainer;
    }

    private function createDisplayObjectContainer():Sprite {
        return new Sprite();
    }

    override private function createDisplayObject():DisplayObject {
        return displayObjectContainer;
    }

    public var children:Collection<Component>;

    public function new() {
        super();
        children = new Collection();
    }

    public function append(child:Component) {
        children.add(child);
        child.parent = this;
        displayObjectContainer.addChild(child.displayObject);
        child.repaint();
    }

    public function insert(index:Int, child:Component) {
        children.add(child, index);
        child.parent = this;
        displayObjectContainer.addChildAt(child.displayObject, index);
        child.repaint();
    }

    public function remove(child:Component) {
        children.remove(child);
        displayObjectContainer.removeChild(child.displayObject);
        child.parent = null;
        repaint();
    }

    public function removeAll() {
        for (child in children) {
            remove(child);
        }
    }

    override public function paint(size: IntDimension): IntDimension {
        super.paint(size);

        if (childrenNeedRepaint) {
            childrenNeedRepaint = false;
            for (c in children) {
                c.paint(calcPaintDimension(size));
            }
        }

        return new IntDimension(Std.int(displayObjectContainer.width), Std.int(displayObjectContainer.height));
    }

    private function calcPaintDimension(size: IntDimension): IntDimension {
        return new IntDimension(absoluteWidth, absoluteHeight);
    }

    public function repaintChildren() {
        childrenNeedRepaint = true;
        if (parent != null) parent.repaintChildren();
    }
}