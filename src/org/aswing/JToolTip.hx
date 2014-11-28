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
 * Dispatched when the tip text changed.
 * @eventType org.aswing.event.ToolTipEvent.TIP_TEXT_CHANGED
 */
// [Event(name="tipTextChanged", type="org.aswing.event.ToolTipEvent")]

/**
 * Dispatched when the tip is showing(before showed), with this method you 
 * can change the tip text, then the showing text will be the new text.
 * @eventType org.aswing.event.ToolTipEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.ToolTipEvent")]

/**
 * Used to display a "Tip" for a Component. Typically components provide api
 * to automate the process of using <code>ToolTip</code>s.
 * For example, any AsWing component can use the <code>Component</code>
 * <code>setToolTipText</code> method to specify the text
 * for a standard tooltip. A component that wants to create a custom
 * <code>ToolTip</code>
 * display can create an owner <code>ToolTip</code> and apply it to a component by 
 * <code>JToolTip.setComponent</code> method.
 * @see org.aswing.JSharedToolTip
 * @author paling
 */
class JToolTip extends Container{
		
	//the time waiting after to view tool tip when roll over a component
	private static var WAIT_TIME:Int= 600;
	//when there is one tooltip is just shown, next will shown fast as this time
	private static var FAST_OCCUR_TIME:Int= 50;
	
	private static var last_tip_dropped_time:Int= 0;
	
	private static var defaultRoot:DisplayObjectContainer = null;
	
	private var containerRoot:DisplayObjectContainer;
	
	private var tipText:String;
	private var comp:Component;
	private var offsets:IntPoint;
	private var offsetsRelatedToMouse:Bool;
	
	private var timer:Timer;
	private var waitThenPopupEnabled:Bool;
	
	public function new() {
		super();
		setName("JToolTip");
		offsets = new IntPoint(4, 20);
		offsetsRelatedToMouse = true;
		waitThenPopupEnabled  = true;
						
		timer = new Timer(WAIT_TIME, 0);
		timer.setInitialDelay(WAIT_TIME);
		timer.addActionListener(__timeOnAction);
		
		mouseEnabled = false;
		mouseChildren = false;
		
		updateUI();
	}
		
	/**
	 * Sets the default container to hold tool tips.
	 * By default(if you have not set one), it is the <code>AsWingManager.getRoot()</code> .
	 * @param theRoot the default container to hold tool tips.
	 */
	public static function setDefaultToolTipContainerRoot(theRoot:DisplayObjectContainer):Void{
		if(theRoot != defaultRoot){
			defaultRoot = theRoot;
		}
	}
	
	private static function getDefaultToolTipContainerRoot():DisplayObjectContainer{
		if(defaultRoot == null){
			return AsWingManager.getRoot();
		}
		return defaultRoot;
	}
	
	/**
	 * Sets the container to hold this tool tip.
	 * By default(if you have not set one), it is the <code>getDefaultToolTipContainerRoot()</code>.
	 * @param theRoot the container to hold this tool tip.
	 */	
	public function setToolTipContainerRoot(theRoot:DisplayObjectContainer):Void{
		if(theRoot != containerRoot){
			containerRoot = theRoot;
		}
	}
	
	private function getToolTipContainerRoot():DisplayObjectContainer{
		if(containerRoot == null){
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
		return containerRoot;
	}
	
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicToolTipUI;
    }
	
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
	public function setWaitThenPopupEnabled(b:Bool):Void{
		waitThenPopupEnabled = b;
	}
	
	/**
	 * Returns whether the tooltip should wait and then popup automatically when roll over the target component.
	 */
	public function isWaitThenPopupEnabled():Bool{
		return waitThenPopupEnabled;
	}
		
	private function __compRollOver(source:Component):Void{
		if(source == comp && isWaitThenPopupEnabled()){
			startWaitToPopup();
		}
	}
	
	private function __compRollOut(source:Component):Void{
		if(source == comp && isWaitThenPopupEnabled()){
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
		if(tipText == null){
			return;
		}
		var containerPane:DisplayObjectContainer = getToolTipContainerRoot();
		if(containerPane == null){
			trace("getToolTipContainerRoot null");
			return;
		}
		containerPane.addChild(this);
		
		var relatePoint:IntPoint = new IntPoint();
		if(offsetsRelatedToMouse)	{
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
		globalPos.move(offsets.x, offsets.y);
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
	public function setTipText(t:String):Void{
		if(t != tipText){
			tipText = t;
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
	public function getTipText():String{
		return tipText;
	}
	
	/**
	 * Specifies the component that the tooltip describes. 
	 * The component c may be null and will have no effect. 
	 * @param the JComponent being described
	 */
	public function setTargetComponent(c:Component):Void{
		if(c != comp){
			if(comp != null){
				unlistenOwner(comp);
			}
			comp = c;
			if(comp != null){
				listenOwner(comp);
			}
		}
	}
	
	/**
	 * Returns the component the tooltip applies to. 
	 * The returned value may be null. 
	 * @return the component that the tooltip describes
	 */
	public function getTargetComponent():Component{
		return comp;
	}
	
	/**
	 * Sets the offsets of the tooltip related the described component.
	 * @param o the offsets point, delta x is o.x, delta y is o.y
	 */
	public function setOffsets(o:IntPoint):Void{
		offsets.setLocation(o);
	}
	
	/**
	 * Returns the offsets of the tooltip related the described component.
	 * @return the offsets point, delta x is o.x, delta y is o.y
	 */	
	public function getOffsets():IntPoint{
		return offsets.clone();
	}
	
	/**
	 * Sets whether the <code>offsets</code> is related the mouse position, otherwise 
	 * it will be related the described component position.
	 * <p>
	 * This change will be taked effect at the next showing, current showing will no be changed.
	 * @param b whether the <code>offsets</code> is related the mouse position
	 */
	public function setOffsetsRelatedToMouse(b:Bool):Void{
		offsetsRelatedToMouse = b;
	}
	
	/**
	 * Returns whether the <code>offsets</code> is related the mouse position.
	 * @return whether the <code>offsets</code> is related the mouse position
	 * @see #setOffsetsRelatedToMouse()
	 */
	public function isOffsetsRelatedToMouse():Bool{
		return offsetsRelatedToMouse;
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