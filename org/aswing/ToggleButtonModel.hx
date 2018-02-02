/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
/**
 * The ToggleButton model
 * @author paling
 */
class ToggleButtonModel extends DefaultButtonModel{
	
	public function new(){
		super();
	}

    /**
     * Sets the selected state of the button.
     * @param b true selects the toggle button,
     *          false deselects the toggle button.
     */
    override public function setSelected(b:Bool):Void {
        var group:ButtonGroup = getGroup();
        if (group != null) {
            // use the group model instead
            group.setSelected(this, b);
            b = group.isSelected(this);
        }
        super.setSelected(b);
    }
    
    /**
     * Sets the button to released or unreleased.
     */
	override public function setPressed(b:Bool):Void {
 
        if(isPressed()==b || !isEnabled()) {
            return;
        }
       
        if (b==false && isArmed()) {
            setSelected(!isSelected());
        }
        
        pressed = b;
            
        fireStateChanged();
		if(!isPressed() && isArmed()) {
			fireActionEvent();
		}
	}	
}