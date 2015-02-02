/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	import org.aswing.plaf.basic.BasicCheckBoxUI;
	
	
/**
 * An implementation of a check box -- an item that can be selected or
 * deselected, and which displays its state to the user. 
 * By convention, any number of check boxes in a group can be selected.
 * @author paling
 */	
class JCheckBox extends JToggleButton{
/**
 * Add a new component CheckBox.
 */
	public function new(text:String="", icon:Icon=null)
	{
		super(text, icon);
		setName("JCheckBox");
		setIconTextGap(1); 
	}
    @:dox(hide)
	override public function getUIClassID():String{
		return "CheckBoxUI";
	}
	/**
    * @see 'BasicCheckBoxUI'
    */
	@:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicCheckBoxUI;
    }
	
}