/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border;


import flash.display.DisplayObject;
import flash.display.Shape; 
import flash.geom.Matrix;
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import org.aswing.ASColor;
import org.aswing.Border;
import org.aswing.Component;
import org.aswing.Insets;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;

class ComboBoxPopupBorder implements Border implements UIResource{
	
	private var shape:Shape;
	
	public function new(){
		shape = new Shape();
	}

	public function updateBorder(c:Component, g:Graphics2D, b:IntRectangle):Void{
		shape.graphics.clear();
		g = new Graphics2D(shape.graphics);
		var cl:ASColor = c.getBackground();
		cl = cl.changeAlpha(1);
		var tune:StyleTune = c.getStyleTune();
		var result:StyleResult = new StyleResult(cl, tune);
		var ml:ASColor = result.bdark;
		var round:Float= result.round;
		var clTop:ASColor = cl.changeLuminance(cl.getLuminance()-0.07);
		var light:ASColor = cl.changeLuminance(cl.getLuminance() + 0.01);
		
		b = b.clone();
		b.width -= 4;
		b.height -= 4;
		
		var brush:SolidBrush = new SolidBrush(cl);
		g.fillRoundRect(new SolidBrush(ml), b.x, b.y, b.width, b.height, round);
		b.grow(-1, -1);
		round--;
		if(round < 0) round = 0;
		g.fillRoundRect(new SolidBrush(light), b.x, b.y, b.width, b.height, round);
		b.grow(-1, -1);
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(b.width, b.height, Math.PI/2, b.x, b.y);
		if(round < 0) round = 0;
		g.fillRoundRect(
			new GradientBrush(GradientBrush.LINEAR, 
				[clTop.getRGB(), cl.getRGB()], 
				[1, 1], [0, 100], matrix), 
			b.x, b.y, b.width, b.height, round);
		var f :Array<BitmapFilter> = new Array<BitmapFilter>();
		f.push(new  DropShadowFilter(1, 45, 0x0, 0.3, 4, 4));

		shape.filters = f;
	}
	
	public function getBorderInsets(c:Component, b:IntRectangle):Insets{
		return new Insets(2, 2, 6, 6);
	}	
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
		
}