/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.dnd;

	
import org.aswing.Component;
import flash.display.Sprite;

/**
 * Remove the dragging movieclip directly.
 * @author paling
 */
class DirectlyRemoveMotion implements DropMotion{
	
	public function new():Void
	{
		
	}
	public function startMotionAndLaterRemove(dragInitiator:Component, dragObject:Sprite):Void{
		if(dragObject.parent != null){
			dragObject.parent.removeChild(dragObject);
		}
	}
	
	public function forceStop():Void{
	}	
}