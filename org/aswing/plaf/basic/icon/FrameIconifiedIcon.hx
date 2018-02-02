/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon;


import org.aswing.StyleResult;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	/**
 * The icon for frame iconified.
 * @author paling
 * @private
 */
class FrameIconifiedIcon extends FrameIcon{
	
	public function new(){
		super();
	}
	
	override public function updateIconImp(c:StyleResult, g:Graphics2D, x:Int, y:Int):Void{	
		var w:Float= width - 8 - 1;
		var h:Float= 2;
		y = Math.round(y+Math.floor((height-2)*3/4-2));
		x = x+4;
		g.fillRectangle(new SolidBrush(c.bdark), x, y, w, h);
	}	
}