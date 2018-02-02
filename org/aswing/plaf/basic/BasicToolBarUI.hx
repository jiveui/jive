/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import org.aswing.graphics.Graphics2D;
import org.aswing.GroundDecorator;
import org.aswing.geom.IntRectangle;
import org.aswing.Component;
import flash.display.DisplayObject;
import org.aswing.AbstractButton;
import org.aswing.plaf.UIResource;

import org.aswing.plaf.BaseComponentUI;
import org.aswing.Container;
	import org.aswing.Component;
	import org.aswing.AbstractButton;
	import org.aswing.GroundDecorator;
	import org.aswing.event.PropertyChangeEvent;
	import org.aswing.event.ContainerEvent;
	/**
 * ToolBar basic ui imp.
 * @author paling
 * @private
 */
class BasicToolBarUI extends BaseComponentUI{
	
	private var bar:Container;
	
	public function new(){
		super();
	}
	
    private function getPropertyPrefix():String{
        return "ToolBar.";
    }
    
	override public function installUI(c:Component):Void{
		bar = AsWingUtils.as(c,Container);
		installDefaults();
		installComponents();
		installListeners();
	}
    
	override public function uninstallUI(c:Component):Void{
		bar = AsWingUtils.as(c,Container);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
 	}
 	
 	private function installDefaults():Void{
        var pp:String= getPropertyPrefix();
        
        LookAndFeel.installColorsAndFont(bar, pp);
        LookAndFeel.installBorderAndBFDecorators(bar, pp);
        LookAndFeel.installBasicProperties(bar, pp);
 	}
	
 	private function uninstallDefaults():Void{
 		LookAndFeel.uninstallBorderAndBFDecorators(bar);
 	}
 	
 	private function installComponents():Void{
 		for(i in 0...bar.getComponentCount()){
 			adaptChild(bar.getComponent(i));
 		}
 	}
	
 	private function uninstallComponents():Void{
 		for(i in 0...bar.getComponentCount()){
 			unadaptChild(bar.getComponent(i));
 		}
 	}
 	
 	private function installListeners():Void{
 		bar.addEventListener(ContainerEvent.COM_ADDED, __onComAdded);
 		bar.addEventListener(ContainerEvent.COM_REMOVED, __onComRemoved);
 	}
	
 	private function uninstallListeners():Void{
 		bar.removeEventListener(ContainerEvent.COM_ADDED, __onComAdded);
 		bar.removeEventListener(ContainerEvent.COM_REMOVED, __onComRemoved);
 	}
 	
 	private function adaptChild(c:Component):Void{
    	var btn:AbstractButton = AsWingUtils.as(c,AbstractButton)	;
    	if(btn != null){
    		var bg:GroundDecorator = btn.getBackgroundDecorator();
    		if(bg != null){
    			var bgAdapter:ToolBarButtonBgAdapter = new ToolBarButtonBgAdapter(bg);
    			btn.setBackgroundDecorator(bgAdapter);
    		}
    		btn.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, __propertyChanged);
    	}
 	}
 	
 	private function unadaptChild(c:Component):Void{
    	var btn:AbstractButton = AsWingUtils.as(c,AbstractButton)	;
    	if(btn != null){
    		btn.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, __propertyChanged);
    		var bg:ToolBarButtonBgAdapter = AsWingUtils.as(btn.getBackgroundDecorator() , ToolBarButtonBgAdapter);
    		if(bg != null){
    			btn.setBackgroundDecorator(bg.getOriginalBg());
    		}
    	}
 	}
    
    //------------------------------------------------
 	
 	private function __propertyChanged(e:PropertyChangeEvent):Void{
 		if(e.getPropertyName() == "backgroundDecorator"){
 			var btn:AbstractButton = AsWingUtils.as(e.target,AbstractButton)	;
 			//var oldG:GroundDecorator = e.getOldValue();
 			var newG:GroundDecorator = e.getNewValue();
 			if(!(Std.is(newG,ToolBarButtonBgAdapter))){
    			var bgAdapter:ToolBarButtonBgAdapter = new ToolBarButtonBgAdapter(newG);
    			btn.setBackgroundDecorator(bgAdapter);
 			}
 		}
 	}
 	
    private function __onComAdded(e:ContainerEvent):Void{
    	adaptChild(e.getChild());
    }
    
    private function __onComRemoved(e:ContainerEvent):Void{
    	unadaptChild(e.getChild());
    }
}
 

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//                 BG Decorator Adapter
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/**
 * This background adapter will invisible the original background, and visible it 
 * only when button be rollover.
 * @author paling
 */
class ToolBarButtonBgAdapter implements GroundDecorator implements UIResource{
	
	private var originalBg:GroundDecorator;
	
	public function new(originalBg:GroundDecorator){
		this.originalBg = originalBg;
	}
	
	public function getOriginalBg():GroundDecorator{
		return originalBg;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
		if(originalBg == null){
			return;
		}
		var btn:AbstractButton = AsWingUtils.as(c,AbstractButton)	;
		var needPaint:Bool= false;
		if(btn == null || btn.getModel().isArmed() || btn.isSelected() 
			|| (btn.getModel().isRollOver() && !btn.getModel().isPressed())){
			needPaint = true;
		}
		
		var dis:DisplayObject = getDisplay(c);
		if(dis != null) dis.visible = needPaint;
		if(needPaint)	{
			originalBg.updateDecorator(c, g, bounds);
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		if(originalBg == null){
			return null;
		}
		return originalBg.getDisplay(c);
	}
}