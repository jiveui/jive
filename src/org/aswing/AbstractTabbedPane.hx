/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.error.Error;
import flash.events.Event; 
import org.aswing.event.InteractiveEvent;
	import org.aswing.plaf.InsetsUIResource;
	import org.aswing.plaf.UIResource;
	import org.aswing.util.ArrayUtils;
	/**
 *  Dispatched when the selected tab changed.
 *
 *  @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * An abstract class for all Container pane class that have title, icon, tip for every sub pane.
 * For example JAccordion, JTabbedPane.
 * @author paling
 */
class AbstractTabbedPane extends Container{
	
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	inline public static var CENTER:Int= AsWingConstants.CENTER;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	inline public static var TOP:Int= AsWingConstants.TOP;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var LEFT:Int= AsWingConstants.LEFT;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var BOTTOM:Int= AsWingConstants.BOTTOM;
 	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var RIGHT:Int= AsWingConstants.RIGHT;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */        
	inline public static var HORIZONTAL:Int= AsWingConstants.HORIZONTAL;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	inline public static var VERTICAL:Int= AsWingConstants.VERTICAL;
	
    private var titles:Array<Dynamic>;
    private var icons:Array<Dynamic>;
    private var tips:Array<Dynamic>;
    private var enables:Array<Dynamic>;
    private var visibles:Array<Dynamic>;
    private var model:SingleSelectionModel;
    
	// Icon/Label Alignment
    private var verticalAlignment:Int;
    private var horizontalAlignment:Int;
    private var verticalTextPosition:Int;
    private var horizontalTextPosition:Int;
    private var iconTextGap:Int;
    private var margin:Insets;
    
	public function new() {
		
		//default
		super();
		setClipMasked(true);
    	verticalAlignment = CENTER;
    	horizontalAlignment = CENTER;
    	verticalTextPosition = CENTER;
    	horizontalTextPosition = RIGHT;
    	iconTextGap = 4;
    	
		titles = new Array<Dynamic>();
		icons = new Array<Dynamic>();
		tips = new Array<Dynamic>();
		enables = new Array<Dynamic>();
		visibles = new Array<Dynamic>();
		setModel(new DefaultSingleSelectionModel());
		
		
	}
	
    /**
     * Sets the model to be used with this tabbedpane.
     * @param model the model to be used
     * @see #getModel()
     */
	public function setModel(model:SingleSelectionModel):Void{
        var oldModel:SingleSelectionModel = getModel();
        if (oldModel != null) {
            oldModel.removeStateListener(__modelStateChanged);
        }
        this.model = model;
        if (model != null) {
            model.addStateListener(__modelStateChanged);
        }
        repaint();
	}
	
    /**
     * Returns the model associated with this tabbedpane.
     * @see #setModel()
     */
	public function getModel():SingleSelectionModel{
		return model;
	}
	
	/**
	 * Adds a listener to listen the tab selection change event.
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
	
	/**
	 * Adds a component to the tabbedpane. 
	 * If constraints is a String or an Icon or an Object(object.toString() as a title), 
	 * it will be used for the tab title, 
	 * otherwise the component's name will be used as the tab title. 
	 * Shortcut of <code>insert(-1, com, constraints)</code>. 
	 * @param com  the component to be displayed when this tab is clicked
	 * @param constraints  the object to be displayed in the tab
	 * @see Container#append()
	 * @see #insert()
	 * @see #insertTab()
	 */
	override public function append(com:Component, constraints:Dynamic=null):Void{
		insert(-1, com, constraints);
	}
	
	/**
	 * Adds a component to the tabbedpane with spesified index.
	 * If constraints is a String or an Icon or an Object(object.toString() as a title), 
	 * it will be used for the tab title, 
	 * otherwise the component's name will be used as the tab title. 
	 * Cover method for insertTab. 
	 * @param i index the position at which to insert the component, or less than 0 value to append the component to the end 
	 * @param com the component to be added
	 * @param constraints the object to be displayed in the tab
	 * @see Container#insert()
	 * @see #insertTab()
	 */
	override public function insert(i:Int, com:Component, constraints:Dynamic=null):Void{
		insertImp(i, com, constraints);
	}
	
	
	/**
	 * This will call insertTab()
	 */
	override private function insertImp(i:Int, com:Component, constraints:Dynamic=null):Void{
		var title:String= null;
		var icon:Icon = null;
		if(constraints == null){
			title = com.getName();
		}else if(Std.is(constraints , String)){
			title = AsWingUtils.as(constraints , String);
		}else if(Std.is(constraints,Icon)){
			icon =AsWingUtils.as(constraints, Icon);
		}else{
			title = constraints.toString();
		}
		insertTab(i, com, title, icon, null);
	}	
	
	/**
	 * Adds a component and tip represented by a title and/or icon, either of which can be null.
	 * Shortcut of <code>insertTab(-1, com, title, icon, tip)</code>
	 * @param com The component to be displayed when this tab is clicked
	 * @param title the title to be displayed in this tab
	 * @param icon the icon to be displayed in this tab
	 * @param tip the tooltip to be displayed for this tab, can be null means no tool tip.
	 */
	public function appendTab(com:Component, title:String="", icon:Icon=null, tip:String=null):Void{
		insertTab(-1, com, title, icon, tip);
	}
	
	/**
	 * Inserts a component, at index, represented by a title and/or icon, 
	 * either of which may be null.
	 * @param i the index position to insert this new tab, less than 0 means append to the end.
	 * @param com The component to be displayed when this tab is clicked
	 * @param title the title to be displayed in this tab
	 * @param icon the icon to be displayed in this tab
	 * @param tip the tooltip to be displayed for this tab, can be null means no tool tip.
	 * @throws RangeError when index > children count
	 */
	public function insertTab(i:Int, com:Component, title:String="", icon:Icon=null, tip:String=null):Void{
		if(i > getComponentCount()){
			throw new Error("illegal component position when insert comp to container");
			 
		}
		if(i < 0){
			i = getComponentCount();
		}
		insertProperties(i, title, icon, tip);
		var currentSelectedIndex:Int= getSelectedIndex();
		var selectedIndexAfterRemove:Int= currentSelectedIndex;
		if(i <= currentSelectedIndex){
			selectedIndexAfterRemove = currentSelectedIndex + 1;
		}else if(currentSelectedIndex < 0){
			selectedIndexAfterRemove = i;
		}
		super.insertImp(i, com);
		getModel().setSelectedIndex(selectedIndexAfterRemove);
	}
	
	private function insertProperties(i:Int, title:String="", icon:Icon=null, tip:String=null):Void{
		insertToArray(titles, i, title);
		insertToArray(icons, i, icon);
		insertToArray(tips, i, tip);
		insertToArray(enables, i, true);
		insertToArray(visibles, i, true);
	}
	
	/**
	 * This will call removeTabAt()
	 */	
	override private function removeAtImp(i:Int):Component{
		return removeTabAt(i);
	}
	
	/**
	 * Removes the specified child component.
	 * After the component is removed, its visibility is reset to true to ensure it will be visible if added to other containers. 
	 * @param i the index of component.
	 * @return the component just removed, or null there is not component at this position.
	 */
	public function removeTabAt(i:Int):Component{
		if(i >= getComponentCount() || getComponentCount() < 0){
			return null;
		}
		
		removeProperties(i);
		
		var currentSelectedIndex:Int= getSelectedIndex();
		var selectedIndexAfterRemove:Int= currentSelectedIndex;
		if(i == currentSelectedIndex){
			selectedIndexAfterRemove = -1;
		}else if(i < currentSelectedIndex){
			selectedIndexAfterRemove = currentSelectedIndex - 1;
		}
		var rc:Component = super.removeAtImp(i);
		rc.setVisible(true);
		
		if(selectedIndexAfterRemove < 0){
			getModel().clearSelection();
		}else{
			getModel().setSelectedIndex(selectedIndexAfterRemove);
		}
		
		return rc;
	}
	
	private function removeProperties(i:Int):Void{
		removeFromArray(titles, i);
		removeFromArray(icons, i);
		removeFromArray(tips, i);
		removeFromArray(enables, i);
		removeFromArray(visibles, i);
	}
	
	/**
	 * Sets whether or not the tab at index is enabled. 
	 * Nothing will happen if there is no tab at that index.
	 * @param index the tab index which should be enabled/disabled
	 * @param enabled whether or not the tab should be enabled 
	 */
	public function setEnabledAt(index:Int, enabled:Bool):Void{
		if(enables[index] != enabled){
			enables[index] = enabled;
			revalidate();
			repaint();
		}
	}
	
	/**
	 * Returns whether or not the tab at index is currently enabled. 
	 * false will be returned if there is no tab at that index.
	 * @param index  the index of the item being queried 
	 * @return if the tab at index is enabled; false otherwise.
	 */
	public function isEnabledAt(index:Int):Bool{
		return enables[index] == true;
	}

	/**
	 * Sets whether or not the tab at index is visible. 
	 * Nothing will happen if there is no tab at that index.
	 * @param index the tab index which should be shown/hidden
	 * @param shown whether or not the tab should be visible 
	 */
	public function setVisibleAt(index:Int, visible:Bool):Void{
		if(visibles[index] != visible){
			visibles[index] = visible;
			revalidate();
			repaint();
		}
	}
	
	/**
	 * Returns whether or not the tab at index is currently visible. 
	 * false will be returned if there is no tab at that index.
	 * @param index  the index of the item being queried 
	 * @return if the tab at index is visible; false otherwise.
	 */
	public function isVisibleAt(index:Int):Bool{
		return visibles[index] == true;
	}
	
	/**
	 * Removes the specified child component.
	 * After the component is removed, its visibility is reset to true to ensure it will be visible if added to other containers. 
	 * 
	 * Cover method for removeTabAt. 
	 * @see Container#remove()
	 * @see #removeTabAt()
	 */
	override public function remove(com:Component):Component{
		var index:Int= getIndex(com);
		if(index >= 0){
			return removeAt(index);
		}
		return null;
	}
	
	/**
	 * Removes the specified index child component. 
	 * After the component associated with index is removed, its visibility is reset to true to ensure it will be visible if added to other containers.
	 * Cover method for removeTabAt. 
	 * @see #removeTabAt() 
	 * @see Container#removeAt()
	 */	
	override public function removeAt(index:Int):Component{
		return removeAtImp(index);
	}
	
	/**
	 * Remove all child components.
	 * After the component is removed, its visibility is reset to true to ensure it will be visible if added to other containers. 
	 * @see #removeAt()
	 * @see #removeTabAt()
	 * @see Container#removeAll()
	 */
	override public function removeAll():Void{
		while(children.length > 0){
			removeAt(children.length - 1);
		}
	}
	
	/**
	 * Returns the count of tabs.
	 */
	public function getTabCount():Int{
		return getComponentCount();
	}
	
	/**
	 * Returns the tab title at specified index. 
	 * @param i the index
	 * @return the tab title
	 */
	public function getTitleAt(i:Int):String{
		return titles[i];
	}
	
	/**
	 * Returns the tab icon at specified index. 
	 * @param i the index
	 * @return the tab icon
	 */	
	public function getIconAt(i:Int):Icon{
		return AsWingUtils.as(icons[i],Icon);
	}
	
	/**
	 * Returns the tab tool tip text at specified index. 
	 * @param i the index
	 * @return the tab tool tip text
	 */	
	public function getTipAt(i:Int):String{
		return tips[i];
	}
	
	/**
	 * Sets the title at index to title which can be null.
	 * Nothing will happen if there is no tab at that index. 
	 * @param i the index
	 * @param t the tab title
	 */
	public function setTitleAt(i:Int, t:String):Void{
		if(i < 0 || i >= getComponentCount()){
			return;
		}
		if(titles[i] != t){
			titles[i] = t;
			revalidate();
			repaint();
		}
	}
	
	/**
	 * Sets the icon at index to tab icon which can be null.
	 * Nothing will happen if there is no tab at that index. 
	 * @param i the index
	 * @param icon the tab icon
	 */	
	public function setIconAt(i:Int, icon:Icon):Void{
		if(i < 0 || i >= getComponentCount()){
			return;
		}
		if(icons[i] != icon){
			//uninstallIconWhenNextPaint(icons[i]);
			icons[i] = icon;
			revalidate();
			repaint();
		}
	}
	
	/**
	 * Sets the tool tip at index to tab tooltip which can be null.
	 * Nothing will happen if there is no tab at that index. 
	 * @param i the index
	 * @param t the tab tool tip
	 */	
	public function setTipAt(i:Int, t:String):Void{
		if(i < 0 || i >= getComponentCount()){
			return;
		}
		if(tips[i] != t){
			tips[i] = t;
			revalidate();
			repaint();
		}
	}	
	
	/**
	 * Returns the first tab index with a given title, or -1 if no tab has this title. 
	 * @param title the title for the tab 
	 * @return the first tab index which matches title, or -1 if no tab has this title
	 */
	public function indexOfTitle(title:String):Int{
		return ArrayUtils.indexInArray(titles, title);
		
	}
	
	/**
	 * Returns the first tab index with a given icon, or -1 if no tab has this icon. 
	 * @param title the title for the tab 
	 * @return the first tab index which matches icon, or -1 if no tab has this icon
	 */	
	public function indexOfIcon(icon:Icon):Int {
	 	
		return ArrayUtils.indexInArray(icons, icon);
	}
	
	/**
	 * Returns the first tab index with a given tip, or -1 if no tab has this tip. 
	 * @param title the title for the tab 
	 * @return the first tab index which matches tip, or -1 if no tab has this tip
	 */		
	public function indexOfTip(tip:String):Int{
		return ArrayUtils.indexInArray(tips, tip);
	}
	
	/**
     * Sets the selected index for this tabbedpane. The index must be
     * a valid tab index or -1, which indicates that no tab should be selected
     * (can also be used when there are no tabs in the tabbedpane).  If a -1
     * value is specified when the tabbedpane contains one or more tabs, then
     * the results will be implementation defined.
     *
     * @param index  the index to be selected
     * @param programmatic indicate if this is a programmatic change.
	 */
	public function setSelectedIndex(i:Int, programmatic:Bool=true):Void{
		if(i>=-1 && i<getComponentCount()){
			getModel().setSelectedIndex(i, programmatic);
		}
	}
	/**
     * Sets the selected component for this tabbedpane.  This
     * will automatically set the <code>selectedIndex</code> to the index
     * corresponding to the specified component.
     *
     * @param com the component to be selected
     * @param programmatic indicate if this is a programmatic change.
     * @see #getSelectedComponent()
	 */
	public function setSelectedComponent(com:Component, programmatic:Bool=true):Void{
		setSelectedIndex(getIndex(com), programmatic);
	}
	
	public function getSelectedIndex():Int{
		return getModel().getSelectedIndex();
	}
	
	public function getSelectedComponent():Component{
		var index:Int= getModel().getSelectedIndex();
		if(index >= 0){
			return getComponent(index);
		}
		return null;
	}

    /**
     * Returns the vertical alignment of the text and icon.
     *
     * @return the <code>verticalAlignment</code> property, one of the
     *		following values: 
     * <ul>
     * <li>AsWingConstants.CENTER (the default)</li>
     * <li>AsWingConstants.TOP</li>
     * <li>AsWingConstants.BOTTOM</li>
     * </ul>
     */
    public function getVerticalAlignment():Int{
        return verticalAlignment;
    }
    
    /**
     * Sets the vertical alignment of the icon and text.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)</li>
     * <li>AsWingConstants.TOP</li>
     * <li>AsWingConstants.BOTTOM</li>
     * </ul>
     */
    public function setVerticalAlignment(alignment:Int):Void{
        if (alignment == verticalAlignment){
        	return;
        }else{
        	verticalAlignment = alignment;
        	revalidate();
        	repaint();
        }
    }
    
    /**
     * Returns the horizontal alignment of the icon and text.
     * @return the <code>horizontalAlignment</code> property,
     *		one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)</li>
     * <li>AsWingConstants.LEFT</li>
     * <li>AsWingConstants.CENTER</li>
     * </ul>
     */
    public function getHorizontalAlignment():Int{
        return horizontalAlignment;
    }
    
    /**
     * Sets the horizontal alignment of the icon and text.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)</li>
     * <li>AsWingConstants.LEFT</li>
     * <li>AsWingConstants.CENTER</li>
     * </ul>
     */
    public function setHorizontalAlignment(alignment:Int):Void{
        if (alignment == horizontalAlignment){
        	return;
        }else{
        	horizontalAlignment = alignment;     
        	revalidate();
        	repaint();
        }
    }

    
    /**
     * Returns the vertical position of the text relative to the icon.
     * @return the <code>verticalTextPosition</code> property, 
     *		one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER  (the default)</li>
     * <li>AsWingConstants.TOP</li>
     * <li>AsWingConstants.BOTTOM</li>
     * </ul>
     */
    public function getVerticalTextPosition():Int{
        return verticalTextPosition;
    }
    
    /**
     * Sets the vertical position of the text relative to the icon.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)</li>
     * <li>AsWingConstants.TOP</li>
     * <li>AsWingConstants.BOTTOM</li>
     * </ul>
     */
    public function setVerticalTextPosition(textPosition:Int):Void{
        if (textPosition == verticalTextPosition){
	        return;
        }else{
        	verticalTextPosition = textPosition;
        	revalidate();
        	repaint();
        }
    }
    
    /**
     * Returns the horizontal position of the text relative to the icon.
     * @return the <code>horizontalTextPosition</code> property, 
     * 		one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)</li>
     * <li>AsWingConstants.LEFT</li>
     * <li>AsWingConstants.CENTER</li>
     * </ul>
     */
    public function getHorizontalTextPosition():Int{
        return horizontalTextPosition;
    }
    
    /**
     * Sets the horizontal position of the text relative to the icon.
     * @param textPosition one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)</li>
     * <li>AsWingConstants.LEFT</li>
     * <li>AsWingConstants.CENTER</li>
     * </ul>
     */
    public function setHorizontalTextPosition(textPosition:Int):Void{
        if (textPosition == horizontalTextPosition){
        	return;
        }else{
        	horizontalTextPosition = textPosition;
        	revalidate();
        	repaint();
        }
    }
    
    /**
     * Returns the amount of space between the text and the icon
     * displayed in this button.
     *
     * @return an int equal to the number of pixels between the text
     *         and the icon.
     * @see #setIconTextGap()
     */
    public function getIconTextGap():Int{
        return iconTextGap;
    }

    /**
     * If both the icon and text properties are set, this property
     * defines the space between them.  
     * <p>
     * The default value of this property is 4 pixels.
     * 
     * @see #getIconTextGap()
     */
    public function setIconTextGap(iconTextGap:Int):Void{
        var oldValue:Int= this.iconTextGap;
        this.iconTextGap = iconTextGap;
        if (iconTextGap != oldValue) {
            revalidate();
            repaint();
        }
    }
    
	/**
	 * Sets space for margin between the tab border and
     * the tab label.
     *
     * @param m the space between the border and the label
	 */
	public function setMargin(m:Insets):Void{
        if (m!=null && !m.equals(margin)) {
        	margin = m;
            revalidate();
            repaint();
        }
	}
	
	/**
	 * Returns the space for margin between the tab border and
     * the tab label.
	 */
	public function getMargin():Insets{
		if(margin == null){
			return new InsetsUIResource();//make it can be replaced by LAF
		}else{
			if(Std.is(margin,UIResource)){//make it can be replaced by LAF
				return new InsetsUIResource(margin.top, margin.left, margin.bottom, margin.right);
			}else{
				return new Insets(margin.top, margin.left, margin.bottom, margin.right);
			}
		}
	}    
        	
	private function __modelStateChanged(e:InteractiveEvent):Void{
		fireStateChanged(e.isProgrammatic());
	}
	
	private function fireStateChanged(programmatic:Bool):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
	}
	
    //----------------------------------------------------------------
    
	private function insertToArray(arr:Array<Dynamic>, i:Int, obj:Dynamic):Void{
		if(i < 0){
			arr.push(obj);
		}else{
			arr.insert(i,  obj);
		}
	}
	
	private function removeFromArray(arr:Array<Dynamic>, i:Int):Void{
		if(i < 0){
			arr.pop();
		}else{
			arr.splice(i, 1);
		}
	}
	
}