package jive.plaf.flat.background;

import org.aswing.UIManager;
import org.aswing.JTextComponent;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import flash.display.DisplayObject;
import org.aswing.ButtonModel;
import org.aswing.StyleTune;
import org.aswing.StyleResult;
import org.aswing.ASColor;
import org.aswing.AbstractButton;
import org.aswing.AsWingUtils;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.Component;
import org.aswing.plaf.UIResource;
import org.aswing.GroundDecorator;
import flash.display.Shape;

class FlatTextComponentBackground implements GroundDecorator implements UIResource{

    private var shape:Shape;

    public function new(){
        shape = new Shape();
    }

    public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
        shape.visible = c.opaque;
        if(c.opaque){
            shape.graphics.clear();

            var textComponent: JTextComponent = AsWingUtils.as(c,JTextComponent);
            if (null == textComponent) return;

            g = new Graphics2D(shape.graphics);
            bounds = c.border.getBorderInsets(null, null).getOutsideBounds(bounds);

            // Background
            g.fillRoundRect(new SolidBrush(c.background), bounds.x+1, bounds.y+1, bounds.width-2, bounds.height-2, c.styleTune.round);

            // Border
            var borderColor:ASColor = c.mideground;
            if (!c.enabled || !textComponent.editable) {
                borderColor = borderColor.offsetHLS(0, 0.2, 0);
            } else {
                borderColor = ASColor.getColorBetween(borderColor, UIManager.getColor("focusForeground"), textComponent.transitFocusFactor);
            }

            g.fillRoundRectRingWithThickness(new SolidBrush(borderColor), bounds.x, bounds.y, bounds.width, bounds.height,
                c.styleTune.round, 1.5, c.styleTune.round-1);
        }
    }

    public function getDisplay(c:Component):DisplayObject{
        return shape;
    }

}
