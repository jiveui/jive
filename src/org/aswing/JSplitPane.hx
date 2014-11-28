/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.plaf.SplitPaneUI;
	import flash.events.Event;
import org.aswing.event.InteractiveEvent;
	import org.aswing.plaf.basic.BasicSplitPaneUI;

/**
 * Dispatched when the divider moved.
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * <code>JSplitPane</code> is used to divide two (and only two)
 * <code>Component</code>s. The two <code>Component</code>s
 * are graphically divided based on the look and feel
 * implementation, and the two <code>Component</code>s can then be
 * interactively resized by the user.
 * 
 * The two <code>Component</code>s in a split pane can be aligned
 * left to right using
 * <code>JSplitPane.HORIZONTAL_SPLIT</code>, or top to bottom using 
 * <code>JSplitPane.VERTICAL_SPLIT</code>.
 * The preferred way to change the size of the <code>Component</code>s
 * is to invoke
 * <code>setDividerLocation</code> where <code>location</code> is either
 * the new x or y position, depending on the orientation of the
 * <code>JSplitPane</code>.
 * <p>
 * To resize the <code>Component</code>s to their preferred sizes invoke
 * <code>resetToPreferredSizes</code>.
 * <p>
 * When the user is resizing the <code>Component</code>s the minimum
 * size of the <code>Components</code> is used to determine the
 * maximum/minimum position the <code>Component</code>s
 * can be set to. If the minimum size of the two
 * components is greater than the size of the split pane the divider
 * will not allow you to resize it. To alter the minimum size of a
 * <code>JComponent</code>, see {@link JComponent#setMinimumSize}.
 * <p>
 * When the user resizes the split pane the new space is distributed between
 * the two components based on the <code>resizeWeight</code> property.
 * A value of 0,
 * the default, indicates the right/bottom component gets all the space,
 * where as a value of 1 indicates the left/top component gets all the space.
 * 
 * @author paling
 */	
class JSplitPane extends Container  implements Orientable{
	
    /**
     * Vertical split indicates the <code>Component</code>s are
     * split along the y axis.  For example the two
     * <code>Component</code>s will be split one on top of the other.
     */
    inline public static var VERTICAL_SPLIT:Int= AsWingConstants.VERTICAL;

    /**
     * Horizontal split indicates the <code>Component</code>s are
     * split along the x axis.  For example the two
     * <code>Component</code>s will be split one to the left of the
     * other.
     */
    inline public static var HORIZONTAL_SPLIT:Int= AsWingConstants.HORIZONTAL;

    /**
     * Used to add a <code>Component</code> to the left of the other
     * <code>Component</code>.
     */
    inline public static var LEFT:String= "left";

    /**
     * Used to add a <code>Component</code> to the right of the other
     * <code>Component</code>.
     */
    inline public static var RIGHT:String= "right";
    
    /**
     * Used to add a <code>Component</code> to the divider
     * <code>Component</code>.
     */
    inline public static var DIVIDER:String= "divider";
	
	private var orientation:Int;
	private var continuousLayout:Bool;
	private var leftComponent:Component;
	private var rightComponent:Component;
	private var dividerComponent:Component;
    private var oneTouchExpandable:Bool;
    private var lastDividerLocation:Int;
    private var resizeWeight:Float;
    private var dividerLocation:Int;
    private var dividerSize:Int;
	
	/**
	 * JSplitPane(orientation:int, continuousLayout:Boolean, leftComponent:Component, rightComponent:Component)<br>
	 * JSplitPane(orientation:int, continuousLayout:Boolean)<br>
	 * JSplitPane(orientation:int)<br>
	 * JSplitPane()
	 * <p>
	 * 
     * Creates a new <code>JSplitPane</code> with the specified
     * orientation and
     * redrawing style, and with the specified components.
     *
     * @param orientation  (Optional)<code>JSplitPane.HORIZONTAL_SPLIT</code> or
     *                        <code>JSplitPane.VERTICAL_SPLIT</code>.Default is <code>JSplitPane.HORIZONTAL_SPLIT</code>
     * @param continuousLayout (Optional) a boolean, true for the components to 
     *        redraw continuously as the divider changes position, false
     *        to wait until the divider position stops changing to redraw. Default is false
     * @param leftComponent (Optional)the <code>Component</code> that will
     *		appear on the left
     *        	of a horizontally-split pane, or at the top of a
     *        	vertically-split pane. Default is null.
     * @param rightComponent (Optional)the <code>Component</code> that will
     *		appear on the right
     *        	of a horizontally-split pane, or at the bottom of a
     *        	vertically-split pane. Default is null.
     */
	public function new(orientation:Int=AsWingConstants.HORIZONTAL, continuousLayout:Bool=false, leftComponent:Component=null, rightComponent:Component=null) {
		super();
		this.orientation = orientation;
		this.continuousLayout = continuousLayout;
		this.setLeftComponent(leftComponent);
		this.setRightComponent(rightComponent);
		resizeWeight = 0.5;
		lastDividerLocation = dividerLocation = 1;
		dividerSize = -1;
		oneTouchExpandable = false;
		updateUI();
	}

    override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicSplitPaneUI;
    }

	override public function getUIClassID():String{
		return "SplitPaneUI";
	}
	
    /**
     * Sets the component to the left (or above) the divider.
     *
     * @param comp the <code>Component</code> to display in that position
     */
    public function setLeftComponent(comp:Component):Void{
        if (comp == null) {
            if (leftComponent != null) {
                remove(leftComponent);
                leftComponent = null;
            }
        } else {
            append(comp, LEFT);
        }
    }


    /**
     * Returns the component to the left (or above) the divider.
     *
     * @return the <code>Component</code> displayed in that position
     */
    public function getLeftComponent():Component {
        return leftComponent;
    }


    /**
     * Sets the component above, or to the left of the divider.
     *
     * @param comp the <code>Component</code> to display in that position
     */
    public function setTopComponent(comp:Component):Void{
        setLeftComponent(comp);
    }


    /**
     * Returns the component above, or to the left of the divider.
     *
     * @return the <code>Component</code> displayed in that position
     */
    public function getTopComponent():Component {
        return leftComponent;
    }


    /**
     * Sets the component to the right (or below) the divider.
     *
     * @param comp the <code>Component</code> to display in that position
     */
    public function setRightComponent(comp:Component):Void{
        if (comp == null) {
            if (rightComponent != null) {
                remove(rightComponent);
                rightComponent = null;
            }
        } else {
            append(comp, RIGHT);
        }
    }


    /**
     * Returns the component to the right (or below) the divider.
     *
     * @return the <code>Component</code> displayed in that position
     */
    public function getRightComponent():Component {
        return rightComponent;
    }


    /**
     * Sets the component below, or to the right of the divider.
     *
     * @param comp the <code>Component</code> to display in that position
     */
    public function setBottomComponent(comp:Component):Void{
        setRightComponent(comp);
    }


    /**
     * Returns the component below, or to the right of the divider.
     *
     * @return the <code>Component</code> displayed in that position
     */
    public function getBottomComponent():Component {
        return rightComponent;
    }


    /**
     * Sets the value of the <code>oneTouchExpandable</code> property, 
     * which must be <code>true</code> for the
     * <code>JSplitPane</code> to provide a UI widget
     * on the divider to quickly expand/collapse the divider.
     * The default value of this property is <code>false</code>.
     * Some look and feels might not support one-touch expanding;
     * they will ignore this property.
     *
     * @param newValue <code>true</code> to specify that the split pane should provide a
     *        collapse/expand widget
     *
     * @see #isOneTouchExpandable()
     */
    public function setOneTouchExpandable(newValue:Bool):Void{
    	if(oneTouchExpandable != newValue){
	        oneTouchExpandable = newValue;
	        repaint();
    	}
    }


    /**
     * Gets the <code>oneTouchExpandable</code> property.
     *
     * @return the value of the <code>oneTouchExpandable</code> property
     * @see #setOneTouchExpandable()
     */
    public function isOneTouchExpandable():Bool{
        return oneTouchExpandable;
    }


    /**
     * Sets the last location the divider was at to
     * <code>newLastLocation</code>.
     *
     * @param newLastLocation an integer specifying the last divider location
     *        in pixels, from the left (or upper) edge of the pane to the 
     *        left (or upper) edge of the divider
     */
    private function setLastDividerLocation(newLastLocation:Int):Void{
        lastDividerLocation = newLastLocation;
    }
    

    /**
     * Returns the last location the divider was at.
     *
     * @return an integer specifying the last divider location as a count
     *       of pixels from the left (or upper) edge of the pane to the 
     *       left (or upper) edge of the divider
     */
    public function getLastDividerLocation():Int{
        return lastDividerLocation;
    }

    /**
     * Sets the orientation, or how the splitter is divided. The options
     * are:<ul>
     * <li>JSplitPane.VERTICAL_SPLIT  (above/below orientation of components)</li>
     * <li>JSplitPane.HORIZONTAL_SPLIT  (left/right orientation of components)</li>
     * </ul>
     *
     * @param orientation an integer specifying the orientation
     */
    public function setOrientation(ori:Int):Void{
        if(ori != orientation){
        	orientation = ori;
        	revalidate();
        	repaint();
        }
    }

    /**
     * Returns the orientation.
     * 
     * @return an integer giving the orientation
     * @see #setOrientation()
     */
    public function getOrientation():Int{
        return orientation;
    }


    /**
     * Sets the value of the <code>continuousLayout</code> property,
     * which must be <code>true</code> for the child components
     * to be continuously
     * redisplayed and laid out during user intervention.
     * The default value of this property is <code>false</code>.
     * Some look and feels might not support continuous layout;
     * they will ignore this property.
     *
     * @param newContinuousLayout  <code>true</code> if the components
     *        should continuously be redrawn as the divider changes position
     * @see #isContinuousLayout()
     */
    public function setContinuousLayout(newContinuousLayout:Bool):Void{
    	if(continuousLayout != newContinuousLayout){
        	continuousLayout = newContinuousLayout;
        	revalidate();
        	repaint();
    	}
    }


    /**
     * Gets the <code>continuousLayout</code> property.
     *
     * @return the value of the <code>continuousLayout</code> property
     * @see #setContinuousLayout()
     */
    public function isContinuousLayout():Bool{
        return continuousLayout;
    }

    /**
     * Specifies how to distribute extra space when the size of the split pane
     * changes. A value of 0, the default,
     * indicates the right/bottom component gets all the extra space (the
     * left/top component acts fixed), where as a value of 1 specifies the
     * left/top component gets all the extra space (the right/bottom component
     * acts fixed). Specifically, the left/top component gets (weight * diff)
     * extra space and the right/bottom component gets (1 - weight) * diff
     * extra space.
     *
     * @param value as described above, limit[0, 1]
     */
    public function setResizeWeight(value:Float):Void{
    	if(value < 0) value = 0;
    	else if(value > 1) value = 1;
    	
    	if(resizeWeight != value){
			resizeWeight = value;
    	}
    }

    /**
     * Returns the number that determines how extra space is distributed.
     * @return how extra space is to be distributed on a resize of the
     *         split pane
     * @see #setResizeWeight()
     */
    public function getResizeWeight():Float{
		return resizeWeight;
    }

    /**
     * Lays out the <code>JSplitPane</code> layout based on the preferred size
     * of the children components. This will likely result in changing
     * the divider location.
     */
    public function resetToPreferredSizes():Void{
        var ui:SplitPaneUI = AsWingUtils.as(getUI() , SplitPaneUI);
        if (ui != null) {
            ui.resetToPreferredSizes(this);
        }
    }

    /**
     * Sets the location of the divider. This is passed off to the 
     * look and feel implementation, and then listeners are notified. A value
     * less than 0 means collapse left/top component. A value equals 
     * AsWingConstants.MAX_VALUE means collapse right/top component.
     *
     * @param location an int specifying a UI-specific value (typically a 
     *        pixel count)
     */
    public function setDividerLocation(location:Int, programmatic:Bool=false):Void{
		var oldValue:Int= dividerLocation;
		if(oldValue != location){
			dividerLocation = location;
			// And update the last divider location.
			if(oldValue >= 0 && oldValue != AsWingConstants.MAX_VALUE){
				setLastDividerLocation(oldValue);
			}
			dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
		}
    }
		
    /**
     * Returns the last value passed to <code>setDividerLocation</code>.
     * The value returned from this method may differ from the actual
     * divider location (if <code>setDividerLocation</code> was passed a
     * value bigger than the curent size).
     *
     * @return an integer specifying the location of the divider
     */
    public function getDividerLocation():Int{
		return dividerLocation;
    }
    
    /**
     * Sets the divider's size, this size is width when the orientation is horizontal 
     * it is height when the orientation is vertical.
     * @param newSize the size of the divider
     */
    public function setDividerSize(newSize:Int):Void{
    	if(dividerSize != newSize){
    		dividerSize = newSize;
    		repaint();
    		revalidate();
    	}
    }
    
    /**
     * Returns the divider size. default it is -1, means the UI will manage this.
     * @return the divider size
     * @see #setDividerSize()
     */
    public function getDividerSize():Int{
    	return dividerSize;
    }
    
    override public function setEnabled(b:Bool):Void{
    	super.setEnabled(b);
    	if(dividerComponent!=null)	{
    		dividerComponent.setEnabled(b);
    	}
    }
    
	override private function insertImp(i:Int, com:Component, constraints:Dynamic=null):Void{
		var toRemove:Component=null;
		if(constraints == LEFT){
			toRemove = leftComponent;
			leftComponent = com;
		}else if(constraints == RIGHT){
			toRemove = rightComponent;
			rightComponent = com;
		}else if(constraints == DIVIDER){
			toRemove = dividerComponent;
			dividerComponent = com;
		}else if(leftComponent == null){
			leftComponent = com;
		}else if(rightComponent == null){
			rightComponent = com;
		}else{
			toRemove = leftComponent;
			leftComponent = com;
		}
		if(toRemove != null){
			remove(toRemove);
		}
		super.insertImp(i, com, constraints);
	}    

    /**
     * Removes the child component, <code>component</code> from the
     * pane. Resets the <code>leftComponent</code> or
     * <code>rightComponent</code> instance variable, as necessary.
     * 
     * @param component the <code>Component</code> to remove
     */
    override public function remove(component:Component):Component {
        if (component == leftComponent) {
            leftComponent = null;
        } else if (component == rightComponent) {
            rightComponent = null;
        }
        var removed:Component = super.remove(component);

        // Update the JSplitPane on the screen
        revalidate();
        repaint();
        return removed;
    }


    /**
     * Removes the <code>Component</code> at the specified index.
     * Updates the <code>leftComponent</code> and <code>rightComponent</code>
     * instance variables as necessary, and then messages super.
     *
     * @param index an integer specifying the component to remove, where
     *        1 specifies the left/top component and 2 specifies the 
     *        bottom/right component
     */
    override public function removeAt(index:Int):Component {
        var comp:Component = getComponent(index);

        if (comp == leftComponent) {
            leftComponent = null;
        } else if (comp == rightComponent) {
            rightComponent = null;
        }
        var removed:Component = super.removeAt(index);

        // Update the JSplitPane on the screen
        revalidate();
        repaint();
        return removed;
    }


    /**
     * Removes all the child components from the split pane, exclude divider. Resets the
     * <code>leftComonent</code> and <code>rightComponent</code>
     * instance variables.
     */
    override public function removeAll():Void{
        setLeftComponent(null);
        setRightComponent(null);

        // Update the JSplitPane on the screen
        revalidate();
        repaint();
    }


    /** 
     * Returns true, so that calls to <code>revalidate</code>
     * on any descendant of this <code>JSplitPane</code>
     * will cause a request to be queued that
     * will validate the <code>JSplitPane</code> and all its descendants.
     * 
     * @return true
     * @see JComponent#revalidate()
     */
    override public function isValidateRoot():Bool{
        return true;
    }
		
	
}