/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.colorchooser;
 
import org.aswing.colorchooser.AbstractColorChooserPanel;
import org.aswing.UIManager;
import org.aswing.plaf.basic.BasicColorMixerUI;

/**
 * @author paling
 */
class JColorMixer extends AbstractColorChooserPanel {
	
	public function new() {
		super();
		updateUI();
	}
	
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
	override public function getUIClassID():String{
		return "ColorMixerUI";
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicColorMixerUI;
    }

}