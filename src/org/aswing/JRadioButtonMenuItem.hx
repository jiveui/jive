/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.plaf.basic.BasicRadioButtonMenuItemUI;

/**
 * An implementation of a radio button menu item.
 * A <code>JRadioButtonMenuItem</code> is
 * a menu item that is part of a group of menu items in which only one
 * item in the group can be selected. The selected item displays its
 * selected state. Selecting it causes any other selected item to
 * switch to the unselected state.
 * To control the selected state of a group of radio button menu items,  
 * use a <code>ButtonGroup</code> object.
 * @author paling
 */
class JRadioButtonMenuItem extends JMenuItem{
	
	public function new(text:String="", icon:Icon=null){
		super(text, icon);
		setName("JRadioButtonMenuItem");
    	setModel(new ToggleButtonModel());
	}

	override public function getUIClassID():String{
		return "RadioButtonMenuItemUI";
	}
	
	override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicRadioButtonMenuItemUI;
    }
	
}