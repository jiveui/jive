/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table.sorter;


import flash.display.Shape;
import flash.display.DisplayObject; 
import flash.geom.Matrix;
import flash.geom.Point;
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import org.aswing.Icon;
import org.aswing.Component;
import org.aswing.ASColor;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.AbstractButton;
import org.aswing.ButtonModel;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.GradientBrush;
 
	/**
 * @author paling
 */
class Arrow implements Icon{
	
	private var shape:Shape;
	private var width:Int;
	private var arrow:Float;
	
	public function new(descending:Bool, size:Int){
		shape = new Shape();
		arrow = descending ? Math.PI/2 : -Math.PI/2;
		this.width = size;
	}
	
	public function getIconWidth(c:Component) : Int{
		return width;
	}

	public function getIconHeight(c:Component) : Int{
		return width;
	}

	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		/*shape.graphics.clear();
		g = new Graphics2D(shape.graphics);
		var center:Point = new Point(x, com.getHeight()/2);
		var w:Number = width;
		
		var ps1:Array = new Array();
		ps1.push(nextPoint(center, arrow, w/2/2));
		var back:Point = nextPoint(center, arrow + Math.PI, w/2/2);
		ps1.push(nextPoint(back, arrow - Math.PI/2, w/2));
		ps1.push(nextPoint(back, arrow + Math.PI/2, w/2));
		
		g.fillPolygon(new SolidBrush(ASColor.BLACK), ps1);	
		*/

		shape.graphics.clear();
		g = new Graphics2D(shape.graphics);
		var center:Point = new Point(x, c.getHeight()/2);
		var w:Float= width;
		var ps1:Array<Dynamic>= new Array<Dynamic>();
		ps1.push(nextPoint(center, arrow, w/2/2));
		var back:Point = nextPoint(center, arrow + Math.PI, w/2/2);
		ps1.push(nextPoint(back, arrow - Math.PI/2, w/2));
		ps1.push(nextPoint(back, arrow + Math.PI/2, w/2));
		
		var cl:ASColor = c.getMideground();
		var style:StyleResult;
		var adjuster:StyleTune = c.getStyleTune().mide;
		if(Std.is(c,AbstractButton)){
			var b:AbstractButton = AsWingUtils.as(c,AbstractButton)	;
			var model:ButtonModel = b.getModel();
	    	var isPressing:Bool= model.isArmed() || model.isSelected();
    		var hue:Float= cl.getHue();
    		var offHue:Float= hue + 0.21;
    		if(offHue > 1) offHue = offHue - 1;
    		if(offHue < 0) offHue = offHue + 1;
	    	if(!b.isEnabled()){//disabled
	    		cl = cl.offsetHLS(0, -0.06, -0.03);
	    		adjuster = adjuster.sharpen(0.4);
	    		cl = cl.offsetHLS(0, -0.10, -0.10);
	    	}else if(isPressing)	{//pressed
	    		adjuster = adjuster.sharpen(0.8);
	    		cl = cl.offsetHLS(offHue-hue, -0.06, 0);
	    	}else if(model.isRollOver()){//over
	    		cl = cl.offsetHLS(offHue-hue, 0.1, 0.3);
	    	}
		}
		style = new StyleResult(cl, adjuster);
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(w+1, w+1, 60/180*Math.PI, x+w/8-0.5, y+w/8-0.5);
		/*var brush:GradientBrush = new GradientBrush(
			GradientBrush.LINEAR, 
			[style.cdark.getRGB(), style.clight.getRGB(), style.cdark.getRGB()], 
			[style.cdark.getAlpha(), style.clight.getAlpha(), style.cdark.getAlpha()], 
			[0, 120, 255], 
			matrix
		);*/
		var brush:GradientBrush = new GradientBrush(
			GradientBrush.RADIAL, 
			[style.clight.getRGB(), style.cdark.getRGB()], 
			[style.clight.getAlpha(), style.cdark.getAlpha()], 
			[0, 255], 
			matrix
		);		
		g.fillPolygon(brush, ps1);
		var f :Array<BitmapFilter> = new Array<BitmapFilter>();
		f.push(new  DropShadowFilter(1, 45, 0x0, style.shadow, 0, 0, 1, 1));
		shape.filters = f;	
		 
	}
	
	private function nextPoint(p:Point, dir:Float, dis:Float):Point{
		return new Point(p.x+Math.cos(dir)*dis, p.y+Math.sin(dir)*dis);
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
 
}