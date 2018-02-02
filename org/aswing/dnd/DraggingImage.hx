/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.dnd;


import flash.display.DisplayObject;

/**
 * The Image for dragging representing.
 * 
 * @author paling
 */
interface DraggingImage{

	/**
	 * Returns the display object for the representation of dragging.
	 */
	function getDisplay() : DisplayObject ;
	
	/**
	 * Paints the image for accept state of dragging.(means drop allowed)
	 */
	function switchToAcceptImage() : Void;
	
	/**
	 * Paints the image for reject state of dragging.(means drop not allowed)
	 */
	function switchToRejectImage() : Void;	
}