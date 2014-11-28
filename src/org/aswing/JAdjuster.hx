/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

		
import flash.errors.Error;
import org.aswing.event.InteractiveEvent;
	import org.aswing.plaf.ComponentUI;
	import org.aswing.plaf.AdjusterUI;
	import org.aswing.plaf.basic.BasicAdjusterUI;
	import org.aswing.event.AWEvent; 
/**
 * Dispatched when when user finish a adjusting.
 * @eventType org.aswing.event.AWEvent.ACT
 * @see #addActionListener()
 */
// [Event(name="act", type="org.aswing.event.AWEvent")]

/**
 * Dispatched when the adjuster's state changed. 
 * @see BoundedRangeModel
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * A component that combine a input text and a button to drop-down a popup slider to let 
 * user input/select a value.
 * 
 * @author paling
 */
class JAdjuster extends Component  implements Orientable implements EditableComponent{

	/** 
	 * Horizontal orientation.
	 */
	inline public static var HORIZONTAL:Int= AsWingConstants.HORIZONTAL;
	/** 
	 * Vertical orientation.
	 */
	inline public static var VERTICAL:Int= AsWingConstants.VERTICAL;

	/**
	 * The default translator translate a int value to a integer string representation.
	 */  	
	public static var DEFAULT_VALUE_TRANSLATOR:Int -> String= function(value:Int):String{
		return value + "";
	};
		
	/**
	 * The default parser parse a int value from the string, if NaN, 0 will be returned.
	 */
	public static var DEFAULT_VALUE_PARSER:String -> Int= function(text:String):Int{
		var value:Int= Std.parseInt(text);
		if( (value==0)){
			value = 0;
		}
		return value;
	};
		
	private var model:BoundedRangeModel;
	private var columns:Int;
	private var orientation:Int;
	private var editable:Bool;
	private var valueTranslator:Int -> String;
	private var valueParser:String -> Int;

	/**
	 * Creates a adjuster with the specified columns input text and orientation<p>
	 * Defalut model is a instance of <code>DefaultBoundedRangeModel</code>.
	 * @param columns (optional)the number of columns to use to calculate the input text preferred width
	 * @param orientation (optional)the pop-up slider's orientation to either VERTICAL or HORIZONTAL.
	 * @see org.aswing.DefaultIntegerBoundedRangeModel 
	 */
	public function new(columns:Int=3, orientation:Int=AsWingConstants.VERTICAL){
		super();
		setColumns(columns);
		setOrientation(orientation);
		
		editable = true;
		valueTranslator = DEFAULT_VALUE_TRANSLATOR;
		valueParser	 = DEFAULT_VALUE_PARSER;
		
		setModel(new DefaultBoundedRangeModel(50, 0, 0, 100));
		updateUI();
		#if(flash9)
		if(getInputText()!=null){
			getInputText().setRestrict("0123456789");
		}
		#end
	}
	
	/**
	 * Sets the ui.
	 * <p>
	 * JComboBox ui should implemented <code>AdjusterUI</code> interface!
	 * </p>
	 * @param newUI the newUI
	 * @throws ArgumentError when the newUI is not an <code>AdjusterUI</code> instance.
	 */
	override public function setUI(newUI:ComponentUI):Void{
		if(Std.is(newUI,AdjusterUI)){
			super.setUI(newUI);
		}else{
			throw new  Error("JComboBox ui should implemented ComboBoxUI interface!");
		}
	}
	
    /**
     * Returns the ui for this combobox with <code>ComboBoxUI</code> instance
     * @return the combobox ui.
     */
    public function getAdjusterUI():AdjusterUI{
    	return AsWingUtils.as(getUI() , AdjusterUI);
    }

	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicAdjusterUI;
    }
	
	override public function getUIClassID():String{
		return "AdjusterUI";
	}
	
	/**
	 * Sets the number of columns for the input text. 
	 * @param columns the number of columns to use to calculate the preferred width.
	 */
	public function setColumns(columns:Int):Void{
		if(columns < 0) columns = 0;
		if(this.columns != columns){
			this.columns = columns;
			if(getInputText() != null){
				getInputText().setColumns(columns);
			}
			revalidate();
		}
	}
	
	/**
	 * @see #setColumns
	 */
	public function getColumns():Int{
		return columns;
	}	
	
	/**
	 * Return this slider's vertical or horizontal orientation.
	 * @return VERTICAL or HORIZONTAL
	 * @see #setOrientation()
	 */
	public function getOrientation():Int{
		return orientation;
	}
	
	
	/**
	 * Set the slider's orientation to either VERTICAL or HORIZONTAL.
	 * @param orientation the orientation to either VERTICAL orf HORIZONTAL
	 */
	public function setOrientation(orientation:Int):Void{
		this.orientation = orientation;
		if(getPopupSlider() != null){
			getPopupSlider().setOrientation(orientation);
		}
	}
	
	/**
	 * Returns data model that handles the slider's four fundamental properties: minimum, maximum, value, extent.
	 * @return the data model
	 */
	public function getModel():BoundedRangeModel{
		return model;
	}
	
	/**
	 * Sets the model that handles the slider's four fundamental properties: minimum, maximum, value, extent. 
	 * @param the data model
	 */
	public function setModel(newModel:BoundedRangeModel):Void{
		if (model != null){
			model.removeStateListener(__onModelStateChanged);
		}
		model = newModel;
		if (model != null){
			model.addStateListener(__onModelStateChanged);
			if(ui != null){
				getPopupSlider().setModel(model);
			}
		}
	}
		
	private function __onModelStateChanged(event:InteractiveEvent):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, event.isProgrammatic()));
	}
	
	/**
	 * Returns the pop-up slider component, based on the LAF, the AdjusterUI should 
	 * return the right slider component to this. 
	 * @return the input text component.
	 * @see org.aswing.plaf.AdjusterUI
	 */	
	public function getPopupSlider():JSlider{
		if(getAdjusterUI() == null){
			return null;
		}
		return getAdjusterUI().getPopupSlider();
	}
	
	/**
	 * Returns the input text component, based on the LAF, the AdjusterUI should 
	 * return the right text component to this. 
	 * @return the input text component.
	 * @see org.aswing.plaf.AdjusterUI
	 */
	public function getInputText():JTextField{
		if(getAdjusterUI() == null){
			return null;
		}
		return getAdjusterUI().getInputText();
	}	
	
	/**
	 * Sets a function(int):String to translator the value to the string representation in 
	 * the input text.
	 * <p>
	 * Generally, if you changed translator, you should change a right valueParser to suit it. 
	 * @param translator a function(int):String.
	 * @see #getValueTranslator()
	 * @see #setValueParser()
	 */
	public function setValueTranslator(translator:Int->String):Void{
		if(valueTranslator != translator){
			valueTranslator = translator;
			repaint();
		}
	}
	
	/**
	 * Returns the value translator function(int):String.
	 * @see #setValueTranslator()
	 */
	public function getValueTranslator():Int->String{
		return valueTranslator;
	}
	
	/**
	 * Sets a function(String):int to parse the value from the string in 
	 * the input text.
	 * <p>
	 * Generally, if you changed parser, you should change a right valueTranslator to suit it. 
	 * @param parser a function(String):int.
	 * @see #getValueParser()
	 * @see #setValueTranslator()
	 */
	public function setValueParser(parser:String -> Int):Void{
		if(valueParser != parser){
			valueParser = parser;
			repaint();
		}
	}
	
	/**
	 * Returns the value parser function(String):int.
	 * @see #setValueParser()
	 * @see #getValueTranslator()
	 */
	public function getValueParser():String -> Int{
		return valueParser;
	}
	
	/**
	 * Sets whether the adjuster is editable to adjust, both the input text and pop-up slider.
	 * @param b true to make the adjuster can be edited the value, no to not.
	 * @see #isEditable()
	 */
	public function setEditable(b:Bool):Void{
		if(editable != b){
			editable = b;
			repaint();
			revalidate();
		}
	}
	
	/**
	 * Returns whether the adjuster is editable.
	 * @return whether the adjuster is editable.
	 * @see #setEditable()
	 */
	public function isEditable():Bool{
		return editable;
	}
	
	/**
	 * Returns the slider's value.
	 * @return the slider's value property.
	 * @see #setValue()
	 * @see BoundedRangeModel#getValue()
	 */
	public function getValue():Int{
		return getModel().getValue();
	}
	
	/**
	 * Sets the slider's value. This method just forwards the value to the model.
	 * @param value the value to set.
	 * @see #getValue()
	 * @see BoundedRangeModel#setValue()
	 */
	public function setValue(value:Int):Void{
		var m:BoundedRangeModel = getModel();
		m.setValue(value);
	}
	
	/**
	 * Returns the "extent" -- the range of values "covered" by the knob.
	 * @return an int representing the extent
	 * @see #setExtent()
	 * @see BoundedRangeModel#getExtent()
	 */
	public function getExtent():Int{
		return getModel().getExtent();
	}
	
	/**
	 * Sets the size of the range "covered" by the knob.  Most look
	 * and feel implementations will change the value by this amount
	 * if the user clicks on either side of the knob.
	 * 
	 * @see #getExtent()
	 * @see BoundedRangeModel#setExtent()
	 */
	public function setExtent(extent:Int):Void{
		getModel().setExtent(extent);
	}
	
	/**
	 * Returns the minimum value supported by the slider (usually zero). 
	 * @return the minimum value supported by the slider
	 * @see #setMinimum()
	 * @see BoundedRangeModel#getMinimum()
	 */
	public function getMinimum():Int{
		return getModel().getMinimum();
	}
	
	/**
	 * Sets the model's minimum property. 
	 * @param minimum the minimum to set.
	 * @see #getMinimum()
	 * @see BoundedRangeModel#setMinimum()
	 */
	public function setMinimum(minimum:Int):Void{
		getModel().setMinimum(minimum);
	}
	
	/**
	 * Returns the maximum value supported by the slider.
	 * @return the maximum value supported by the slider
	 * @see #setMaximum()
	 * @see BoundedRangeModel#getMaximum()
	 */
	public function getMaximum():Int{
		return getModel().getMaximum();
	}
	
	/**
	 * Sets the model's maximum property.
	 * @param maximum the maximum to set.
	 * @see #getMaximum()
	 * @see BoundedRangeModel#setMaximum()
	 */	
	public function setMaximum(maximum:Int):Void{
		getModel().setMaximum(maximum);
	}
	
	/**
	 * True if the slider knob is being dragged. 
	 * @return the value of the model's valueIsAdjusting property
	 */
	public function getValueIsAdjusting():Bool{
		return getModel().getValueIsAdjusting();
	}
	
	/**
	 * Sets the model's valueIsAdjusting property. Slider look and feel 
	 * implementations should set this property to true when a knob drag begins, 
	 * and to false when the drag ends. The slider model will not generate 
	 * ChangeEvents while valueIsAdjusting is true. 
	 * @see BoundedRangeModel#setValueIsAdjusting()
	 */
	public function setValueIsAdjusting(b:Bool):Void{
		var m:BoundedRangeModel = getModel();
		m.setValueIsAdjusting(b);
	}
	
	/**
	 * Sets the four BoundedRangeModel properties after forcing the arguments to 
	 * obey the usual constraints: "minimum le value le value+extent le maximum" 
	 * ("le" means less or equals)
	 */
	public function setValues(newValue:Int, newExtent:Int, newMin:Int, newMax:Int):Void{
		var m:BoundedRangeModel = getModel();
		m.setRangeProperties(newValue, newExtent, newMin, newMax, m.getValueIsAdjusting());
	}
	
    /**
     * Adds a action listener to this adjuster. Adjuster fire a <code>AWEvent.ACT</code> 
     * event when user finished a adjusting.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.AWEvent#ACT
     */
    public function addActionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
    	addEventListener(AWEvent.ACT, listener, false, priority, useWeakReference);
    }
    
	/**
	 * Removes a action listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.AWEvent#ACT
	 */
	public function removeActionListener(listener:Dynamic -> Void):Void{
		removeEventListener(AWEvent.ACT, listener);
	}    	
	
	/**
	 * Adds a listener to listen the adjuster's state change event.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */	
	public function addStateListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(InteractiveEvent.STATE_CHANGED, listener, false, priority);
	}
	
	/**
	 * Removes a state listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */
	public function removeStateListener(listener:Dynamic -> Void):Void{
		removeEventListener(InteractiveEvent.STATE_CHANGED, listener);
	}
}