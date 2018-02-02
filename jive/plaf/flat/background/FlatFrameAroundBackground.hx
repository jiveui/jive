package jive.plaf.flat.background;


import org.aswing.graphics.Pen;
import org.aswing.AsWingUtils;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite; 
import flash.filters.BitmapFilterType; 
import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.JFrame;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.FrameUI;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

/**
 * @private
 */
class FlatFrameAroundBackground implements GroundDecorator implements UIResource{
    
    private var shape:Sprite;
    private var color:ASColor;
    private var thinkness:Float;

    public function new(?color: ASColor = null, ?thinkness: Float = 1) {
        shape = new Sprite();
        this.color = color == null ? org.aswing.ASColor.BLACK : color;
        this.thinkness = thinkness;
    }

    public function getDisplay(c:Component):DisplayObject{
        return shape;
    }
    
    public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
        shape.graphics.clear();
        g = new Graphics2D(shape.graphics);
        g.drawRoundRect(new Pen(color, thinkness), b.x, b.y, b.width, b.height, c.styleTune.round);
    }
    
}