package org.aswing.plaf.basic.background;


import flash.display.DisplayObject;

import org.aswing.ASColor;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

class ListBackground implements GroundDecorator implements UIResource{
	
	public function new(){
	}

	public function getDisplay(c:Component):DisplayObject{
		return null;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(c.isOpaque()){
			var cl:ASColor = c.getMideground();
			var style:StyleResult;
			var adjuster:StyleTune = c.getStyleTune();
			if(!c.isEnabled()){
				adjuster = adjuster.sharpen(0.5);
				cl = cl.changeAlpha(0.6);
			}
			style = new StyleResult(cl, adjuster);
			BasicGraphicsUtils.fillGradientRoundRect(g, b, style, -Math.PI/2);
		}
	}
	
}