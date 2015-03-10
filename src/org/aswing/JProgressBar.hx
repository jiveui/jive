/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

import bindx.Bind;
import org.aswing.event.InteractiveEvent;
import org.aswing.event.AWEvent;
import org.aswing.util.Timer;
import flash.events.Event;
import org.aswing.plaf.basic.BasicProgressBarUI;

/**
 * A component that, by default, displays an integer value within a bounded 
 * interval.
 *
 * A progress bar typically communicates the progress of some
 * work by displaying its percentage of completion and possibly a textual
 * display of this percentage.
 * @author paling
 */
@:event("org.aswing.event.InteractiveEvent.STATE_CHANGED", "Dispatched when the scrollBar's state changed")
class JProgressBar extends Component  implements Orientable{

    /** 
     * Horizontal orientation.
     */
    inline public static var HORIZONTAL:Int= AsWingConstants.HORIZONTAL;
    /** 
     * Vertical orientation.
     */
    inline public static var VERTICAL:Int= AsWingConstants.VERTICAL;
	
	public var indeterminateDelay(get, set): Int;
	private function get_indeterminateDelay(): Int { return getIndeterminateDelay(); }
	private function set_indeterminateDelay(v: Int): Int { setIndeterminateDelay(v); return v; }

    public var indeterminateDelaySet(get, set): Bool;
    private var _indeterminateDelaySet: Bool;
    private function get_indeterminateDelaySet(): Bool { return isIndeterminateDelaySet(); }
    private function set_indeterminateDelaySet(v: Bool): Bool { setIndeterminateDelaySet(v); return v; }

    /**
     * The progress bar's orientation to <code>newOrientation</code>,
     * which must be <code>JProgressBar.VERTICAL</code> or
     * <code>JProgressBar.HORIZONTAL</code>. The default orientation
     * is <code>HORIZONTAL</code>.
     *
     * Note that If the orientation is set to <code>VERTICAL</code>,
     *  the progress string can only be displayable when the progress bar's font
     *  is a embedFonts.
     *
     * @see org.aswing.ASFont#getEmbedFonts()
     */
    public var orientation(get, set): Int;
    private var _orientation: Int;
    private function get_orientation(): Int { return getOrientation(); }
    private function set_orientation(v: Int): Int { setOrientation(v); return v; }

    /**
     * Determines whether the progress bar is in determinate
     * or indeterminate mode.
     *
     * An indeterminate progress bar continuously displays animation
     * indicating that an operation of unknown length is occurring.
     *
     * By default, this property is <code>false</code>.
     *
     * An indeterminate progress bar will start a <code>Timer</code> to
     * call repaint continuously when it is displayable, it make the progress can paint continuously.
     * Make sure the current <code>Icon</code> for this bar support indeterminate
     * if you set indeterminate to true.
     */
    public var indeterminate(get, set): Bool;
    private var _indeterminate: Bool;
    private function get_indeterminate(): Bool { return isIndeterminate(); }
    private function set_indeterminate(v: Bool): Bool { setIndeterminate(v); return v; }

    /**
     * The current value of the progress string.
     */
    public var string(get, set): String;
    private var _string: String;
    private function get_string(): String { return getString(); }
    private function set_string(v: String): String { setString(v); return v; }

    /**
     * The data model used by the <code>JProgressBar</code>.
     */
    @bindable public var model(get, set): BoundedRangeModel;
    private var _model: BoundedRangeModel;
    private function get_model(): BoundedRangeModel { return getModel(); }
    private function set_model(v: BoundedRangeModel): BoundedRangeModel { setModel(v); return v; }

	private var indeterminatePaintTimer:Timer;

	/**
	 * @param orient (optional)the desired orientation of the progress bar,
	 *  just can be <code>JProgressBar.HORIZONTAL</code> or <code>JProgressBar.VERTICAL</code>,
	 *  default is <code>JProgressBar.HORIZONTAL</code>
	 * @param min (optional)the minimum value of the progress bar, default is 0
	 * @param max (optional)the maximum value of the progress bar, default is 100
	 */
	public function new(orient:Int=AsWingConstants.HORIZONTAL, min:Int=0, max:Int=100) {
		super();
		setName("ProgressBar");
		
		_orientation = orient;
		_model = new DefaultBoundedRangeModel(min, 0, min, max);
		addListenerToModel();
		
		_indeterminate = false;
		_string = null;
		
		_indeterminateDelaySet = false;
		indeterminatePaintTimer = new Timer(20);
		indeterminatePaintTimer.addActionListener(__indeterminateInterval);
		addEventListener(Event.ADDED_TO_STAGE, __progressAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, __progressRemovedFromStage);
		updateUI();
	}

	@:dox(hide)
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicProgressBarUI;
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "ProgressBarUI";
	} 
	
	@:dox(hide)
    public function setIndeterminateDelay(delay:Int):Void{
		indeterminatePaintTimer.setDelay(delay);
		setIndeterminateDelaySet(true);
	}

    @:dox(hide)
	public function getIndeterminateDelay():Int{
		return indeterminatePaintTimer.getDelay();
	}
	
	public function setIndeterminateDelaySet(b:Bool):Void{
		_indeterminateDelaySet = b;
	}
	
	public function isIndeterminateDelaySet():Bool{
		return _indeterminateDelaySet;
	}
	    
	/**
     * Returns the data model used by this progress bar.
     *
     * @return the <code>BoundedRangeModel</code> currently in use
     * @see    org.aswing.BoundedRangeModel
     */
    @:dox(hide)
	public function getModel():BoundedRangeModel {
		return _model;
	}
	
    /**
     * Sets the data model used by the <code>JProgressBar</code>.
     *
     * @param  newModel the <code>BoundedRangeModel</code> to use
     */
    @:dox(hide)
	public function setModel(newModel:BoundedRangeModel):Void{
		if (_model != null){
			_model.removeStateListener(__onModelStateChanged);
		}
		_model = newModel;
		if (_model != null){
			addListenerToModel();
		}
	}
	
    /**
     * Returns the current value of the progress string.
     * @return the value of the progress string
     * @see    #setString
     */
    @:dox(hide)
	public function getString():String{
		return _string;
	}

    /**
     * Sets the value of the progress string. By default,
     * this string is <code>null</code>, will paint nothing text.
     * @param  s the value of the progress string
     * @see    #getString()
     */
    @:dox(hide)
	public function setString(s:String):Void{
		if(_string != s){
			_string = s;
			repaint();
		}
	}

    /**
     * Returns <code>JProgressBar.VERTICAL</code> or 
     * <code>JProgressBar.HORIZONTAL</code>, depending on the orientation
     * of the progress bar. The default orientation is 
     * <code>HORIZONTAL</code>.
     *
     * @return <code>HORIZONTAL</code> or <code>VERTICAL</code>
     * @see #setOrientation()
     */
    @:dox(hide)
	public function getOrientation():Int{
		return _orientation;
	}
	
    /**
     * Sets the progress bar's orientation to <code>newOrientation</code>, 
     * which must be <code>JProgressBar.VERTICAL</code> or 
     * <code>JProgressBar.HORIZONTAL</code>. The default orientation 
     * is <code>HORIZONTAL</code>.
     * <p>
     * Note that If the orientation is set to <code>VERTICAL</code>,
     *  the progress string can only be displayable when the progress bar's font 
     *  is a embedFonts.
     * 
     * @param  newOrientation  <code>HORIZONTAL</code> or <code>VERTICAL</code>
     * @see #getOrientation()
     * @see org.aswing.ASFont#getEmbedFonts()
     */
    @:dox(hide)
	public function setOrientation(newOrientation:Int):Void{
		if(newOrientation != HORIZONTAL && newOrientation!= VERTICAL){
			newOrientation = HORIZONTAL;
		}
		if(_orientation != newOrientation){
			_orientation = newOrientation;
			revalidate();
			repaint();
		}
	}
	
    /**
     * Returns the percent complete for the progress bar.
     * Note that this number is between 0.0 and 1.0.
     *
     * @return the percent complete for this progress bar
     */
    public function getPercentComplete():Float{
		var span:Int= _model.getMaximum() - _model.getMinimum();
		var currentValue:Int= _model.getValue();
		var pc:Float= (currentValue - _model.getMinimum()) / span;
		return pc;
    }
    
    /**
     * Returns the progress bar's current value,
     * which is stored in the progress bar's <code>BoundedRangeModel</code>.
     * The value is always between the 
     * minimum and maximum values, inclusive. By default, the 
     * value is initialized to be equal to the minimum value.
     *
     * @return  the current value of the progress bar
     * @see     #setValue()
     * @see     org.aswing.BoundedRangeModel#getValue()
     */
	public function getValue():Int{
		return getModel().getValue();
	}
    /**
     * Returns the progress bar's minimum value,
     * which is stored in the progress bar's <code>BoundedRangeModel</code>.
     * By default, the minimum value is <code>0</code>.
     *
     * @return  the progress bar's minimum value
     * @see     #setMinimum()
     * @see     org.aswing.BoundedRangeModel#getMinimum()
     */	
	public function getMinimum():Int{
		return getModel().getMinimum();
	}
	/**
     * Returns the progress bar's maximum value,
     * which is stored in the progress bar's <code>BoundedRangeModel</code>.
     * By default, the maximum value is <code>100</code>.
     *
     * @return  the progress bar's maximum value
     * @see     #setMaximum()
     * @see     org.aswing.BoundedRangeModel#getMaximum()
     */
	public function getMaximum():Int{
		return getModel().getMaximum();
	}
    /**
     * Sets the progress bar's current value 
     * (stored in the progress bar's data model) to <code>n</code>.
     * The data model (a <code>BoundedRangeModel</code> instance)
     * handles any mathematical
     * issues arising from assigning faulty values.
     * <p>
     * If the new value is different from the previous value,
     * all change listeners are notified.
     *
     * @param   n       the new value
     * @see     #getValue()
     * @see    #addChangeListener()
     * @see     org.aswing.BoundedRangeModel#setValue()
     */	
	public function setValue(n:Int):Void{
		getModel().setValue(n);
	}
    /**
     * Sets the progress bar's minimum value 
     * (stored in the progress bar's data model) to <code>n</code>.
     * The data model (a <code>BoundedRangeModel</code> instance)
     * handles any mathematical
     * issues arising from assigning faulty values.
     * <p>
     * If the minimum value is different from the previous minimum,
     * all change listeners are notified.
     *
     * @param  n       the new minimum
     * @see    #getMinimum()
     * @see    #addChangeListener()
     * @see    org.aswing.BoundedRangeModel#setMinimum()
     */	
	public function setMinimum(n:Int):Void{
		getModel().setMinimum(n);
	}
    /**
     * Sets the progress bar's maximum value
     * (stored in the progress bar's data model) to <code>n</code>.
     * The underlying <code>BoundedRangeModel</code> handles any mathematical
     * issues arising from assigning faulty values.
     * <p>
     * If the maximum value is different from the previous maximum,
     * all change listeners are notified.
     *
     * @param  n       the new maximum
     * @see    #getMaximum()
     * @see    #addChangeListener()
     * @see    org.aswing.BoundedRangeModel#setMaximum()
     */	
	public function setMaximum(n:Int):Void{
		getModel().setMaximum(n);
	}
    /**
     * Sets the <code>indeterminate</code> property of the progress bar,
     * which determines whether the progress bar is in determinate
     * or indeterminate mode.
     * An indeterminate progress bar continuously displays animation
     * indicating that an operation of unknown length is occurring.
     * By default, this property is <code>false</code>.
     * <p>
     * An indeterminate progress bar will start a <code>Timer</code> to 
     * call repaint continuously when it is displayable, it make the progress can paint continuously.
     * Make sure the current <code>Icon</code> for this bar support indeterminate 
     * if you set indeterminate to true.
     * <p>
     * @param newValue	<code>true</code> if the progress bar
     * 			should change to indeterminate mode;
     * 			<code>false</code> if it should revert to normal.
     *
     * @see #isIndeterminate()
     */
    @:dox(hide)
	public function setIndeterminate(newValue:Bool):Void{
		_indeterminate = newValue;
		__validateIndeterminateIntervalIfNecessary();
	}
    /**
     * Returns the value of the <code>indeterminate</code> property.
     *
     * @return the value of the <code>indeterminate</code> property
     * @see    #setIndeterminate()
     */
    @:dox(hide)
	public function isIndeterminate():Bool{
		return _indeterminate;
	}
	
	//------------------
	    
	private function addListenerToModel():Void{
		_model.addStateListener(__onModelStateChanged);
	}
	
	private function __progressAddedToStage(e:Event):Void{
		__validateIndeterminateIntervalIfNecessary();
	}
	
	private function __progressRemovedFromStage(e:Event):Void{
		__validateIndeterminateIntervalIfNecessary();
	}
	
	private function __onModelStateChanged(event:InteractiveEvent):Void{
        Bind.notify(this.model);
		repaint();
	}
	
	private function __indeterminateInterval(e:AWEvent):Void{
		repaint();
	}
	
	private function __validateIndeterminateIntervalIfNecessary():Void{
		if(isIndeterminate() && isOnStage()){
			if(!indeterminatePaintTimer.isRunning()){
				indeterminatePaintTimer.start();
			}
		}else{
			if(indeterminatePaintTimer.isRunning()){
				indeterminatePaintTimer.stop();
			}
		}
	}	
}