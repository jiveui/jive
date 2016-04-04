/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * The editor component used for JComboBox components.
 * @author paling
 */
interface ComboBoxEditor{
	
	/**
	 * Return the component that performance the editing asset.
	 * @return the editor component
	 */
	function getEditorComponent():Component;
	
	/**
	 * Sets whether the editor is editable now.
	 */
	function setEditable(b:Bool):Void;
	
	/**
	 * Returns whether the editor is editable now.
	 */
	function isEditable():Bool;
		
	/**
	 * Adds a listener to listen the editor event when the edited item changes.
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
	 * Set the item that should be edited. Cancel any editing if necessary.
	 */
	function setValue(value:Dynamic):Void;
	
	/**
	 * Return the edited item.
	 */
	function getValue():Dynamic;
	
	/**
	 * Ask the editor to start editing and to select everything in the editor.
	 */
	function selectAll():Void;
}