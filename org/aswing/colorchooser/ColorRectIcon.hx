/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.colorchooser;
 
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.Icon;
import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.graphics.Pen;
	import flash.display.DisplayObject;

/**
 * @author paling
 */
class ColorRectIcon implements Icon {
	private var width:Float;
	private var height:Float;
	private var color:ASColor;
	
	public function new(width:Int, height:Int, color:ASColor){
		this.width = width;
		this.height = height;
		this.color = color;
	}
	
	public function setColor(color:ASColor):Void{
		this.color = color;
	}
	
	public function getColor():ASColor{
		return color;
	}

	/**
	 * Return the icon's width.
	 */
	public function getIconWidth(c:Component):Int{
		return Std.int(width);
	}
	
	/**
	 * Return the icon's height.
	 */
	public function getIconHeight(c:Component):Int{
		return Std.int(height);
	}
	
	public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int):Void{
		var w:Int= Std.int(width);
		var h:Int= Std.int(height);
		g.fillRectangle(new SolidBrush(ASColor.WHITE), x, y, w, h);
		//why	
	 
		if(color != null){
			var t:Float= 5;
			for(c in 0...w){
				g.drawLine(new Pen(ASColor.GRAY, 1), x+c, y, x+c, y+h);
			}
			for(r in 0...h){
				g.drawLine(new Pen(ASColor.GRAY, 1), x, y+r, x+w, y+r);
			}
			g.fillRectangle(new SolidBrush(color), x, y, width, height);
		}else{
			g.drawLine(new Pen(ASColor.RED, 2), x+1, y+h-1, x+w-1, y+1);
		}
		 
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return null;
	}	 
}