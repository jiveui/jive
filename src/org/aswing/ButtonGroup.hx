/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.util.ArrayUtils;

/**
 * This class is used to create a multiple-exclusion scope for a set of buttons. 
 * Creating a set of buttons with the same ButtonGroup object means that turning "on" 
 * one of those buttons turns off all other buttons in the group. 
 * <p>
 * A ButtonGroup can be used with any set of objects that inherit from AbstractButton. 
 * Typically a button group contains instances of JRadioButton, JRadioButtonMenuItem, 
 * or JToggleButton. It wouldn't make sense to put an instance of JButton or JMenuItem in a button group because JButton and JMenuItem don't implement the selected state. 
 * </p>
 * <p>
 * Initially, all buttons in the group are unselected. Once any button is selected, one button is always selected in the group. There is no way to turn a button programmatically to "off", in order to clear the button group. To give the appearance of "none selected", add an invisible radio button to the group and then programmatically select that button to turn off all the displayed radio buttons. For example, a normal button with the label "none" could be wired to select the invisible radio button. 
 * </p>
 * @author paling
 * @author Aron (added the allowUncheck feature)
 */
class ButtonGroup
{
    // the list of buttons participating in this group
    private var buttons:Array<Dynamic>;
    
    private var allowUncheck : Bool;

		/**
	 * The current selection.
	 */
    private var selection:ButtonModel;

    /**
	 * Creates a new <code>ButtonGroup</code>.
	 */
    public function new() {
    	selection=null;
			buttons = new Array<Dynamic>();
    }
    
    /**
     * Create a button group and append the buttons in, then return the group.
     * @return the button group.
     */
    public static function groupButtons(buttons: Array<Dynamic>):ButtonGroup{
    	var g:ButtonGroup = new ButtonGroup();
    	for (i in buttons ){
    		g.append(i);
    	}
    	return g;
    }

    /**
	 * Adds the button to the group.
	 * 
	 * @param b the button to be added
	 */ 
    public function append(b:AbstractButton):Void{
        if(b == null) {
            return;
        }
        buttons.push(b);

        if (b.isSelected()) {
            if (selection == null) {
                selection = b.getModel();
            } else {
                b.setSelected(false);
            }
        }

        b.getModel().setGroup(this);
    }
 	
 	/**
 	 * Appends all buttons into this group.
 	 */
 	public function appendAll(buttons: Array<Dynamic>):Void{
    	for (i in buttons ){
    		append(i);
    	}
 	}
 	
    /**
	 * Removes the button from the group.
	 * 
	 * @param b the button to be removed
	 */ 
    public function remove(b:AbstractButton):Void{
        if(b == null) {
            return;
        }
        ArrayUtils.removeFromArray(buttons, b);
        if(b.getModel() == selection) {
            selection = null;
        }
        b.getModel().setGroup(null);
    }
    
    /**
     * Returns whether the group contains the button.
     * @return true if the group contains the button, false otherwise
     */
    public function contains(b:AbstractButton):Bool{
    	for(i in 0...buttons.length){
    		if(buttons[i] == b){
    			return true;
    		}
    	}
    	return false;
    }

    /**
	 * Returns all the buttons that are participating in this group.
	 * 
	 * @return an <code>Array</code> of the buttons in this group
	 */
    public function getElements():Array<Dynamic>{
        return ArrayUtils.cloneArray(buttons);
    }

    /**
	 * Returns the model of the selected button.
	 * 
	 * @return the selected button model
	 */
    public function getSelection():ButtonModel {
        return selection;
    }
    
    public function getSelectedIndex():Int{
        for (i  in 0...buttons.length) {
				var ab	:AbstractButton = AsWingUtils.as(buttons[i], AbstractButton);
				if(ab.isSelected()) return i;
        }
        return -1;
    }
    
    /**
     * Return the first selected button, if none, return null.
     */
    public function getSelectedButton():AbstractButton{
    	for (b in buttons ){
    		if(b.isSelected()){
    			return b;
    		}
    	}
    	return null;
    }

    /**
	 * Sets the selected value for the <code>ButtonModel</code>. Only one
	 * button in the group may be selected at a time.
	 * 
	 * @param m the <code>ButtonModel</code>
	 * @param b <code>true</code> if this button is to be selected,
	 *            otherwise <code>false</code>
	 */
    public function setSelected(m:ButtonModel, b:Bool):Void{
        if (b && m != null && m != selection) {
            var oldSelection:ButtonModel = selection;
            selection = m;
            if (oldSelection != null) {
                oldSelection.setSelected(false);
            }
            m.setSelected(true);
        }
        else if(!b && m != null && allowUncheck)
        {
			selection = null;
			//m.setSelected(false);
		}
    }

    /**
	 * Returns whether a <code>ButtonModel</code> is selected.
	 * 
	 * @return <code>true</code> if the button is selected, otherwise returns
	 *         <code>false</code>
	 */
    public function isSelected(m:ButtonModel):Bool{
        return (m == selection);
    }

    /**
	 * Returns the number of buttons in the group.
	 * 
	 * @return the button count
	 */
    public function getButtonCount():Float{
    	return buttons.length;
    }
    
    public function setAllowUncheck(allowUncheck : Bool) : Void{
    	this.allowUncheck = allowUncheck;
    }
}