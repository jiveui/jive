/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import org.aswing.JViewport;
	import org.aswing.Component;
	import org.aswing.event.FocusKeyEvent;
	import org.aswing.plaf.BaseComponentUI;
import org.aswing.geom.IntPoint;
import org.aswing.AWKeyboard;
import flash.events.MouseEvent;

/**
 * @private
 */
class BasicViewportUI extends BaseComponentUI{
	
	private var viewport:JViewport;
	
	public function new(){
		super();
	}
	
	override public function installUI(c:Component):Void{
		viewport = AsWingUtils.as(c,JViewport);
		installDefaults();
		installListeners();
	}

	override public function uninstallUI(c:Component):Void{
		viewport = AsWingUtils.as(c,JViewport);
		uninstallDefaults();
		uninstallListeners();
	}

    private function getPropertyPrefix():String{
        return "Viewport.";
    }

	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
		LookAndFeel.installColorsAndFont(viewport, pp);
		LookAndFeel.installBorderAndBFDecorators(viewport, pp);
		LookAndFeel.installBasicProperties(viewport, pp);
	}

	private function uninstallDefaults():Void{
		LookAndFeel.uninstallBorderAndBFDecorators(viewport);
	}
	
	private function installListeners():Void{
		viewport.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
		viewport.addEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
	}
	
	private function uninstallListeners():Void{
		viewport.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
		viewport.removeEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
	}
	
	private function __onMouseWheel(e:MouseEvent):Void{
		if(!(viewport.isEnabled() && viewport.isShowing())){
			return;
		}
    	var viewPos:IntPoint = viewport.getViewPosition();
    	if(e.shiftKey)	{
    		viewPos.x -= e.delta*viewport.getHorizontalUnitIncrement();
    	}else{
    		viewPos.y -= e.delta*viewport.getVerticalUnitIncrement();
    	}
    	viewport.setViewPosition(viewPos);
	}
	
	private function __onKeyDown(e:FocusKeyEvent):Void{
		if(!(viewport.isEnabled() && viewport.isShowing())){
			return;
		}
    	var code:Int= e.keyCode;
    	var viewpos:IntPoint = viewport.getViewPosition();
    	switch(code){
    		case AWKeyboard.UP:
    			viewpos.move(0, -viewport.getVerticalUnitIncrement());
    			
    		case AWKeyboard.DOWN:
    			viewpos.move(0, viewport.getVerticalUnitIncrement());
    			
    		case AWKeyboard.LEFT:
    			viewpos.move(-viewport.getHorizontalUnitIncrement(), 0);
    			
    		case AWKeyboard.RIGHT:
    			viewpos.move(viewport.getHorizontalUnitIncrement(), 0);
    			
    		case AWKeyboard.PAGE_UP:
    			if(e.shiftKey)	{
    				viewpos.move(-viewport.getHorizontalBlockIncrement(), 0);
    			}else{
    				viewpos.move(0, -viewport.getVerticalBlockIncrement());
    			}
    			
    		case AWKeyboard.PAGE_DOWN:
    			if(e.shiftKey)	{
    				viewpos.move(viewport.getHorizontalBlockIncrement(), 0);
    			}else{
    				viewpos.move(0, viewport.getVerticalBlockIncrement());
    			}
    		
    		case AWKeyboard.HOME:
    			viewpos.setLocationXY(0, 0);
    			
    		case AWKeyboard.END:
    			viewpos.setLocationXY(AsWingConstants.MAX_VALUE, AsWingConstants.MAX_VALUE);
    			
    	}
    	viewport.setViewPosition(viewpos);
	}
}