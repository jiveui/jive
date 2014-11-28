/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

import flash.geom.Point;
import org.aswing.Component;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.GradientBrush;
	import org.aswing.graphics.Pen;
	import org.aswing.Icon;
import org.aswing.plaf.UIResource;
import flash.display.DisplayObject;
import flash.geom.Matrix;
import org.aswing.ASColor;

/**
 * The default leaf icon for JTree.
 * TODO draw a nicer icon
 * @author paling
 */
class TreeLeafIcon implements Icon implements UIResource{
	
	public function new(){
	}
	
	public function getIconWidth(c:Component) : Int{
		return 16;
	}

	public function getIconHeight(c:Component) : Int{
		return 16;
	}

	public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int):Void{
		var b:IntRectangle = new IntRectangle(0, 0, 16, 16);
		b.grow( -2, -1 );
		b.move( x, y );
		
		var foldSize:Int= 4;
		var points:Array<Dynamic>= new Array<Dynamic>();
		points.push( new Point( b.x, 								b.y ) );
		points.push( new Point( b.width - foldSize, b.y ) );
		points.push( new Point( b.width, 						b.y + foldSize ) );
		points.push( new Point( b.width, 						b.height ) );
		points.push( new Point( b.x, 								b.height ) );
		
    var colors:Array<Int>= [0xE6E9EE, 0x8E94BD];
		var alphas:Array<Dynamic>= [100/255, 100/255];
		var ratios:Array<Dynamic>= [0, 255];
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(b.width, b.height, 0, b.x, b.y);     
    var brush:GradientBrush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
    g.fillPolygon(brush, points);
		
		g.drawPolygon(new Pen(ASColor.BLACK, 0.5), points );
		
		var foldPoints:Array<Dynamic>= new Array<Dynamic>();
		foldPoints.push( new Point( b.width - foldSize, b.y ) );
		foldPoints.push( new Point( b.width - foldSize, b.y + foldSize ) );
		foldPoints.push( new Point( b.width, 						b.y + foldSize ) );
		g.drawPolyline( new Pen(ASColor.BLACK, 0.5), foldPoints );
	}

	public function getDisplay(c:Component):DisplayObject{
		return null;
	}
	public function destroy():Void
	{
		 
	}
}