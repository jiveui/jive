/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf;


import org.aswing.JComboBox;

/**
 * Pluginable ui for JComboBox.
 * @see org.aswing.JComboBox
 * @author paling
 */
interface ComboBoxUI extends ComponentUI{

	/**
     * Set the visiblity of the popup
     */
	function setPopupVisible(c:JComboBox, v:Bool):Void;
	
	/**
     * Determine the visibility of the popup
     */
	function isPopupVisible(c:JComboBox):Bool;
}