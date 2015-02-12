package jive.plaf.flat.background;

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

class FlatButtonBackground implements GroundDecorator implements UIResource{

    private static var luminanceFactor: Float = 0.04;

    private var shape:Shape;

    public function new(){
        shape = new Shape();
    }

    public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
        var b:AbstractButton = AsWingUtils.as(c,AbstractButton)	;
        if(b == null){
            return;
        }

        shape.graphics.clear();
        g = new Graphics2D(shape.graphics);
        bounds = bounds.clone();

        var color:ASColor = c.getBackground();

        if(c.opaque){
            if (Math.abs(b.transitBackgroundFactor) < 1) {
                // The Model State is already changed but
                // the background color is still transiting from one state to another (e.g. Normal to RollOver)
                var factor = b.transitBackgroundFactor * luminanceFactor;
                color = color.offsetHLS(0,factor,0);
            } else {
                var model:ButtonModel = b.model;
                var isPressing:Bool= model.isArmed() || model.isSelected();

                if (isPressing) {
                    color = color.offsetHLS(0, -luminanceFactor, 0);
                } else if (b.model.isRollOver()) {
                    color = color.offsetHLS(0, luminanceFactor, 0);
                }
            }
            g.fillRoundRect(new SolidBrush(color), bounds.x, bounds.y, bounds.width, bounds.height, b.styleTune.round);
        }
    }

    public function getDisplay(c:Component):DisplayObject{
        return shape;
    }

}
