/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border;

	
import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.border.LineBorder;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.UIResource;
	/**
 * Discard in aswing 2.0(Background raped his job)
 * @private
 */
class ProgressBarBorder extends LineBorder  implements UIResource
{
 
	public function new() {
		color = null;	
		super();
	}
	
	override public function updateBorderImp(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(color == null){
			color = c.getUI().getColor("ProgressBar.foreground");
			setColor(color);
		}
		super.updateBorderImp(c, g, b);
	}
}