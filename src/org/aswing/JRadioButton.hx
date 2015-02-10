/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

import haxe.ds.StringMap;
import org.aswing.plaf.basic.BasicRadioButtonUI;
	
	
/**
 * An implementation of a radio button -- an item that can be selected or
 * deselected, and which displays its state to the user.
 * Used with a `ButtonGroup` object to create a group of buttons
 * in which only one button at a time can be selected. (Create a ButtonGroup
 * object and use its <code>Component.append</code> method to include the JRadioButton objects
 * in the group.)
 * <blockquote>
 * <strong>Note:</strong>
 * The ButtonGroup object is a logical grouping -- not a physical grouping.
 * To create a button panel, you should still create a `JPanel` or similar
 * container-object and add a `org.aswing.border.Border` to it to set it off from surrounding
 * components.
 * </blockquote>
 * @author paling
 */	
class JRadioButton extends JToggleButton{
	
    private static var groups: StringMap<ButtonGroup> = new StringMap<ButtonGroup>();

	public function new(text:String="", icon:Icon=null)
	{
		super(text, icon);
		setName("JRadioButton");
	}
	
    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicRadioButtonUI;
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "RadioButtonUI";
	}

    public var groupName(get, set): String;
    private var _groupName: String;
    private function get_groupName(): String { return _groupName; }
    private function set_groupName(v: String): String {
        if (null != _groupName) {
            groups.get(_groupName).remove(this);
        }
        if (null != v) {
            if (!groups.exists(v)) {
                groups.set(v, new ButtonGroup());
            }
            groups.get(v).append(this);
        }
        _groupName = v;
        return v;
    }
	
}