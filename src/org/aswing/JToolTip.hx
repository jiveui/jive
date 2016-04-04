/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point; 
	import flash.Lib;

import org.aswing.event.ToolTipEvent;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.plaf.basic.BasicToolTipUI;
import org.aswing.util.Timer;

/**
 * Used to display a "Tip" for a Component. Typically components provide api
 * to automate the process of using `ToolTip`s.
 * For example, any AsWing component can use the `Component`
 * `toolTipText` method to specify the text
 * for a standard tooltip. A component that wants to create a custom
 * `ToolTip`
 * display can create an owner `ToolTip` and apply it to a component by 
 * `JToolTip.setComponent` method.
 *
 * @see JSharedToolTip
 *
 * Author paling
 */
@:event("org.aswing.event.ToolTipEvent.TIP_TEXT_CHANGED", "Dispatched when the tip text changed")
@:event("org.aswing.event.ToolTipEvent.STATE_CHANGED", "Dispatched when the tip is showing(before showed), with this method you can change the tip text, then the showing text will be the new text")
class JToolTip extends Container{
		
	//the time waiting after to view tool tip when roll over a component
	private static var WAIT_TIME:Int= 600;
	//when there is one tooltip is just shown, next will shown fast as this time
	private static var FAST_OCCUR_TIME:Int= 50;
	
	private static var last_tip_dropped_time:Int= 0;

	/**
	 * The default container to hold tool tips.
	 * By default(if you have not set one), it is the `AsWingManager.getRoot()` .
	 */
	public static var defaultRoot(get, set): DisplayObjectContainer;
	private static var _defaultRoot: DisplayObjectContainer;
	private static function get_defaultRoot(): DisplayObjectContainer { return getDefaultToolTipContainerRoot(); }
	private static function set_defaultRoot(v: DisplayObjectContainer): DisplayObjectContainer { setDefaultToolTipContainerRoot(v); return v; }

	/**
	 * The container to hold this tool tip.
	 * By default(if you have not set one), it is the `getDefaultToolTipContainerRoot()`.
	 */
	public var containerRoot(get, set): DisplayObjectContainer;
	private var _containerRoot: DisplayObjectContainer;
	private function get_containerRoot(): DisplayObjectContainer { return getToolTipContainerRoot(); }
	private function set_containerRoot(v: DisplayObjectContainer): DisplayObjectContainer { setToolTipContainerRoot(v); return v; }

	/**
	 * The text to show when the tool tip is displayed.
	 * null to set this tooltip will not be displayed.
	 */
	public var text(get, set): String;
	private var _text: String;
	private function get_text(): String { return getTipText(); }
	private function set_text(v: String): String { setTipText(v); return v; }

	/**
	 * Specifies the component that the tooltip describes.
	 * The component may be null and will have no effect.
	 */
	public var targetComponent(get, set): Component;
	private var _targetComponent: Component;
	private function get_targetComponent(): Component { return getTargetComponent(); }
	private function set_targetComponent(v: Component): Component { setTargetComponent(v); return v; }

	/**
	 * The offsets of the tooltip related the described component.
	 * The offsets point: delta x is o.x, delta y is o.y
	 */
	public var offsets(get, set): IntPoint;
	private var _offsets: IntPoint;
	private function get_offsets(): IntPoint { return getOffsets(); }
	private function set_offsets(v: IntPoint): IntPoint { setOffsets(v); return v; }

	/**
	 * Whether the `offsets` is related the mouse position, otherwise
	 * it will be related the described component position.
	 *
	 * The change will be taked effect at the next showing, current showing will no be changed.
	 */
	public var offsetsRelatedToMouse(get, set): Bool;
	private var _offsetsRelatedToMouse: Bool;
	private function get_offsetsRelatedToMouse(): Bool { return isOffsetsRelatedToMouse(); }
	private function set_offsetsRelatedToMouse(v: Bool): Bool { setOffsetsRelatedToMouse(v); return v; }
	
	private var timer:Timer;

	/**
	 * Whether the tooltip should wait and then popup automatically when roll over the target component.
	 */
	public var waitThenPopupEnabled(get, set): Bool;
	private var _waitThenPopupEnabled: Bool;
	private function get_waitThenPopupEnabled(): Bool { return isWaitThenPopupEnabled(); }
	private function set_waitThenPopupEnabled(v: Bool): Bool { setWaitThenPopupEnabled(v); return v; }
	
	public function new() {
		super();
		setName("JToolTip");
		_offsets = new IntPoint(4, 20);
		_offsetsRelatedToMouse = true;
		_waitThenPopupEnabled  = true;
						
		timer = new Timer(WAIT_TIME, 0);
		timer.setInitialDelay(WAIT_TIME);
		timer.addActionListener(__timeOnAction);
		
		mouseEnabled = false;
		mouseChildren = false;
		
		updateUI();
	}
		
	/**
	 * Sets the default container to hold tool tips.
	 * By default(if you have not set one), it is the `AsWingManager.getRoot()` .
	 * @param theRoot the default container to hold tool tips.
	 */
	@:dox(hide)
	public static function setDefaultToolTipContainerRoot(theRoot:DisplayObjectContainer):Void{
		if(theRoot != _defaultRoot){
			_defaultRoot = theRoot;
		}
	}
	
	@:dox(hide)
	private static function getDefaultToolTipContainerRoot():DisplayObjectContainer{
		if(_defaultRoot == null){
			return AsWingManager.getRoot();
		}
		return _defaultRoot;
	}
	
	/**
	 * Sets the container to hold this tool tip.
	 * By default(if you have not set one), it is the `getDefaultToolTipContainerRoot()`.
	 * @param theRoot the container to hold this tool tip.
	 */
	@:dox(hide)
	public function setToolTipContainerRoot(theRoot:DisplayObjectContainer):Void{
		if(theRoot != _containerRoot){
			_containerRoot = theRoot;
		}
	}

	@:dox(hide)
	private function getToolTipContainerRoot():DisplayObjectContainer{
		if(_containerRoot == null){
			var cr:DisplayObjectContainer=null;
			if (getTargetComponent() != null) {
			//cr = getTargetComponent().root as DisplayObjectContainer;	
				cr =  AsWingUtils.as(AsWingManager.getStage(),DisplayObjectContainer)	;
			}
			if(cr == null){
				cr = getDefaultToolTipContainerRoot();
			}
			return cr;
		}
		return _containerRoot;
	}
	
	@:dox(hide)
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}

	@:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicToolTipUI;
    }

	@:dox(hide)
	override public function getUIClassID():String{
		return "ToolTipUI";
	}
	
	/**
	 * Starts waits to popup, if mouse are not moved for a while, the tool tip will be popuped.
	 */
	public function startWaitToPopup():Void{
		if(  Lib.getTimer() - last_tip_dropped_time < FAST_OCCUR_TIME){
			timer.setInitialDelay(FAST_OCCUR_TIME);
		}else{
			timer.setInitialDelay(WAIT_TIME);
		}
		timer.restart();
		if(getTargetComponent()!=null){
			getTargetComponent().addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMoved, false, 0, false);
		}
	}
	
	/**
	 * Stops waiting.
	 */
	public function stopWaitToPopup():Void{
		timer.stop();
		if(getTargetComponent()!=null){
			getTargetComponent().removeEventListener(MouseEvent.MOUSE_MOVE, __onMouseMoved);
		}
 
		last_tip_dropped_time =   Lib.getTimer();
	}
	
	/**
	 * Sets whether the tooltip should wait and then popup automatically when roll over the target component.
	 */
	@:dox(hide)
	public function setWaitThenPopupEnabled(b:Bool):Void{
		_waitThenPopupEnabled = b;
	}
	
	/**
	 * Returns whether the tooltip should wait and then popup automatically when roll over the target component.
	 */
	@:dox(hide)
	public function isWaitThenPopupEnabled():Bool{
		return _waitThenPopupEnabled;
	}
		
	private function __compRollOver(source:Component):Void{
		if(source == _targetComponent && isWaitThenPopupEnabled()){
			startWaitToPopup();
		}
	}
	
	private function __compRollOut(source:Component):Void{
		if(source == _targetComponent && isWaitThenPopupEnabled()){
			disposeToolTip();
		}
	}
		
	private function __onMouseMoved(e:Event):Void{
		if(timer.isRunning()){
			timer.restart();
		}
	}
	
	private function __timeOnAction(e:Event):Void{
		timer.stop();
		dispatchEvent(new ToolTipEvent(ToolTipEvent.TIP_SHOWING));
		disposeToolTip();
		viewToolTip();
	}
	
	/**
	 * view the tool tip on stage
	 */
	private function viewToolTip():Void{
		if(_text == null){
			return;
		}
		var containerPane:DisplayObjectContainer = getToolTipContainerRoot();
		if(containerPane == null){
			trace("getToolTipContainerRoot null");
			return;
		}
		containerPane.addChild(this);
		
		var relatePoint:IntPoint = new IntPoint();
		if(_offsetsRelatedToMouse)	{
			var gp:Point = containerPane.localToGlobal(new Point(containerPane.mouseX, containerPane.mouseY));
			relatePoint.setWithPoint(gp);
		}else{
			if (getTargetComponent() != null)
			{
				relatePoint.setWithPoint(getTargetComponent().localToGlobal(new Point(0, 0)));
			}
		}
		moveLocationRelatedTo(relatePoint);
	}
	
	/**
	 * Moves tool tip to new location related to the specified pos(global).
	 */
	public function moveLocationRelatedTo(globalPos:IntPoint):Void{
		if(!isShowing()){
			//not created, so can't move
			return;
		}
		globalPos = globalPos.clone();
		globalPos.move(_offsets.x, _offsets.y);
		var viewSize:IntDimension = getPreferredSize();
		var visibleBounds:IntRectangle = AsWingUtils.getVisibleMaximizedBounds(parent);
		
		if(globalPos.x + viewSize.width > visibleBounds.x + visibleBounds.width){
			globalPos.x = visibleBounds.x + visibleBounds.width - viewSize.width;
		}
		if(globalPos.y + viewSize.height > visibleBounds.y + visibleBounds.height){
			globalPos.y = visibleBounds.y + visibleBounds.height - viewSize.height;
		}
		if(globalPos.x < visibleBounds.x){
			globalPos.x = visibleBounds.x;
		}
		if(globalPos.y < visibleBounds.y){
			globalPos.y = visibleBounds.y;
		}
		setGlobalLocation(globalPos);
		setSize(viewSize);
		revalidate();
	}
	
	/**
	 * Shows tooltip directly.
	 */
	public function showToolTip():Void{
		viewToolTip();
	}
	
	/**
	 * Disposes the tool tip.
	 */
	public function disposeToolTip():Void{
		stopWaitToPopup();
		removeFromContainer();
	}
		
	/**
	 * Sets the text to show when the tool tip is displayed. 
	 * null to set this tooltip will not be displayed.
	 * @param t the String to display, or null not display tool tip.
	 */
	@:dox(hide)
	public function setTipText(t:String):Void{
		if(t != _text){
			_text = t;
			dispatchEvent(new ToolTipEvent(ToolTipEvent.TIP_TEXT_CHANGED));
			if(t == null){
				disposeToolTip();
			}else{
				if(isShowing()){
					setSize(getPreferredSize());
					repaint();
					revalidate();
				}
			}
		}
	}
	
	/**
	 * Returns the text that is shown when the tool tip is displayed. 
	 * The returned value may be null. 
	 * @return the string that displayed.
	 */
	@:dox(hide)
	public function getTipText():String{
		return _text;
	}
	
	/**
	 * Specifies the component that the tooltip describes. 
	 * The component c may be null and will have no effect. 
	 * @param the JComponent being described
	 */
	@:dox(hide)
	public function setTargetComponent(c:Component):Void{
		if(c != _targetComponent){
			if(_targetComponent != null){
				unlistenOwner(_targetComponent);
			}
			_targetComponent = c;
			if(_targetComponent != null){
				listenOwner(_targetComponent);
			}
		}
	}
	
	/**
	 * Returns the component the tooltip applies to. 
	 * The returned value may be null. 
	 * @return the component that the tooltip describes
	 */
	@:dox(hide)
	public function getTargetComponent():Component{
		return _targetComponent;
	}
	
	/**
	 * Sets the offsets of the tooltip related the described component.
	 * @param o the offsets point, delta x is o.x, delta y is o.y
	 */
	@:dox(hide)
	public function setOffsets(o:IntPoint):Void{
		_offsets.setLocation(o);
	}
	
	/**
	 * Returns the offsets of the tooltip related the described component.
	 * @return the offsets point, delta x is o.x, delta y is o.y
	 */
	@:dox(hide)
	public function getOffsets():IntPoint{
		return _offsets.clone();
	}
	
	/**
	 * Sets whether the `offsets` is related the mouse position, otherwise 
	 * it will be related the described component position.
	 * <p>
	 * This change will be taked effect at the next showing, current showing will no be changed.
	 * @param b whether the `offsets` is related the mouse position
	 */
	@:dox(hide)
	public function setOffsetsRelatedToMouse(b:Bool):Void{
		_offsetsRelatedToMouse = b;
	}
	
	/**
	 * Returns whether the `offsets` is related the mouse position.
	 * @return whether the `offsets` is related the mouse position
	 * See #setOffsetsRelatedToMouse()
	 */
	@:dox(hide)
	public function isOffsetsRelatedToMouse():Bool{
		return _offsetsRelatedToMouse;
	}
	
	private function listenOwner(comp:InteractiveObject, useWeakReference:Bool= false):Void{
		comp.addEventListener(MouseEvent.ROLL_OVER, ____compRollOver, false, 0, useWeakReference);
		comp.addEventListener(MouseEvent.ROLL_OUT, ____compRollOut, false, 0, useWeakReference);
		comp.addEventListener(MouseEvent.MOUSE_DOWN, ____compRollOut, false, 0, useWeakReference);
	}
	private function unlistenOwner(comp:InteractiveObject):Void{
		comp.removeEventListener(MouseEvent.ROLL_OVER, ____compRollOver);
		comp.removeEventListener(MouseEvent.ROLL_OUT, ____compRollOut);
		comp.removeEventListener(MouseEvent.MOUSE_DOWN, ____compRollOut);
		//maybe showing, so this event need to remove
		comp.removeEventListener(MouseEvent.MOUSE_MOVE, __onMouseMoved);
	}
	
	
	//-----------can't override these------
	private function ____compRollOver(e:Event):Void{
		var source:Component = AsWingUtils.as(e.currentTarget,Component)	;
		__compRollOver(source);
	}
	
	private function ____compRollOut(e:Event):Void{
		var source:Component = AsWingUtils.as(e.currentTarget,Component)	;
		__compRollOut(source);
	}
}