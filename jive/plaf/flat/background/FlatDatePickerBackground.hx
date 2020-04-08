package jive.plaf.flat.background;

import org.aswing.UIManager;
import org.aswing.UIManager;
import org.aswing.graphics.SolidBrush;
import org.aswing.AsWingUtils;
import org.aswing.ASColor;
import org.aswing.graphics.Pen;
import flash.display.DisplayObject;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.Component;
import flash.display.Sprite;
import org.aswing.plaf.UIResource;
import org.aswing.GroundDecorator;

class FlatDatePickerBackground implements GroundDecorator implements UIResource {
    private var sprite: Sprite;

    public function new(){
        sprite = new Sprite();
    }

    public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
        g = new Graphics2D(sprite.graphics);
        var bo = bounds.clone();
        g.clear();
        g.fillRoundRect(new SolidBrush(c.background),bo.x, bo.y, bo.width, bo.height, UIManager.get("Picker.cornerSize"));
        g.drawRoundRect(new Pen(c.mideground),bo.x, bo.y, bo.width, bo.height, UIManager.get("Picker.cornerSize"));
    }

    public function getDisplay(c:Component):DisplayObject{
        return sprite;
    }
}
