/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf;


/**
 * Pluginable ui for JFrame.
 * @see org.aswing.JFrame
 * @author paling
 */
interface FrameUI extends ComponentUI
{
	/**
	 * Flash the modal frame. (User clicked other where is not in the modal frame, 
	 * flash the frame to make notice this frame is modal.)
	 */
	function flashModalFrame():Void;
	
	/**
	 * For <code>flashModalFrame</code> to judge whether paint actived color or inactived color.
	 */
	function isPaintActivedFrame():Bool;
}