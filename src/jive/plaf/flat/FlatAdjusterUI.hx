package jive.plaf.flat;
	
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
import jive.plaf.flat.adjuster.MinusButtonBackground;
import jive.plaf.flat.adjuster.PlusButtonBackground;
import org.aswing.ASColor;
import org.aswing.border.EmptyBorder;
import org.aswing.Component;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.Pen;
import org.aswing.Icon;
import org.aswing.Insets;
import org.aswing.JAdjuster;
import org.aswing.JButton;
import org.aswing.JSlider;
import org.aswing.JTextField;
import org.aswing.LookAndFeel;

import org.aswing.border.BevelBorder;
import org.aswing.event.AWEvent;
import org.aswing.event.FocusKeyEvent;
import org.aswing.event.ReleaseEvent;
import org.aswing.plaf.basic.adjuster.PopupSliderUI;
import org.aswing.plaf.basic.icon.ArrowIcon;

class FlatAdjusterUI extends org.aswing.plaf.BaseComponentUI implements org.aswing.plaf.AdjusterUI {
	
	var adjuster: JAdjuster;
	public var plusButton: Component;
	public var minusButton: Component;
	var inputText: JTextField;

	private var cornerRadius: Float;
	
	public function new(){
		super();
		inputText = new JTextField("", 3);
		inputText.setFocusable(false);
	}
	
	public function getInputText():JTextField{
		return inputText;
	}

	public function getPopupSlider():JSlider{
		return null;
	}
	
    override public function installUI(c:Component) {
    	adjuster = cast(c);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override public function uninstallUI(c:Component) {
    	adjuster = cast(c);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
    
	function getPropertyPrefix():String {
		return "Adjuster.";
	}
	
	function installDefaults() {
		var pp:String = getPropertyPrefix();
        LookAndFeel.installBorderAndBFDecorators(adjuster, pp);
        LookAndFeel.installColorsAndFont(adjuster, pp);
        LookAndFeel.installBasicProperties(adjuster, pp);
		cornerRadius = getNumber(pp + "cornerRadius");
	}
    
    function uninstallDefaults() {
    	LookAndFeel.uninstallBorderAndBFDecorators(adjuster);
    }
    
	 function installComponents() {
		initInputText();
		
		plusButton = createPlusButton();
		minusButton = createMinusButton();
		
		adjuster.addChild(inputText);
		adjuster.addChild(plusButton);
		adjuster.addChild(minusButton);

		inputText.addEventListener(MouseEvent.MOUSE_WHEEL, __onInputTextMouseWheel);
		plusButton.addEventListener(MouseEvent.MOUSE_DOWN, __onPlusButtonPressed);
		minusButton.addEventListener(MouseEvent.MOUSE_DOWN, __onMinusButtonPressed);
    }
    
	 function uninstallComponents() {
		inputText.removeEventListener(MouseEvent.MOUSE_WHEEL, __onInputTextMouseWheel);
		plusButton.removeEventListener(MouseEvent.MOUSE_DOWN, __onPlusButtonPressed);
		minusButton.removeEventListener(MouseEvent.MOUSE_DOWN, __onMinusButtonPressed);
		
		adjuster.removeChild(inputText);
		adjuster.removeChild(plusButton);
		adjuster.removeChild(minusButton);
    }
	
	 function installListeners() {
		adjuster.addStateListener(__onValueChanged);
		adjuster.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onInputTextKeyDown);
		adjuster.addEventListener(AWEvent.FOCUS_GAINED, __onFocusGained);
		adjuster.addEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
	}
    
     function uninstallListeners() {
		adjuster.removeStateListener(__onValueChanged);
		adjuster.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onInputTextKeyDown);
		adjuster.removeEventListener(AWEvent.FOCUS_GAINED, __onFocusGained);
		adjuster.removeEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
    }
    
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle) {
		super.paint(c, g, b);
		var text:String = getShouldFilledText();
		if(text != inputText.getText()){
			inputText.setText(text);
		}
		layoutAdjuster();
		getInputText().setEditable(adjuster.isEditable());
		getInputText().setEnabled(adjuster.isEnabled());
		plusButton.setEnabled(adjuster.isEnabled());
		minusButton.setEnabled(adjuster.isEnabled());
				
		g.drawLine(new Pen(c.background.offsetHLS(0,-0.2,-0.2)), plusButton.x-1, b.y-1, plusButton.x-1, b.y + b.height + 1);
		g.drawLine(new Pen(c.background.offsetHLS(0,-0.2,-0.2)), plusButton.x, b.y + Std.int(b.height/2), b.x + b.width, b.y + Std.int(b.height/2));
		//g.drawLine(new Pen(new ASColor(0xffffff)), plusButton.x, b.y + Std.int(b.height/2) + 1, b.x + b.width, b.y + Std.int(b.height/2) + 1);
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
	
	function initInputText() {
		inputText.setColumns(adjuster.getColumns());
		inputText.setForeground(null);//make it grap the property from parent
		inputText.setFont(adjuster.getFont());
		inputText.setBorder(new EmptyBorder(null, new Insets(0,10,0,10)));
		inputText.setBackgroundDecorator(null);
	}
	
	function createButton(): JButton{
		var btn:JButton = new JButton(null);
		btn.setMargin(new Insets(2, 5, 2, 5));
		btn.setForeground(null);//make it grap the property from parent
		btn.setBackground(null);//make it grap the property from parent
		btn.setFont(null);//make it grap the property from parent
		btn.setFocusable(false);
		return btn;
	}
	
	function createPlusButton(): Component {
		var btn: JButton = createButton();
		btn.setIcon(new lookandfeel.icon.PlusIcon(6, adjuster.mideground));
		btn.setBackgroundDecorator(new PlusButtonBackground(
			adjuster.background, 
			adjuster.background.offsetHLS(0, 0.1, 0), 
			adjuster.background.offsetHLS(0, -0.1, 0), 
			cornerRadius));
		return btn;
	}
	
	function createMinusButton(): Component {
		var btn: JButton = createButton();
		btn.setIcon(new lookandfeel.icon.MinusIcon(6, adjuster.mideground));
		btn.setBackgroundDecorator(new MinusButtonBackground(
			adjuster.background, 
			adjuster.background.offsetHLS(0, 0.1, 0), 
			adjuster.background.offsetHLS(0, -0.1, 0), 
			cornerRadius));
		return btn;
	}
	
	function fillInputTextWithCurrentValue() {
		inputText.setText(getShouldFilledText());
	}
	
	function getShouldFilledText():String{
		var value:Int = adjuster.getValue();
		var text:String = adjuster.getValueTranslator()(value);
		return text;
	}
	
	function getTextButtonGap():Int{
		return 1;
	}
	
	 function layoutAdjuster() {
		var td:IntDimension = adjuster.getSize();
		var insets:Insets = adjuster.getInsets();
		var top:Int = insets.top;
		var left:Int = insets.left;
		var right:Int = td.width - insets.right;
		var gap:Int = getTextButtonGap();
		
		var height:Int = td.height - insets.top - insets.bottom;
    	var buttonSize:IntDimension = plusButton.getPreferredSize(); 
    	plusButton.setSizeWH(buttonSize.width, Std.int(height / 2) + 1);
    	plusButton.setLocationXY(right - buttonSize.width, top - 1);
    	minusButton.setSizeWH(buttonSize.width, Std.int(height / 2));
    	minusButton.setLocationXY(right - buttonSize.width, top + Std.int(height / 2)+1);
    	inputText.setLocationXY(left, top - 1);
    	inputText.setSizeWH(td.width - insets.left - insets.right - buttonSize.width - gap, height + 2);		
	}
    
    override public function getPreferredSize(c:Component):IntDimension{
    	var insets:Insets = adjuster.getInsets();
    	var textSize: IntDimension = inputText.getPreferredSize();
    	var btnSize:IntDimension = plusButton.getPreferredSize();
    	var size:IntDimension = new IntDimension(
    		textSize.width + getTextButtonGap() + btnSize.width,
    		textSize.height
    	);
    	return insets.getOutsideSize(size);
    }

    override public function getMinimumSize(c:Component):IntDimension{
    	return adjuster.getInsets().getOutsideSize(new IntDimension(0, 0)); // arrowButton.getPreferredSize());
    }

    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }    	
	
	//--------------------- handlers--------------------
	
	private function __onValueChanged(e:Event) {
		fillInputTextWithCurrentValue();
	}
	
	private function __onInputTextMouseWheel(e:MouseEvent) {
		adjuster.setValue(adjuster.getValue()+e.delta*getUnitIncrement());
	}
	
	private function __onPlusButtonPressed(e) {
		adjuster.setValue(adjuster.getValue() + getUnitIncrement());
		fillInputTextWithCurrentValue();
		fireActionEvent();
	}

	private function __onMinusButtonPressed(e) {
		adjuster.setValue(adjuster.getValue() - getUnitIncrement());
		fillInputTextWithCurrentValue();
		fireActionEvent();
	}
	
	private function __inputTextAction(fireActOnlyIfChanged:Bool=false) {
		var text:String = inputText.getText();
		var value:Int = adjuster.getValueParser()(text);
		adjuster.setValue(value);
		//revalidte a legic text
		fillInputTextWithCurrentValue();
		if(!fireActOnlyIfChanged){
			fireActionEvent();
		}else if(value != startEditingValue){
			fireActionEvent();
		}
	}
	
	 var startEditingValue:Int;
	 function fireActionEvent() {
		startEditingValue = adjuster.getValue();
		adjuster.dispatchEvent(new AWEvent(AWEvent.ACT));
	}
	
	private function __onFocusGained(e:AWEvent) {
		startEditingValue = adjuster.getValue();
	}
	
	private function __onFocusLost(e:AWEvent) {
		__inputTextAction(true);
	}
	
	private function __onInputTextKeyDown(e:FocusKeyEvent) {
    	var code:UInt = e.keyCode;
    	var unit:Int = getUnitIncrement();
    	var block:Int =  unit*10;
    	var delta:Int = 0;
    	if(code == Keyboard.ENTER){
    		__inputTextAction(false);
    		return;
    	}
    	if(code == Keyboard.UP){
    		delta = unit;
    	}else if(code == Keyboard.DOWN){
    		delta = -unit;
    	}else if(code == Keyboard.PAGE_UP){
    		delta = block;
    	}else if(code == Keyboard.PAGE_DOWN){
    		delta = -block;
    	}else if(code == Keyboard.HOME){
    		adjuster.setValue(adjuster.getMinimum());
    		return;
    	}else if(code == Keyboard.END){
    		adjuster.setValue(adjuster.getMaximum() - adjuster.getExtent());
    		return;
    	}
    	adjuster.setValue(adjuster.getValue() + delta);
	}
	
    private var unitIncrement: Null<Int>;
	public function setUnitIncrement(increment: Int) {
		unitIncrement = increment;
	}
	
	function getUnitIncrement(): Int {
    	return if (null == unitIncrement) Std.int((adjuster.getMaximum() - adjuster.getMinimum()) / 20) else unitIncrement;
    }
}
