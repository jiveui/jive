/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

import flash.display.DisplayObject;
import flash.geom.Point;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.GradientBrush;
	import org.aswing.graphics.Pen;
	import org.aswing.Icon;
import org.aswing.plaf.UIResource;
import flash.geom.Matrix;

/**
 * The default folder icon for JTree.
 * TODO draw a nicer icon
 * @author paling
 */
class TreeFolderIcon implements Icon implements UIResource{
	
	public function new(){
	}
	
	public function getIconWidth(c:Component) : Int{
		return 16;
	}

	public function getIconHeight(c:Component) : Int{
		return 16;
	}

	public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int):Void{
		//var borderColor:ASColor = ASColor.BLACK;
		var borderColor:ASColor = new ASColor( 0x555555 );
		
		var b:IntRectangle = new IntRectangle(0, 0, 16, 16);
		b.grow( 0, -1 );
		b.height -= 1;
		b.move( x, y );
		
		// Draw back face
		var flapSize:Int= 5;
		var backPoints:Array<Dynamic>= new Array<Dynamic>();
		backPoints.push( new Point( b.x, 								b.y ) );
		backPoints.push( new Point( b.x + flapSize, 		b.y ) );
		backPoints.push( new Point( b.x + flapSize + 1, b.y + 1 ) );
		backPoints.push( new Point( b.width - 3, 				b.y + 1 ) );
		backPoints.push( new Point( b.width - 3, 				b.height ) );
		backPoints.push( new Point( b.x, 								b.height ) );
		
    var colors:Array<Int>= [0xE6E9EE, 0x8E94BD];
		var alphas:Array<Dynamic>= [100/255, 100/255];
		var ratios:Array<Dynamic>= [0, 255];
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(b.width, b.height, 0, b.x, b.y);     
    var brush:GradientBrush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
    g.fillPolygon(brush, backPoints);
		
		//g.drawPolygon( new Pen( ASColor.BLACK, 0.5 ), backPoints );
		g.drawPolygon( new Pen( borderColor, 0.5 ), backPoints );
		
		// Draw front face
		alphas = [230/255, 230/255];
		brush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		
		var frontPoints:Array<Dynamic>= new Array<Dynamic>();
		frontPoints.push( new Point( b.x, 				b.height ) );
		frontPoints.push( new Point( b.x + 3, 		b.y + 3 ) );
		frontPoints.push( new Point( b.width, 		b.y + 3 ) );
		frontPoints.push( new Point( b.width - 3, b.height ) );
		
		g.fillPolygon(brush, frontPoints);
		
		g.drawPolygon( new Pen( borderColor, 0.25 ), frontPoints );
		
	}

	public function getDisplay(c:Component):DisplayObject{
		return null;
	}
	public function destroy():Void
	{ 
	}

}