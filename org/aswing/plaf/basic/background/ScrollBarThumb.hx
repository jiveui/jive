/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.background;

	
import flash.display.CapsStyle;
import flash.display.DisplayObject;
import flash.display.LineScaleMode;
import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

import org.aswing.GroundDecorator;
	import org.aswing.JScrollBar;
	import org.aswing.AWSprite;
	import org.aswing.Component;
	import org.aswing.StyleTune;
	import org.aswing.StyleResult;
	import org.aswing.ASColor;
	import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.plaf.UIResource;
	import org.aswing.plaf.basic.BasicGraphicsUtils;
	import org.aswing.event.ReleaseEvent;
/**
 * The thumb decorator for JScrollBar.
 * @author paling
 * @private
 */
class ScrollBarThumb implements GroundDecorator implements UIResource{
	
	private var bar:JScrollBar;
    private var thumb:AWSprite;
    private var size:IntDimension;
    private var verticle:Bool;
        
	private var rollover:Bool;
	private var pressed:Bool;
    
	public function new(){
		thumb = new AWSprite();
		rollover = false;
		pressed = false;
		initSelfHandlers();
	}
		
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
		thumb.x = bounds.x;
		thumb.y = bounds.y;
		size = bounds.getSize();
		bar = AsWingUtils.as(c,JScrollBar);
		
		verticle = (bar.getOrientation() == JScrollBar.VERTICAL);
		paint();
	}
	
	private function paint():Void{
		var x:Float= 0;
		var y:Float= 0;
    	var w:Float= size.width;
    	var h:Float= size.height;
    	thumb.graphics.clear();
    	var g:Graphics2D = new Graphics2D(thumb.graphics);
    	var b:IntRectangle;
		var direction:Float;
		var notchSize:Int;
    	if(verticle)	{
			direction = Math.PI/2;
			notchSize =Std.int( w - 6);
    	}else{
			direction = 0;
			notchSize = Std.int(h - 6);
    	}
    	b = new IntRectangle(Std.int(x), Std.int(y), Std.int(w), Std.int(h));
    	var tune:StyleTune = bar.getStyleTune().mide;
    	var style:StyleResult;
    	var cl:ASColor = bar.getMideground().changeAlpha(1);
    	if(!bar.isEnabled()){//disabled
    		cl = cl.offsetHLS(0, -0.06, -0.03);
    		tune = tune.sharpen(0.4);
    	}else if(pressed)	{//pressed
    		tune = tune.sharpen(0.8);
    	}else if(rollover)	{//over
    		cl = cl.offsetHLS(0, 0.06, 0);
    	}

    	style = new StyleResult(cl, tune);
		BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction);
		BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction);
		b = b.clone();
		b.grow(-1, -1);
		var innerStyle:StyleResult = new StyleResult(cl, tune);
		innerStyle.bdark = innerStyle.cdark.offsetHLS(0, 0.06, 0);
		innerStyle.blight = innerStyle.clight.offsetHLS(0, 0.06, 0);
		BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, innerStyle, direction);
		
		var snotchX:Int= 0;
		var snotchY:Int = 0;
		//why	
	 
		var lightPen:Pen = new Pen(innerStyle.blight, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE);
		var darkPen:Pen = new Pen(style.blight, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE);
		
    	if(verticle)	{
			snotchX = Std.int(x + 3);
			snotchY = Std.int(y + h/2 - 3);
			g.drawLine(lightPen, snotchX, snotchY, snotchX + notchSize, snotchY);
			snotchY += 1;
			g.drawLine(darkPen, snotchX, snotchY, snotchX + notchSize, snotchY);
			snotchY += 1;
			g.drawLine(lightPen, snotchX, snotchY, snotchX + notchSize, snotchY);
			snotchY += 1;
			g.drawLine(darkPen, snotchX, snotchY, snotchX + notchSize, snotchY);
			snotchY += 1;
			g.drawLine(lightPen, snotchX, snotchY, snotchX + notchSize, snotchY);
			snotchY += 1;
			g.drawLine(darkPen, snotchX, snotchY, snotchX + notchSize, snotchY);
    	}else{
			snotchX = Std.int(x + w/2 - 3);
			snotchY = Std.int(y + 3);
			g.drawLine(lightPen, snotchX, snotchY, snotchX, snotchY + notchSize);
			snotchX += 1;
			g.drawLine(darkPen, snotchX, snotchY, snotchX, snotchY + notchSize);
			snotchX += 1;
			g.drawLine(lightPen, snotchX, snotchY, snotchX, snotchY + notchSize);
			snotchX += 1;
			g.drawLine(darkPen, snotchX, snotchY, snotchX, snotchY + notchSize);
			snotchX += 1;
			g.drawLine(lightPen, snotchX, snotchY, snotchX, snotchY + notchSize);
			snotchX += 1;
			g.drawLine(darkPen, snotchX, snotchY, snotchX, snotchY + notchSize);
    	}
		thumb.alpha = bar.getMideground().getAlpha();
	 
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return thumb;
	}

	private function initSelfHandlers():Void{
		thumb.addEventListener(MouseEvent.ROLL_OUT, __rollOutListener);
		thumb.addEventListener(MouseEvent.ROLL_OVER, __rollOverListener);
		thumb.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDownListener);
		thumb.addEventListener(ReleaseEvent.RELEASE, __mouseUpListener);
	}
	 
	
	private function __rollOverListener(e:Event):Void{
		rollover = true;
		paint();
	}
	private function __rollOutListener(e:Event):Void{
		rollover = false;
		if(pressed!=true){
			paint();
		}
	}
	private function __mouseDownListener(e:Event):Void{
		pressed = true;
		paint();
	}
	private function __mouseUpListener(e:Event):Void{
		if(pressed)	{
			pressed = false;
			paint();
		}
	}
}