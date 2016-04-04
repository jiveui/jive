package org.aswing;


import flash.display.DisplayObject;
import org.aswing.graphics.Graphics2D;

/**
 * EmptyIcon is just for sit a place.
 * @author paling
 */
class EmptyIcon implements Icon{
	
	private var width:Int;
	private var height:Int;
	
	public function new(width:Int, height:Int){
		this.width = width;
		this.height = height;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return null;
	}
	
	public function getIconWidth(c:Component):Int{
		return width;
	}
	
	public function getIconHeight(c:Component):Int{
		return height;
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
	} 
}