/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import bindx.Bind;
import org.aswing.event.InteractiveEvent;
import org.aswing.plaf.basic.BasicSliderUI;

/**
 * A component that lets the user graphically select a value by sliding
 * a knob within a bounded interval. The slider can show both 
 * major tick marks and minor tick marks between them. The number of
 * values between the tick marks is controlled with 
 * <code>this.majorTickSpacing</code> and <code>this.minorTickSpacing</code>.
 * @author paling
 */
@:event("org.aswing.event.InteractiveEvent.STATE_CHANGED", "Dispatched when the slider's state changed")
class JSlider extends Component implements Orientable implements bindx.IBindable {
    /** 
     * Horizontal orientation.
     */
    inline public static var HORIZONTAL:Int= AsWingConstants.HORIZONTAL;
    /** 
     * Vertical orientation.
     */
    inline public static var VERTICAL:Int= AsWingConstants.VERTICAL;

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
    @:bindable public var value(get, set): Int;
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

    /**
     * The major tick spacing.
     *
     * The number that is passed-in represents the distance, measured in values, between each major tick mark.
     *
     * If you have a slider with a range from 0 to 50 and the major tick spacing
     * is set to 10, you will get major ticks next to the following values:
     * 0, 10, 20, 30, 40, 50.
     */
    public var majorTickSpacing(get, set): Int;
    private var _majorTickSpacing: Int;
    private function get_majorTickSpacing(): Int { return getMajorTickSpacing(); }
    private function set_majorTickSpacing(v: Int): Int { setMajorTickSpacing(v); return v; }

    /**
     * The minor tick spacing.
     *
     * The number that is passed-in represents the distance, measured in values, between each minor tick mark.
     *
     * If you have a slider with a range from 0 to 50 and the minor tick spacing
     * is set to 10, you will get minor ticks next to the following values:
     * 0, 10, 20, 30, 40, 50.
     */
    public var minorTickSpacing(get, set): Int;
    private var _minorTickSpacing: Int;
    private function get_minorTickSpacing(): Int { return getMinorTickSpacing(); }
    private function set_minorTickSpacing(v: Int): Int { setMinorTickSpacing(v); return v; }

    /**
     * True to reverse the value-range shown for the slider and false to
     * put the value range in the normal order.
     */
    public var isInverted(get, set): Bool;
    private var _isInverted: Bool;
    private function get_isInverted(): Bool { return getInverted(); }
    private function set_isInverted(v: Bool): Bool { setInverted(v); return v; }

    /**
     * Specifying true makes the knob (and the data value it represents)
     * resolve to the closest tick mark next to where the user
     * positioned the knob.
     */
    public var snapToTicks(get, set): Bool;
    private var _snapToTicks: Bool;
    private function get_snapToTicks(): Bool { return getSnapToTicks(); }
    private function set_snapToTicks(v: Bool): Bool { setSnapToTicks(v); return v; }

    /**
     * Determines whether the track is painted on the slider.
     */
    public var paintTrack(get, set): Bool;
    private var _paintTrack: Bool;
    private function get_paintTrack(): Bool { return getPaintTrack(); }
    private function set_paintTrack(v: Bool): Bool { setPaintTrack(v); return v; }

    /**
     * Determines whether tick marks are painted on the slider.
     */
    public var paintTicks(get, set): Bool;
    private var _paintTicks: Bool;
    private function get_paintTicks(): Bool { return getPaintTicks(); }
    private function set_paintTicks(v: Bool): Bool { setPaintTicks(v); return v; }

    /**
     * A Tip component to show the value tip.
     *
     * By default there will be a <code>JToolTip</code>
     * instance created for this.
     */
    public var valueTip(get, set): JToolTip;
    private var _valueTip: JToolTip;
    private function get_valueTip(): JToolTip { return getValueTip(); }
    private function set_valueTip(v: JToolTip): JToolTip { setValueTip(v); return v; }

     /**
     * Whether to show a tip for the value when user slide the thumb.
     *
     * This is related to the LAF, different LAF may have different display for this.
     *
     * Default value is false.
     * @see #valueTip
     */
    public var showValueTip(get, set): Bool;
    private var _showValueTip: Bool;
    private function get_showValueTip(): Bool { return getShowValueTip(); }
    private function set_showValueTip(v: Bool): Bool { setShowValueTip(v); return v; }

	/**
	 * Creates a slider with the specified orientation, value, extent, minimum, and maximum. 
	 * The "extent" is the size of the viewable area. It is also known as the "visible amount". 
	 * 
	 * @param orientation the slider's orientation to either VERTICAL or HORIZONTAL. 
	 * @param min the min value
	 * @param max the max value
	 * @param value the selected value
	 */
	public function new(orientation:Int=AsWingConstants.HORIZONTAL, min:Int=0, max:Int=100, value:Int=50){
		super();
		setName("JSlider");
		_isInverted = false;
		_majorTickSpacing = 0;
		_minorTickSpacing = 0;
		_snapToTicks = false;
		_paintTrack = true;
		_paintTicks = false;
		_showValueTip = false;
	
		setOrientation(orientation);
		setModel(new DefaultBoundedRangeModel(value, 0, min, max));
		updateUI();
	}

    @:dox(hide)
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicSliderUI;
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "SliderUI";
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
		var oldValue:Int= this._orientation;
		this._orientation = orientation;
		if (orientation != oldValue){
			repaint();
			revalidate();
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
		var oldModel:BoundedRangeModel = _model;
		if (oldModel != null){
			oldModel.removeStateListener(__onModelStateChanged);
		}
		_model = newModel;
		if (_model != null){
			_model.addStateListener(__onModelStateChanged);
		}
	}
	
	private function __onModelStateChanged(event:InteractiveEvent):Void{
        if (!isAdjusting) Bind.notify(this.value, 0, value);
        dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, event.isProgrammatic()));
	}
	
	/**
     * Enables the list so that items can be selected.
     */
    @:dox(hide)
	override public function setEnabled(b:Bool):Void{
		super.setEnabled(b);
		mouseChildren = b;
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
     * @param programmatic indicate if this is a programmatic change.
	 * @see #value
	 * @see BoundedRangeModel#setValue()
	 */
	public function setValue(value:Int, programmatic:Bool=true):Void{
		var m:BoundedRangeModel = getModel();
		m.setValue(value, programmatic);
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
	public function setValues(newValue:Int, newExtent:Int, newMin:Int, newMax:Int, programmatic:Bool=true):Void{
		var m:BoundedRangeModel = getModel();
		m.setRangeProperties(newValue, newExtent, newMin, newMax, m.getValueIsAdjusting(), programmatic);
	}

    /**
     * Returns true if the value-range shown for the slider is reversed,
     *
     * @return true if the slider values are reversed from their normal order
     * @see #setInverted
     */
    @:dox(hide)
    public function getInverted():Bool{ 
        return _isInverted;
    }

    /**
     * Specify true to reverse the value-range shown for the slider and false to
     * put the value range in the normal order.  The order depends on the
     * slider's <code>ComponentOrientation</code> property.  Normal (non-inverted)
     * horizontal sliders with a <code>ComponentOrientation</code> value of 
     * <code>LEFT_TO_RIGHT</code> have their maximum on the right.  
     * Normal horizontal sliders with a <code>ComponentOrientation</code> value of
     * <code>RIGHT_TO_LEFT</code> have their maximum on the left.  Normal vertical 
     * sliders have their maximum on the top.  These labels are reversed when the 
     * slider is inverted.
     *
     * @param b  true to reverse the slider values from their normal order
     * @beaninfo
     *        bound: true
     *    attribute: visualUpdate true
     *  description: If true reverses the slider values from their normal order 
     * 
     */
    @:dox(hide)
    public function setInverted( b:Bool):Void{ 
        if (b != _isInverted) {
        	_isInverted = b;
            repaint();
        }
    }	
	
    /**
     * This method returns the major tick spacing.  The number that is returned
     * represents the distance, measured in values, between each major tick mark.
     * If you have a slider with a range from 0 to 50 and the major tick spacing
     * is set to 10, you will get major ticks next to the following values:
     * 0, 10, 20, 30, 40, 50.
     *
     * @return the number of values between major ticks
     * @see #setMajorTickSpacing()
     */
    @:dox(hide)
    public function getMajorTickSpacing():Int{ 
        return _majorTickSpacing;
    }
    
    /**
     * This method sets the major tick spacing.  The number that is passed-in
     * represents the distance, measured in values, between each major tick mark.
     * If you have a slider with a range from 0 to 50 and the major tick spacing
     * is set to 10, you will get major ticks next to the following values:
     * 0, 10, 20, 30, 40, 50.
     *
     * @see #getMajorTickSpacing()
     */
    @:dox(hide)
    public function setMajorTickSpacing(n:Int):Void{
    	if(n != _majorTickSpacing){
    		_majorTickSpacing = n;
    		if(getPaintTicks()){
    			repaint();
    		}
    	}
    }
	
    /**
     * This method returns the minor tick spacing.  The number that is returned
     * represents the distance, measured in values, between each minor tick mark.
     * If you have a slider with a range from 0 to 50 and the minor tick spacing
     * is set to 10, you will get minor ticks next to the following values:
     * 0, 10, 20, 30, 40, 50.
     *
     * @return the number of values between minor ticks
     * @see #getMinorTickSpacing
     */
    @:dox(hide)
    public function getMinorTickSpacing():Int{
        return _minorTickSpacing;
    }

    /**
     * This method sets the minor tick spacing.  The number that is passed-in
     * represents the distance, measured in values, between each minor tick mark.
     * If you have a slider with a range from 0 to 50 and the minor tick spacing
     * is set to 10, you will get minor ticks next to the following values:
     * 0, 10, 20, 30, 40, 50.
     *
     * @see #getMinorTickSpacing()
     */
    @:dox(hide)
    public function setMinorTickSpacing(n:Int):Void{
        if (_minorTickSpacing != n) {
        	_minorTickSpacing = n;
    		if(getPaintTicks()){
    			repaint();
    		}
        }
    }	

    /**
     * Specifying true makes the knob (and the data value it represents) 
     * resolve to the closest tick mark next to where the user
     * positioned the knob.
     *
     * @param b  true to snap the knob to the nearest tick mark
     * @see #getSnapToTicks()
     */
    @:dox(hide)
    public function setSnapToTicks(b:Bool):Void{
        if(b != _snapToTicks){
        	_snapToTicks = b;
        	repaint();
        }
    }    

    /**
     * Returns true if the knob (and the data value it represents) 
     * resolve to the closest tick mark next to where the user
     * positioned the knob.
     *
     * @return true if the value snaps to the nearest tick mark, else false
     * @see #setSnapToTicks()
     */
    @:dox(hide)
    public function getSnapToTicks():Bool{
        return _snapToTicks;
    }    
    
    /**
     * Tells if tick marks are to be painted.
     * @return true if tick marks are painted, else false
     * @see #setPaintTicks()
     */
    @:dox(hide)
    public function getPaintTicks():Bool{
        return _paintTicks;
    }


    /**
     * Determines whether tick marks are painted on the slider.
     * @see #getPaintTicks()
     */
    @:dox(hide)
    public function setPaintTicks(b:Bool):Void{
        if (_paintTicks != b) {
			_paintTicks = b;
            revalidate();
            repaint();
        }
    }

    /**
     * Tells if the track (area the slider slides in) is to be painted.
     * @return true if track is painted, else false
     * @see #setPaintTrack()
     */
    @:dox(hide)
    public function getPaintTrack():Bool{
        return _paintTrack;
    }


    /**
     * Determines whether the track is painted on the slider.
     * @see #getPaintTrack()
     */
    @:dox(hide)
    public function setPaintTrack(b:Bool):Void{
        if (_paintTrack != b) {
        	_paintTrack = b;
            repaint();
        }
    }
    
    /**
     * Sets whether show a tip for the value when user slide the thumb.
     * This is related to the LAF, different LAF may have different display for this.
     * Default value is false.
     * @param b true to set to show tip for value, false indicate not show tip.
     * @see #getShowValueTip()
     */
    @:dox(hide)
    public function setShowValueTip(b:Bool):Void{
    	if(_showValueTip != b){
    		_showValueTip = b;
    		if(_showValueTip)	{
    			if(_valueTip == null){
    				createDefaultValueTip();
    			}
    		}else{
    			if(_valueTip != null && _valueTip.isShowing()){
    				_valueTip.disposeToolTip();
    			}
    		}
    	}
    }
    
    /**
     * Returns whether show a tip for the value when user slide the thumb.
     * This is related to the LAF, different LAF may have different display for this.
     * Default value is false.
     * @return whether show a tip for the value when user slide the thumb.
     * @see #setShowValueTip()
     */
    @:dox(hide)
    public function getShowValueTip():Bool{
    	if(_showValueTip && _valueTip == null){
    		createDefaultValueTip();
    	}
    	return _showValueTip;
    }
    
    /**
     * Returns the <code>JToolTip</code> which is used to show the value tip.
     * This may return null if the slider had never set to showValueTip.
     * @return the <code>JToolTip</code> which is used to show the value tip.
     * @see #setShowValueTip()
     * @see #setValueTip()
     */
    @:dox(hide)
    public function getValueTip():JToolTip{
    	return _valueTip;
    }
    
    /**
     * Sets a Tip component to show the value tip. By default there will be a <code>JToolTip</code> 
     * instance created for this.
     * @param valueTip  the Tip component to show the value tip
     * @see #getValueTip()
     * @see #getValueTip()
     */
    @:dox(hide)
    public function setValueTip(valueTip:JToolTip):Void{
    	if(valueTip != null){
    		valueTip.setTargetComponent(this);
    	}
    	this._valueTip = valueTip;
    	if(valueTip == null && getShowValueTip()){
    		createDefaultValueTip();
    	}
    }
	
	private function createDefaultValueTip():Void{
    	_valueTip = new JToolTip();
    	_valueTip.setTargetComponent(this);
	}
	
	/**
	 * Adds a listener to listen the slider's state change event.
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