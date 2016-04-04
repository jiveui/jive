/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.colorchooser;
 
import flash.events.EventDispatcher;

import org.aswing.ASColor;

/**
 * @author paling
 * A model that supports selecting a <code>Color</code>.
 * 
 * @see org.aswing.ASColor
 */
interface ColorSelectionModel{
	
    /**
     * Returns the selected <code>ASColor</code> which should be
     * non-<code>null</code>.
     *
     * @return  the selected <code>ASColor</code>
     * @see     #setSelectedColor()
     */
    function getSelectedColor():ASColor;

    /**
     * Sets the selected color to <code>ASColor</code>.
     * Note that setting the color to <code>null</code>
     * is undefined and may have unpredictable results.
     * This method fires a state changed event if it sets the
     * current color to a new non-<code>null</code> color.
     *
     * @param color the new <code>ASColor</code>
     * @see   #getSelectedColor()
     * @see   #addChangeListener()
     */
    function setSelectedColor(color:ASColor):Void;
    
    /**
     * Fires a event to indicate a color is adjusting, for example:
     * durring swatched rollover or mixer modification.
     * <p>
     * This should be called by AsWing core(generally called by UI classes), 
     * client app should not call this generally.
     * 
     * @param color the new adjusting <code>ASColor</code>
     * @see #addColorAdjustingListener()
     */
    function fireColorAdjusting(color:ASColor):Void;

	/**
	 * addChangeListener(func:Function)<br>
	 * <p>
	 * Add a listener to listen the Model's change event.
	 * <p>
	 * When the selected color changed.
	 * 
	 * onStateChanged(source:ColorSelectionModel)
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 * @see flash.events.EventDispatcher#addEventListener()
	 */
    function addChangeListener(func:Dynamic -> Void):Void;
    
    /**
	 * addColorAdjustingListener(func:Function)<br>bject)
	 * <p>
	 * Add a listener to listen the color adjusting event.
	 * <p>
	 * When user adjusting to a new color.
	 * 
	 * onColorAdjusting(source:ColorSelectionModel, color:ASColor)
	 * @see org.aswing.event.ColorChooserEvent#COLOR_ADJUSTING
	 * @see flash.events.EventDispatcher#addEventListener()
     */
    function addColorAdjustingListener(func:Dynamic -> Void):Void;
    
    /**
    * removeChangeListener(func:Fuction)<br>
    * <p>
    * Remove the changeListener
    * <p>
    * @see flash.events.EventDispatcher#removeEventListener()
    */ 
    function removeChangeListener(func:Dynamic -> Void):Void;
    
    /**
    * removeColorAdjustingListener(func:Fuction)<br>
    * <p>
    * Remove the colorAdjustingListener
    * <p>
    * @see flash.events.EventDispatcher#removeEventListener()
    */ 
    function removeColorAdjustingListener(func:Dynamic -> Void):Void;
}