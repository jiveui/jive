/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

import org.aswing.Component;
	import org.aswing.JSpacer;
	import org.aswing.plaf.BaseComponentUI;
import org.aswing.geom.IntDimension;

/**
 * @private
 */
class BasicSpacerUI extends BaseComponentUI
{
	public function new(){
		super();
	}
	
	private function getPropertyPrefix():String{
		return "Spacer.";
	}
	
	override public function installUI(c:Component):Void{
		installDefaults(AsWingUtils.as(c,JSpacer));
	}
	
	override public function uninstallUI(c:Component):Void{
		uninstallDefaults(AsWingUtils.as(c,JSpacer));
	}
	
	private function installDefaults(s:JSpacer):Void{
		var pp:String= getPropertyPrefix();
		LookAndFeel.installColors(s, pp);
		LookAndFeel.installBasicProperties(s, pp);
		LookAndFeel.installBorderAndBFDecorators(s, pp);
	}
	
	private function uninstallDefaults(s:JSpacer):Void{
		LookAndFeel.uninstallBorderAndBFDecorators(s);
	}
	
	override public function getPreferredSize(c:Component):IntDimension{
		return c.getInsets().getOutsideSize(new IntDimension(0, 0));
	}
	
	override public function getMaximumSize(c:Component):IntDimension
	{
		return IntDimension.createBigDimension();
	}
	/**
	 * Returns null
	 */	
	override public function getMinimumSize(c:Component):IntDimension
	{
		return new IntDimension(0, 0);
	}
}