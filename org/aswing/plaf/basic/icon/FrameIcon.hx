/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon;


import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite; 
import flash.filters.BitmapFilterType; 

import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
import org.aswing.AsWingManager;
import org.aswing.Icon;
import org.aswing.Component;
import org.aswing.ASColor;
import org.aswing.AbstractButton;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.ButtonModel;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

/**
 * Frame title bar icon base.
 * @author paling
 * @private
 */
class FrameIcon implements Icon implements UIResource{
			
	private var width:Int;
	private var height:Int;
	private var box:Shape;
	private var dot:Shape;
	
	private var sprite:Sprite;
		
	/**
	 * @param width the width of the icon square.
	 */	
	public function new(width:Int=16){
		this.width = width;
		height = width;
		sprite = new Sprite();
		sprite.mouseChildren = false;
		sprite.mouseEnabled = false;
		
		box = new Shape();
		dot = new Shape();
		sprite.addChild(box);
		sprite.addChild(dot);
	}
	
	public function getColor(c:Component):ASColor{
		return c.getMideground();
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		box.graphics.clear();
		g = new Graphics2D(box.graphics);
		
		var b:AbstractButton = AsWingUtils.as(c,AbstractButton)	;
		if(b == null){
			return;
		}
		var bounds:IntRectangle = new IntRectangle(x, y, width, height);
		// make 1 pixel space for shadow filter effect
		bounds.width -= 1;
		bounds.height -= 1;
		
		var cl:ASColor = c.getMideground();
		var style:StyleResult;
		var adjuster:StyleTune = c.getStyleTune().mide;
		
		var model:ButtonModel = b.getModel();
    	var isPressing:Bool= model.isArmed() || model.isSelected();
		var shadowScale:Float= 1;
    	if(!b.isEnabled()){//disabled
    		cl = cl.offsetHLS(0, -0.06, -0.03);
    		adjuster = adjuster.sharpen(0.4);
    		style = new StyleResult(cl, adjuster);
			BasicGraphicsUtils.fillGradientRoundRect(g, bounds, style);
    	}else if(isPressing)	{//pressed
    		adjuster = adjuster.sharpen(0.8);
			style = new StyleResult(cl, adjuster);
			BasicGraphicsUtils.fillGradientRoundRect(g, bounds, style, -Math.PI/2);
    	}else if(model.isRollOver()){//over
    		cl = cl.offsetHLS(0, 0.06, 0);
    		style = new StyleResult(cl, adjuster);
			BasicGraphicsUtils.fillGradientRoundRect(g, bounds, style);
    	}else{//normal
			style = new StyleResult(cl, adjuster);
			BasicGraphicsUtils.fillGradientRoundRect(g, bounds, style);
    	}
    	BasicGraphicsUtils.drawGradientRoundRectLine(g, bounds, 1, style);
  
		
    		//new flash.filters.BevelFilter(1, 90, 0xFFFFFF, 0.18, 0xFFFFFF, 0, 0, 0, 1, 1, BitmapFilterType.INNER),
		
     
		var box_f:Array<BitmapFilter> = new Array<BitmapFilter>();
		box_f.push(new  DropShadowFilter(1, 45, 0xFFFFFF, style.shadow * shadowScale, 1, 1, 1, 1));
		box.filters = box_f;
		dot.graphics.clear();
		updateIconImp(style, new Graphics2D(dot.graphics), x, y);
		/*
		var dot_f:Array<BitmapFilter> = new Array<BitmapFilter>();
		dot_f.push(new DropShadowFilter(0, 70, 0x0, style.shadow*shadowScale*2, 2, 2, 8, 1));
		dot.filters = AsWingManager.USE_FILTERS ?  dot_f : null;
		*/
	}
	
	public function updateIconImp(style:StyleResult, g:Graphics2D, x:Int, y:Int):Void{}
	
	public function getSize():Int{
		return width;
	}
	
	public function getIconHeight(c:Component):Int{
		return width;
	}
	
	public function getIconWidth(c:Component):Int{
		return height;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return sprite;
	}
 
}