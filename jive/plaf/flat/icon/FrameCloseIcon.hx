/*
 Copyright aswing.org, see the LICENCE.txt.
*/


package jive.plaf.flat.icon;

	
import flash.display.CapsStyle;
import flash.display.LineScaleMode;

import org.aswing.StyleResult;
	import org.aswing.ASColor;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	/**
 * The icon for frame close.
 * @author paling
 * @private
 */
class FrameCloseIcon extends FrameIcon {
	
	public function new(){
		super();
	}
	
	override public function updateIconImp(c: ASColor, g:Graphics2D, x:Int, y:Int):Void{
		var gap:Int= 4;
		var w:Int= width-1-gap*2;
		var h:Int= height-1-gap*2;
		var x1:Int= x+gap;
		var y1:Int= y+gap;

		var lightPane:Pen = new Pen(c, 2, true, LineScaleMode.NORMAL, CapsStyle.ROUND);
		g.drawLine(lightPane, x1, y1, x1+w, y1+h);
		g.drawLine(lightPane, x1+w, y1, x1, y1+h);
		 
	}
}