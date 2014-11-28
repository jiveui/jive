/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

	
import org.aswing.Icon;
	import org.aswing.AbstractButton;
	import org.aswing.Component;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	/**
 * Basic RadioButton implementation.
 * @author paling
 * @private
 */	
class BasicRadioButtonUI extends BasicToggleButtonUI{
	
	private var defaultIcon:Icon;
	
	public function new(){
		super();
	}
	
	override private function installDefaults(b:AbstractButton):Void{
		super.installDefaults(b);
		defaultIcon = getIcon(getPropertyPrefix() + "icon");
	}
	
	override private function uninstallDefaults(b:AbstractButton):Void{
		super.uninstallDefaults(b);
		if(defaultIcon.getDisplay(b)!=null){
    		if(button.contains(defaultIcon.getDisplay(b))){
    			button.removeChild(defaultIcon.getDisplay(b));
    		}
		}
	}
	
    override private function getPropertyPrefix():String{
        return "RadioButton.";
    }
    	
    public function getDefaultIcon():Icon {
        return defaultIcon;
    }
    
    override private function getIconToLayout():Icon{
    	if(button.getIcon() == null){
    		if(defaultIcon.getDisplay(button)!=null){
	    		if(!button.contains(defaultIcon.getDisplay(button))){
	    			button.addChild(defaultIcon.getDisplay(button));
	    		}
    		}
    		return defaultIcon;
    	}else{
    		return button.getIcon();
    	}
    }
    
	override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(c.isOpaque()){
			g.fillRectangle(new SolidBrush(c.getBackground()), b.x, b.y, b.width, b.height);
		}
	}
}