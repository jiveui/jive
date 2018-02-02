/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.plaf.basic.BasicCheckBoxMenuItemUI;

/**
 * A menu item that can be selected or deselected. If selected, the menu
 * item typically appears with a checkmark next to it. If unselected or
 * deselected, the menu item appears without a checkmark. Like a regular
 * menu item, a check box menu item can have either text or a graphic
 * icon associated with it, or both.
 * @author paling
 */
class JCheckBoxMenuItem extends JMenuItem{
	
	public function new(text:String="", icon:Icon=null){
		super(text, icon);
		setName("JCheckBoxMenuItem");
		setModel(new ToggleButtonModel()); 
	}

	override public function getUIClassID():String{
		return "CheckBoxMenuItemUI";
	}
	
	override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicCheckBoxMenuItemUI;
    }
	
}