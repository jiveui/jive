package jive.plaf.flat.background;

import org.aswing.plaf.UIResource;
import org.aswing.GroundDecorator;
import flash.display.DisplayObject;
import flash.display.Shape;
import org.aswing.graphics.SolidBrush;
import org.aswing.AsWingUtils;
import org.aswing.JComboBox;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.Component;
import org.aswing.UIManager;
import org.aswing.ASColor;
import org.aswing.JTextComponent;

class FlatInputBackground implements GroundDecorator implements UIResource {
    private var shape:Shape;

    public function new() {
        shape = new Shape();
    }

    public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
        shape.visible = c.opaque;
        if(c.opaque){
            shape.graphics.clear();

            var cb: JComboBox = AsWingUtils.as(c,JComboBox);
            if (null == cb) return;

            g = new Graphics2D(shape.graphics);
            bounds = c.border.getBorderInsets(null, null).getOutsideBounds(bounds);

            var bgColor = c.background;

            if(!cb.editable && cb.enabled) {
                bgColor = cb.notEditableBackground;
            }

            g.fillRoundRect(new SolidBrush(bgColor), bounds.x+1, bounds.y+1, bounds.width-2, bounds.height-2, c.styleTune.round);

            // Border
            var borderColor:ASColor = c.mideground;
            if (!c.enabled) {
                borderColor = borderColor.offsetHLS(0, 0.2, 0);
            } else if (!cb.editable) {
                borderColor = cb.notEditableBackground;
            } else {
                borderColor = ASColor.getColorBetween(borderColor, UIManager.getColor("focusForeground"), cb.transitFocusFactor);
            }

            g.fillRoundRectRingWithThickness(new SolidBrush(borderColor), bounds.x, bounds.y, bounds.width, bounds.height,
                c.styleTune.round, 1.5, c.styleTune.round-1);
        }
    }

    public function getDisplay(c:Component):DisplayObject{
        return shape;
    }
}
