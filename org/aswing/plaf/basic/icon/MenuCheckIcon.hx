/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon;


import org.aswing.graphics.Graphics2D;
import org.aswing.Icon;
import org.aswing.Component;
import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;

/**
 * @private
 */
class MenuCheckIcon implements Icon implements UIResource{
	
	public function new(){
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
	}
	
	public function getIconHeight(c:Component):Int{
		return 8;
	}
	
	public function getIconWidth(c:Component):Int{
		return 8;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return null;
	}
 
}