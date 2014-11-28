/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.colorchooser;
 

import org.aswing.Icon;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.graphics.Pen;
	import flash.display.DisplayObject;
/**
 * PreviewColorIcon represent two color rect, on previous, on current.
 * @author paling
 */
class PreviewColorIcon implements Icon{
	/** 
     * Horizontal orientation.
     */
    inline public static var HORIZONTAL:Int= AsWingConstants.HORIZONTAL;
    /** 
     * Vertical orientation.
     */
    inline public static var VERTICAL:Int= AsWingConstants.VERTICAL;
    
	private var previousColor:ASColor;
	private var currentColor:ASColor;
	private var width:Int;
	private var height:Int;
	private var orientation:Int;
	
	public function new(width:Int, height:Int, orientation:Int=AsWingConstants.VERTICAL){
		this.width = width;
		this.height = height;
		this.orientation = orientation;
		previousColor = currentColor = ASColor.WHITE;
	}
	
	public function setColor(c:ASColor):Void{
		setCurrentColor(c);
		setPreviousColor(c);
	}
	
	public function setOrientation(o:Int):Void{
		orientation = o;
	}
	
	public function getOrientation():Int{
		return orientation;
	}
	
	public function setPreviousColor(c:ASColor):Void{
		previousColor = c;
	}
	
	public function getPreviousColor():ASColor{
		return previousColor;
	}
	
	public function setCurrentColor(c:ASColor):Void{
		currentColor = c;
	}
	
	public function getCurrentColor():ASColor{
		return currentColor;
	}
	
	public function getIconWidth(c:Component) : Int{
		return width;
	}

	public function getIconHeight(c:Component) : Int{
		return height;
	}

	public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int):Void{
		var w:Int= Std.int(width);
		var h:Int= Std.int(height);
		g.fillRectangle(new SolidBrush(ASColor.WHITE), x, y, w, h);
//why	
		 
		var t:Float= 5;
		for(c in 0...w){
			g.drawLine(new Pen(ASColor.GRAY, 1), x+c, y, x+c, y+h);
		}
		for(r in 0...h){
			g.drawLine(new Pen(ASColor.GRAY, 1), x, y+r, x+w, y+r);
		}
			 
		if(previousColor == null && currentColor == null){
			paintNoColor(g, x, y, w, h);
			return;
		}
		
		if(orientation == HORIZONTAL){
			w = Std.int(width/2);
			h = height;
			if(previousColor == null){
				paintNoColor(g, x, y, w, h);
			}else{
				g.fillRectangle(new SolidBrush(previousColor), x, y, w, h);
			}
			x += w;
			if(currentColor == null){
				paintNoColor(g, x, y, w, h);
			}else{
				g.fillRectangle(new SolidBrush(currentColor), x, y, w, h);
			}
		}else{
			w = width;
			h = Std.int(height/2);
			if(previousColor == null){
				paintNoColor(g, x, y, w, h);
			}else{
				g.fillRectangle(new SolidBrush(previousColor), x, y, w, h);
			}
			y += h;
			if(currentColor == null){
				paintNoColor(g, x, y, w, h);
			}else{
				g.fillRectangle(new SolidBrush(currentColor), x, y, w, h);
			}
		}
	}
	
	private function paintNoColor(g:Graphics2D, x:Float, y:Float, w:Float, h:Float):Void{
		g.fillRectangle(new SolidBrush(ASColor.WHITE), x, y, w, h);
		g.drawLine(new Pen(ASColor.RED, 2), x+1, y+h-1, x+w-1, y+1);
	}

	public function getDisplay(c:Component):DisplayObject{
		return null;
	}
 
}