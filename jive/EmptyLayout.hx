package jive;

import openfl.display.DisplayObjectContainer;
import flash.display.Sprite;
import jive.geom.Metric;
import jive.geom.IntDimension;
import jive.geom.MetricDimension;

class EmptyLayout extends Container {

    private var needsLayout:Bool;

    public function new() {
        super();

        needsLayout = false;
    }

    override private function get_displayObjectContainer():Sprite {
        if (null == displayObjectContainer && null != parent) {
            displayObjectContainer = parent.displayObjectContainer;
            displayObject = displayObjectContainer;
        }
        return displayObjectContainer;
    }

    override private function createDisplayObjectContainer():Sprite {
        return null;
    }

    private function rebase() {
        for (child in children) {
            if (child.displayObject != null && child.displayObject.parent != null)
                child.displayObject.parent.removeChild(child.displayObject);
        }

        if (displayObjectContainer != null) {
            for (child in children) {
                displayObjectContainer.addChild(child.displayObject);
            }
        }

        for (child in children) {
            if (Std.is(child, EmptyLayout)) {
                cast(child, EmptyLayout).rebase();
            }
        }

        repaint();
        relayout();
    }

    override private function set_parent(c:Container):Container {
        var needRebase:Bool = parent != c;
        parent = c;
        if (needRebase)
            rebase();

        return parent;
    }

    override public function append(child:Component) {
        children.add(child);
        child.parent = this;

        if (displayObjectContainer != null) {
            displayObjectContainer.addChild(child.displayObject);
            child.repaint();
        }
    }

    override public function insert(index:Int, child:Component) {
        children.add(child, index);
        child.parent = this;

        if (displayObjectContainer != null) {
            displayObjectContainer.addChildAt(child.displayObject, index);
            child.repaint();
        }
    }

    override public function remove(child:Component) {
        if (displayObjectContainer != null) {
            displayObjectContainer.removeChild(child.displayObject);
            repaint();
        }

        children.remove(child);
        child.parent = null;
    }

    override public function paint(size: IntDimension):IntDimension {
        for (child in children) {
            var childSize:IntDimension = child.dimension;
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
        repaintChildren();
    }
}