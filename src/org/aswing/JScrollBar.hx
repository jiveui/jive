/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.event.InteractiveEvent;
import org.aswing.plaf.basic.BasicScrollBarUI;
	
/**
 * Dispatched when the scrollBar's state changed. 
 * @see BoundedRangeModel
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * An implementation of a scrollbar. The user positions the knob in the scrollbar to determine the contents of 
 * the viewing area. The program typically adjusts the display so that the end of the scrollbar represents the 
 * end of the displayable contents, or 100% of the contents. The start of the scrollbar is the beginning of the 
 * displayable contents, or 0%. The position of the knob within those bounds then translates to the corresponding 
 * percentage of the displayable contents. 
 * <p>
 * Typically, as the position of the knob in the scrollbar changes a corresponding change is 
 * made to the position of the JViewport on the underlying view, changing the contents of the 
 * JViewport.
 * </p>
 * @author paling
 */	
class JScrollBar extends Component  implements Orientable{
	
    /** 
     * Horizontal orientation.
     */
    inline public static var HORIZONTAL:Int= AsWingConstants.HORIZONTAL;
    /** 
     * Vertical orientation.
     */
    inline public static var VERTICAL:Int= AsWingConstants.VERTICAL;
	       	
	private var model:BoundedRangeModel;
	private var orientation:Float;
	private var unitIncrement:Float;
	private var blockIncrement:Float;

	/**
	 * JScrollBar(orientation:Number, value:Number, extent:Number, min:Number, max:Number)<br>
	 * JScrollBar(orientation:Number) default to value=0, extent=10, min=0, max=100<br>
	 * <p>
	 * Creates a scrollbar with the specified orientation, value, extent, minimum, and maximum. 
	 * The "extent" is the size of the viewable area. It is also known as the "visible amount". 
	 * <p>
	 * Note: Use setBlockIncrement to set the block increment to a size slightly smaller than 
	 * the view's extent. That way, when the user jumps the knob to an adjacent position, one 
	 * or two lines of the original contents remain in view. 
	 * 
	 * @param orientation the scrollbar's orientation to either VERTICAL or HORIZONTAL. 
	 * @param value
	 * @param extent
	 * @param min
	 * @param max
	 */
	public function new(orientation:Int=AsWingConstants.VERTICAL, 
		value:Int=0, extent:Int=10, min:Int=0, max:Int=100){
		super();
		setName("JScrollBar");
		unitIncrement = 1;
		blockIncrement = (extent == 0 ? 10 : extent);
		setOrientation(orientation);
		setModel(new DefaultBoundedRangeModel(value, extent, min, max));
		updateUI();
	}
	
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicScrollBarUI;
    }
	
	override public function getUIClassID():String{
		return "ScrollBarUI";
	}
	
	/**
	 * @return the orientation.
	 */
	public function getOrientation():Int{
		return Std.int(orientation);
	}
	
	/**
	 * Sets the orientation.
	 */
	public function setOrientation(orientation:Int):Void{
		var oldValue:Int= Std.int(this.orientation);
		this.orientation = orientation;
		if (orientation != oldValue){
			revalidate();
			repaint();
		}
	}
	
	/**
	 * Returns data model that handles the scrollbar's four fundamental properties: minimum, maximum, value, extent.
	 * @return the data model
	 */
	public function getModel():BoundedRangeModel{
		return model;
	}
	
	/**
	 * Sets the model that handles the scrollbar's four fundamental properties: minimum, maximum, value, extent. 
	 * @param the data model
	 */
	public function setModel(newModel:BoundedRangeModel):Void{
		if (model != null){
			model.removeStateListener(__modelStateListener);
		}
		model = newModel;
		if (model != null){
			model.addStateListener(__modelStateListener);
		}
	}
	
	/**
	 * Sets the unit increment
	 * @param unitIncrement the unit increment
	 * @see #getUnitIncrement()
	 */
	public function setUnitIncrement(unitIncrement:Int):Void{
		this.unitIncrement = unitIncrement;
	}
	
	/**
	 * Returns the amount to change the scrollbar's value by, given a unit up/down request. 
	 * A ScrollBarUI implementation typically calls this method when the user clicks on a 
	 * scrollbar up/down arrow and uses the result to update the scrollbar's value. 
	 * Subclasses my override this method to compute a value, e.g. the change required 
	 * to scroll up or down one (variable height) line text or one row in a table.
	 * <p>
	 * The JScrollPane component creates scrollbars (by default) that then
	 * set the unit increment by the viewport, if it has one. The {@link Viewportable} interface 
	 * provides a method to return the unit increment.
	 * 
	 * @return the unit increment
	 * @see org.aswing.JScrollPane
	 * @see org.aswing.Viewportable
	 */
	public function getUnitIncrement():Int{
		return Std.int(unitIncrement);
	}
	
	/**
	 * Sets the block increment.
	 * @param blockIncrement the block increment.
	 * @see #getBlockIncrement()
	 */
	public function setBlockIncrement(blockIncrement:Int):Void{
		this.blockIncrement = blockIncrement;
	}
	
	/**
	 * Returns the amount to change the scrollbar's value by, given a block (usually "page") 
	 * up/down request. A ScrollBarUI implementation typically calls this method when the 
	 * user clicks above or below the scrollbar "knob" to change the value up or down by 
	 * large amount. Subclasses my override this method to compute a value, e.g. the change 
	 * required to scroll up or down one paragraph in a text document. 
	 * <p>
	 * The JScrollPane component creates scrollbars (by default) that then
	 * set the block increment by the viewport, if it has one. The {@link Viewportable} interface 
	 * provides a method to return the block increment.
	 * 
	 * @return the block increment
	 * @see JScrollPane
	 * @see Viewportable
	 */
	public function getBlockIncrement():Int{
		return Std.int(blockIncrement);
	}
	
	/**
	 * Returns the scrollbar's value.
	 * @return the scrollbar's value property.
	 * @see #setValue()
	 * @see BoundedRangeModel#getValue()
	 */
	public function getValue():Int{
		return getModel().getValue();
	}
	
	/**
	 * Sets the scrollbar's value. This method just forwards the value to the model.
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
	 * Returns the scrollbar's extent. In many scrollbar look and feel 
	 * implementations the size of the scrollbar "knob" or "thumb" is proportional to the extent. 
	 * @return the scrollbar's extent.
	 * @see #setVisibleAmount()
	 * @see BoundedRangeModel#getExtent()
	 */
	public function getVisibleAmount():Int{
		return getModel().getExtent();
	}
	
	/**
	 * Set the model's extent property.
	 * @param extent the extent to set
	 * @see #getVisibleAmount()
	 * @see BoundedRangeModel#setExtent()
	 */
	public function setVisibleAmount(extent:Int):Void{
		getModel().setExtent(extent);
	}
	
	/**
	 * Returns the minimum value supported by the scrollbar (usually zero). 
	 * @return the minimum value supported by the scrollbar
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
	 * Returns the maximum value supported by the scrollbar.
	 * @return the maximum value supported by the scrollbar
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
	 * True if the scrollbar knob is being dragged. 
	 * @return the value of the model's valueIsAdjusting property
	 */
	public function getValueIsAdjusting():Bool{
		return getModel().getValueIsAdjusting();
	}
	
	/**
	 * Sets the model's valueIsAdjusting property. Scrollbar look and feel 
	 * implementations should set this property to true when a knob drag begins, 
	 * and to false when the drag ends. The scrollbar model will not generate 
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
	 * Adds a listener to listen the scrollBar's state change event.
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
		
	private function __modelStateListener(event:InteractiveEvent):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, event.isProgrammatic()));
	}
	
	override public function setEnabled(b:Bool):Void{
		super.setEnabled(b);
		mouseChildren = b;
	}
	
}