/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

import flash.events.Event;
import flash.events.EventDispatcher;

import org.aswing.event.InteractiveEvent;
	/**
 * A generic implementation of SingleSelectionModel.
 * @author paling
 */
class DefaultSingleSelectionModel extends EventDispatcher  implements SingleSelectionModel{
	
	private var index:Int;
	
	public function new(){
		index = -1;
		super();
	}
	
	public function getSelectedIndex() : Int{
		return index;
	}

	public function setSelectedIndex(index : Int, programmatic:Bool=true) : Void{
		if(this.index != index){
			this.index = index;
			fireChangeEvent(programmatic);
		}
	}

	public function clearSelection(programmatic:Bool=true) : Void{
		setSelectedIndex(-1, programmatic);
	}

	public function isSelected() : Bool{
		return getSelectedIndex() != -1;
	}
	
	public function addStateListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(InteractiveEvent.STATE_CHANGED, listener, false,  priority, useWeakReference);
	}
	
	public function removeStateListener(listener:Dynamic -> Void):Void{
		removeEventListener(InteractiveEvent.STATE_CHANGED, listener);
	}
	
	private function fireChangeEvent(programmatic:Bool):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
	}
}