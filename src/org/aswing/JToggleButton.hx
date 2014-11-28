/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	import org.aswing.plaf.basic.BasicToggleButtonUI;
	

/**
 * An implementation of a two-state button.  
 * The <code>JRadioButton</code> and <code>JCheckBox</code> classes
 * are subclasses of this class.
 * @author paling
 */
class JToggleButton extends AbstractButton
{
	public function new(text:String="", icon:Icon=null)
	{
		super(text, icon);
		setClipMasked(true);
		setName("JToggleButton");
    	setModel(new ToggleButtonModel());
		
		//updateUI();
	}
	
    override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicToggleButtonUI;
    }
	
	override public function getUIClassID():String{
		return "ToggleButtonUI";
	}
	
}