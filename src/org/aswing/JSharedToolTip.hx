/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.display.InteractiveObject;
import flash.errors.Error; 
	
/**
 * Shared instance Tooltip to saving instances.
 * @author paling
 */
class JSharedToolTip extends JToolTip{
	
	private static var sharedInstance:JSharedToolTip;
	
	private var targetedComponent:Component;
	private var textMap:haxe.ds.IntMap<String>;
	
	public function new() {
		super();
		setName("JSharedToolTip");
		textMap = new  haxe.ds.IntMap<String>();
	}
	
	/**
	 * Returns the shared JSharedToolTip instance.
	 * <p>
	 * You can create a your shared tool tip instance too, if you want to 
	 * shared by the default.
	 * </p>
	 * @return a singlton shared instance.
	 */
	public static function getSharedInstance():JSharedToolTip{
		if(sharedInstance == null){
			sharedInstance = new JSharedToolTip();
		}
		return sharedInstance;
	}
	
	/**
	 * Sets the shared JSharedToolTip instance.
	 * <p>
	 * You can only call this before any <code>getSharedInstance()</code> invoke, and 
	 * you can only set it once. This is means, you'd better to call this at the beginning 
	 * of your program.
	 * </p>
	 * @param ins the shared JSharedToolTip instance you want to use.
	 */
	public static function setSharedInstance(ins:JSharedToolTip):Void{
		if(sharedInstance!=null)	{
			throw new Error("sharedInstance is already set!");
		 
		}else{
			sharedInstance = ins;
		}
	}
	
    /**
     * Registers a component for tooltip management.
     *
     * @param c  a <code>InteractiveObject</code> object to add.
     * @param (optional)tipText the text to show when tool tip display. If the c 
     * 		is a <code>Component</code> this param is useless, if the c is only a 
     * 		<code>InteractiveObject</code> this param is required.
     */
	public function registerComponent(c:Component, tipText:String=null):Void{
		//TODO chech whether the week works
		listenOwner(c, true);
		  textMap.set(c.getAwmlIndex(),tipText);
		if(getTargetComponent() == c){
			setTipText(getTargetToolTipText(c));
		}
	}
	

    /**
     * Removes a component from tooltip control.
     *
     * @param component  a <code>InteractiveObject</code> object to remove
     */
	public function unregisterComponent(c:Component):Void {
		if (!textMap.exists(c.getAwmlIndex()))
		{
			return;
		}
		unlistenOwner(c);
		 textMap.remove(c.getAwmlIndex());
		if(getTargetComponent() == c){
			disposeToolTip();
			targetedComponent = null;
		}
	}
	
	/**
	 * Registers a component that the tooltip describes. 
	 * The component c may be null and will have no effect. 
	 * <p>
	 * This method is overrided just to call registerComponent of this class.
	 * @param the InteractiveObject being described
	 * @see #registerComponent()
	 */
	override public function setTargetComponent(c:Component):Void{
		registerComponent(c);
	}
	
	/** 
	 * Returns the lastest targeted component. 
	 * @return the lastest targeted component. 
	 */
	override public function getTargetComponent():Component{
		return targetedComponent;
	}
	
	private function getTargetToolTipText(c:Component):String{
		if(Std.is(c,Component)){
			var co:Component = AsWingUtils.as(c,Component)	;
			return co.getToolTipText();
		}else{
			return   textMap.get(c.getAwmlIndex());
		}
	}
	
	//-------------
	override private function __compRollOver(source:Component):Void{
		var tipText:String= getTargetToolTipText(source);
		if(tipText != null && isWaitThenPopupEnabled()){
			targetedComponent = source;
			setTipText(tipText);
			startWaitToPopup();
		}
	}
	
	override private function __compRollOut(source:Component):Void{
		if(source == targetedComponent && isWaitThenPopupEnabled()){
			disposeToolTip();
			targetedComponent = null;
		}
	}	
}