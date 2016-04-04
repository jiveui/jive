/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.dnd;


import org.aswing.Component;
import flash.display.Sprite;

/**
 * The motion when a drag action dropped.
 * The motion must remove the drag movie clip when motion is completed.
 * @author paling
 */
interface DropMotion{
	
	/**
	 * Starts the drop motion and remove the dragObject from its parent when motion is completed.
	 * @param dragInitiator the drag initiator
	 * @param dragObject the display object to do motion
	 */
	function startMotionAndLaterRemove(dragInitiator:Component, dragObject:Sprite):Void;
	
	/**
	 * A new drag is started, so the last motion should be stopped if it is still running.
	 */
	function forceStop():Void;
		
}