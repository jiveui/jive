package jive;

import jive.geom.DimensionRequest;
import jive.geom.MetricHelper;
import jive.geom.Metric;
import flash.display.Sprite;
import flash.display.DisplayObject;
import jive.geom.IntDimension;

using jive.geom.MetricHelper;

@:children("jive.Component")
class Container extends Component {

    private var childrenNeedRepaint:Bool = true;
    private var needsLayout: Bool = true;

    public var children:Collection<Component>;

    public function new() {
        super();
        children = new Collection();
    }

    public function append(child:Component) {
        children.add(child);
        child.parent = this;
        sprite.addChild(child.sprite);
        child.repaint();
        relayout();
    }

    public function insert(index:Int, child:Component) {
        children.add(child, index);
        child.parent = this;
        sprite.addChildAt(child.sprite, index);
        child.repaint();
        relayout();
    }

    public function remove(child:Component) {
        children.remove(child);
        sprite.removeChild(child.sprite);
        child.parent = null;
        repaint();
        relayout();
    }

    public function removeAll() {
        for (child in children) {
            remove(child);
        }
    }

    override public function paint(size: IntDimension) {
        super.paint(size);

        if (childrenNeedRepaint) {
            childrenNeedRepaint = false;
            doChildrenRepaint(size);
        }

        layout(size);
    }

    private function doChildrenRepaint(size: IntDimension) {
        for (c in children) {
            c.paint(calcPaintComponentSize(c, size));
        }
    }

    private function calcPaintComponentSize(c: Component, size: IntDimension): IntDimension {
        return size;
    }

    override public function repaint() {
        if (!needsPaint) {
            super.repaint();
            for (c in children) {
                c.repaint();
            }
        }
    }

    public function repaintChildren() {
        if (!childrenNeedRepaint) {
            childrenNeedRepaint = true;
            if (parent != null) parent.repaintChildren();
            relayout();
        }
    }

    private function layout(size: IntDimension) {
        if (needsLayout) {
            needsLayout = false;
            for (child in children) {
                var insets = child.margin.toInsets(child);
                child.updateSpriteTransformationMatrix(child.absoluteX() + insets.left, child.absoluteY() + insets.top);
            }
        }
    }

    public function relayout() {
        needsLayout = true;
    }
}