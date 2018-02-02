/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.adjuster;

	
import org.aswing.plaf.basic.icon.SliderThumbIcon;
import org.aswing.Component;

/**
 * @private
 */
class PopupSliderThumbIcon extends SliderThumbIcon{
	
	public function new(){
		super();
	}
	
	override private function getPropertyPrefix():String{
		return "Adjuster.";
	}	
	
	override public function getIconHeight(c:Component):Int{
		return 12;
	}
	
	override public function getIconWidth(c:Component):Int{
		return 12;
	}	
	
}