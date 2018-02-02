/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.background;


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
class FrameBackground implements GroundDecorator implements UIResource{
	
	private var shape:Sprite;
	private var bar:Shape;
	
	public function new(){
		shape = new Sprite();
		bar = new Shape();
		shape.mouseChildren = false;
		shape.mouseEnabled = false;
		shape.addChild(bar);
	}

	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		shape.graphics.clear();
		bar.graphics.clear();
		if(c.isOpaque()){
			var shadowW:Float= 6;
			var shadowH:Float= 6;
			var cl:ASColor = c.getMideground();
			var style:StyleResult;
			var adjuster:StyleTune = c.getStyleTune().mide;
			var shadowScale:Float= 1;
			b = new IntRectangle(
				1, 
				2, 
				Std.int(c.getWidth()-shadowW - 1), 
				Std.int(c.getHeight()-shadowH - 2));
			
			g = new Graphics2D(bar.graphics);
			var barHeight:Int= 24;
			if (Std.is(c, JFrame)) {
				var cf:	JFrame = AsWingUtils.as(c, JFrame);
				barHeight = cf.getTitleBar().getSelf().getHeight();
			}
			style = new StyleResult(cl, adjuster);
			BasicGraphicsUtils.fillGradientRoundRectBottomRightAngle(g, 
				new IntRectangle(b.x, b.y, b.width,Std.int( Math.min(barHeight-2, b.height))), 
				style, Math.PI / 2);
			#if(flash9)
			bar.filters = [
				new flash.filters.BevelFilter(1, 90, 0xFFFFFF, adjuster.shadowAlpha, 0x0, 0.1, 1, 1, 1, 1, BitmapFilterType.INNER), 
				new flash.filters.BevelFilter(1, 90, 0x0, 0.1, 0xFFFFFF, adjuster.shadowAlpha, 1, 1, 1, 1, BitmapFilterType.OUTER)
			];
			#end  
			g = new Graphics2D(shape.graphics);
			var ui:FrameUI = AsWingUtils.as( c.getUI(), FrameUI);
			if(ui!=null)	{
				if(!ui.isPaintActivedFrame()){
					shadowScale = 0.5;
				}
			}
			cl = c.getBackground();
			adjuster = c.getStyleTune();
			style = new StyleResult(cl, adjuster);
			var ratioScale:Float= Math.min(1, barHeight*2.2/b.height);
			var ratios:Array<Dynamic>= [255*(1-ratioScale), 255];
			BasicGraphicsUtils.fillGradientRoundRect(g, b, style, -Math.PI/2, false, null, ratios);
            var shape_f:Array<BitmapFilter> = new Array<BitmapFilter>();
            shape_f.push(new  DropShadowFilter(2, 45, 0x0, style.shadow*shadowScale, shadowW, shadowH, 1, 1));
			shape.filters =shape_f;
		}
		shape.visible = c.isOpaque();
	}
	
}