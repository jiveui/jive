/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.event.InteractiveEvent;
import org.aswing.plaf.basic.BasicSliderUI;

/**
 * Dispatched when the slider's state changed. 
 * @see BoundedRangeModel
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * A component that lets the user graphically select a value by sliding
 * a knob within a bounded interval. The slider can show both 
 * major tick marks and minor tick marks between them. The number of
 * values between the tick marks is controlled with 
 * <code>setMajorTickSpacing</code> and <code>setMinorTickSpacing</code>. 
 * @author paling
 */
class JSlider extends Component  implements Orientable{
    /** 
     * Horizontal orientation.
     */
    inline public static var HORIZONTAL:Int= AsWingConstants.HORIZONTAL;
    /** 
     * Vertical orientation.
     */
    inline public static var VERTICAL:Int= AsWingConstants.VERTICAL;

	private var model:BoundedRangeModel;
	private var orientation:Int;
	private var majorTickSpacing:Int;
	private var minorTickSpacing:Int;
	private var isInverted:Bool;
	private var snapToTicks:Bool;
	private var paintTrack:Bool;
	private var paintTicks:Bool;
	private var valueTip:JToolTip;
	private var showValueTip:Bool;

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
		isInverted = false;
		majorTickSpacing = 0;
		minorTickSpacing = 0;
		snapToTicks = false;
		paintTrack = true;
		paintTicks = false;
		showValueTip = false;
	
		setOrientation(orientation);
		setModel(new DefaultBoundedRangeModel(value, 0, min, max));
		updateUI();
	}

	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicSliderUI;
    }
	
	override public function getUIClassID():String{
		return "SliderUI";
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
		var oldValue:Int= this.orientation;
		this.orientation = orientation;
		if (orientation != oldValue){
			repaint();
			revalidate();
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
		var oldModel:BoundedRangeModel = model;
		if (oldModel != null){
			oldModel.removeStateListener(__onModelStateChanged);
		}
		model = newModel;
		if (model != null){
			model.addStateListener(__onModelStateChanged);
		}
	}
	
	private function __onModelStateChanged(event:InteractiveEvent):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, event.isProgrammatic()));
	}
	
	/**
     * Enables the list so that items can be selected.
     */
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
	public function getValue():Int{
		return getModel().getValue();
	}
	
	/**
	 * Sets the slider's value. This method just forwards the value to the model.
	 * @param value the value to set.
     * @param programmatic indicate if this is a programmatic change.
	 * @see #getValue()
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
    public function getInverted():Bool{ 
        return isInverted; 
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
    public function setInverted( b:Bool):Void{ 
        if (b != isInverted) {
        	isInverted = b;
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
    public function getMajorTickSpacing():Int{ 
        return majorTickSpacing; 
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
    public function setMajorTickSpacing(n:Int):Void{
    	if(n != majorTickSpacing){
    		majorTickSpacing = n;
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
    public function getMinorTickSpacing():Int{ 
        return minorTickSpacing; 
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
    public function setMinorTickSpacing(n:Int):Void{ 
        if (minorTickSpacing != n) {
        	minorTickSpacing = n;
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
    public function setSnapToTicks(b:Bool):Void{ 
        if(b != snapToTicks){
        	snapToTicks = b;
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
    public function getSnapToTicks():Bool{ 
        return snapToTicks; 
    }    
    
    /**
     * Tells if tick marks are to be painted.
     * @return true if tick marks are painted, else false
     * @see #setPaintTicks()
     */
    public function getPaintTicks():Bool{ 
        return paintTicks; 
    }


    /**
     * Determines whether tick marks are painted on the slider.
     * @see #getPaintTicks()
     */
    public function setPaintTicks(b:Bool):Void{ 
        if (paintTicks != b) {
			paintTicks = b;
            revalidate();
            repaint();
        }
    }

    /**
     * Tells if the track (area the slider slides in) is to be painted.
     * @return true if track is painted, else false
     * @see #setPaintTrack()
     */
    public function getPaintTrack():Bool{ 
        return paintTrack; 
    }


    /**
     * Determines whether the track is painted on the slider.
     * @see #getPaintTrack()
     */
    public function setPaintTrack(b:Bool):Void{ 
        if (paintTrack != b) {
        	paintTrack = b;
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
    public function setShowValueTip(b:Bool):Void{
    	if(showValueTip != b){
    		showValueTip = b;
    		if(showValueTip)	{
    			if(valueTip == null){
    				createDefaultValueTip();
    			}
    		}else{
    			if(valueTip != null && valueTip.isShowing()){
    				valueTip.disposeToolTip();
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
    public function getShowValueTip():Bool{
    	if(showValueTip && valueTip == null){
    		createDefaultValueTip();
    	}
    	return showValueTip;
    }
    
    /**
     * Returns the <code>JToolTip</code> which is used to show the value tip.
     * This may return null if the slider had never set to showValueTip.
     * @return the <code>JToolTip</code> which is used to show the value tip.
     * @see #setShowValueTip()
     * @see #setValueTip()
     */
    public function getValueTip():JToolTip{
    	return valueTip;
    }
    
    /**
     * Sets a Tip component to show the value tip. By default there will be a <code>JToolTip</code> 
     * instance created for this.
     * @param valueTip  the Tip component to show the value tip
     * @see #getValueTip()
     * @see #getValueTip()
     */
    public function setValueTip(valueTip:JToolTip):Void{
    	if(valueTip != null){
    		valueTip.setTargetComponent(this);
    	}
    	this.valueTip = valueTip;
    	if(valueTip == null && getShowValueTip()){
    		createDefaultValueTip();
    	}
    }
	
	private function createDefaultValueTip():Void{
    	valueTip = new JToolTip();
    	valueTip.setTargetComponent(this);
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