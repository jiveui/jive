/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import org.aswing.Component;
	import org.aswing.JPanel;
	import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.BaseComponentUI;

/**
 * @private
 * @author paling
 */
class BasicPanelUI extends BaseComponentUI
{
	public function new()
	{
		super();
	}
	
	override public function installUI(c:Component):Void{
		var p:JPanel = AsWingUtils.as(c,JPanel);
		installDefaults(p);
	}

	override public function uninstallUI(c:Component):Void{
		var p:JPanel = AsWingUtils.as(c,JPanel);
		uninstallDefaults(p);
	}

	private function installDefaults(p:JPanel):Void{
		var pp:String= "Panel.";
		LookAndFeel.installColorsAndFont(p, pp);
		LookAndFeel.installBorderAndBFDecorators(p, pp);
		LookAndFeel.installBasicProperties(p, pp);
	}

	private function uninstallDefaults(p:JPanel):Void{
		LookAndFeel.uninstallBorderAndBFDecorators(p);
	}
	
	override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		//do nothing, bg decorator will do this job
	}
}