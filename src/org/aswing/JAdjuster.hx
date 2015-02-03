/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import bindx.Bind;
import flash.errors.Error;
import org.aswing.event.InteractiveEvent;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.AdjusterUI;
import org.aswing.plaf.basic.BasicAdjusterUI;
import org.aswing.event.AWEvent;

/**
 * A component that combine a input text and a button to drop-down a popup slider to let 
 * user input/select a value.
 * 
 * @author paling
 */
@:event("org.aswing.event.AWEvent.ACT", "Dispatched when when user finish a adjusting")
@:event("org.aswing.event.InteractiveEvent.STATE_CHANGED", "Dispatched when the adjuster's state changed")
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

    /**
	 * The model that handles the slider's four fundamental properties: minimum, maximum, value, extent.
	 */
    public var model(get, set): BoundedRangeModel;
    private var _model: BoundedRangeModel;
    private function get_model(): BoundedRangeModel { return getModel(); }
    private function set_model(v: BoundedRangeModel): BoundedRangeModel { setModel(v); return v; }

    /**
     * The slider's orientation: `JSlider.VERTICAL` or `JSlider.HORIZONTAL`.
	 */
    public var orientation(get, set): Int;
    private var _orientation: Int;
    private function get_orientation(): Int { return getOrientation(); }
    private function set_orientation(v: Int): Int { setOrientation(v); return v; }

    /**
	 * The slider's value. It just forwards the value to the model.
	 * @see #setValue()
	 * @see BoundedRangeModel#setValue()
	 */
    @bindable public var value(get, set): Int;
    private function get_value(): Int { return getValue(); }
    private function set_value(v: Int): Int { setValue(v); return v; }

    /**
     * Sets the size of the range "covered" by the knob.  Most look
     * and feel implementations will change the value by this amount
     * if the user clicks on either side of the knob.
     *
     * @see BoundedRangeModel#extent
	 */
    public var extent(get, set): Int;
    private function get_extent(): Int { return getExtent(); }
    private function set_extent(v: Int): Int { setExtent(v); return v; }

    /**
	 * The model's minimum property.
	 * @see BoundedRangeModel#minimum
	 */
    public var minimum(get, set): Int;
    private function get_minimum(): Int { return getMinimum(); }
    private function set_minimum(v: Int): Int { setMinimum(v); return v; }

    /**
	 * The model's maximum property.
	 * @see BoundedRangeModel#maximum
	 */
    public var maximum(get, set): Int;
    private function get_maximum(): Int { return getMaximum(); }
    private function set_maximum(v: Int): Int { setMaximum(v); return v; }

    /**
	 * True if the slider knob is being dragged.
	 */
    public var isAdjusting(get, null): Bool;
    private function get_isAdjusting(): Bool { return getValueIsAdjusting(); }

    public var columns(get, set): Int;
    private var _columns: Int;
    private function get_columns(): Int { return getColumns(); }
    private function set_columns(v: Int): Int { setColumns(v); return v; }

    /**
	 * Whether the adjuster is editable to adjust, both the input text and pop-up slider.
	 */
    public var editable(get, set): Bool;
    private var _editable: Bool;
    private function get_editable(): Bool { return isEditable(); }
    private function set_editable(v: Bool): Bool { setEditable(v); return v; }

    /**
	 * A function(int):String to translator the value to the string representation in
	 * the input text.
	 *
	 * Generally, if you changed translator, you should change a right valueParser to suit it.
	 * @see #valueParser
	 */
    public var valueTranslator(get, set): Int -> String;
    private var _valueTranslator: Int -> String;
    private function get_valueTranslator(): Int -> String { return getValueTranslator(); }
    private function set_valueTranslator(v: Int -> String): Int -> String { setValueTranslator(v); return v; }

    /**
	 * A function(String):int to parse the value from the string in
	 * the input text.
	 *
	 * Generally, if you changed parser, you should change a right valueTranslator to suit it.
	 * @see #valueTranslator
	 */
    public var valueParser(get, set): String -> Int;
    private var _valueParser: String -> Int;
    private function get_valueParser(): String -> Int { return getValueParser(); }
    private function set_valueParser(v: String -> Int): String -> Int { setValueParser(v); return v; }

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
		
		_editable = true;
		_valueTranslator = DEFAULT_VALUE_TRANSLATOR;
		_valueParser	 = DEFAULT_VALUE_PARSER;
		
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
    @:dox(hide)
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
    @:dox(hide)
    public function getAdjusterUI():AdjusterUI{
    	return AsWingUtils.as(getUI() , AdjusterUI);
    }

    @:dox(hide)
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicAdjusterUI;
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "AdjusterUI";
	}
	
	/**
	 * Sets the number of columns for the input text. 
	 * @param columns the number of columns to use to calculate the preferred width.
	 */
    @:dox(hide)
	public function setColumns(columns:Int):Void{
		if(columns < 0) columns = 0;
		if(this._columns != columns){
			this._columns = columns;
			if(getInputText() != null){
				getInputText().setColumns(columns);
			}
			revalidate();
		}
	}
	
	/**
	 * @see #setColumns
	 */
    @:dox(hide)
	public function getColumns():Int{
		return _columns;
	}	
	
	/**
	 * Return this slider's vertical or horizontal orientation.
	 * @return VERTICAL or HORIZONTAL
	 * @see #setOrientation()
	 */
    @:dox(hide)
	public function getOrientation():Int{
		return _orientation;
	}
	
	
	/**
	 * Set the slider's orientation to either VERTICAL or HORIZONTAL.
	 * @param orientation the orientation to either VERTICAL orf HORIZONTAL
	 */
    @:dox(hide)
	public function setOrientation(orientation:Int):Void{
		this._orientation = orientation;
		if(getPopupSlider() != null){
			getPopupSlider().setOrientation(orientation);
		}
	}
	
	/**
	 * Returns data model that handles the slider's four fundamental properties: minimum, maximum, value, extent.
	 * @return the data model
	 */
    @:dox(hide)
	public function getModel():BoundedRangeModel{
		return _model;
	}
	
	/**
	 * Sets the model that handles the slider's four fundamental properties: minimum, maximum, value, extent. 
	 * @param the data model
	 */
    @:dox(hide)
	public function setModel(newModel:BoundedRangeModel):Void{
		if (_model != null){
			_model.removeStateListener(__onModelStateChanged);
		}
		_model = newModel;
		if (_model != null){
			_model.addStateListener(__onModelStateChanged);
			if(_ui != null){
				getPopupSlider().setModel(_model);
			}
		}
	}
		
	private function __onModelStateChanged(event:InteractiveEvent):Void {
        if (!isAdjusting) Bind.notify(this.value);
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
    @:dox(hide)
	public function setValueTranslator(translator:Int->String):Void{
		if(_valueTranslator != translator){
			_valueTranslator = translator;
			repaint();
		}
	}
	
	/**
	 * Returns the value translator function(int):String.
	 * @see #setValueTranslator()
	 */
    @:dox(hide)
	public function getValueTranslator():Int->String{
		return _valueTranslator;
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
    @:dox(hide)
	public function setValueParser(parser:String -> Int):Void{
		if(_valueParser != parser){
			_valueParser = parser;
			repaint();
		}
	}
	
	/**
	 * Returns the value parser function(String):int.
	 * @see #setValueParser()
	 * @see #getValueTranslator()
	 */
    @:dox(hide)
	public function getValueParser():String -> Int{
		return _valueParser;
	}
	
	/**
	 * Sets whether the adjuster is editable to adjust, both the input text and pop-up slider.
	 * @param b true to make the adjuster can be edited the value, no to not.
	 * @see #isEditable()
	 */
    @:dox(hide)
	public function setEditable(b:Bool):Void{
		if(_editable != b){
			_editable = b;
			repaint();
			revalidate();
		}
	}
	
	/**
	 * Returns whether the adjuster is editable.
	 * @return whether the adjuster is editable.
	 * @see #setEditable()
	 */
    @:dox(hide)
	public function isEditable():Bool{
		return _editable;
	}
	
	/**
	 * Returns the slider's value.
	 * @return the slider's value property.
	 * @see #setValue()
	 * @see BoundedRangeModel#getValue()
	 */
    @:dox(hide)
	public function getValue():Int{
		return getModel().getValue();
	}
	
	/**
	 * Sets the slider's value. This method just forwards the value to the model.
	 * @param value the value to set.
	 * @see #getValue()
	 * @see BoundedRangeModel#setValue()
	 */
    @:dox(hide)
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
    @:dox(hide)
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
    @:dox(hide)
	public function setExtent(extent:Int):Void{
		getModel().setExtent(extent);
	}
	
	/**
	 * Returns the minimum value supported by the slider (usually zero). 
	 * @return the minimum value supported by the slider
	 * @see #setMinimum()
	 * @see BoundedRangeModel#getMinimum()
	 */
    @:dox(hide)
	public function getMinimum():Int{
		return getModel().getMinimum();
	}
	
	/**
	 * Sets the model's minimum property. 
	 * @param minimum the minimum to set.
	 * @see #getMinimum()
	 * @see BoundedRangeModel#setMinimum()
	 */
    @:dox(hide)
	public function setMinimum(minimum:Int):Void{
		getModel().setMinimum(minimum);
	}
	
	/**
	 * Returns the maximum value supported by the slider.
	 * @return the maximum value supported by the slider
	 * @see #setMaximum()
	 * @see BoundedRangeModel#getMaximum()
	 */
    @:dox(hide)
	public function getMaximum():Int{
		return getModel().getMaximum();
	}
	
	/**
	 * Sets the model's maximum property.
	 * @param maximum the maximum to set.
	 * @see #getMaximum()
	 * @see BoundedRangeModel#setMaximum()
	 */
    @:dox(hide)
	public function setMaximum(maximum:Int):Void{
		getModel().setMaximum(maximum);
	}
	
	/**
	 * True if the slider knob is being dragged. 
	 * @return the value of the model's valueIsAdjusting property
	 */
    @:dox(hide)
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
    @:dox(hide)
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