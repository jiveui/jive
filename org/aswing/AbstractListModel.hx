/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.event.ListDataListener;
	import org.aswing.event.ListDataEvent;
	import org.aswing.util.ArrayUtils;
	/**
 * Abstract list model that provide the list model events base.
 * @author paling
 */
class AbstractListModel{
	
    private var listeners:Array<Dynamic>;
    
    public function new(){
    	listeners = new Array<Dynamic>();
    }

    public function addListDataListener(l:ListDataListener):Void{
		listeners.push(l);
    }

    public function removeListDataListener(l:ListDataListener):Void{
    	ArrayUtils.removeFromArray(listeners, l);
    }

    private function fireContentsChanged(target:Dynamic, index0:Int, index1:Int, removedItems:Array<Dynamic>):Void{
		var e:ListDataEvent = new ListDataEvent(target, index0, index1, removedItems);
	
		for (i in 0...listeners.length  ){
			var lis:ListDataListener = AsWingUtils.as(listeners[i],ListDataListener);
			lis.contentsChanged(e);
		}
    }

    private function fireIntervalAdded(target:Dynamic, index0:Int, index1:Int):Void{
		var e:ListDataEvent = new ListDataEvent(target, index0, index1, []);
	
		for (i in 0...listeners.length  ){
			var lis:ListDataListener =AsWingUtils.as(listeners[i],ListDataListener);
			lis.intervalAdded(e);     
		}
    }

    private function fireIntervalRemoved(target:Dynamic, index0:Int, index1:Int, removedItems:Array<Dynamic>):Void{
		var e:ListDataEvent = new ListDataEvent(target, index0, index1, removedItems);
	
		for (i in 0...listeners.length ){
			var lis:ListDataListener = AsWingUtils.as(listeners[i],ListDataListener);
			lis.intervalRemoved(e);
		}		
    }
}