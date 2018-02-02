/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon;

	
import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.Icon;
	import org.aswing.Component;
	import org.aswing.ASColor;
	import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;
import flash.geom.Point;
import flash.display.Shape;

/**
 * The default frame title icon.
 * @author paling
 * @private
 */
class TitleIcon implements Icon implements UIResource{
	
	private static var WIDTH:Int= 16;
	private static var HEIGHT:Int= 12;
	private var shape:Shape;
	
	public function new(){
		shape = new Shape();
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		shape.graphics.clear();
		return;
		g = new Graphics2D(shape.graphics);
		//This is just for test the icon
		//TODO draw a real beautiful icon for AsWing frame title
		//g.fillCircleRingWithThickness(new SolidBrush(ASColor.GREEN), x + WIDTH/2, y + WIDTH/2, WIDTH/2, WIDTH/4);
		var outterRect:ASColor = c.getUI().getColor("Frame.activeCaptionBorder");
		//var innerRect:ASColor = UIManager.getColor("Frame.inactiveCaptionBorder");
		var innerRect:ASColor = new ASColor(0xFFFFFF);
		
		x = x + 2;
		var width:Int= WIDTH;
		var height:Int= HEIGHT;
		
		var w4:Float= width/4;
		var h23:Float= 2*height/3;
		var w2:Float= width/2;
		var h:Float= height;
		var w:Float= width;
		
		var points:Array<Dynamic>= new Array<Dynamic>();
		points.push(new Point(x, y));
		points.push(new Point(x+w4, y+h));
		points.push(new Point(x+w2, y+h23));
		points.push(new Point(x+w4*3, y+h));
		points.push(new Point(x+w, y));
		points.push(new Point(x+w2, y+h23));
		
		//why	
		g.drawPolygon(new Pen(outterRect, 2), points);
		g.fillPolygon(new SolidBrush(innerRect), points);		
	}
	
	public function getIconHeight(c:Component):Int{
		return 0;
		//return HEIGHT;
	}
	
	public function getIconWidth(c:Component):Int{
		return 0;
		//return WIDTH + 2;
	}
	
	public function getDisplay(c:Component):DisplayObject
	{
		return shape;
	}
 
}