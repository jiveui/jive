package jive.plaf.flat.border;

import org.aswing.AsWingUtils;
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

class TextCellComponentBorder implements Border implements UIResource{

    private var shape:Shape;

    public function new(){
        shape = new Shape();
    }

    public function updateBorder(c:Component, g:Graphics2D, b:IntRectangle):Void{
        shape.graphics.clear();
        var tc: TextCellComponent = AsWingUtils.as(c, TextCellComponent);
        if (null == tc) return;

        b = b.clone();
        var brush: SolidBrush =  new SolidBrush(c.background);
        var round: Float = c.styleTune.round;

        g = new Graphics2D(shape.graphics);
        if (tc.isFirst) {
            g.fillRoundRect(new SolidBrush(c.background), b.x, b.y, b.width, 2*round, round);
            g.fillRectangle(brush, b.x, b.y+round, b.width, b.height-round);
        } else if (tc.isLast) {
            g.fillRoundRect(new SolidBrush(c.background), b.x, b.y+b.height-2*round, b.width, 2*round, round);
            g.fillRectangle(brush, b.x, b.y, b.width, b.height-round);
        } else {
            g.fillRectangle(brush, b.x, b.y, b.width, b.height);
        }
    }

    public function getBorderInsets(c:Component, b:IntRectangle):Insets{
        return new Insets(5, 15, 5, 15);
    }

    public function getDisplay(c:Component):DisplayObject { return shape; }

}
