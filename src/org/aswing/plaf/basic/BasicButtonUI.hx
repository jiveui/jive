/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

	
import flash.text.TextField;
	import flash.text.TextFormat;
	import org.aswing.AWKeyboard;

import org.aswing.AbstractButton;
	import org.aswing.Component;
	import org.aswing.ButtonModel;
	import org.aswing.FocusManager;
	import org.aswing.Insets;
	import org.aswing.Icon;
	import org.aswing.ASFont;
	import org.aswing.ASColor;
	import org.aswing.event.AWEvent;
import org.aswing.event.FocusKeyEvent;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.UIResource;
	import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
	/**
 * Basic Button implementation.
 * @author paling
 * @private
 */
class BasicButtonUI extends BaseComponentUI{
	
	private var button:AbstractButton;
	private var textField:TextField;
	
	public function new(){
		super();
	}

    private function getPropertyPrefix():String{
        return "Button.";
    }
    
	override public function installUI(c:Component):Void{
		button = AsWingUtils.as(c,AbstractButton);
		installDefaults(button);
		installComponents(button);
		installListeners(button);
	}
    
	override public function uninstallUI(c:Component):Void{
		button = AsWingUtils.as(c,AbstractButton);
		uninstallDefaults(button);
		uninstallComponents(button);
		uninstallListeners(button);
 	}
 	
 	private function installDefaults(b:AbstractButton):Void{
        // load shared instance defaults
        var pp:String= getPropertyPrefix();
        if(!b.isShiftOffsetSet()){
        	b.setShiftOffset(getInt(pp + "textShiftOffset"));
        	b.setShiftOffsetSet(false);
        }
        
        if(Std.is(b.getMargin() , UIResource)) {
            b.setMargin(getInsets(pp + "margin"));
        }
        
        LookAndFeel.installColorsAndFont(b, pp);
        LookAndFeel.installBorderAndBFDecorators(b, pp);
        LookAndFeel.installBasicProperties(b, pp);
        button.mouseChildren = false;
        if(Std.is(b.getTextFilters() , UIResource)){
        	b.setTextFilters(getInstance(pp + "textFilters"));
        }
 	}
	
    override public function refreshStyleProperties():Void{
    	installDefaults(button);
    	button.repaint();
    	button.revalidate();
    }	
	
 	private function uninstallDefaults(b:AbstractButton):Void{
 		LookAndFeel.uninstallBorderAndBFDecorators(b);
 	}
 	
 	private function installComponents(b:AbstractButton):Void{
 		textField = AsWingUtils.createLabel(b, "label");
 		b.setFontValidated(false);
 	}
	
 	private function uninstallComponents(b:AbstractButton):Void{
 		b.removeChild(textField);
 	}
 	
 	private function installListeners(b:AbstractButton):Void{
 		b.addStateListener(__stateListener);
 		b.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
 		b.addEventListener(FocusKeyEvent.FOCUS_KEY_UP, __onKeyUp);
 	}
	
 	private function uninstallListeners(b:AbstractButton):Void{
 		b.removeStateListener(__stateListener);
 		b.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
 		b.removeEventListener(FocusKeyEvent.FOCUS_KEY_UP, __onKeyUp);
 	}
 	
 	//-----------------------------------------------------
 	        
    private function getTextShiftOffset():Int{
    	return button.getShiftOffset();
    }
    
    //--------------------------------------------------------
    
    private function __stateListener(e:AWEvent):Void{
    	button.repaint();
    }
    
    private function __onKeyDown(e:FocusKeyEvent):Void{
		if(!(button.isShowing() && button.isEnabled())){
			return;
		}
		var model:ButtonModel = button.getModel();
		if(Std.int(e.keyCode) == AWKeyboard.SPACE && !(model.isRollOver() && model.isPressed())){
	    	setTraversingTrue();
			model.setRollOver(true);
			model.setArmed(true);
			model.setPressed(true);
		}
    }
    
    private function __onKeyUp(e:FocusKeyEvent):Void{
		if(!(button.isShowing() && button.isEnabled())){
			return;
		}
		if(Std.int(e.keyCode) == AWKeyboard.SPACE){
			var model:ButtonModel = button.getModel();
	    	setTraversingTrue();
			model.setPressed(false);
			model.setArmed(false);
			//b.fireActionEvent();
			model.setRollOver(false);
		}
    }
    
    private function setTraversingTrue():Void{
    	var fm:FocusManager = FocusManager.getManager(button.stage);
    	if(fm!=null){
    		fm.setTraversing(true);
    	}
    }
    
    //--------------------------------------------------
    
    /* These rectangles/insets are allocated once for all 
     * ButtonUI.paint() calls.  Re-using rectangles rather than 
     * allocating them in each paint call substantially reduced the time
     * it took paint to run.  Obviously, this method can't be re-entered.
     */
	private static var viewRect:IntRectangle = new IntRectangle();
    private static var textRect:IntRectangle = new IntRectangle();
    private static var iconRect:IntRectangle = new IntRectangle();    

    override public function paint(c:Component, g:Graphics2D, r:IntRectangle):Void{
    	super.paint(c, g, r);
    	var b:AbstractButton = AsWingUtils.as(c,AbstractButton);
    	
    	var insets:Insets = b.getMargin();
    	if(insets != null){
    		r = insets.getInsideBounds(r);
    	}
    	viewRect.setRect(r);

    	textRect.x = textRect.y = textRect.width = textRect.height = 0;
        iconRect.x = iconRect.y = iconRect.width = iconRect.height = 0;

        // layout the text and icon
        var text:String= AsWingUtils.layoutCompoundLabel(c, 
            c.getFont(), b.getDisplayText(), getIconToLayout(), 
            b.getVerticalAlignment(), b.getHorizontalAlignment(),
            b.getVerticalTextPosition(), b.getHorizontalTextPosition(),
            viewRect, iconRect, textRect, 
	    	b.getDisplayText() == null ? 0 : b.getIconTextGap());

    	paintIcon(b, g, iconRect);
    	
        if (text != null && text != ""){
        	textField.visible = true;
        	if(b.getModel().isArmed() || b.getModel().isSelected()){
        		textRect.x += getTextShiftOffset();
        		textRect.y += getTextShiftOffset();
        	}
			paintText(b, textRect, text);
        }else{
        	textField.text = "";
        	textField.visible = false;
        }
    }
    
    private function getIconToLayout():Icon{
    	return button.getIcon();
    }
    
    /**
     * do nothing here, let background decorator to paint the background
     */
	override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		//do nothing here, let background decorator to paint the background
	}

    /**
     * paint the text to specified button with specified bounds
     */
    private function paintText(b:AbstractButton, textRect:IntRectangle, text:String):Void{
    	b.bringToTop(textField);
    	var font:ASFont = b.getFont();
    	
		if(textField.text != text){
			textField.text = text;
		}
	
		if(!b.isFontValidated()){
			AsWingUtils.applyTextFont(textField, font);
			b.setFontValidated(true);
		}
    	AsWingUtils.applyTextColor(textField, getTextPaintColor(b));
		textField.x = textRect.x;
		textField.y = textRect.y;
		if(b.getMnemonicIndex() >= 0){
			textField.setTextFormat(
				new TextFormat(null, null, null, null, null, true), 
				b.getMnemonicIndex());
		} 

    	textField.filters = b.getTextFilters();
    }
    
    private function getTextPaintColor(b:AbstractButton):ASColor{
    	if(b.isEnabled()){
    		return b.getForeground();
    	}else{
    		return BasicGraphicsUtils.getDisabledColor(b);
    	}
    }
    
    /**
     * paint the icon to specified button's mc with specified bounds
     */
    private function paintIcon(b:AbstractButton, g:Graphics2D, iconRect:IntRectangle):Void{
        var model:ButtonModel = b.getModel();
        var icon:Icon = b.getIcon();
        var tmpIcon:Icon = null;
        
        var icons:Array<Dynamic>= getIcons();
        for(i in 0...icons.length){
        	var ico:Icon = icons[i];
			setIconVisible(ico, false);
        }
        
	    if(icon == null) {
	    	return;
	    }

		if(!model.isEnabled()) {
			if(model.isSelected()) {
				tmpIcon = b.getDisabledSelectedIcon();
			} else {
				tmpIcon = b.getDisabledIcon();
			}
		} else if(model.isPressed() && model.isArmed()) {
			tmpIcon = b.getPressedIcon();
		} else if(b.isRollOverEnabled() && model.isRollOver()) {
			if(model.isSelected()) {
				tmpIcon = b.getRollOverSelectedIcon();
			} else {
				tmpIcon = b.getRollOverIcon();
			}
		} else if(model.isSelected()) {
			tmpIcon = b.getSelectedIcon();
		}
              
		if(tmpIcon != null) {
			icon = tmpIcon;
		}
		setIconVisible(icon, true);
		if(model.isPressed() && model.isArmed()) {
			icon.updateIcon(b, g, iconRect.x + getTextShiftOffset(),
                        iconRect.y + getTextShiftOffset());
		}else{
			icon.updateIcon(b, g, iconRect.x, iconRect.y);
		}
    }
    
    private function setIconVisible(icon:Icon, visible:Bool):Void{
    	if(icon.getDisplay(button) != null){
    		icon.getDisplay(button).visible = visible;
    	}
    }
    
    private function getIcons():Array<Dynamic>{
    	var arr:Array<Dynamic>= new Array<Dynamic>();
    	if(button.getIcon() != null){
    		arr.push(button.getIcon());
    	}
    	if(button.getDisabledIcon() != null){
    		arr.push(button.getDisabledIcon());
    	}
    	if(button.getSelectedIcon() != null){
    		arr.push(button.getSelectedIcon());
    	}
    	if(button.getDisabledSelectedIcon() != null){
    		arr.push(button.getDisabledSelectedIcon());
    	}
    	if(button.getRollOverIcon() != null){
    		arr.push(button.getRollOverIcon());
    	}
    	if(button.getRollOverSelectedIcon() != null){
    		arr.push(button.getRollOverSelectedIcon());
    	}
    	if(button.getPressedIcon() != null){
    		arr.push(button.getPressedIcon());
    	}
    	return arr;
    }
    
      
    /**
     * Returns the a button's preferred size with specified icon and text.
     */
    private function getButtonPreferredSize(b:AbstractButton, icon:Icon, text:String):IntDimension{
    	viewRect.setRectXYWH(0, 0, 100000, 100000);
    	textRect.x = textRect.y = textRect.width = textRect.height = 0;
        iconRect.x = iconRect.y = iconRect.width = iconRect.height = 0;
        
        AsWingUtils.layoutCompoundLabel(b, 
            b.getFont(), text, icon, 
            b.getVerticalAlignment(), b.getHorizontalAlignment(),
            b.getVerticalTextPosition(), b.getHorizontalTextPosition(),
            viewRect, iconRect, textRect, 
	    	b.getDisplayText() == null ? 0 : b.getIconTextGap()
        );
        /* The preferred size of the button is the size of 
         * the text and icon rectangles plus the buttons insets.
         */
        var size:IntDimension;
        if(icon == null){
        	size = textRect.getSize();
        }else if(b.getDisplayText()==null || b.getDisplayText()==""){
        	size = iconRect.getSize();
        }else{
        	var r:IntRectangle = iconRect.union(textRect);
        	size = r.getSize();
        }
        size = b.getInsets().getOutsideSize(size);
		if(b.getMargin() != null)
        	size = b.getMargin().getOutsideSize(size);
        return size;
    }
    
    /**
     * Returns the a button's minimum size with specified icon and text.
     */    
    private function getButtonMinimumSize(b:AbstractButton, icon:Icon, text:String):IntDimension{
        var size:IntDimension = b.getInsets().getOutsideSize();
		if(b.getMargin() != null)
        	size = b.getMargin().getOutsideSize(size);
		return size;
    }    
    
    override public function getPreferredSize(c:Component):IntDimension{
    	var b:AbstractButton = AsWingUtils.as(c,AbstractButton);
    	return getButtonPreferredSize(b, getIconToLayout(), b.getDisplayText());
    }

    override public function getMinimumSize(c:Component):IntDimension{
    	var b:AbstractButton = AsWingUtils.as(c,AbstractButton);
    	return getButtonMinimumSize(b, getIconToLayout(), b.getDisplayText());
    }

    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }
}