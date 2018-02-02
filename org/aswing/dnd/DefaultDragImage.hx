/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.dnd;


import flash.display.Shape;
	import flash.display.DisplayObject;
	import org.aswing.Component;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	/**
 * The default drag image.
 * @author paling
 */
class DefaultDragImage implements DraggingImage{
	
	private var image:Shape;
	private var width:Int;
	private var height:Int;
	
	public function new(dragInitiator:Component){
		width = Std.int(dragInitiator.width);
		height = Std.int(dragInitiator.height);
		
		image = new Shape();
	}
	
	public function getDisplay():DisplayObject
	{
		return image;
	}
	
	public function switchToRejectImage():Void{
		image.graphics.clear();
		var r:Float= Math.min(width, height) - 2;
		var x:Float= 0;
		var y:Float= 0;
		var w:Float= width;
		var h:Float= height;
		var g:Graphics2D = new Graphics2D(image.graphics);
		//why	
		 
		g.drawLine(new Pen(ASColor.RED, 2), x+1, y+1, x+1+r, y+1+r);
		g.drawLine(new Pen(ASColor.RED, 2), x+1+r, y+1, x+1, y+1+r);
		g.drawRectangle(new Pen(ASColor.GRAY), x, y, w, h);
		 
	}
	
	public function switchToAcceptImage():Void{
		image.graphics.clear();
		var g:Graphics2D = new Graphics2D(image.graphics);
		g.drawRectangle(new Pen(ASColor.GRAY), 0, 0, width, height);
	}
	
}