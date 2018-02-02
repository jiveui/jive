/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon;


import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;

/**
 * @private
 */
class MenuArrowIcon extends SolidArrowIcon  implements UIResource{
	
	public function new(){
		super(0, 8, ASColor.BLACK);
	}
	
	override public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		super.updateIcon(c, g, x, y);
		paintIconWithColor(c.getMideground());
	}
}