/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.plaf.flat.background;


import org.aswing.graphics.SolidBrush;
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
class FlatFrameBackground implements GroundDecorator implements UIResource{
	
	private var shape:Sprite;

	public function new(){
		shape = new Sprite();
		shape.mouseChildren = false;
		shape.mouseEnabled = false;
	}

	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		shape.graphics.clear();
		if(c.isOpaque()){
			var shadowW:Float= 6;
			var shadowH:Float= 6;
			var shadowScale:Float= 1;
			b = new IntRectangle(
				1, 
				2, 
				Std.int(c.getWidth()-shadowW - 1), 
				Std.int(c.getHeight()-shadowH - 2));
			
			g = new Graphics2D(shape.graphics);
			var ui:FrameUI = AsWingUtils.as( c.getUI(), FrameUI);
			if(ui!=null)	{
				if(!ui.isPaintActivedFrame()){
					shadowScale = 0.5;
				}
			}

            g.fillRoundRect(new SolidBrush(c.background), b.x, b.y, b.width, b.height, c.styleTune.round);

            var shape_f:Array<BitmapFilter> = new Array<BitmapFilter>();
            shape_f.push(new  DropShadowFilter(2, 45, 0x0, c.styleTune.shadowAlpha*shadowScale, shadowW, shadowH, 1, 1));
			shape.filters =shape_f;
		}
		shape.visible = c.isOpaque();
	}
	
}