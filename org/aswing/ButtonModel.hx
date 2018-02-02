/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
/**
 * State Model for buttons.
 * This model is used for check boxes and radio buttons, which are
 * special kinds of buttons, as well as for normal buttons.
 * For check boxes and radio buttons, pressing the mouse selects
 * the button. For normal buttons, pressing the mouse "arms" the
 * button. Releasing the mouse over the button then initiates a
 * <i>button</i> press, firing its action event. Releasing the 
 * mouse elsewhere disarms the button.
 * <p>
 * In use, a UI will invoke <code>setSelected</code> when a mouse
 * click occurs over a check box or radio button. It will invoke
 * <code>setArmed</code when the mouse is pressed over a regular
 * button and invoke <code>setPressed</code when the mouse is released.
 * If the mouse travels outside the button in the meantime, 
 * <code>setArmed(false)</code> will tell the button not to fire
 * when it sees <code>setPressed</code>. (If the mouse travels 
 * back in, the button will be rearmed.)
 * </p>
 * <b>Note: </b><br>
 * A button is triggered when it is both "armed" and "pressed".
 * 
 * <p>
 * Buttons always fire <code>programmatic=false</code> InteractiveEvent.
 * </p>
 * @author paling
 */	
interface ButtonModel
{
	/**
	 * Adds a listener to listen the Model's state change event.
	 * <p>
	 * When the button's state changed, the state is all about:
	 * <ul>
	 * <li>enabled</li>
	 * <li>rollOver</li>
	 * <li>pressed</li>
	 * <li>released</li>
	 * <li>selected</li>
	 * </ul>
	 * </p>
	 * <p>
	 * Buttons always fire <code>programmatic=false</code> InteractiveEvent.
	 * </p>
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */
	function addStateListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void;
	
	/**
	 * Removes a state listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */
	function removeStateListener(listener:Dynamic -> Void):Void;
	
	/**
	 * Adds a listener to listen the Model's act event.
	 * When the button model's armed and pressed to fire this event.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.AWEvent#ACT
	 */
	function addActionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void;
	
	/**
	 * Removes a action listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.AWEvent#ACT
	 */
	function removeActionListener(listener:Dynamic -> Void):Void;	
	
	/**
	 * Add a listener to listen the Model's selection change event.
	 * When the button's selection changed, fired when diselected or selected.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.InteractiveEvent#SELECTION_CHANGED
	 */	
	function addSelectionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void;
	
	/**
	 * Removes a selection listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.InteractiveEvent#SELECTION_CHANGED
	 */
	function removeSelectionListener(listener:Dynamic -> Void):Void;
		
	/**
	 * Indicates if the button can be selected or pressed by an input device (such as a mouse pointer).
	 * @return true if the button is enabled, and therefore selectable (or pressable)
	 */
	function isEnabled():Bool;
	
	/**
	 * Indicates that the mouse is over the button.
	 * @return true if the mouse is over the button
	 */
	function isRollOver():Bool;
	
	/**
	 * Indicates partial commitment towards pressing the button.
	 * <p>
	 * Note, this is similar to AS2 version's both <b>pressed</b> and <b>rollover</b>.
	 * </p>
	 * @return true if the button is armed, and ready to be pressed
	 */
	function isArmed():Bool;
	
	/**
	 * Indicates if button has been pressed.
	 * @return true if the button has been pressed
	 */
	function isPressed():Bool;
				
	/**
	 * Indicates if the button has been selected.
	 */
	function isSelected():Bool;
	
	/**
	 * Enables or disables the button.
	 */
	function setEnabled(b:Bool):Void;
	
    /**
     * Sets or clears the button's rollover state
     * 
     * @param b true to turn on rollover
     * @see #isRollover
     */
	function setRollOver(b:Bool):Void;

    /**
     * Marks the button as "armed". If the mouse button is
     * released while it is over this item, the button's action event
     * fires. If the mouse button is released elsewhere, the
     * event does not fire and the button is disarmed.
     * 
     * @param b true to arm the button so it can be selected
     */
	function setArmed(b:Bool):Void;
	
	/**
	 * Sets the button to being pressed or unpressed.
	 */
	function setPressed(b:Bool):Void;
		
    /**
     * Selects or deselects the button.
     *
     * @param b true selects the button,
     *          false deselects the button.
     */
	function setSelected(b:Bool):Void;
	
    /**
     * Identifies the group this button belongs to --
     * needed for radio buttons, which are mutually
     * exclusive within their group.
     *
     * @param group the ButtonGroup this button belongs to
     */
	function setGroup(group:ButtonGroup):Void;	
}