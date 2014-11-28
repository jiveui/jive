/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon;

	
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.geom.Point;

import org.aswing.Icon;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.plaf.UIResource;

/**
 * @private
 * @author paling
 */
class SolidArrowIcon implements Icon implements UIResource{
	
	private var shape:Shape;
	private var width:Float;
	private var height:Float;
	private var arrow:Float;
	
	public function new(arrow:Float, size:Float, color:ASColor){
		this.arrow = arrow;
		this.width = size;
		this.height = size;
		shape = new Shape();
		paintIconWithColor(color);
	}	
	
	public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int):Void{
		shape.x = x;
		shape.y = y;
	}
	
	public function paintIconWithColor(cl:ASColor):Void{
		var x:Int= 0;
		var y:Int= 0;
		shape.graphics.clear();
		var g:Graphics2D = new Graphics2D(shape.graphics);
		var center:Point = new Point(x + width/2, y + height/2);
		var w:Float= width;
		var ps1:Array<Dynamic>= new Array<Dynamic>();
		ps1.push(nextPoint(center, arrow, w/2/2));
		var back:Point = nextPoint(center, arrow + Math.PI, w/2/2);
		ps1.push(nextPoint(back, arrow - Math.PI/2, w/2));
		ps1.push(nextPoint(back, arrow + Math.PI/2, w/2));
		
		g.fillPolygon(new SolidBrush(cl), ps1);
	}
	
	//nextPoint with Point
	private function nextPoint(op:Point, direction:Float, distance:Float):Point{
		return new Point(op.x+Math.cos(direction)*distance, op.y+Math.sin(direction)*distance);
	}
	
	public function getIconHeight(c:Component):Int{
		return Std.int(height);
	}
	
	public function getIconWidth(c:Component):Int{
		return Std.int(width);
	}
	
	public function setArrow(arrow:Float):Void{
		this.arrow = arrow;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
 
	
}