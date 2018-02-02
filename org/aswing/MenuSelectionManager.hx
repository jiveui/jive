/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.display.InteractiveObject;
import flash.events.EventDispatcher;
import flash.events.KeyboardEvent;
import org.aswing.AWKeyboard;

import org.aswing.event.InteractiveEvent;
import org.aswing.util.ArrayList;
import org.aswing.util.ArrayUtils;
import org.aswing.util.WeakReference; 
	
/**
 * Dispatched when the menu selection changed.
 * 
 * @eventType org.aswing.event.InteractiveEvent.SELECTION_CHANGED
 */
// [Event(name="selectionChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * A MenuSelectionManager owns the selection in menu hierarchy.
 * 
 * @author paling
 */
class MenuSelectionManager extends EventDispatcher{
		 	
	private static var instance:MenuSelectionManager;
	
	private var selection:ArrayList;
	private var keyEnabled:Bool;
	
	public function new(){
		selection = new ArrayList();
		keyEnabled = true;
		lastTriggerRef = new WeakReference();
		super();
	}
	
	public static function defaultManager():MenuSelectionManager{
		if(instance == null){
			instance = new MenuSelectionManager();
		}
		return instance;
	}
	
	/**
	 * Replaces the default manager by yours.
	 */
	public static function setDefaultManager(m:MenuSelectionManager):Void{
		instance = m;
	}
	
	public function setKeyEnabled(b:Bool):Void{
		keyEnabled = b;
	}
	
	public function isKeyEnabled():Bool{
		return keyEnabled;
	}
	
	private   var lastTriggerRef:WeakReference;
    /**
     * Changes the selection in the menu hierarchy.  The elements
     * in the array are sorted in order from the root menu
     * element to the currently selected menu element.
     * <p>
     * Note that this method is public but is used by the look and
     * feel engine and should not be called by client applications.
     * </p>
     * @param path  an array of <code>MenuElement</code> objects specifying
     *        the selected path.
     * @param programmatic indicate if this is a programmatic change.
     */
    public function setSelectedPath(trigger:InteractiveObject, path:Array<Dynamic>, programmatic:Bool):Void{ //MenuElement[] 
        var i:Int;
        var c:Int;
        var currentSelectionCount:Int= selection.size();
        var firstDifference:Int= 0;
				
        if(path == null) {
            path = new Array<Dynamic>();
        }
		//for(i=0,c=path.length; i<c; i++) {

        for(i in 0...path.length){
            if(i < currentSelectionCount && selection.get(i) == path[i]){
                firstDifference++;
            }else{
                break;
            }
        }
	
		//       for(i=currentSelectionCount-1 ; i>=firstDifference; i--) {
		i=currentSelectionCount-1 ;
        while( i >=firstDifference ){
            var me:MenuElement = AsWingUtils.as(selection.get(i),MenuElement);
            selection.removeAt(i);
            me.menuSelectionChanged(false);
			i--;
        }
	
	
		// for(i = firstDifference, c = path.length ; i < c ; i++) {
        for (i  in firstDifference...path.length ) {
			
        	var tm:MenuElement = AsWingUtils.as(path[i],MenuElement);
		    if (tm != null) {
				selection.append(tm); 
				tm.menuSelectionChanged(true);
		    }
		} 
		if(firstDifference < path.length - 1 || currentSelectionCount != path.length){
			fireSelectionChanged(programmatic);
		}
		var lastTrigger:InteractiveObject = lastTriggerRef.value;
		if(selection.size() == 0){
			if(lastTrigger!=null)	{
				lastTrigger.removeEventListener(KeyboardEvent.KEY_DOWN, __onMSMKeyDown);
				lastTriggerRef.clear();
			}
		}else{
			if(lastTrigger != trigger){
				if(lastTrigger!=null)	{
					lastTrigger.removeEventListener(KeyboardEvent.KEY_DOWN, __onMSMKeyDown);
				}
				lastTrigger = trigger;
				if(trigger!=null)	{
					trigger.addEventListener(KeyboardEvent.KEY_DOWN, __onMSMKeyDown, false, 0, false);
				}
				lastTriggerRef.value = trigger;
			}
		}
    }
    
	/**
	 * Adds a listener to listen the menu seletion change event.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */	
	public function addSelectionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(InteractiveEvent.SELECTION_CHANGED, listener, false, priority);
	}	
	
	/**
	 * Removes a menu seletion change listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */	
	public function removeSelectionListener(listener:Dynamic -> Void):Void{
		removeEventListener(InteractiveEvent.SELECTION_CHANGED, listener);
	}
	
    /**
     * Returns the path to the currently selected menu item
     *
     * @return an array of MenuElement objects representing the selected path
     */
    public function getSelectedPath():Array<Dynamic>{ //MenuElement[]
        return selection.toArray();
    }

    /**
     * Tell the menu selection to close and unselect all the menu components. Call this method
     * when a choice has been made.
     * @param programmatic indicate if this is a programmatic change.
     */
    public function clearSelectedPath(programmatic:Bool):Void{
        if (selection.size() > 0) {
            setSelectedPath(null, null, true);
        }
    }
    
    /** 
     * Return true if c is part of the currently used menu
     */
    public function isComponentPartOfCurrentMenu(c:Component):Bool{
        if(selection.size() > 0) {
            var me:MenuElement = AsWingUtils.as(selection.get(0),MenuElement);
            return isComponentPartOfMenu(me, c);
        }else{
            return false;
        }
    }
    
    public function isNavigatingKey(code:Int):Bool{
    	return isPageNavKey(code) || isItemNavKey(code);
    }
    public function isPageNavKey(code:Int):Bool{
    	return isPrevPageKey(code) || isNextPageKey(code);
    }
    public function isItemNavKey(code:Int):Bool{
    	return isPrevItemKey(code) || isNextItemKey(code);
    }
    public function isPrevPageKey(code:Int):Bool{
    	return code == AWKeyboard.LEFT;
    }
    public function isPrevItemKey(code:Int):Bool{
    	return code == AWKeyboard.UP;
    }
    public function isNextPageKey(code:Int):Bool{
    	return code == AWKeyboard.RIGHT;
    }
    public function isNextItemKey(code:Int):Bool{
    	return code == AWKeyboard.DOWN;
    }
    public function isEnterKey(code:Int):Bool{
    	return code == AWKeyboard.ENTER;
    }
    public function isEscKey(code:Int):Bool{
    	return code == AWKeyboard.TAB || code == AWKeyboard.ESCAPE;
    }
    
    public function nextSubElement(parent:MenuElement, sub:MenuElement):MenuElement{
    	return besideSubElement(parent, sub, 1);
    }
    
    public function prevSubElement(parent:MenuElement, sub:MenuElement):MenuElement{
    	return besideSubElement(parent, sub, -1);
    }
    
    private function besideSubElement(parent:MenuElement, sub:MenuElement, dir:Float):MenuElement{
    	if(parent == null || sub == null){
    		return null;
    	}
    	var subs:Array<Dynamic>= parent.getSubElements();
    	var index:Int= ArrayUtils.indexInArray(subs, sub);
    	if(index < 0){
    		return null;
    	}
    	index += Std.int(dir);
    	if(index >= subs.length){
    		index = 0;
    	}else if(index < 0){
    		index = subs.length - 1;
    	}
    	return AsWingUtils.as(subs[index],MenuElement);
    }

    private function isComponentPartOfMenu(root:MenuElement, c:Component):Bool{
        var children:Array<Dynamic>;
        var i:Float;
        var d:Float;
	
		if (root == null){
		    return false;
		}
	
        if(root.getMenuComponent() == c){
            return true;
        }else {
            children = root.getSubElements();
			//  for(i=0,d=children.length; i<d; i++) {
            for(i in 0...children.length){
            	var me:MenuElement = AsWingUtils.as(children[i],MenuElement);
                if(me != null && isComponentPartOfMenu(me, c)){
                    return true;
                }
            }
        }
        return false;
	}
	
	private function fireSelectionChanged(programmatic:Bool):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.SELECTION_CHANGED, programmatic));
	}
	
	private function __onMSMKeyDown(e:KeyboardEvent):Void{
		if(selection.size() == 0 || !isKeyEnabled()){
			return;
		}
		var code:Int= e.keyCode;
		if(isEscKey(code)){
			setSelectedPath(null, null, true);
			return;
		} 
		var element:MenuElement = AsWingUtils.as(selection.last(),MenuElement);
		element.processKeyEvent(code);
	}
	
}