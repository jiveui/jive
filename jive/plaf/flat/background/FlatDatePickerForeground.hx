package jive.plaf.flat.background;

import org.aswing.UIManager;
import org.aswing.UIManager;
import org.aswing.graphics.SolidBrush;
import org.aswing.graphics.GradientBrush;
import flash.display.GradientType;
import flash.geom.Matrix;
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
import org.aswing.plaf.basic.BasicGraphicsUtils;

class FlatDatePickerForeground implements GroundDecorator implements UIResource {
    private var sprite: Sprite;

    public function new(){
        sprite = new Sprite();
        sprite.mouseEnabled = false;
    }

    public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
        var p: Picker = AsWingUtils.as(c, Picker);

        g = new Graphics2D(sprite.graphics);
        var bo = bounds.clone();

        g.clear();

        // Shadows of cylinder

//        var shadow = c.background.offsetHLS(0,-0.2, 0).getRGB();
//        var colors = [shadow, shadow, shadow, shadow];
//        var alphas = [1.0, 0, 0, 1.0];
//        var coords = [0, 110, 145, 255];

//        var matrix: Matrix = new Matrix();
//        matrix.createGradientBox(bo.width, bo.height, Math.PI/2, bo.x, bo.y);
//        g.beginFill(new GradientBrush(
//            GradientType.LINEAR,
//            colors,
//            alphas,
//            coords,
//            matrix));
//        BasicGraphicsUtils.drawRoundRect(g, bo.x, bo.y, bo.width, bo.height, 0);
//        g.endFill();

        // Transparent selector
        g.fillRectangle(new SolidBrush(cast(UIManager.get("highlightControl"), ASColor).changeAlpha(0.5)), bo.x, bo.y + bo.height/2 - p.MAGNETIC_BORDER_SIZE/2, bo.width, p.MAGNETIC_BORDER_SIZE);

        var topY = bo.y + bo.height/2 - p.MAGNETIC_BORDER_SIZE/2;
//        g.drawLine(new Pen(c.mideground), bo.x, topY , bo.x + bo.width, topY);

        var bottomY = topY + p.MAGNETIC_BORDER_SIZE;
        g.drawLine(new Pen(c.mideground), bo.x, bottomY , bo.x + bo.width, bottomY);
    }

    public function getDisplay(c:Component):DisplayObject{
        return sprite;
    }
}
