/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * Interface for editable components.
 * @author paling
 */
interface EditableComponent{
	
	/**
     * Returns true if the component is editable, false not editable.
     * @return true if the component is editable, false not editable.
     */
	function isEditable():Bool;
	
	/**
     * Sets the whether or not the component is editable.
     * @param b true to set to editable, false not editable.
     */
	function setEditable(b:Bool):Void;	
}