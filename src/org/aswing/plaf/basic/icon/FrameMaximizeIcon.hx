/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon;


import org.aswing.StyleResult;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	/**
 * The icon for frame maximize.
 * @author paling
 * @private
 */
class FrameMaximizeIcon extends FrameIcon{

	public function new(){
		super();
	}	

	override public function updateIconImp(c:StyleResult, g:Graphics2D, x:Int, y:Int):Void{
		var gap:Int= 4;
		x = x+gap;
		y = y+gap;
		var w:Int= width -1 - gap*2;
		var h:Int= height - 1 - gap*2 - 2;
		g.fillRectangle(new SolidBrush(c.bdark), x, y, w, 1);
		var darkBrush:SolidBrush = new SolidBrush(c.bdark);
		g.fillRectangle(darkBrush, x, y+1, w, 1);
		g.fillRectangleRingWithThickness(darkBrush, x, y+2, w, h, 1);		
	}	
}