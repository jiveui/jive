/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon;


import org.aswing.StyleResult;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	/**
 * The icon for frame normal.
 * @author paling
 * @private
 */
class FrameNormalIcon extends FrameIcon{

	public function new(){
		super();
	}

	override public function updateIconImp(c:StyleResult, g:Graphics2D, x:Int, y:Int):Void{
		var gap:Int= 4;
		var w:Int= 5;
		var h:Int= 4;
		var x1:Int= x+gap;
		var y2:Int= y+gap;
		var x2:Int= x1 + 3;
		var y1:Int= y2 + 3;
		var lightBrush:SolidBrush = new SolidBrush(c.bdark);
		var darkBrush:SolidBrush = new SolidBrush(c.bdark);
		g.fillRectangle(lightBrush, x2, y2, w, 1);
		g.fillRectangle(darkBrush, x2, y2+1, w, 1);
		g.fillRectangle(darkBrush, x2+w-1, y2+2, 1, h-1);
		g.fillRectangle(darkBrush, x2+w-2, y2+h, 1, 1);
		
		g.fillRectangle(lightBrush, x1, y1, w, 1);
		g.fillRectangleRingWithThickness(darkBrush, x1, y1+1, w, h, 1);
	}	
}