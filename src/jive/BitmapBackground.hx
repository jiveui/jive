package jive;

import org.aswing.graphics.BitmapBrush;
import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import flash.display.BitmapData;
import flash.display.DisplayObject;

class BitmapBackground implements GroundDecorator {

    public var bitmapData: BitmapData;

    public function new(bitmapData: BitmapData = null) {
        this.bitmapData = bitmapData;
    }

    public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle): Void {
        g.fillRectangle(new BitmapBrush(bitmapData), bounds.x, bounds.y, bounds.width, bounds.height);
    }

    public function getDisplay(c:Component): DisplayObject { return null; }
}
