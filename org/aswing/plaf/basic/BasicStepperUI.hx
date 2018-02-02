/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

	
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.MouseEvent;
import org.aswing.AWKeyboard;

import org.aswing.Component;
	import org.aswing.JTextField;
	import org.aswing.JStepper;
	import org.aswing.JButton;
	import org.aswing.Insets;
	import org.aswing.event.AWEvent;
	import org.aswing.event.FocusKeyEvent;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.basic.icon.ArrowIcon;
import org.aswing.util.Timer;
import org.aswing.event.ReleaseEvent;
/**
 * Basic stepper ui imp.
 * @private
 */
class BasicStepperUI extends BaseComponentUI{

	private var upButton:Component;
	private var downButton:Component;
	private var inputText:JTextField;
	private var stepper:JStepper;
	
	private static var continueSpeedThrottle:Int= 60; // delay in milli seconds
    private static var initialContinueSpeedThrottle:Int= 500; // first delay in milli seconds
    private var continueTimer:Timer;
    
	public function new() {
		super();
		inputText  = new JTextField("", 3);
	}
	
    override public function installUI(c:Component):Void{
    	stepper = AsWingUtils.as(c,JStepper);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override public function uninstallUI(c:Component):Void{
    	stepper = AsWingUtils.as(c,JStepper);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
    
	private function getPropertyPrefix():String{
		return "Stepper.";
	}
	
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
        LookAndFeel.installBorderAndBFDecorators(stepper, pp);
        LookAndFeel.installColorsAndFont(stepper, pp);
        LookAndFeel.installBasicProperties(stepper, pp);
	}
    
    private function uninstallDefaults():Void{
    	LookAndFeel.uninstallBorderAndBFDecorators(stepper);
    }
    
	private function installComponents():Void{
		upButton   = createButton(-Math.PI/2);
		downButton = createButton(Math.PI/2);
		inputText.setBackgroundDecorator(null);
		inputText.setBorder(null);
		//make it proxy to the stepper
		inputText.setForeground(null);
		inputText.setBackground(null);
    	inputText.setMideground(null);
    	inputText.setStyleTune(null);
		
		upButton.setUIElement(true);
		downButton.setUIElement(true);
		inputText.setUIElement(true);
		
		upButton.setFocusable(false);
		downButton.setFocusable(false);
		inputText.setFocusable(false);
		
		stepper.addChild(inputText);
		stepper.addChild(upButton);
		stepper.addChild(downButton);
    }
    
	private function uninstallComponents():Void{
		stepper.removeChild(inputText);
		stepper.removeChild(upButton);
		stepper.removeChild(downButton);
    }
	
	private function installListeners():Void{
		stepper.addStateListener(__onValueChanged);
		stepper.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onInputTextKeyDown);
		stepper.addEventListener(AWEvent.FOCUS_GAINED, __onFocusGained);
		stepper.addEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
		
		inputText.addEventListener(MouseEvent.MOUSE_WHEEL, __onInputTextMouseWheel);
		inputText.getTextField().addEventListener(Event.CHANGE, __textChanged);
		upButton.addEventListener(MouseEvent.MOUSE_DOWN, __onUpButtonPressed);
		upButton.addEventListener(ReleaseEvent.RELEASE, __onUpButtonReleased);
		downButton.addEventListener(MouseEvent.MOUSE_DOWN, __onDownButtonPressed);
		downButton.addEventListener(ReleaseEvent.RELEASE, __onDownButtonReleased);
		
		continueTimer = new Timer(continueSpeedThrottle);
		continueTimer.setInitialDelay(initialContinueSpeedThrottle);
		continueTimer.addActionListener(__continueTimerPerformed);		
	}
    
    private function uninstallListeners():Void{
		stepper.removeStateListener(__onValueChanged);
		stepper.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onInputTextKeyDown);
		stepper.removeEventListener(AWEvent.FOCUS_GAINED, __onFocusGained);
		stepper.removeEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
		
		inputText.removeEventListener(MouseEvent.MOUSE_WHEEL, __onInputTextMouseWheel);
		inputText.getTextField().removeEventListener(Event.CHANGE, __textChanged);
		upButton.removeEventListener(MouseEvent.MOUSE_DOWN, __onUpButtonPressed);
		upButton.removeEventListener(ReleaseEvent.RELEASE, __onUpButtonReleased);
		downButton.removeEventListener(MouseEvent.MOUSE_DOWN, __onDownButtonPressed);
		downButton.removeEventListener(ReleaseEvent.RELEASE, __onDownButtonReleased);
		
		continueTimer.stop();
		continueTimer = null;
    }
    
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		layoutStepper();
		upButton.setEnabled(stepper.isEnabled());
		downButton.setEnabled(stepper.isEnabled());
		inputText.setFont(stepper.getFont());
		inputText.setForeground(stepper.getForeground());
		#if (flash9)
		inputText.setMaxChars(stepper.getMaxChars());
		inputText.setRestrict(stepper.getRestrict());
		#end
		inputText.setEditable(stepper.isEditable());
		inputText.setEnabled(stepper.isEnabled());
		fillInputTextWithCurrentValue();
	}
        
    override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
    	//do nothing, background decorator will paint it
    }
    
    /**
     * Just override this method if you want other LAF drop down buttons.
     */
    private function createButton(direction:Float):Component{
    	var btn:JButton = new JButton("", new ArrowIcon(
    				direction, 15
    	));
    	btn.setFocusable(false);
    	btn.setPreferredSize(new IntDimension(15, 15));
    	btn.setBackgroundDecorator(null);
    	btn.setMargin(new Insets());
    	btn.setBorder(null);
    	//make it proxy to the stepper
    	btn.setMideground(null);
    	btn.setStyleTune(null);
    	return btn;
    }
    
    /**
     * Returns the input text to receive the focus for the component.
     * @param c the component
     * @return the object to receive the focus.
     */
	override public function getInternalFocusObject(c:Component):InteractiveObject{
		return inputText.getTextField();
	}
	
	private function fillInputTextWithCurrentValue():Void{
		inputText.setText(getShouldFilledText());
	}
	
	private function getShouldFilledText():String{
		var value:Int= stepper.getValue();
		var text:String= stepper.getValueTranslator()(value);
		return text;
	}
		
	//--------------------- handlers--------------------
	
	private function __onValueChanged(e:Event):Void{
		if(textInputing!=true){
			fillInputTextWithCurrentValue();
		}
	}
	
	private function __onInputTextMouseWheel(e:MouseEvent):Void{
		stepper.setValue(
				stepper.getValue()+e.delta*stepper.getUnitIncrement(),
				false
		);
	}
	
	private var textInputing:Bool;
	private function __textChanged(e:Event):Void{
		textInputing = true;
		var text:String= inputText.getText();
		var value:Int= Std.int(stepper.getValueParser()(text));
		stepper.setValue(value, false);
		textInputing = false;
	}
	
	private function __inputTextAction(fireActOnlyIfChanged:Bool=false):Void{
		var text:String= inputText.getText();
		var value:Int= Std.int(stepper.getValueParser()(text));
		stepper.setValue(value, false);
		if(fireActOnlyIfChanged!=true){
			fireActionEvent();
		}else if(value != startEditingValue){
			fireActionEvent();
		}
	}
	
	private var startEditingValue:Int;
	private function fireActionEvent():Void{
		startEditingValue = stepper.getValue();
		fillInputTextWithCurrentValue();
		stepper.dispatchEvent(new AWEvent(AWEvent.ACT));
	}
	
	private function __onFocusGained(e:AWEvent):Void{
		startEditingValue = stepper.getValue();
	}
	
	private function __onFocusLost(e:AWEvent):Void{
		__inputTextAction(true);
	}
	
	private function __onInputTextKeyDown(e:FocusKeyEvent):Void{
     
		var code:Int = e.keyCode;
	 
    	var unit:Int= stepper.getUnitIncrement();
    	var delta:Int= 0;
    	if(code == AWKeyboard.ENTER){
    		__inputTextAction(false);
    		return;
    	}
    	if(code == AWKeyboard.HOME){
    		stepper.setValue(stepper.getMinimum(), false);
    		return;
    	}else if(code == AWKeyboard.END){
    		stepper.setValue(stepper.getMaximum() - stepper.getExtent(), false);
    		return;
    	}
    	if(code == AWKeyboard.UP){
    		delta = unit;
    	}else if(code == AWKeyboard.DOWN){
    		delta = -unit;
    	}else if(code == AWKeyboard.PAGE_UP){
    		delta = unit;
    	}else if(code == AWKeyboard.PAGE_DOWN){
    		delta = -unit;
    	}
    	makeStepper(delta);
	}
	
	private function makeStepper(step:Int):Void{
		stepper.setValue(stepper.getValue() + step, false);
	}
	
	private var timerIncrement:Int;
	private var timerContinued:Int;
	private function __onUpButtonPressed(e:Event):Void{
		timerIncrement = stepper.getUnitIncrement();
		makeStepper(timerIncrement);
		continueTimer.restart();
		timerContinued = 0;
	}
	
	private function __onUpButtonReleased(e:Event):Void{
		continueTimer.stop();
		fireActionEvent();
	}
	
	private function __onDownButtonPressed(e:Event):Void{
		timerIncrement = -stepper.getUnitIncrement();
		makeStepper(timerIncrement);
		continueTimer.restart();
		timerContinued = 0;
	}
	
	private function __onDownButtonReleased(e:Event):Void{
		continueTimer.stop();
		fireActionEvent();
	}
	
    private function __continueTimerPerformed(e:AWEvent):Void{
    	makeStepper(timerIncrement);
    	timerContinued++;
    	if(timerContinued >= 5){
    		timerContinued = 0;
    		timerIncrement *= 2;
    	}
    }
	
	//---------------------Layout Implementation---------------------------
    private function layoutStepper():Void{
    	var td:IntDimension = stepper.getSize();
		var insets:Insets = stepper.getInsets();
		var top:Int= insets.top;
		var left:Int= insets.left;
		var right:Int= td.width - insets.right;
		
		var height:Int= td.height - insets.top - insets.bottom;
    	var buttonSize:IntDimension = upButton.getPreferredSize(); 
    	upButton.setSizeWH(buttonSize.width, Std.int(height/2));
    	upButton.setLocationXY(right - buttonSize.width, top);
    	downButton.setSizeWH(buttonSize.width, Std.int(height/2));
    	downButton.setLocationXY(right - buttonSize.width, Std.int(top+height/2));
    	
    	inputText.setLocationXY(left, top);
    	inputText.setSizeWH(td.width-insets.left-insets.right- buttonSize.width, height);
    }
    
    override public function getPreferredSize(c:Component):IntDimension{
    	var insets:Insets = stepper.getInsets();
    	inputText.setColumns(stepper.getColumns());
    	var inputSize:IntDimension = inputText.getPreferredSize();
    	var buttonSize:IntDimension = upButton.getPreferredSize(); 
    	inputSize.width += buttonSize.width;
    	return insets.getOutsideSize(inputSize);
    }

    override public function getMinimumSize(c:Component):IntDimension{
    	var buttonSize:IntDimension = upButton.getPreferredSize(); 
    	buttonSize.height *= 2;
    	return stepper.getInsets().getOutsideSize(buttonSize);
    }

    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }    

}