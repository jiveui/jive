/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf;


import org.aswing.JTextField;
	import org.aswing.JSlider;
	import org.aswing.plaf.ComponentUI;

/**
 * Pluginable ui for JAdjuster.
 * @see org.aswing.JAdjuster
 * @author paling
 */
interface AdjusterUI extends ComponentUI{
	
	function getInputText():JTextField;
	
	function getPopupSlider():JSlider;
}