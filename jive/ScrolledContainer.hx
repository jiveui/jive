package jive;

import openfl.display.Sprite;
import openfl.display.DisplayObject;
import jive.geom.IntDimension;

class ScrolledContainer extends Container {

    public function new() {
        super();
        sprite.name = "container";
        var wrap = new Sprite();
        wrap.addChild(sprite);
        sprite = wrap;
        wrap.name = "wrapper";
    }

    override public function paint(size: IntDimension) {
        if (needsPaint) {
            var g = cast(sprite, Sprite).graphics;
            g.beginFill(0xFFFFFF, 0);
            g.drawRect(0, 0, size.width, size.height);
            g.endFill();
        }
    
        return super.paint(size);
    } 
}