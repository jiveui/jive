/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import flash.display.DisplayObject; 
import org.aswing.error.Error;
import org.aswing.event.ContainerEvent;
	import org.aswing.geom.IntDimension;
//--------------------------------------
//  Events
//--------------------------------------
	
/**
 * Dispatched when a component is added to a container. 
 * The following methods trigger this event: 
 * Container.addChild(com:Component), 
 * Container.addChildAt(com:Component, index:int), 
 * Container.append(), Container.insert(). 
 * 
 * @eventType org.aswing.event.ContainerEvent.COM_ADDED
 */
// [Event(name="comAdded", type="org.aswing.event.ContainerEvent")]

/**
 * Dispatched when a component is removed from a container.
 * The following methods trigger this event: 
 * Container.removeChild(com:Component), 
 * Container.removeChildAt(com:Component, index:int), 
 * Container.remove(), Container.removeAt(). 
 *
 *  @eventType org.aswing.event.ContainerEvent.COM_REMOVED
 */
// [Event(name="comRemoved", type="org.aswing.event.ContainerEvent")]


/**
 * Container can contain many component to be his child, all children are in its bounds,
 * and it moved, all children moved. It be removed from stage all children will be removed from stage.
 * <p>
 * It for component like <code>DisplayObjectContainer</code> for <code>DisplayObject</code>.
 * </p>
 * <p>
 * <ul>
 * <li>There are two scope for <code>Container</code> children, 
 * One is <code>Component</code> children. 
 * The indices and numbers for <code>insert()</code>, <code>getComponent()</code>, 
 * <code>removeAt()</code>, <code>getComponentCount()</code> is in <code>Component</code> 
 * children scope.
 * </li>
 * <li>Another is normal <code>DisplayObject</code> children, 
 * The indices and numbers for <code>addChildAt()</code>, <code>getChildAt()</code>, 
 * <code>removeChildAt()</code> and <code>numChildren()</code> is in normal <code>DisplayObject</code> 
 * children scope.
 * </li>
 * </ul>
 * </p>
 * @author paling
 */	
class Container extends Component{
	
	private var focusTraversalPolicy:FocusTraversalPolicy;
	private var children: Array<Dynamic>;
	private var _layout:LayoutManager;

	public var layout(get, set): LayoutManager;
	private function get_layout():LayoutManager { return getLayout(); }
	private function set_layout(l:LayoutManager):LayoutManager { setLayout(l); return l; }

	public function new()
	{
		super();
		setName("Container");
		focusTraversalPolicy = null;
		children = new Array();
		_layout = new EmptyLayout();
	}

	public function setLayout(layout:LayoutManager):Void{
		this._layout = layout;
		revalidate();
	}
	
	public function getLayout():LayoutManager{
		return _layout;
	}
	
	/**
	 * Sets the focus traversal policy to this container, or sets null to 
	 * make this container use its parent's focus traversal policy.
	 * (By default, it is null)
	 * @param ftp the focus traversal policy, or null.
	 */
	public function setFocusTraversalPolicy(ftp:FocusTraversalPolicy):Void{
		focusTraversalPolicy = ftp;
	}
	
	/**
	 * Returns the focus traversal policy of this container, it will return its parent's 
	 * focus traversal policy if its self is null. If no focus traversal policy is found, 
	 * it will return a default focus traversal policy.
	 * (<code>FocusManager.getCurrentManager().getDefaultFocusTraversalPolicy()</code>).
	 * @return the focus traversal policy
	 */
	public function getFocusTraversalPolicy():FocusTraversalPolicy{
		if(focusTraversalPolicy == null){
			var ftp:FocusTraversalPolicy = null;
			if(getParent() != null){
				ftp = getParent().getFocusTraversalPolicy();
			}
			if(ftp == null){
				var fm:FocusManager = FocusManager.getManager(stage);
				if(fm != null){
					ftp = fm.getDefaultFocusTraversalPolicy();
				}
				if(ftp == null){
					ftp = new ContainerOrderFocusTraversalPolicy();
				}
			}
			return ftp;
		}else{
			return focusTraversalPolicy;
		}
	}
	
    /** 
     * Invalidates the container.  The container and all parents
     * above it are marked as needing to be laid out.  This method can
     * be called often, so it needs to execute quickly.
     * @see #validate()
     * @see #doLayout()
     * @see org.aswing.LayoutManager
     */
    override public function invalidate():Void{
    	_layout.invalidateLayout(this);
    	super.invalidate();
    }
	
    /** 
     * Validates this container and all of its subcomponents.
     * <p>
     * The <code>validate</code> method is used to cause a container
     * to lay out its subcomponents again. It should be invoked when
     * this container's subcomponents are modified (added to or
     * removed from the container, or layout-related information
     * changed) after the container has been displayed.
     *
     * @see #append()
     * @see Component#invalidate()
     * @see org.aswing.Component#revalidate()
     */
    override public function validate():Void{
    	if(!valid){
    		doLayout();
    		for(i in 0...children.length){
    			children[i].validate();
    		}
    		valid = true;
    	}
    }
    
	/**
	 * layout this container
	 */
	public function doLayout():Void{
		if(isVisible()){
			_layout.layoutContainer(this);
		}
	}
	
	/**
	 * Removes all children and then append them with their constraints.
	 * @see Component#getConstraints()
	 */
	public function reAppendChildren():Void{
		var chs: Array<Dynamic>= children.copy();
		removeAll();
		for(i in 0...chs.length){
			append(chs[i]);
		}
		revalidate();
	}
	
	/**
	 * On Component just can add to one Container.
	 * So if the com has a parent, it will remove from its parent first, then add to 
	 * this container. 
	 * This method is as same as <code>insert(-1, com, constraints)</code>.
	 * @param com the component to be added
	 * @param constraints an object expressing layout contraints for this component
	 * @see #insert()
	 */
	public function append(com:Component, constraints:Dynamic=null):Void{
	    insertImp(-1, com, constraints);
	}
	
	/**
	 * Adds one or more component to the container with null constraints
	 * @see #append()
	 */
	public function appendAll(coms: Array<Dynamic>):Void{
		for (i in 0...coms.length ){
			var com:Component = AsWingUtils.as(coms[i],Component)	;
			if(com != null){
				append(com);
			}
		}
	}
	
	/**
	 * Add component to spesified index.
	 * So if the com has a parent, it will remove from its parent first, then add to 
	 * this container. 
	 * @param i index the position at which to insert the component, or less than 0 value to append the component to the end 
	 * @param com the component to be added
	 * @param constraints an object expressing layout contraints for this component
	 * @throws RangeError when index > children count
	 * @throws ArgumentError when add container's parent(or itself) to itself
	 * @see Component#removeFromContainer()
	 * @see #append()
	 */
	public function insert(i:Int, com:Component, constraints:Dynamic=null):Void{
		insertImp(i, com, constraints);
	}
	
	/**
	 * Insets one or more component to the container with null constraints at specified starting index.
	 * @see #insert()
	 */
	public function insertAll(index:Int, coms: Array<Dynamic>):Void{
		for (i in coms ){
			var com:Component = AsWingUtils.as(i,Component)	;
			if(com != null){
				insert(index, com);
				index++;
			}
		}
	}
	
	/**
	 * @param i the index to be insert
	 * @param com the component to be insert
	 * @param constraints the layout constraints
	 * @param forceChildIndex the index to force the child to be added(for DisplayContainer scope), 
	 * 			default -1 means not force.
	 */
	private function insertImp(i:Int, com:Component, constraints:Dynamic=null):Void{
		if(i > getComponentCount()){
			throw new Error("illegal component position when insert comp to container");
			 
		}
		if(Std.is(com,Container)){
			var cn:Container = this;	
			while ( cn != null) {
				
                if (cn == com) {
                	throw new Error("adding container's parent to itself");
                }
				cn = cn.getParent();
            }
		}
		if(com.getParent() != null){
			com.removeFromContainer();
		}
		com.container = this;
		if(i < 0){
			children.push(com);
			addChild(com);
		}else{
			addChildAt(com, getChildIndexWithComponentIndex(i));
			children.insert(i, com);
		}
		_layout.addLayoutComponent(com, (constraints == null) ? com.getConstraints() : constraints);
		dispatchEvent(new ContainerEvent(ContainerEvent.COM_ADDED, this, com));
		
		if (valid) {
			revalidate();
	    }else{
	    	invalidatePreferSizeCaches();
	    }
	}
	
	/**
	 * Removes a normal display object child.
	 * <p>
	 * If <code>child</code> is a <code>Component</code> child instance, 
	 * a <code>ArgumentError</code> error will be thrown. Becasue you should call 
	 * <code>remove</code> to remove a component child.
	 * </p>
	 * @param child the child to be removed.
	 * @inheritDoc
	 * @see #remove()
	 * @throws ArgumentError if the child is a component child of this container.
	 */	
	override public function removeChild(child:DisplayObject):DisplayObject{
		checkChildRemoval(child);
		return super.removeChild(child);
	}
	
	/**
	 * Removes a normal display object child with index.
	 * <p>
	 * If <code>child</code> is a <code>Component</code> child instance, 
	 * a <code>ArgumentError</code> error will be thrown. Becasue you should call 
	 * <code>removeAt</code> to remove a component child.
	 * </p>
	 * @param index the index of the child to be removed.
	 * @inheritDoc 
	 * @see #removeAt()
	 * @throws ArgumentError if the child is a component child of this container.
	 */		
	override public function removeChildAt(index:Int):DisplayObject{
		checkChildRemoval(getChildAt(index));
		return super.removeChildAt(index);
	}
	
	private function checkChildRemoval(child:DisplayObject):Void{
		if(Std.is(child,Component)){
			var c:Component = AsWingUtils.as(child,Component)	;
			if(c.getParent() != null){
				throw new Error("You should call remove method to remove a component child!");
			}
		}
	}
	
	/**
	 * Remove the specified child component.
	 * @return the component just removed, null if the component is not in this container.
	 */
	public function remove(com:Component):Component{
		var i:Int= getIndex(com);
		if(i >= 0){
			return removeAt(i);
		}
		return null;
	}
	
	/**
	 * Remove the specified index child component.
	 * @param i the index of component.
	 * @return the component just removed. or null there is not component at this position.
	 */	
	public function removeAt(i:Int):Component{
		return removeAtImp(i);
	}
	
	private function removeAtImp(i:Int):Component{
		if(i < 0){
			return null;
		}
		var com:Component = children[i];
		if(com != null){
			children.splice(i, 1);
			super.removeChild(com);
			com.container = null;
			_layout.removeLayoutComponent(com);
			dispatchEvent(new ContainerEvent(ContainerEvent.COM_REMOVED, this, com));
			
			if (valid) {
				revalidate();
		    }else{
	    		invalidatePreferSizeCaches();
	    	}
		}
		return com;
	}
	
	
	/**
	 * Remove all child components.
	 */
	public function removeAll():Void{
		while(children.length > 0){
			removeAt(children.length - 1);
		}
	}
	public function  getComponents():Array<Dynamic> {
		return children ;
	}	
    /** 
     * Gets the nth(index) component in this container.
     * @param  n   the index of the component to get.
     * @return the n<sup>th</sup> component in this container. returned null if 
     * the index if out of bounds.  
     * @throw RangeError if index out of container children bounds
     * @see #getComponentCount()
     */
	public function getComponent(index:Int):Component{
		if(index < 0 || index >= children.length){
			throw new Error("Index out of container children bounds!!!");
		}
		return children[index];
	}
	
	/**
	 * Returns the index of the child component in this container.
	 * @return the index of the specified child component.
	 * @see #getComponent()
	 */
	public function getIndex(com:Component):Int{
		var n:Int= children.length;
		for(i in 0...n){
			if(com == children[i]){
				return i;
			}
		}
		return -1;
	}
	
    /** 
     * Gets the number of components in this container.
     * @return    the number of components in this container.
     * @see       #getComponent()
     */	
	public function getComponentCount():Int{
		return children.length;
	}
	
    /**
     * Checks if the component is contained in the component hierarchy of
     * this container.
     * @param c the component
     * @return     <code>true</code> if it is an ancestor; 
     *             <code>false</code> otherwise.
     */
    public function isAncestorOf(c:Component):Bool{
		var p:Container = c.getParent();
		if (c == null || p == null) {
		    return false;
		}
		while (p != null) {
		    if (p == this) {
				return true;
		    }
		    p = p.getParent();
		}
		return false;
    }
	
	private function getChildIndexWithComponentIndex(index:Int):Int{
		var count:Int= getComponentCount();
		if(index < 0 || index > count){
			throw new Error("Out of index counting bounds, it should be >=0 and <= component count!");
		}
		if(index == count){
			return getHighestIndexUnderForeground();
		}else{
			return getChildIndex(getComponent(index));
		}
	}
	
	private function getComponentIndexWithChildIndex(index:Int):Int{
		var count:Int= numChildren;
		if(index < 0 || index > count){
			throw new Error("Out of index counting bounds, it should be >=0 and <= numChildren!");
		}
		if(index == count){
			return getComponentCount();
		}else{
			var aboveCount:Int= 0;
			for(i in index...count){
				if(Std.is(getChildAt(i) , Component)){
					aboveCount++;
				}
			}
			return getComponentCount() - aboveCount;
		}
		return 0;
	}    
		
	/**
	 * call the ui, if ui return null, ehn call layout to count.
	 */
	override private function countMinimumSize():IntDimension{
		var size:IntDimension = null;
		if(ui != null){
			size = ui.getMinimumSize(this);
		}
		if(size == null){
			size = _layout.minimumLayoutSize(this);
		}
		if(size == null){//this should never happen
			size = super.countMinimumSize();
		}
		return size;
	}
	
	/**
	 * call the ui, if ui return null, ehn call layout to count.
	 */
	override private function countMaximumSize():IntDimension{
		var size:IntDimension = null;
		if(ui != null){
			size = ui.getMaximumSize(this);
		}
		if(size == null){
			size = _layout.maximumLayoutSize(this);
		}
		if(size == null){//this should never happen
			size = super.countMaximumSize();
		}
		return size;
	}
	
	/**
	 * call the ui, if ui return null, ehn call layout to count.
	 */
	override private function countPreferredSize():IntDimension{
		var size:IntDimension = null;
		if(ui != null){
			size = ui.getPreferredSize(this);
		}
		if(size == null){
			size = _layout.preferredLayoutSize(this);
		}
		if(size == null){//this should never happen
			size = super.countPreferredSize();
		}
		return size;
	}    
	 
	
}
