package jive.plaf.flat.background;

import jive.Picker;
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

class FlatPickerForeground implements GroundDecorator implements UIResource {
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

        var scale: Float = LookAndFeelHelper.scale;

        // Edges of roller

        var edgeThickness = Math.floor(4*scale);
        var holeThickness = Math.floor(scale);
        var vertMargin = Math.floor(2*scale);

        g.beginFill(new SolidBrush(ASColor.LIGHT_GRAY));
        g.rectangle(bo.x + 1, bo.y + vertMargin, edgeThickness, bo.height-2*vertMargin);
        g.endFill();

        g.beginFill(new SolidBrush(ASColor.LIGHT_GRAY));
        g.rectangle(bo.x + bo.width - edgeThickness-1, bo.y+vertMargin, edgeThickness, bo.height-2*vertMargin);
        g.endFill();

        // Shadows of cylinder

        var colors = [];
        var alphas = [];
        var coords = [];

        for (i in 0...256) {
            colors.push(0x000000);
            coords.push(i);
            alphas.push(1 - Math.sqrt(128*128 - (i-128)*(i-128))/128);
        }

        var matrix: Matrix = new Matrix();
        matrix.createGradientBox(bo.width, bo.height, Math.PI/2, bo.x, bo.y);
        g.beginFill(new GradientBrush(
            GradientType.LINEAR,
            colors,
            alphas,
            coords,
            matrix));
        BasicGraphicsUtils.drawRoundRect(g, bo.x, bo.y, bo.width, bo.height, 5);
        g.endFill();

        // Transparent selector

        g.fillRectangle(new SolidBrush(ASColor.getWithARGB(0x99c9e9ff)), 3, bo.height/2 - p.MAGNETIC_BORDER_SIZE/2, bo.width-3, p.MAGNETIC_BORDER_SIZE/2);
        g.fillRectangle(new SolidBrush(ASColor.getWithARGB(0x550081c4)), 3, bo.height/2, bo.width-3, p.MAGNETIC_BORDER_SIZE/2);

        var topY = bo.height/2 - p.MAGNETIC_BORDER_SIZE/2;
        g.drawLine(new Pen(ASColor.GRAY), 3, topY , bo.width-3, topY);
        g.drawLine(new Pen(ASColor.WHITE), 3, topY+1 , bo.width-3, topY+1);

        var bottomY = topY + p.MAGNETIC_BORDER_SIZE;
        g.drawLine(new Pen(ASColor.GRAY), 2, bottomY , bo.width-4, bottomY);

        // Shadow of transparent selector

        matrix.createGradientBox(bo.width, p.MAGNETIC_BORDER_SIZE/8, Math.PI/2, bo.x, bottomY+1);
        g.fillRectangle(
            new GradientBrush(
                GradientType.LINEAR,
                [0x000000, 0x000000],
                [0.2, 0],
                [0, 255],
                matrix),
            bo.x, bottomY+1, bo.width, p.MAGNETIC_BORDER_SIZE/8);

        // Hole
        g.beginFill(new SolidBrush(ASColor.BLACK));
        BasicGraphicsUtils.drawRoundRectLine(g, bo.x+1, bo.y+1, bo.width-2, bo.height-2, 5, 1);
        g.endFill();

        // Edge
        matrix.createGradientBox(bo.width, bo.height, Math.PI/2, bo.x, bo.y);
        g.beginFill(new GradientBrush(
            GradientType.LINEAR,
            [0x333333, 0xcccccc],
            [0.5, 0.5],
            [0, 255],
            matrix));
        BasicGraphicsUtils.drawRoundRectLine(g, bo.x, bo.y, bo.width, bo.height, 5, 1);
        g.endFill();

    }

    public function getDisplay(c:Component):DisplayObject{
        return sprite;
    }
}
