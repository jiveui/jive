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
            var model:ButtonModel = b.model;
            var isPressing:Bool= model.isArmed() || model.isSelected();

            g.fillRoundRect(new SolidBrush(color), bounds.x, bounds.y, bounds.width, bounds.height, b.styleTune.round);
        }
    }

    public function getDisplay(c:Component):DisplayObject{
        return shape;
    }

}
