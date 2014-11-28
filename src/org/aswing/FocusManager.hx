/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.display.Stage;
	import flash.display.Sprite;
	import flash.display.InteractiveObject;
	import org.aswing.error.Error;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
import flash.text.TextField;
import org.aswing.AWKeyboard;

import org.aswing.event.MovedEvent;
	import org.aswing.event.ResizedEvent;
	import org.aswing.util.DepthManager;
import org.aswing.util.ArrayList;
import org.aswing.util.WeakMap;
import org.aswing.AsWingUtils;
/**
 * FocusManager manages all the when a component should receive focus, i.e if it
 * can.
 * 
 * @author paling
 */
class FocusManager{
	
	private static var managers:WeakMap<Stage,FocusManager> = new WeakMap<Stage,FocusManager>();
	private static var defaultTraversalEnabled:Bool= true;
	
	private var oldFocusOwner:Component;
	private var focusOwner:Component;
	private var popups:ArrayList;
	private var activeWindow:JWindow;
	private var traversalEnabled:Bool;
	private var traversalDefault:Bool;
		
	private var stage:Stage;
	private var focusRect:Sprite;
	private var inited:Bool;
	private var defaultPolicy:FocusTraversalPolicy;
	private var traversing:Bool;
		
	public function new(theStage:Stage){
		traversalEnabled=true;
			traversalDefault=true;
			traversing = false;
		inited = false;
		defaultPolicy = new ContainerOrderFocusTraversalPolicy();
		popups = new ArrayList();
		init(theStage);
	}
	
    /**
     * Returns the current FocusManager instance
     *
     * @return this the current FocusManager instance
     * @see #setCurrentManager
     */
	public static function getManager(theStage:Stage):FocusManager{
		if(theStage == null){
			return null;
		}
		var manager:FocusManager = managers.getValue(theStage);
		if (manager == null) {  
			manager = new FocusManager(theStage);
			managers.put(theStage, manager);
		}		
		return manager;
	}
	private function __referenceEvent(e:Event):Void{//just for keep stage reference this manager
	}
	
	/**
     * Sets the current FocusManager instance. If null is specified, 
     * then the current FocusManager is replaced with a new instance of FocusManager.
     * 
     * @param newManager the new FocusManager
     * @see #getCurrentManager
     * @see org.aswing.FocusManager
	 */
	public static function setManager(theStage:Stage, newManager:FocusManager):Void{
		if(theStage == null){
			throw new Error("theStage can't be null!");
			 
		}
		if(newManager == null){
			newManager = new FocusManager(theStage);
		}
		var oldManager:FocusManager = managers.getValue(theStage);
		if(oldManager != newManager){
			if(oldManager != null){
				oldManager.uninit();
			}
			managers.put(theStage, newManager);
		}
	}
	
	/**
	 * Init the focus manager, it will only start works when it is inited.
	 * By default, it will be inited when a component is added to stage automatically.
	 */
	public function init(theStage:Stage):Void{
		if(inited!=true){
			stage = theStage;
			inited = true;
			stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, __onKeyFocusChange, false, 0, false);
			stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, __onMouseFocusChange, false, 0, false);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown, false, 0, false);
			stage.addEventListener(KeyboardEvent.KEY_UP, __onKeyUp, false, 0, false);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown, false, 0, false);
			focusRect = new Sprite();
			focusRect.mouseEnabled = false;
			focusRect.visible = false;
			stage.addChild(focusRect);
			//Make stage reference this manager to keep manager will not be GC until stage be GC.
			stage.addEventListener(Event.DEACTIVATE, __referenceEvent);
		}
	}
	
	public function getPopupsVector():ArrayList{
		return popups;
	}
	
	private var focusPaintedComponent:Component;
	
	public function moveFocusRectUpperTo(c:Component):Sprite{
		if(focusPaintedComponent != c){
			if(focusPaintedComponent != null){
				removeistenerToFocusPaintedComponent();
			}
			focusPaintedComponent = c;
			addListenerToFocusPaintedComponent();
		}
		
		DepthManager.bringToTop(focusRect);		
		var p:Point =  c.localToGlobal(new Point(0,0));
		focusRect.x = p.x;
		focusRect.y = p.y;
		return focusRect;
	}
	
	private function addListenerToFocusPaintedComponent():Void{
		focusPaintedComponent.addEventListener(MovedEvent.MOVED, __focusPaintedComMoved);
		focusPaintedComponent.addEventListener(ResizedEvent.RESIZED, __focusPaintedComResized);
		focusPaintedComponent.addEventListener(Event.REMOVED_FROM_STAGE, __focusPaintedComRemoved);
	}
	
	private function removeistenerToFocusPaintedComponent():Void{
		if(focusPaintedComponent != null){
			focusPaintedComponent.removeEventListener(MovedEvent.MOVED, __focusPaintedComMoved);
			focusPaintedComponent.removeEventListener(ResizedEvent.RESIZED, __focusPaintedComResized);
			focusPaintedComponent.removeEventListener(Event.REMOVED_FROM_STAGE, __focusPaintedComRemoved);
			focusPaintedComponent = null;
		}
	}
	
	private function __focusPaintedComRemoved(e:Event):Void{
		focusRect.graphics.clear();
		removeistenerToFocusPaintedComponent();
	}
	
	private function __focusPaintedComMoved(e:MovedEvent):Void{
		if(focusRect.visible)	{
			var dx:Int= e.getNewLocation().x - e.getOldLocation().x;
			var dy:Int= e.getNewLocation().y - e.getOldLocation().y;
			focusRect.x += dx;
			focusRect.y += dy;
		}
	}
	private function __focusPaintedComResized(e:ResizedEvent):Void{
		if(focusRect.visible)	{
			focusPaintedComponent.paintFocusRect(true);
		}
	}
	 
	/**
	 * Un-init this focus manager.
	 */
	public function uninit():Void{
		if (stage != null) {
			 
			stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, __onKeyFocusChange, false);
			stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, __onMouseFocusChange, false);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown, false);
			stage.removeEventListener(KeyboardEvent.KEY_UP, __onKeyUp, false);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown, false);
			stage = null;
			focusOwner = null;
			activeWindow = null;
			defaultPolicy = null;
			focusPaintedComponent = null;
			if(focusRect.parent!=null)	{
				focusRect.parent.removeChild(focusRect);
			}
			focusRect = null;
			inited = false;
			oldFocusOwner = null;
			traversing = false;
			
		}
	}
	
	private function __onMouseDown(e:MouseEvent):Void{
		setTraversing(false);
	}
	
	private function __onMouseFocusChange(e:FocusEvent):Void{
		//prevent default focus change if the related object is not tabEnabled
		if(focusOwner != null){
			var tar:InteractiveObject = AsWingUtils.as(e.relatedObject, InteractiveObject)	;
			var is_tar:Bool=false;
			if (Std.is(tar, Component))
			{
				var tc:Component = AsWingUtils.as(tar, Component);
				is_tar = !tc.isFocusable();
			}
			#if(flash9)	
				if(AsWingManager.isPreventNullFocus() 
					&& (tar == null || !(Std.is(tar,TextField)|| tar.tabEnabled))
					||is_tar){
					e.preventDefault();
				}
			#end
		}
	}
	
	private function __onKeyFocusChange(e:FocusEvent):Void{
		if(!isTraversalEnabled()){
			return;
		}
		if (focusOwner != null) {
			#if (flash9)
				e.preventDefault();
			#end	
			
		}
		if(Std.int(e.keyCode) != AWKeyboard.TAB){
			return;
		}
		setTraversing(true);
		if(e.shiftKey)	{
			focusPrevious();
		}else{
			focusNext();
		}
	}
	
	private function __onKeyDown(e:KeyboardEvent):Void{
		if(focusOwner != null){
			focusOwner.fireFocusKeyDownEvent(e);
		}
	}
	
	private function __onKeyUp(e:KeyboardEvent):Void{
		if(focusOwner != null){
			focusOwner.fireFocusKeyUpEvent(e);
		}
	}
	
	/**
	 * Returns if the focus is traversing by keys.
	 * <p>
	 * Once when focus traversed by FocusTraversalKeys this is turned on, 
	 * true will be returned. Once when Mouse is down, this will be turned off, 
	 * false will be returned.
	 * @return true if the focus is traversing by FocusTraversalKeys, otherwise returns false.
	 * @see #getDefaultFocusTraversalKeys()
	 * @see Component#getFocusTraversalKeys()
	 */
	public function isTraversing():Bool{
		return traversing;
	}
	
	/**
	 * Sets if the focus is traversing by keys.
	 * <p>
	 * By default, the traversing property will only be set true when TRAVERSAL_KEYS down.
	 * If your component need view focus rect, you should set it to true when your component's 
	 * managed key down. 
	 * @param b true tag traversing to be true, false tag traversing to be false
	 * @see #isTraversing()
	 */
	public function setTraversing(b:Bool):Void{
		traversing = b;
		focusRect.visible = b;
		if(b!=true){
			focusRect.graphics.clear();
			removeistenerToFocusPaintedComponent();
		}
	}
		
	/**
	 * The default to disables or enables the traversal by keys pressing.
	 * @see #setTraversalEnabled()
	 * @see #setTraversalAsDefault()
	 */
	public static function setDefaultTraversalEnabled(b:Bool):Void{
		defaultTraversalEnabled = b;
	}
	
	/**
	 * Returns the default value for <code>defaultTraversalEnabled</code>.
	 * @see #setTraversalEnabled()
	 * @see #setTraversalAsDefault()
	 */
	public static function isDefaultTraversalEnabled():Bool{
		return defaultTraversalEnabled;
	}
	
	/**
	 * Disables or enables the traversal by keys pressing.
	 * This will call <code>setTraversalAsDefault(false)</code>
	 * <p>
	 * If this method called, TAB... keys will or not effect the focus traverse with this focus system. 
	 * </p>
	 * <p>
	 * And component will or not fire any Key events when there are focused and key pressed.
	 * </p>
	 * @see #setTraversalAsDefault()
	 * @see #setDefaultTraversalEnabled()
	 */
	public function setTraversalEnabled(b:Bool):Void{
		traversalEnabled = b;
		setTraversalAsDefault(false);
	}
	
	/**
	 * Returns traversal by keys pressing is enabled or not. 
	 * If <code>isTraversalAsDefault()</code> returns true, this will returns <code>isDefaultTraversalEnabled</code>
	 * <p>
	 * If this method called, TAB... keys will or not effect the focus traverse with this focus system. 
	 * </p>
	 * <p>
	 * And component will or not fire any Key events when there are focused and key pressed.
	 * </p>
	 * @see #isTraversalAsDefault()
	 * @see #setDefaultTraversalEnabled()
	 */
	public function isTraversalEnabled():Bool{
		return traversalEnabled;
	}
	
	/**
	 * Sets whether or not to use default value for traversal enabled.
	 * @see #isTraversalEnabled()
	 * @see #setDefaultTraversalEnabled()
	 */
	public function setTraversalAsDefault(b:Bool):Void{
		traversalDefault = b;
	}
	
	/**
	 * Returns whether or not to use default value for traversal enabled.
	 * @see #isTraversalEnabled()
	 * @see #setDefaultTraversalEnabled()
	 */
	public function isTraversalAsDefault():Bool{
		return traversalDefault;
	}
	
	/**
     * Returns the previous focused component.
     *
     * @return the previous focused component.
     */
	public function getPreviousFocusedComponent():Component{
		return oldFocusOwner;
	}

	/**
     * Returns the focus owner.
     *
     * @return the focus owner.
     * @see #setFocusOwner()
     */
	public function getFocusOwner():Component{
		return focusOwner;
	}
	
	/**
     * Sets the focus owner. The operation will be cancelled if the Component
     * is not focusable.
     * <p>
     * This method does not actually set the focus to the specified Component.
     * It merely stores the value to be subsequently returned by
     * <code>getFocusOwner()</code>. Use <code>Component.requestFocus()</code>
     * or <code>Component.requestFocusInWindow()</code> to change the focus
     * owner.
     *
     * @param focusOwner the focus owner
     * @see #getFocusOwner()
     * @see Component#requestFocus()
     * @see Component#isFocusable()
	 */
	public function setFocusOwner(newFocusOwner:Component):Void{
		if(focusOwner != newFocusOwner){
			oldFocusOwner = focusOwner;
			focusOwner = newFocusOwner;
		}
	}
	
	/**
     * Returns the active Window.
     * The active Window is always either the focused Window, or the first
     * Window that is an owner of the focused Window.
     *
     * @return the active Window
     * @see #setActiveWindow()
	 */
	public function getActiveWindow():JWindow{
		return activeWindow;
	}
	
	/**
     * Sets the active Window. The active Window is always either the 
     * focused Window, or the first Window that is an owner of the focused Window.
     * <p>
     * This method does not actually change the active Window . 
     * It merely stores the value to be
     * subsequently returned by <code>getActiveWindow()</code>. Use
     * <code>Component.requestFocus()</code> or
     * <code>Component.requestFocusInWindow()</code> or
     * <code>JWindow.setActive()</code>to change the active
     * Window.
     *
     * @param activeWindow the active Window
     * @see #getActiveWindow()
     * @see Component#requestFocus()
     * @see Component#requestFocusInWindow()
     * @see JWindow#setActive()
	 */
	public function setActiveWindow(newActiveWindow:JWindow):Void{
		activeWindow = newActiveWindow;
	}	
	
    /**
     * Focuses the Component after aComponent, typically based on a
     * FocusTraversalPolicy.
     *
     * @param aComponent the Component that is the basis for the focus
     *        traversal operation
     * @see FocusTraversalPolicy
     */
	public function focusNextOfComponent(aComponent:Component):Void{
        if (aComponent != null) {
            aComponent.transferFocus();
        }
	}
	
    /**
     * Focuses the Component before aComponent, typically based on a
     * FocusTraversalPolicy.
     *
     * @param aComponent the Component that is the basis for the focus
     *        traversal operation
     * @see FocusTraversalPolicy
     */	
	public function focusPreviousOfComponent(aComponent:Component):Void{ 
        if (aComponent != null) {
            aComponent.transferFocusBackward();
        }
	}

    /**
     * Focuses the Component after the current focus owner.
     * @see #focusNextOfComponent()
     */	
	public function focusNext():Void{
		focusNextOfComponent(getFocusOwner());
	}
    /**
     * Focuses the Component before the current focus owner.
     * @see #focusPreviousOfComponent()
     */	
	public function focusPrevious():Void{
		focusPreviousOfComponent(getFocusOwner());
	}
	
	/**
     * Returns the default FocusTraversalPolicy. Top-level components 
     * use this value on their creation to initialize their own focus traversal
     * policy by explicit call to Container.setFocusTraversalPolicy.
     *
     * @return the default FocusTraversalPolicy. null will never be returned.
     * @see #setDefaultFocusTraversalPolicy()
     * @see Container#setFocusTraversalPolicy()
     * @see Container#getFocusTraversalPolicy()
     */
	public function getDefaultFocusTraversalPolicy():FocusTraversalPolicy{
		return defaultPolicy;
	}

    /**
     * Sets the default FocusTraversalPolicy. Top-level components 
     * use this value on their creation to initialize their own focus traversal
     * policy by explicit call to Container.setFocusTraversalPolicy.
     * Note: this call doesn't affect already created components as they have 
     * their policy initialized. Only new components will use this policy as
     * their default policy.
     *
     * @param defaultPolicy the new, default FocusTraversalPolicy, if it is null, nothing will be done
     * @see #getDefaultFocusTraversalPolicy()
     * @see Container#setFocusTraversalPolicy()
     * @see Container#getFocusTraversalPolicy()
     */	
	public function setDefaultFocusTraversalPolicy(newDefaultPolicy:FocusTraversalPolicy):Void{
		if (newDefaultPolicy != null){
			defaultPolicy = newDefaultPolicy;
		}
	}
}
