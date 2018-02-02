/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon;


import flash.display.DisplayObject;
import flash.display.Shape; 
import flash.filters.BitmapFilterType;
import flash.geom.Matrix;
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import org.aswing.Icon;
import org.aswing.Component;
import org.aswing.AbstractButton;
import org.aswing.ButtonModel;
import org.aswing.ASColor;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.graphics.GradientBrush;
import org.aswing.plaf.UIResource;

/**
 * @private
 */
class RadioButtonIcon implements Icon implements UIResource{
	
	private var shape:Shape;
	
	public function new(){
		shape = new Shape();
	}
		
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		var b:AbstractButton = AsWingUtils.as(c,AbstractButton);
		var model:ButtonModel = b.getModel();
		var drawDot:Bool= model.isSelected();
		
		shape.graphics.clear();
		var g:Graphics2D = new Graphics2D(shape.graphics);
		
		var w:Int= getIconWidth(c)-2;
		var h:Int= getIconHeight(c)-4;
		x += 1;
		y += 3;
		var cl:ASColor = c.getBackground();
		var style:StyleResult;
		var adjuster:StyleTune = c.getStyleTune();
		
    	var isPressing:Bool= model.isArmed() || model.isSelected();
		var shadowScale:Float= 1;
		var innerDis:Float= 2;
		var alpha:Float= 1;
    	if(isPressing)	{//pressed
	    	innerDis = 3;
	    	adjuster = adjuster.clone();
	    	adjuster.bGradient *= 0.8;
	    	adjuster.cGradient *= 0.8;
    		if(!b.isEnabled()){
	    		cl = cl.offsetHLS(0, 0, -0.03);
	    		adjuster = adjuster.sharpen(0.6);
	    		alpha = 0.5;
    		}else if(model.isRollOver()){
    			cl = cl.offsetHLS(0, 0.06, 0.06);
    			adjuster = adjuster.sharpen(0.8);
	    		innerDis = 4;
    		}else if(model.isArmed()){
    			adjuster = adjuster.sharpen(0.8);
    		}
			//shadowScale = 0.5;
    	}else{
    		if(!b.isEnabled()){//disabled
	    		cl = cl.offsetHLS(0, -0.06, -0.03);
	    		adjuster = adjuster.sharpen(0.6);
	    		alpha = 0.5;
    		}else if(model.isRollOver()){//normal over
	    		cl = cl.offsetHLS(0, 0.06, 0.06);
	    		innerDis = 4;
	    	}else{//normal
	    	}
    	}
		style = new StyleResult(cl, adjuster);
		g.fillEllipse(new SolidBrush(style.bdark), x, y, w, h);
		g.fillEllipse(new SolidBrush(style.clight), x+1, y+1, w-2, h-2);
		
		if(drawDot)	{
			cl = c.getMideground();
			adjuster = c.getStyleTune().mide;
			if(model.isArmed()){
				cl = cl.offsetHLS(0, -0.06, 0.03);
			}else if(model.isRollOver()){
				cl = cl.offsetHLS(0, 0.06, 0.06);
			}else if(!b.isEnabled()){
	    		cl = cl.offsetHLS(0, 0, -0.03);
	    		adjuster = adjuster.sharpen(0.4);
			}else{
				
			}
			var mcls:StyleResult = new StyleResult(cl, adjuster);
			var matrix:Matrix = new Matrix();
			var r:Float= w/4;
			matrix.createGradientBox(r * 2, r * 2, Math.PI / 5, x + r - r / 2, y + r - r / 2);
			//why
			g.fillCircle(
				new GradientBrush(
					GradientBrush.RADIAL, 
					[mcls.clight.getRGB(), mcls.cdark.getRGB()], 
					[mcls.clight.getAlpha(), mcls.cdark.getAlpha()], 
					[0, 200], 
					matrix
				), 
				x+w/2, y+h/2, r);
		}
		shape.alpha = alpha;
		var f :Array<BitmapFilter>= new Array<BitmapFilter>();
        f.push(new  DropShadowFilter(innerDis, 45, 0x0, style.shadow * shadowScale, 5, 5, 1, 1, true) );
		shape.filters = f;
			
			
			//new flash.filters.BevelFilter(1, 45, 0x0, style.shadow, 0xFFFFFF, style.shadow, 3, 3, 1, 1, BitmapFilterType.FULL)
			
		 
	}
	
	public function getIconHeight(c:Component):Int{
		return 16;
	}
	
	public function getIconWidth(c:Component):Int{
		return 14;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	 
}