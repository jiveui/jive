/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf;


import org.aswing.Component;

/**
 * Pluggable look and feel interface for JColorSwatchs.
 * 
 * @author paling
 */
interface ColorSwatchesUI extends ComponentUI{
	
	/**
	 * Adds a component to this panel's sections bar.
	 * @param com the component to be added
	 */
	function addComponentColorSectionBar(com:Component):Void;
	
}