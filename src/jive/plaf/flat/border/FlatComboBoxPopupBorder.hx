package jive.plaf.flat.border;

import flash.display.DisplayObject;
import flash.display.Shape;
import org.aswing.ASColor;
import org.aswing.Border;
import org.aswing.Component;
import org.aswing.Insets;
import org.aswing.StyleTune;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;

class FlatComboBoxPopupBorder implements Border implements UIResource{

    private var shape:Shape;

    public function new(){
        shape = new Shape();
    }

    public function updateBorder(c:Component, g:Graphics2D, b:IntRectangle):Void{
        shape.graphics.clear();
        b = b.clone();
        b.y += 10;
        b.height -= 10;
        g = new Graphics2D(shape.graphics);
        g.fillRoundRect(new SolidBrush(c.background), b.x, b.y, b.width, b.height, c.styleTune.round);
    }

    public function getBorderInsets(c:Component, b:IntRectangle):Insets{
        return new Insets(10, 0, 0, 0);
    }

    public function getDisplay(c:Component):DisplayObject { return shape; }

}
