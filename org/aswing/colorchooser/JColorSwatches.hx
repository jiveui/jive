/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.colorchooser;


import org.aswing.Component;
	import org.aswing.plaf.ColorSwatchesUI;
import org.aswing.plaf.basic.BasicColorSwatchesUI;

/**
 * @author paling
 */
class JColorSwatches extends AbstractColorChooserPanel {
		
	public function new() {
		super();
		updateUI();
	}
	
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicColorSwatchesUI;
    }
	
	override public function getUIClassID():String{
		return "ColorSwatchesUI";
	}
	
	/**
	 * Adds a component to this panel's sections bar
	 * @param com the component to be added
	 */
	public function addComponentColorSectionBar(com:Component):Void{
		AsWingUtils.as(getUI(),ColorSwatchesUI).addComponentColorSectionBar(com);
	}
}