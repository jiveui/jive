package jive;

import jive.geom.DimensionRequest;
import openfl.display.Sprite;
import openfl.display.DisplayObject;
import jive.geom.IntDimension;

class ScrolledContainer extends Container {

    private var wrap: Sprite;

    public function new() {
        super();
        sprite.name = "container";
        wrap = new Sprite();
        sprite.addChild(wrap);
        wrap.name = "children wrapper";
    }

    override public function doPaint(size: IntDimension) {
        var g = sprite.graphics;
        g.beginFill(0xFFFFFF, 0);
        g.drawRect(0, 0, size.width, size.height);
        g.endFill();
        super.doPaint(size);
    }

    override public function append(child:Component) {
        children.add(child);
        child.parent = this;
        wrap.addChild(child.sprite);
        child.repaint();
        relayout();
    }

    override public function insert(index:Int, child:Component) {
        children.add(child, index);
        child.parent = this;
        wrap.addChildAt(child.sprite, index);
        child.repaint();
        relayout();
    }

    override public function remove(child:Component) {
        children.remove(child);
        wrap.removeChild(child.sprite);
        child.parent = null;
        repaint();
        relayout();
    }
}