/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

	
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import org.aswing.AsWingManager;
import org.aswing.AsWingUtils;
import org.aswing.AWKeyboard;

import org.aswing.JAdjuster;
	import org.aswing.Component;
	import org.aswing.JPopup;
	import org.aswing.JTextField;
	import org.aswing.JSlider;
	import org.aswing.JButton;
	import org.aswing.Insets;
	import org.aswing.Icon;
	import org.aswing.event.AWEvent;
import org.aswing.event.FocusKeyEvent;
import org.aswing.event.ReleaseEvent;
import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.AdjusterUI;
	import org.aswing.plaf.SliderUI;
	import org.aswing.plaf.basic.adjuster.PopupSliderUI;
import org.aswing.plaf.basic.icon.ArrowIcon;

/**
 * Basic adjust ui imp.
 * @author paling
 * @private
 */
class BasicAdjusterUI extends BaseComponentUI  implements AdjusterUI{
	
	private var adjuster:JAdjuster;
	private var arrowButton:Component;
	private var popup:JPopup;
	private var inputText:JTextField;
	private var popupSlider:JSlider;
	private var popupSliderUI:SliderUI;
	private var startMousePoint:IntPoint;
	private var startValue:Float;
		
	public function new(){
		super();
		inputText   = new JTextField("", 3);
		inputText.setFocusable(false);
		popupSlider = new JSlider();
		popupSlider.setFocusable(false);
		popupSlider.setOpaque(false);
	}
	
	public function getPopupSlider():JSlider{
		return popupSlider;
	}
	
	public function getInputText():JTextField{
		return inputText;
	}
	
    override public function installUI(c:Component):Void{
    	adjuster =      AsWingUtils.as(c,JAdjuster);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override public function uninstallUI(c:Component):Void{
    	adjuster = AsWingUtils.as(c,JAdjuster);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
    
	private function getPropertyPrefix():String{
		return "Adjuster.";
	}
	
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
        LookAndFeel.installBorderAndBFDecorators(adjuster, pp);
        LookAndFeel.installColorsAndFont(adjuster, pp);
        LookAndFeel.installBasicProperties(adjuster, pp);
	}
    
    private function uninstallDefaults():Void{
    	LookAndFeel.uninstallBorderAndBFDecorators(adjuster);
    }
    
	private function installComponents():Void{
		initInputText();
		initPopupSlider();
		arrowButton = createArrowButton();
		arrowButton.setUIElement(true);
		popupSlider.setUIElement(true);
		popupSliderUI = createPopupSliderUI();
		popupSlider.setUI(popupSliderUI);
		popupSlider.setModel(adjuster.getModel());
		adjuster.addChild(inputText);
		adjuster.addChild(arrowButton);
		
		inputText.getTextField().addEventListener(Event.CHANGE, __textChanged);
		inputText.addEventListener(MouseEvent.MOUSE_WHEEL, __onInputTextMouseWheel);
		arrowButton.addEventListener(MouseEvent.MOUSE_DOWN, __onArrowButtonPressed);
		arrowButton.addEventListener(ReleaseEvent.RELEASE, __onArrowButtonReleased);
    }
    
	private function uninstallComponents():Void{
		inputText.getTextField().removeEventListener(Event.CHANGE, __textChanged);
		inputText.removeEventListener(MouseEvent.MOUSE_WHEEL, __onInputTextMouseWheel);
		arrowButton.removeEventListener(MouseEvent.MOUSE_DOWN, __onArrowButtonPressed);
		arrowButton.removeEventListener(ReleaseEvent.RELEASE, __onArrowButtonReleased);
		
		adjuster.removeChild(arrowButton);
		adjuster.removeChild(inputText);
		if(popup != null && popup.isVisible()){
			popup.dispose();
		}
    }
	
	private function installListeners():Void{
		adjuster.addStateListener(__onValueChanged);
		adjuster.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onInputTextKeyDown);
		adjuster.addEventListener(AWEvent.FOCUS_GAINED, __onFocusGained);
		adjuster.addEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
	}
    
    private function uninstallListeners():Void{
		adjuster.removeStateListener(__onValueChanged);
		adjuster.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onInputTextKeyDown);
		adjuster.removeEventListener(AWEvent.FOCUS_GAINED, __onFocusGained);
		adjuster.removeEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
    }
    
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		fillInputTextWithCurrentValue();
		layoutAdjuster();
		getInputText().setEditable(adjuster.isEditable());
		getInputText().setEnabled(adjuster.isEnabled());
		arrowButton.setEnabled(adjuster.isEnabled());
		inputText.setFont(adjuster.getFont());
		inputText.setForeground(adjuster.getForeground());
	}
	
    override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
    	//do nothing, background decorator will paint it
    }	
	
	//*******************************************************************************
	//              Override these methods to easily implement different look
	//*******************************************************************************
    /**
     * Returns the input text to receive the focus for the component.
     * @param c the component
     * @return the object to receive the focus.
     */
	override public function getInternalFocusObject(c:Component):InteractiveObject{
		return inputText.getTextField();
	}
	
	private function initInputText():Void{
		inputText.setForeground(null);
		inputText.setColumns(adjuster.getColumns());
		inputText.setBackgroundDecorator(null);
		inputText.setOpaque(false);
		inputText.setBorder(null);
		inputText.setFont(adjuster.getFont());
	}
	
	private function initPopupSlider():Void{
		popupSlider.setOrientation(adjuster.getOrientation());
	}
	
	private function createArrowButton():Component{
    	var btn:JButton = new JButton("", createArrowIcon());
    	btn.setFocusable(false);
    	//btn.setPreferredSize(new IntDimension(16, 16));
    	btn.setBackgroundDecorator(null);
    	btn.setMargin(new Insets());
    	btn.setBorder(null);
    	//make it proxy to the combobox
    	btn.setMideground(null);
    	btn.setStyleTune(null);
		btn.setForeground(null);//make it grap the property from parent
		btn.setBackground(null);//make it grap the property from parent
		btn.setFont(null);//make it grap the property from parent
    	return btn;
	}
	
	private function createPopupSliderUI():SliderUI{
		return new PopupSliderUI();
	}
	
	private function createArrowIcon() : Icon {
		return new ArrowIcon(Math.PI/2, 16);
	}
		
	private function getPopup():JPopup{
		if(popup == null){
			popup = new JPopup();
			popup.append(popupSlider, BorderLayout.CENTER);
			popup.filters = [new DropShadowFilter(4, 45, 0, 0.3)];
		}
		return popup;
	}
	
	private function fillInputTextWithCurrentValue():Void{
		inputText.setText(getShouldFilledText());
	}
	
	private function getShouldFilledText():String{
		var value:Int= adjuster.getValue();
		var text:String= adjuster.getValueTranslator()(value);
		return text;
	}
	
	private function getTextButtonGap():Int{
		return 1;
	}
	
	private function layoutAdjuster():Void{
    	var td:IntDimension = adjuster.getSize();
		var insets:Insets = adjuster.getInsets();
		var top:Int= insets.top;
		var left:Int= insets.left;
		var right:Int= td.width - insets.right;
		var gap:Int= getTextButtonGap();
		
		var height:Int= td.height - insets.top - insets.bottom;
    	var buttonSize:IntDimension = arrowButton.getPreferredSize(); 
    	arrowButton.setSizeWH(buttonSize.width, height);
    	arrowButton.setLocationXY(right - buttonSize.width, top);
    	inputText.setLocationXY(left, top);
    	inputText.setSizeWH(td.width - insets.left - insets.right - buttonSize.width-gap, height);		
	}
    
    override public function getPreferredSize(c:Component):IntDimension{
    	var insets:Insets = adjuster.getInsets();
    	var textSize:IntDimension = inputText.getPreferredSize();
    	var btnSize:IntDimension = arrowButton.getPreferredSize();
    	var size:IntDimension = new IntDimension(
    		textSize.width + getTextButtonGap() + btnSize.width,
    		Std.int(Math.max(textSize.height, btnSize.height))
    	);
    	return insets.getOutsideSize(size);
    }

    override public function getMinimumSize(c:Component):IntDimension{
    	return adjuster.getInsets().getOutsideSize(arrowButton.getPreferredSize());
    }

    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }    	
	
	//--------------------- handlers--------------------
	
	private function __onValueChanged(e:Event):Void{
		if(textInputing!=true){
			fillInputTextWithCurrentValue();
		}
	}
	
	private function __onInputTextMouseWheel(e:MouseEvent):Void{
		adjuster.setValue(adjuster.getValue()+e.delta*getUnitIncrement());
	}
	
	private var textInputing:Bool;
	private function __textChanged(e:Event):Void{
		textInputing = true;
		var text:String= inputText.getText();
		var value:Int= Std.int(adjuster.getValueParser()(text));
		adjuster.setValue(value);
		textInputing = false;
	}
	
	private function __inputTextAction(fireActOnlyIfChanged:Bool=false):Void{
		var text:String= inputText.getText();
		var value:Int= Std.int(adjuster.getValueParser()(text));
		adjuster.setValue(value);
		//revalidte a legic text
		fillInputTextWithCurrentValue();
		if(fireActOnlyIfChanged!=true){
			fireActionEvent();
		}else if(value != startEditingValue){
			fireActionEvent();
		}
	}
	
	private var startEditingValue:Int;
	private function fireActionEvent():Void{
		startEditingValue = adjuster.getValue();
		adjuster.dispatchEvent(new AWEvent(AWEvent.ACT));
	}
	
	private function __onFocusGained(e:AWEvent):Void{
		startEditingValue = adjuster.getValue();
	}
	
	private function __onFocusLost(e:AWEvent):Void{
		__inputTextAction(true);
	}
	
	private function __onInputTextKeyDown(e:FocusKeyEvent):Void{
    	var code:Int= e.keyCode;
    	var unit:Int= getUnitIncrement();
    	var block:Int= popupSlider.getMajorTickSpacing() > 0 ? popupSlider.getMajorTickSpacing() : unit*10;
    	var delta:Int= 0;
    	if(code == AWKeyboard.ENTER){
    		__inputTextAction(false);
    		return;
    	}
    	if(code == AWKeyboard.UP){
    		delta = unit;
    	}else if(code == AWKeyboard.DOWN){
    		delta = -unit;
    	}else if(code == AWKeyboard.PAGE_UP){
    		delta = block;
    	}else if(code == AWKeyboard.PAGE_DOWN){
    		delta = -block;
    	}else if(code == AWKeyboard.HOME){
    		adjuster.setValue(adjuster.getMinimum());
    		return;
    	}else if(code == AWKeyboard.END){
    		adjuster.setValue(adjuster.getMaximum() - adjuster.getExtent());
    		return;
    	}
    	adjuster.setValue(adjuster.getValue() + delta);
	}
	
	private function __onArrowButtonPressed(e:Event):Void{
		var popupWindow:JPopup = getPopup();
		if(popupWindow.isOnStage()){
			popupWindow.dispose();
		}
		popupWindow.changeOwner(AsWingUtils.getOwnerAncestor(adjuster));
		popupWindow.pack();
		popupWindow.show();
		var max:Float= adjuster.getMaximum();
		var min:Float= adjuster.getMinimum();
		var pw:Float= popupWindow.getWidth();
		var ph:Float= popupWindow.getHeight();
		var sw:Float= getSliderTrackWidth();
		var sh:Float= getSliderTrackHeight();
		var insets:Insets = popupWindow.getInsets();
		var sliderInsets:Insets = popupSliderUI.getTrackMargin();
		insets.top += sliderInsets.top;
		insets.left += sliderInsets.left;
		insets.bottom += sliderInsets.bottom;
		insets.right += sliderInsets.right;
		var mouseP:IntPoint = adjuster.getMousePosition();
		var windowP:IntPoint = new IntPoint(Std.int(mouseP.x - pw/2), Std.int(mouseP.y - ph/2));
		var value:Float= adjuster.getValue();
		var valueL:Float;
		if(adjuster.getOrientation() == JAdjuster.VERTICAL){
			valueL = (value - min)/(max - min) * sh;
			windowP.y = Std.int(mouseP.y - (sh - valueL) - insets.top);
		}else{
			valueL = (value - min)/(max - min) * sw;
			windowP.x =Std.int( mouseP.x - valueL - insets.left);
			windowP.y += Std.int(adjuster.getHeight()/4);
		}
		var agp:IntPoint = adjuster.getGlobalLocation();
		agp.move(windowP.x, windowP.y);
		popupWindow.setLocation(agp);
		
		startMousePoint = adjuster.getMousePosition();
		startValue = adjuster.getValue();
		if(AsWingManager.getStage()!=null)	{
			AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMoveOnSlider, false, 0, false);
			adjuster.addEventListener(Event.REMOVED_FROM_STAGE, __onMouseMoveOnSliderRemovedFromStage, false, 0, false);
		}
	}
	
	private function __onMouseMoveOnSliderRemovedFromStage(e:Event):Void{
		AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __onMouseMoveOnSlider);
		adjuster.removeEventListener(Event.REMOVED_FROM_STAGE, __onMouseMoveOnSliderRemovedFromStage);
	}
	
	private function __onArrowButtonReleased(e:Event):Void{
		if(adjuster.stage!=null)	{
			__onMouseMoveOnSliderRemovedFromStage(null);
		}
		popup.dispose();
		fireActionEvent();
	}
	
	private function __onMouseMoveOnSlider(e:MouseEvent):Void{
		var delta:Float= 0;
		var valueDelta:Float= 0;
		var range:Float= adjuster.getMaximum() - adjuster.getMinimum();
		var p:IntPoint = adjuster.getMousePosition();
		if(adjuster.getOrientation() == JAdjuster.VERTICAL){
			delta = -p.y + startMousePoint.y;
			valueDelta = delta/(getSliderTrackHeight()) * range;
		}else{
			delta = p.x - startMousePoint.x;
			valueDelta = delta/(getSliderTrackWidth()) * range;			
		}
		adjuster.setValue(Std.int(startValue + valueDelta));
		e.updateAfterEvent();
	}	
	
    private function getUnitIncrement():Int{
    	var unit:Int= 0;
    	if(popupSlider.getMinorTickSpacing() >0 ){
    		unit = popupSlider.getMinorTickSpacing();
    	}else if(popupSlider.getMajorTickSpacing() > 0){
    		unit = popupSlider.getMajorTickSpacing();
    	}else{
    		var range:Float= popupSlider.getMaximum() - popupSlider.getMinimum();
    		if(range > 2){
    			unit = Std.int(Math.max(1, Math.round(range/500)));
    		}else{
    			unit = Std.int(range/100);
    		}
    	}
    	return unit;
    }
	
	private function getSliderTrackWidth():Float{
		var sliderInsets:Insets = popupSliderUI.getTrackMargin();
		var w:Float= popupSlider.getWidth();
		if(w == 0){
			w = popupSlider.getPreferredWidth();
		}
		return w - sliderInsets.left - sliderInsets.right;
	}
	
	private function getSliderTrackHeight():Float{
		var sliderInsets:Insets = popupSliderUI.getTrackMargin();
		var h:Float= popupSlider.getHeight();
		if(h == 0){
			h = popupSlider.getPreferredHeight();
		}
		return h - sliderInsets.top - sliderInsets.bottom;
	}
}