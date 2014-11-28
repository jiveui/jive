/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.error.Error;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import org.aswing.event.ListDataListener;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.event.ListDataEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.event.ListItemEvent;
	import org.aswing.event.ReleaseEvent;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.plaf.basic.BasicListUI; 
	import org.aswing.util.ArrayList;
	import org.aswing.dnd.DragManager;
	/**
 * Dispatched when the list selection changed.
 * @eventType org.aswing.event.SelectionEvent.LIST_SELECTION_CHANGED
 */
// [Event(name="listSelectionChanged", type="org.aswing.event.SelectionEvent")]

/**
 * Dispatched when the list item be click.
 * @eventType org.aswing.event.ListItemEvent.ITEM_CLICK
 */
// [Event(name="itemClick", type="org.aswing.event.ListItemEvent")]

/**
 * Dispatched when the list item be double click.
 * @eventType org.aswing.event.ListItemEvent.ITEM_DOUBLE_CLICK
 */
// [Event(name="itemDoubleClick", type="org.aswing.event.ListItemEvent")]

/**
 * Dispatched when the list item be mouse down.
 * @eventType org.aswing.event.ListItemEvent.ITEM_MOUSE_DOWN
 */
// [Event(name="itemMouseDown", type="org.aswing.event.ListItemEvent")]

/**
 * Dispatched when the list item be roll over.
 * @eventType org.aswing.event.ListItemEvent.ITEM_ROLL_OVER
 */
// [Event(name="itemRollOver", type="org.aswing.event.ListItemEvent")]

/**
 * Dispatched when the list item be roll out.
 * @eventType org.aswing.event.ListItemEvent.ITEM_ROLL_OUT
 */
// [Event(name="itemRollOut", type="org.aswing.event.ListItemEvent")]

/**
 * Dispatched when the list item be released out side.
 * @eventType org.aswing.event.ListItemEvent.ITEM_RELEASE_OUT_SIDE
 */
// [Event(name="itemReleaseOutSide", type="org.aswing.event.ListItemEvent")]

/**
 * Dispatched when the viewport's state changed. the state is all about:
 * <ul>
 * <li>view position</li>
 * <li>verticalUnitIncrement</li>
 * <li>verticalBlockIncrement</li>
 * <li>horizontalUnitIncrement</li>
 * <li>horizontalBlockIncrement</li>
 * </ul>
 * </p>
 * 
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]

/** 
 * A component that allows the user to select one or more objects from a
 * list.  A separate model, <code>ListModel</code>, represents the contents
 * of the list.  It's easy to display an array objects, using
 * a <code>JList</code> constructor that builds a <code>ListModel</code> 
 * instance for you:
 * <pre>
 * // Create a JList that displays the strings in data[]
 *
 * var data:Array = ["one", "two", "three", "four"];
 * var dataList:JList = new JList(data);
 * 
 * // The value of the JList model property is an object that provides
 * // a read-only view of the data.  It was constructed automatically.
 *
 * for(int i = 0; i < dataList.getModel().getSize(); i++) {
 *     System.out.println(dataList.getModel().getElementAt(i));
 * }
 *
 * // Create a JList that displays the values in a IVector--<code>VectorListModel</code>.
 *
 * var vec:VectorListModel = new VectorListModel(["one", "two", "three", "four"]);
 * var vecList:JList = new JList(vec);
 * 
 * //When you add elements to the vector, the JList will be automatically updated.
 * vec.append("five");
 * </pre>
 * <p>
 * <code>JList</code> doesn't support scrolling directly. 
 * To create a scrolling
 * list you make the <code>JList</code> the viewport of a
 * <code>JScrollPane</code>.  For example:
 * <pre>
 * JScrollPane scrollPane = new JScrollPane(dataList);
 * // Or in two steps:
 * JScrollPane scrollPane = new JScrollPane();
 * scrollPane.setView(dataList);
 * </pre>
 * <p>
 * By default the <code>JList</code> selection model is 
 * <code>SINGLE_SELECTION</code>.
 * <pre>
 * String[] data = {"one", "two", "three", "four"};
 * JList dataList = new JList(data);
 *
 * dataList.setSelectedIndex(1);  // select "two"
 * dataList.getSelectedValue();   // returns "two"
 * </pre>
 * <p>
 * The contents of a <code>JList</code> can be dynamic,
 * in other words, the list elements can
 * change value and the size of the list can change after the
 * <code>JList</code> has
 * been created.  The <code>JList</code> observes changes in its model with a
 * <code>ListDataListener</code> implementation.  A correct 
 * implementation of <code>ListModel</code> notifies
 * it's listeners each time a change occurs.  The changes are
 * characterized by a <code>ListDataEvent</code>, which identifies
 * the range of list indices that have been modified, added, or removed.
 * Simple dynamic-content <code>JList</code> applications can use the
 * <code>VectorListModel</code> class to store list elements.  This class
 * implements the <code>ListModel</code> and <code>IVector</code> interfaces
 * and provides the Vector API.  Applications that need to 
 * provide custom <code>ListModel</code> implementations can subclass 
 * <code>AbstractListModel</code>, which provides basic 
 * <code>ListDataListener</code> support.
 * <p>
 * <code>JList</code> uses a <code>Component</code> provision, provided by 
 * a delegate called the
 * <code>ListCell</code>, to paint the visible cells in the list.
 * <p>
 * <code>ListCell</code> created by a <code>ListCellFactory</code>, to custom 
 * the item representation of the list, you need a custom <code>ListCellFactory</code>.
 * For example a IconListCellFactory create IconListCells.
 * <p>
 * <code>ListCellFactory</code> is related to the List's performace too, see the doc 
 * comments of <code>ListCellFactory</code> for the details.
 * And if you want a horizontal scrollvar visible when item width is bigger than the visible 
 * width, you need a not <code>shareCells</code> Factory(and of course the List should located 
 * in a JScrollPane first). <code>shareCells</code> Factory 
 * can not count the maximum width of list items.
 * @author paling
 * @see ListCellFactory
 * @see ListCell
 * @see ListModel
 * @see VectorListModel
 */
class JList extends Container  implements LayoutManager implements Viewportable implements ListDataListener{
	
 	/**
 	 * The default unit/block increment, it means auto count a value.
 	 */
 	inline public static var AUTO_INCREMENT:Int= AsWingConstants.MIN_VALUE;
 	
	/**
	 * Only can select one most item at a time.
	 */
	inline public static var SINGLE_SELECTION:Int= DefaultListSelectionModel.SINGLE_SELECTION;
	/**
	 * Can select any item at a time.
	 */
	inline public static var MULTIPLE_SELECTION:Int= DefaultListSelectionModel.MULTIPLE_SELECTION;
	
	/**
	 * Drag and drop disabled.
	 */
	inline public static var DND_NONE:Int= DragManager.TYPE_NONE; 
	
	/**
	 * Drag and drop enabled, and the action of items is move.
	 */
	inline public static var DND_MOVE:Int= DragManager.TYPE_MOVE;
	
	/**
	 * Drag and drop enabled, and the action of items is copy.
	 */
	inline public static var DND_COPY:Int= DragManager.TYPE_COPY;
	
	//---------------------caches------------------
	private var viewHeight:Int;
	private var viewWidth:Int;
	private var maxWidthCell:ListCell;
	private var cellPrefferSizes:haxe.ds.IntMap<IntDimension>; //use for catche sizes when not all cells same height
	private var comToCellMap:haxe.ds.IntMap<ListCell>;
	private var visibleRowCount:Int;
	private var visibleCellWidth:Int;
	//--
	
	private var preferredWidthWhenNoCount:Int;
	
	private var tracksWidth:Bool;
	private var verticalUnitIncrement:Int;
	private var verticalBlockIncrement:Int;
	private var horizontalUnitIncrement:Int;
	private var horizontalBlockIncrement:Int;
	
	private var viewPosition:IntPoint;
	private var selectionForeground:ASColor;
	private var selectionBackground:ASColor;
	
	private var cellPane:CellPane;
	private var cellFactory:ListCellFactory;
	private var model:ListModel;
	private var selectionModel:ListSelectionModel;
	private var cells:ArrayList;
	
	private var firstVisibleIndex:Int;
	private var lastVisibleIndex:Int;
	private var firstVisibleIndexOffset:Int;
	private var lastVisibleIndexOffset:Int;
	
	private var autoDragAndDropType:Int;
	
	/**
	 * Create a list.
	 * @param listData (optional)a ListModel or a Array.
	 * @param cellFactory (optional)the cellFactory for this List.
	 */
	public function new(listData:Dynamic=null, ?cellFactory:ListCellFactory=null) {
		this.firstVisibleIndexOffset=0;
		this.lastVisibleIndexOffset=0;
			super();
		
		setName("JList");
		_layout = this;
		cellPane = new CellPane();
		append(cellPane);
		viewPosition = new IntPoint(0, 0);
		setSelectionModel(new DefaultListSelectionModel());
		firstVisibleIndex = 0;
		lastVisibleIndex = -1;
		firstVisibleIndexOffset = 0;
		lastVisibleIndexOffset = 0;
		visibleRowCount = -1;
		visibleCellWidth = -1;
		preferredWidthWhenNoCount = 20; //Default 20
		
		verticalUnitIncrement = AUTO_INCREMENT;
		verticalBlockIncrement = AUTO_INCREMENT;
		horizontalUnitIncrement = AUTO_INCREMENT;
		horizontalBlockIncrement = AUTO_INCREMENT;
		
		tracksWidth = false;
		viewWidth = 0;
		viewHeight = 0;
		maxWidthCell = null;
		cellPrefferSizes = new haxe.ds.IntMap<IntDimension>();
		comToCellMap = new haxe.ds.IntMap<ListCell>();
		cells = new ArrayList();
		model = null;
		autoDragAndDropType = DND_NONE;
		
		if(cellFactory == null){
			this.cellFactory = new DefaultListCellFactory(true);
		}
		else {
			this.cellFactory = cellFactory;
			
		}
		
		if(listData == null){
			setModel(new VectorListModel());
		}else if(Std.is(listData,Array)){
			setListData(AsWingUtils.as(listData,Array) );
		}
		else if(Std.is(listData,ListModel)){
			setModel(AsWingUtils.as(listData,ListModel)	);
		}
		updateUI();
	}
	
    override public function updateUI():Void{
    	//update cells ui
    	for(i in 0...cells.size() ){
    		var cell:ListCell = AsWingUtils.as(cells.get(i),ListCell);
    		cell.getCellComponent().updateUI();
    	}
    	
    	setUI(UIManager.getUI(this));
    }
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicListUI;
    }
    	
	override public function getUIClassID():String{
		return "ListUI";
	}
	
	
	/**
	 * Can not set layout to JList, its layout is itself.
	 * @throws ArgumentError when set any layout.
	 */
	override public function setLayout(layout:LayoutManager):Void{
		throw new  Error("Can not set layout to JList, its layout is itself!");
	}	
	
	/**
	 * Set a array to be the list data, a new model will be created and the values is copied to the model.
	 * This is not a good way, its slow. So suggest you to create a ListMode for example VectorListMode to JList,
	 * When you modify ListMode, it will automatic update JList if necessary.
	 * @see #setModel()
	 * @see org.aswing.ListModel
	 */
	public function setListData(ld:Array<Dynamic>):Void{
		var m:ListModel = new VectorListModel(ld);
		setModel(m);
	}
	
	/**
	 * Set the list mode to provide the data to JList.
	 * @see org.aswing.ListModel
	 */
	public function setModel(m:ListModel):Void{
		if(m != model){
			if(model != null){
				model.removeListDataListener(this);
			}
			model = m;
			model.addListDataListener(this);
			updateListView();
		}
	}
	
	/**
	 * @return the model of this List
	 */
	public function getModel():ListModel{
		return model;
	}

    /**
     * Sets the <code>selectionModel</code> for the list to a
     * non-<code>null</code> <code>ListSelectionModel</code>
     * implementation. The selection model handles the task of making single
     * selections, multiple selections.
     * <p>
     * @param selectionModel  the <code>ListSelectionModel</code> that
     *				implements the selections, if it is null, nothing will be done.
     * @see #getSelectionModel()
     */
	public function setSelectionModel(m:ListSelectionModel):Void{
		if(m != selectionModel){
			if(selectionModel != null){
				selectionModel.removeListSelectionListener(__selectionListener);
			}
			selectionModel = m;
			selectionModel.addListSelectionListener(__selectionListener);
		}
	}
	
    /**
     * Returns the value of the current selection model. The selection
     * model handles the task of making single selections, multiple selections.
     *
     * @return the <code>ListSelectionModel</code> that implements
     *					list selections
     * @see #setSelectionModel()
     * @see ListSelectionModel
     */
	public function getSelectionModel():ListSelectionModel{
		return selectionModel;
	}
		
	/**
	 * @return the cellFactory of this List
	 */
	public function getCellFactory():ListCellFactory{
		return cellFactory;
	}
	
	/**
	 * This will cause all cells recreating by new factory.
	 * @param newFactory the new cell factory for this List
	 */
	public function setCellFactory(newFactory:ListCellFactory):Void{
		cellFactory = newFactory;
		removeAllCells();
		updateListView();
	}
	
	/**
	 * Adds a listener to list selection changed.
	 * @param listener the listener to be add.
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.SelectionEvent
	 */	
	public function addSelectionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(SelectionEvent.LIST_SELECTION_CHANGED, listener, false, priority, useWeakReference);
	}
	
	/**
	 * Removes a listener from list selection changed listeners.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.SelectionEvent
	 */	
	public function removeSelectionListener(listener:Dynamic -> Void):Void{
		removeEventListener(SelectionEvent.LIST_SELECTION_CHANGED, listener);
	}

	/**
	 * @see #setPreferredWidthWhenNoCount()
	 * @return the default preferred with of the List when <code>shareCelles</code>.
	 */
	public function getPreferredCellWidthWhenNoCount():Int{
		return preferredWidthWhenNoCount;
	}

	/**
	 * The preferred with of the List, it is only used when List have no counting for its prefferredWidth.
	 * <p>
	 * When <code>ListCellFactory</code> is <code>shareCelles</code>, List will not count prefferred width.
	 * @param preferredWidthWhenNoCount the preferred with of the List.
	 */
	public function setPreferredCellWidthWhenNoCount(preferredWidthWhenNoCount:Int):Void{
		this.preferredWidthWhenNoCount = preferredWidthWhenNoCount;
	}	
	
	/**
	 * When your list data changed, and you want to update list view by hand.
	 * call this method.
	 * <p>This method is called automatically when setModel called with a different model to set. 
	 */
	public function updateListView() : Void{
		createCells();
		validateCells();
	}
	
	/**
	 * Clears the selection - after calling this method isSelectionEmpty will return true. 
	 * This is a convenience method that just delegates to the selectionModel.
     * @param programmatic indicate if this is a programmatic change.
	 */
	public function clearSelection(programmatic:Bool=true):Void{
		getSelectionModel().clearSelection(programmatic);
	}
	
	/**
	 * Determines whether single-item or multiple-item selections are allowed.
	 * If selection mode changed, will cause clear selection;
	 * @see #SINGLE_SELECTION
	 * @see #MULTIPLE_SELECTION
	 */
	public function setSelectionMode(sm:Int):Void{
		getSelectionModel().setSelectionMode(sm);
	}
	
	/**
	 * Return whether single-item or multiple-item selections are allowed.
	 * @see #SINGLE_SELECTION
	 * @see #MULTIPLE_SELECTION
	 */	
	public function getSelectionMode():Int{
		return getSelectionModel().getSelectionMode();
	}
	
	
    /**
     * Returns the foreground color for selected cells.
     *
     * @return the <code>Color</code> object for the foreground property
     * @see #setSelectionForeground()
     * @see #setSelectionBackground()
     */
	public function getSelectionForeground():ASColor{
		return selectionForeground;
	}
	
    /**
     * Sets the foreground color for selected cells.  Cell renderers
     * can use this color to render text and graphics for selected
     * cells.
     * <p>
     * The default value of this property is defined by the look
     * and feel implementation.
     * 
     * @param selectionForeground  the <code>Color</code> to use in the foreground
     *                             for selected list items
     * @see #getSelectionForeground()
     * @see #setSelectionBackground()
     * @see #setForeground()
     * @see #setBackground()
     * @see #setFont()
     */	
	public function setSelectionForeground(selectionForeground:ASColor):Void{
		var old:ASColor = this.selectionForeground;
		this.selectionForeground = selectionForeground;
		if (!selectionForeground.equals(old)){
			repaint();
			validateCells();
		}
	}
	
    /**
     * Returns the background color for selected cells.
     *
     * @return the <code>Color</code> used for the background of selected list items
     * @see #setSelectionBackground()
     * @see #setSelectionForeground()
     */	
	public function getSelectionBackground():ASColor{
		return selectionBackground;
	}
	
    /**
     * Sets the background color for selected cells.  Cell renderers
     * can use this color to the fill selected cells.
     * <p>
     * The default value of this property is defined by the look
     * and feel implementation.
     * @param selectionBackground  the <code>Color</code> to use for the background
     *                             of selected cells
     * @see #getSelectionBackground()
     * @see #setSelectionForeground()
     * @see #setForeground()
     * @see #setBackground()
     * @see #setFont()
     */	
	public function setSelectionBackground(selectionBackground:ASColor):Void{
		var old:ASColor = this.selectionBackground;
		this.selectionBackground = selectionBackground;
		if (!selectionBackground.equals(old)){
			repaint();
			validateCells();
		}
	}	
	
    /**
     * Returns the first index argument from the most recent 
     * <code>addSelectionModel</code> or <code>setSelectionInterval</code> call.
     * This is a convenience method that just delegates to the
     * <code>selectionModel</code>.
     *
     * @return the index that most recently anchored an interval selection
     * @see ListSelectionModel#getAnchorSelectionIndex
     * @see #addSelectionInterval()
     * @see #setSelectionInterval()
     * @see #addSelectionListener()
     */
    public function getAnchorSelectionIndex():Int{
        return getSelectionModel().getAnchorSelectionIndex();
    }

    /**
     * Returns the second index argument from the most recent
     * <code>addSelectionInterval</code> or <code>setSelectionInterval</code>
     * call.
     * This is a convenience method that just  delegates to the 
     * <code>selectionModel</code>.
     *
     * @return the index that most recently ended a interval selection
     * @see ListSelectionModel#getLeadSelectionIndex
     * @see #addSelectionInterval()
     * @see #setSelectionInterval()
     * @see #addSelectionListener()
     */
    public function getLeadSelectionIndex():Int{
        return getSelectionModel().getLeadSelectionIndex();
    }	
	
    /** 
     * @param index0 index0.
     * @param index1 index1.
     * @param programmatic indicate if this is a programmatic change.
     * @see ListSelectionModel#setSelectionInterval
     * @see #removeSelectionInterval()
     */	
	public function setSelectionInterval(index0:Int, index1:Int, programmatic:Bool = true):Void {
		getSelectionModel().setSelectionInterval(index0, index1, programmatic);
	}
	
    /** 
     * @param index0 index0.
     * @param index1 index1.
     * @param programmatic indicate if this is a programmatic change.
     * @see ListSelectionModel#addSelectionInterval()
     * @see #removeSelectionInterval()
     */	
	public function addSelectionInterval(index0:Int, index1:Int, programmatic:Bool=true):Void{
		getSelectionModel().addSelectionInterval(index0, index1, programmatic);
	}

    /** 
     * @param index0 index0.
     * @param index1 index1.
     * @param programmatic indicate if this is a programmatic change.
     * @see ListSelectionModel#removeSelectionInterval()
     */	
	public function removeSelectionInterval(index0:Int, index1:Int, programmatic:Bool=true):Void{
		getSelectionModel().removeSelectionInterval(index0, index1, programmatic);
	}
	
	/**
	 * Selects all elements in the list.
	 * 
     * @param programmatic indicate if this is a programmatic change.
	 * @see #setSelectionInterval
	 */
	public function selectAll(programmatic:Bool=true):Void{
		setSelectionInterval(0, getModel().getSize()-1, programmatic);
	}
	
	/**
	 * Return the selected index, if selection multiple, return the first.
	 * if not selected any, return -1.
	 * @return the selected index
	 */
	public function getSelectedIndex():Int{
		return getSelectionModel().getMinSelectionIndex();	
	}
	
	/**
	 * Returns true if nothing is selected.
	 * @return true if nothing is selected, false otherwise.
	 */
	public function isSelectionEmpty():Bool{
		return getSelectionModel().isSelectionEmpty();
	}
	
	/**
	 * Returns an array of all of the selected indices in increasing order.
	 * @return a array contains all selected indices
	 */
	public function getSelectedIndices():Array<Dynamic>{
		var indices:Array<Dynamic>= new Array<Dynamic>();
		var sm:ListSelectionModel = getSelectionModel();
		var min:Int= sm.getMinSelectionIndex();
		var max:Int= sm.getMaxSelectionIndex();
		if(min < 0 || max < 0 || isSelectionEmpty()){
			return indices;
		}
		for(i in min...max+1){
			if(sm.isSelectedIndex(i)){
				indices.push(i);
			}
		}
		return indices;
	}
	
	/**
	 * @return true if the index is selected, otherwise false.
	 */
	public function isSelectedIndex(index:Int):Bool{
		return getSelectionModel().isSelectedIndex(index);
	}
	
	/**
	 * Returns the first selected value, or null if the selection is empty.
	 * @return the first selected value
	 */
	public function getSelectedValue():Dynamic{
		var i:Int= getSelectedIndex();
		if(i < 0){
			return null;
		}else{
			return model.getElementAt(i);
		}
	}
	
	/**
	 * Returns an array of the values for the selected cells.
     * The returned values are sorted in increasing index order.
     * @return the selected values or an empty list if nothing is selected
	 */
	public function getSelectedValues():Array<Dynamic>{
		var values:Array<Dynamic>= new Array<Dynamic>();
		var sm:ListSelectionModel = getSelectionModel();
		var min:Int= sm.getMinSelectionIndex();
		var max:Int= sm.getMaxSelectionIndex();
		if(min < 0 || max < 0 || isSelectionEmpty()){
			return values;
		}
		var vm:ListModel = getModel();
		for(i in min...max+1){
			if(sm.isSelectedIndex(i)){
				values.push(vm.getElementAt(i));
			}
		}
		return values;
	}
	
	/**
     * Selects a single cell.
     * @param index the index to be seleted.
     * @param programmatic indicate if this is a programmatic change.
     * @see ListSelectionModel#setSelectionInterval
     * @see #isSelectedIndex()
     * @see #addSelectionListener()
	 * @see #ensureIndexIsVisible()
	 */
	public function setSelectedIndex(index:Int, programmatic:Bool=true):Void{
		if(index >= getModel().getSize()){
			return;
		}
		getSelectionModel().setSelectionInterval(index, index, programmatic);
	}
	
	/**
	 * Selects a set of cells. 
	 * <p> This will not cause a scroll, if you want to 
	 * scroll to visible the selected value, call ensureIndexIsVisible().
	 * @param indices an array of the indices of the cells to select.
     * @param programmatic indicate if this is a programmatic change.
     * @see #isSelectedIndex()
     * @see #addSelectionListener()
	 * @see #ensureIndexIsVisible()
	 */	
	public function setSelectedIndices(indices:Array<Dynamic>, programmatic:Bool=true):Void{
        var sm:ListSelectionModel = getSelectionModel();
        sm.clearSelection();
		var size:Int= getModel().getSize();
        for(i in 0...indices.length){
	    	if (indices[i] < size) {
				sm.addSelectionInterval(indices[i], indices[i], programmatic);
	    	}
        }
	}
	
	/**
	 * Selects the specified object from the list. This will not cause a scroll, if you want to 
	 * scroll to visible the selected value, call ensureIndexIsVisible().
	 * @param value the value to be selected.
     * @param programmatic indicate if this is a programmatic change.
	 * @see #setSelectedIndex()
	 * @see #ensureIndexIsVisible()
	 */
	public function setSelectedValue(value:Dynamic, programmatic:Bool=true):Void{
		var n:Int= model.getSize();
		for(i in 0...n){
			if(model.getElementAt(i) == value){
				setSelectedIndex(i, programmatic);
				return;
			}
		}
		setSelectedIndex(-1, programmatic); //there is not this value
	}
	
	/**
	 * Selects a set of cells. 
	 * <p> This will not cause a scroll, if you want to 
	 * scroll to visible the selected value, call ensureIndexIsVisible().
	 * @param values an array of the values to select.
     * @param programmatic indicate if this is a programmatic change.
     * @see #isSelectedIndex()
     * @see #addSelectionListener()
	 * @see #ensureIndexIsVisible()
	 */	
	public function setSelectedValues(values:Array<Dynamic>, programmatic:Bool=true):Void{
        var sm:ListSelectionModel = getSelectionModel();
        sm.clearSelection();
		var size:Int= getModel().getSize();
        for(i in 0...values.length){
        	for(j in 0...size){
        		if(values[i] == getModel().getElementAt(j)){
					sm.addSelectionInterval(j, j, programmatic);
					break;
        		}
        	}
        }
	}	
		
	/**
	 * Scrolls the JList to make the specified cell completely visible.
	 * @see #setFirstVisibleIndex()
	 */
	public function ensureIndexIsVisible(index:Int):Void{
		if(index<=getFirstVisibleIndex()){
			setFirstVisibleIndex(index);
		}else if(index>=getLastVisibleIndex()){
			setLastVisibleIndex(index);
		}
	}
	
	public function getFirstVisibleIndex():Int{
		return firstVisibleIndex;
	}
	
	/**
	 * scroll the list to view the specified index as first visible.
	 * If the list data elements is too short can not move the specified
	 * index to be first, just scroll as top as can.
	 * @see #ensureIndexIsVisible()
	 * @see #setLastVisibleIndex()
	 */
	public function setFirstVisibleIndex(index:Int):Void{
    	var factory:ListCellFactory = getCellFactory();
		var p:IntPoint = getViewPosition();
		if(factory.isAllCellHasSameHeight() || factory.isShareCells()){
			p.y = index * factory.getCellHeight();
		}else{
			var num:Int=Std.int( Math.min(cells.getSize()-1, index));
			var y:Int= 0;
			for(i in 0...num){
				var cell:ListCell = AsWingUtils.as(cells.get(i),ListCell);
				var s:IntDimension = getCachedCellPreferSize(cell);
				if(s == null){
					s = cell.getCellComponent().getPreferredSize();
					trace("Warnning : cell size not cached index = " + i + ", value = " + cell.getCellValue());
				}
				y += s.height;
			}
			p.y = y;
		}
		p.y = Std.int(Math.max(0, Math.min(getViewMaxPos().y, p.y)));
		setViewPosition(p);
	}
	
	public function getLastVisibleIndex():Int{
		return lastVisibleIndex;
	}
	
	/**
	 * scroll the list to view the specified index as last visible
	 * If the list data elements is too short can not move the specified
	 * index to be last, just scroll as bottom as can.
	 * @see ensureIndexIsVisible()
	 * @see setFirstVisibleIndex()
	 */
	public function setLastVisibleIndex(index:Int):Void{
    	var factory:ListCellFactory = getCellFactory();	
		var p:IntPoint = getViewPosition();
		if(factory.isAllCellHasSameHeight() || factory.isShareCells()){
			p.y = (index + 1) * factory.getCellHeight() - getExtentSize().height;
		}else{
			var num:Int= Std.int(Math.min(cells.getSize(), index+2));
			var y:Int= 0;
			for(i in 0...num){
				var cell:ListCell = AsWingUtils.as(cells.get(i),ListCell);
				var s:IntDimension = getCachedCellPreferSize(cell);
				if(s == null){
					s = cell.getCellComponent().getPreferredSize();
					trace("Warnning : cell size not cached index = " + i + ", value = " + cell.getCellValue());
				}
				y += s.height;
			}
			p.y = y - getExtentSize().height;
		}
		p.y = Std.int(Math.max(0, Math.min(getViewMaxPos().y, p.y)));
		setViewPosition(p);
	}
	
    /**
     * Returns the prefferred number of visible rows.
     *
     * @return an integer indicating the preferred number of rows to display
     *         without using a scroll bar, -1 means perffered number is <code>model.getSize()</code>
     * @see #setVisibleRowCount()
     */
	public function getVisibleRowCount():Int{
		return visibleRowCount;
	}
	
    /**
     * Sets the preferred number of rows in the list that can be displayed.
     * -1 means prefer to display all rows.
     * <p>
     * The default value of this property is -1.
     * The rowHeight will be counted as 20 if the cell factory produces not same height cells.
     * <p>
     *
     * @param visibleRowCount  an integer specifying the preferred number of
     *                         visible rows
     * @see #setVisibleCellWidth()
     * @see #getVisibleRowCount()
     */	
	public function setVisibleRowCount(c:Int):Void{
		if(c != visibleRowCount){
			visibleRowCount = c;
			revalidate();
		}
	}
	
    /**
     * Returns the preferred width of visible list pane. -1 means return the view width.
     *
     * @return an integer indicating the preferred width to display.
     * @see #setVisibleCellWidth()
     */
	public function getVisibleCellWidth():Int{
		return visibleCellWidth;
	}
	
    /**
     * Sets the preferred width the list that can be displayed.
     * <p>
     * The default value of this property is -1.
     * -1 means the width that can display all content.
     * <p>
     *
     * @param visibleRowCount  an integer specifying the preferred width.
     * @see #setVisibleRowCount()
     * @see #getVisibleCellWidth()
     * @see #setPreferredCellWidthWhenNoCount()
     */	
	public function setVisibleCellWidth(w:Int):Void{
		if(w != visibleCellWidth){
			visibleCellWidth = w;
			revalidate();
		}
	}
	
	/**
	 * Sets true to make the cell always have same width with the List container, 
	 * and the herizontal scrollbar will not shown if the list is in a <code>JScrollPane</code>; 
	 * false to make it as same as its preffered width.
	 * @param b tracks width, default value is false
	 */
	public function setTracksWidth(b:Bool):Void{
		if(b != tracksWidth){
			tracksWidth = b;
		}
	}
	
	/**
	 * Returns tracks width value.
	 * @return tracks width
	 * @see #setTracksWidth()
	 */
	public function isTracksWidth():Bool{
		return tracksWidth;
	}
	
	/**
	 * Scrolls to view bottom left content. 
	 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
	 * if it is located in a <code>JScrollPane</code>.
	 */
	public function scrollToBottomLeft():Void{
		setViewPosition(new IntPoint(0, AsWingConstants.MAX_VALUE));
	}
	/**
	 * Scrolls to view bottom right content. 
	 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
	 * if it is located in a <code>JScrollPane</code>.
	 */	
	public function scrollToBottomRight():Void{
		setViewPosition(new IntPoint(AsWingConstants.MAX_VALUE, AsWingConstants.MAX_VALUE));
	}
	/**
	 * Scrolls to view top left content. 
	 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
	 * if it is located in a <code>JScrollPane</code>.
	 */	
	public function scrollToTopLeft():Void{
		setViewPosition(new IntPoint(0, 0));
	}
	/**
	 * Scrolls to view to right content. 
	 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
	 * if it is located in a <code>JScrollPane</code>.
	 */	
	public function scrollToTopRight():Void{
		setViewPosition(new IntPoint(AsWingConstants.MAX_VALUE, 0));
	}	
	
	/**
     * Enables the list so that items can be selected.
     */
	override public function setEnabled(b:Bool):Void{
		super.setEnabled(b);
		mouseChildren = b;
	}
		
	/**
	 * Sets auto drag and drop type.
	 * @see #DND_NONE
	 * @see #DND_MOVE
	 * @see #DND_COPY
	 */
	/*public function setAutoDragAndDropType(type:int):void{
		autoDragAndDropType = type;
		if(dndListener == null){
			dndListener = new Object();
			dndListener[ON_DRAG_RECOGNIZED] = Delegate.create(this, ____onDragRecognized);
			dndListener[ON_DRAG_ENTER] = Delegate.create(this, ____onDragEnter);
			dndListener[ON_DRAG_OVERRING] = Delegate.create(this, ____onDragOverring);
			dndListener[ON_DRAG_EXIT] = Delegate.create(this, ____onDragExit);
			dndListener[ON_DRAG_DROP] = Delegate.create(this, ____onDragDrop);
		}
		removeEventListener(dndListener);
		if(isAutoDragAndDropAllown()){
			setDropTrigger(true);
			setDragEnabled(true);
			addEventListener(dndListener);
		}else{
			setDropTrigger(false);
			setDragEnabled(false);
		}
	}*/
	
	/**
	 * Returns the auto drag and drop type.
	 * @see #DND_NONE
	 * @see #DND_MOVE
	 * @see #DND_COPY
	 */
	public function getAutoDragAndDropType():Int{
		return autoDragAndDropType;
	}
	
	private function isAutoDragAndDropAllown():Bool{
		return autoDragAndDropType == DND_MOVE || autoDragAndDropType == DND_COPY;
	}
	
	/**
	 * Returns is this list allown to automatically be as an drag and drop initiator.
	 * @see #org.aswing.MutableListModel
	 * @see #DND_NONE
	 * @see #DND_MOVE
	 * @see #DND_COPY
	 */
	public function isAutoDnDInitiatorAllown():Bool{
		if(!isAutoDragAndDropAllown()){
			return false;
		}
		if(!isMutableModel()){
			return autoDragAndDropType == DND_COPY;
		}else{
			return true;
		}
	}
	
	/**
	 * Returns is this list allown to automatically be as an drag and drop target.
	 * @see #org.aswing.MutableListModel
	 * @see #DND_NONE
	 * @see #DND_MOVE
	 * @see #DND_COPY
	 */
	public function isAutoDnDDropTargetAllown():Bool{
		return isAutoDragAndDropAllown() && isMutableModel();
	}
	
	//----------------------privates-------------------------
	
	private function addCellToContainer(cell:ListCell):Void{
		cell.getCellComponent().setFocusable(false);
		cellPane.append(cell.getCellComponent());
		comToCellMap.set(cell.getCellComponent().getAwmlIndex(), cell);
		addHandlersToCell(cell.getCellComponent());
	}
	
	private function removeCellFromeContainer(cell:ListCell):Void{
		cell.getCellComponent().removeFromContainer();
		comToCellMap.remove(cell.getCellComponent().getAwmlIndex());
		removeHandlersFromCell(cell.getCellComponent());
	}
	
	private function checkCreateCellsWhenShareCells():Void{
		createCellsWhenShareCells();
	}
	
	private function createCellsWhenShareCells():Void{
		var ih:Int= getCellFactory().getCellHeight();
		var needNum:Int= Math.floor(getExtentSize().height/ih) + 2;
		
		viewWidth = getPreferredCellWidthWhenNoCount();
		viewHeight = getModel().getSize()*ih;
		
		if(cells.getSize() == needNum/* || !displayable*/){
			return;
		}
		
		var i:Int;
		var cell:ListCell;
		//create needed
		if(cells.getSize() < needNum){
			var addNum:Int= needNum - cells.getSize();
			for(i in 0...addNum){
				cell = createNewCell();
				addCellToContainer(cell);
				cells.append(cell);
			}
		}else if(cells.getSize() > needNum){ //remove mored
			var removeIndex:Int= needNum;
			var removed:Array<Dynamic>= cells.removeRange(removeIndex, cells.getSize()-1);
			for(i in 0...removed.length){
				cell = AsWingUtils.as(removed[i],ListCell);
				removeCellFromeContainer(cell);
			}
		}
	}
	
	private function createCellsWhenNotShareCells():Void{
		var factory:ListCellFactory = getCellFactory();
		var m:ListModel = getModel();
		
		var w:Int= 0;
		var h:Int= 0;
		var sameHeight:Bool= factory.isAllCellHasSameHeight();
		
		var mSize:Int= m.getSize();
		var cSize:Int= cells.getSize();
		
		cellPrefferSizes=new   haxe.ds.IntMap<IntDimension>();
		
		var n:Int=Std.int( Math.min(mSize, cSize));
		var i:Int;
		var cell:ListCell;
		var s:IntDimension;
		//reuse created cells
		for(i in 0...n){
			cell = AsWingUtils.as(cells.get(i),ListCell);
			cell.setCellValue(m.getElementAt(i));
			s = cell.getCellComponent().getPreferredSize();
			cellPrefferSizes.set(cell.getCellComponent().getAwmlIndex(), s);
			if(s.width > w){
				w = s.width;
				maxWidthCell = cell;
			}
			if(sameHeight!=true){
				h += s.height;
			}
		}
		
		//create lest needed cells
		if(mSize > cSize){
			for(i  in cSize...mSize){
				cell = createNewCell();
				cells.append(cell);
				cell.setCellValue(m.getElementAt(i));
				addCellToContainer(cell);
				s = cell.getCellComponent().getPreferredSize();
				cellPrefferSizes.set(cell.getCellComponent().getAwmlIndex(), s);
				if(s.width > w){
					w = s.width;
					maxWidthCell = cell;
				}
				if(sameHeight!=true){
					h += s.height;
				}
			}
		}else if(mSize < cSize){ //remove unwanted cells
			var removed:Array<Dynamic>= cells.removeRange(mSize, cSize-1);
			for(i in 0...removed.length){
				cell = AsWingUtils.as(removed[i],ListCell);
				removeCellFromeContainer(cell);
				cellPrefferSizes.remove(cell.getCellComponent().getAwmlIndex());
			}
		}
		
		if(sameHeight)	{
			h = m.getSize()*factory.getCellHeight();
		}
		
		viewWidth = w;
		viewHeight = h;
	}
	
	private function createNewCell():ListCell{
		return getCellFactory().createNewCell();
	}
	
	private function createCells():Void{
		if(getCellFactory().isShareCells()){
			createCellsWhenShareCells();
		}else{
			createCellsWhenNotShareCells();
		}
	}
	
	private function removeAllCells() : Void{
		for(i in 0...cells.getSize()){
			var cell:ListCell = cells.get(i);
			cell.getCellComponent().removeFromContainer();
		}
		cells.clear();
	}
	
	private function validateCells():Void{
		revalidate();
	}
	
	//--------------------------------------------------------
	
	private function fireStateChanged(programmatic:Bool=true):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
	}
	
	public function getVerticalUnitIncrement() : Int{
		if(verticalUnitIncrement != AUTO_INCREMENT){
			return verticalUnitIncrement;
		}else if(getCellFactory().isAllCellHasSameHeight()){
			return getCellFactory().getCellHeight();
		}else{
			return 18;
		}
	}

	public function getVerticalBlockIncrement() : Int{
		if(verticalBlockIncrement != AUTO_INCREMENT){
			return verticalBlockIncrement;
		}else if(getCellFactory().isAllCellHasSameHeight()){
			return getExtentSize().height - getCellFactory().getCellHeight();
		}else{
			return getExtentSize().height - 10;
		}
	}

	public function getHorizontalUnitIncrement() : Int{
		if(horizontalUnitIncrement == AUTO_INCREMENT){
			return 1;
		}else{
			return horizontalUnitIncrement;
		}
	}

	public function getHorizontalBlockIncrement() : Int{
		if(horizontalBlockIncrement == AUTO_INCREMENT){
			return getExtentSize().width - 1;
		}else{
			return horizontalBlockIncrement;
		}
	}
	
    public function setVerticalUnitIncrement(increment:Int):Void{
    	if(verticalUnitIncrement != increment){
    		verticalUnitIncrement = increment;
			fireStateChanged();
    	}
    }
    
    public function setVerticalBlockIncrement(increment:Int):Void{
    	if(verticalBlockIncrement != increment){
    		verticalBlockIncrement = increment;
			fireStateChanged();
    	}
    }
    
    public function setHorizontalUnitIncrement(increment:Int):Void{
    	if(horizontalUnitIncrement != increment){
    		horizontalUnitIncrement = increment;
			fireStateChanged();
    	}
    }
    
    public function setHorizontalBlockIncrement(increment:Int):Void{
    	if(horizontalBlockIncrement != increment){
    		horizontalBlockIncrement = increment;
			fireStateChanged();
    	}
    }
 
    public function setViewportTestSize(s:IntDimension):Void{
    	setSize(s); 
		 
    }	
		
	public function getExtentSize() : IntDimension {	
    	return getInsets().getInsideSize(getSize());
	}

	public function getViewSize() : IntDimension {
		var w:Int= isTracksWidth() ? getExtentSize().width : viewWidth;
		return new IntDimension(w, viewHeight);
	}

	public function getViewPosition() : IntPoint {
		return new IntPoint(viewPosition.x, viewPosition.y);
	}

	public function setViewPosition(p : IntPoint, programmatic:Bool=true) : Void{
		restrictionViewPos(p);
		if(!viewPosition.equals(p)){
			viewPosition.setLocation(p);
			fireStateChanged(programmatic);
			//revalidate();
			valid = false;
			RepaintManager.getInstance().addInvalidRootComponent(this);
		}
	}

	public function scrollRectToVisible(contentRect : IntRectangle, programmatic:Bool=true) : Void{
		setViewPosition(new IntPoint(contentRect.x, contentRect.y), programmatic);
	}
	
	private function restrictionViewPos(p:IntPoint):IntPoint{
		var maxPos:IntPoint = getViewMaxPos();
		p.x = Std.int(Math.max(0, Math.min(maxPos.x, p.x)));
		p.y = Std.int(Math.max(0, Math.min(maxPos.y, p.y)));
		return p;
	}
	
	private function getViewMaxPos():IntPoint{
		var showSize:IntDimension = getExtentSize();
		var viewSize:IntDimension = getViewSize();
		var p:IntPoint = new IntPoint(viewSize.width-showSize.width, viewSize.height-showSize.height);
		if(p.x < 0) p.x = 0;
		if(p.y < 0) p.y = 0;
		return p;
	}

	/**
	 * Add a listener to listen the viewpoat state change event.
	 * <p>
	 * When the viewpoat's state changed, the state is all about:
	 * <ul>
	 * <li>viewPosition</li>
	 * <li>verticalUnitIncrement</li>
	 * <li>verticalBlockIncrement</li>
	 * <li>horizontalUnitIncrement</li>
	 * <li>horizontalBlockIncrement</li>
	 * </ul>
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
	 * @see org.aswing.event.AWEvent#STATE_CHANGED
	 */	
	public function removeStateListener(listener:Dynamic -> Void):Void{
		removeEventListener(InteractiveEvent.STATE_CHANGED, listener);
	}

	public function getViewportPane() : Component {
		return this;
	}
	//------------------------Layout implementation---------------------
	

    /**
     * do nothing
     */
    public function addLayoutComponent(comp:Component, constraints:Dynamic):Void{
    }

    /**
     * do nothing
     */
    public function removeLayoutComponent(comp:Component):Void{
    }
	
    public function preferredLayoutSize(target:Container):IntDimension{
    	var viewSize:IntDimension = getViewSize();
    	var rowCount:Int= getVisibleRowCount();
    	if(rowCount > 0){
	    	var rowHeight:Int= 20;
	    	if(getCellFactory().isAllCellHasSameHeight()){
	    		rowHeight = getCellFactory().getCellHeight();
	    	}
    		viewSize.height = rowCount * rowHeight;
    	}
    	var cellWidth:Int= getVisibleCellWidth();
    	if(cellWidth > 0){
    		viewSize.width = cellWidth;
    	}
    	return getInsets().getOutsideSize(viewSize);
    }

    public function minimumLayoutSize(target:Container):IntDimension{
    	return getInsets().getOutsideSize();
    }
	
    public function maximumLayoutSize(target:Container):IntDimension{
    	return IntDimension.createBigDimension();
    }
    
    /**
     * position and fill cells here
     */
    public function layoutContainer(target:Container):Void{
    	var factory:ListCellFactory = getCellFactory();
    	
		var ir:IntRectangle = getInsets().getInsideBounds(getSize().getBounds());
 
    	cellPane.setComBounds(ir);
    	
    	if(factory.isShareCells()){
    		layoutWhenShareCells();
    	}else{
    		if(factory.isAllCellHasSameHeight()){
    			layoutWhenNotShareCellsAndSameHeight();
    		}else{
    			layoutWhenNotShareCellsAndNotSameHeight();
    		}
    	}
    }
    
    private function layoutWhenShareCells():Void{
    	checkCreateCellsWhenShareCells();
    	
    	var factory:ListCellFactory = getCellFactory();
		var m:ListModel = getModel();
		var ir:IntRectangle = getInsets().getInsideBounds(getSize().getBounds());
    	var cellWidth:Int= ir.width;
    	ir.x = ir.y = 0; //this is because the cells is in cellPane, not in JList
    	
    	restrictionViewPos(viewPosition);
		var x:Int= viewPosition.x;
		var y:Int= viewPosition.y;
		var ih:Int= factory.getCellHeight();
		var startIndex:Int= Math.floor(y/ih);
		var startY:Int= startIndex*ih - y;
		var listSize:Int= m.getSize();
		var cx:Int= ir.x - x;
		var cy:Int= ir.y + startY;
		var maxY:Int= ir.y + ir.height;
		var cellsSize:Int= cells.getSize();
		if(listSize < 0){
			lastVisibleIndex = -1;
		}
		for(i in 0...cellsSize){
			var cell:ListCell = cells.get(i);
			var ldIndex:Int= startIndex + i;
			var cellCom:Component = cell.getCellComponent();
			if(ldIndex < listSize){
				cell.setCellValue(m.getElementAt(ldIndex));
				cellCom.setVisible(true);
				cellCom.setComBoundsXYWH(cx, cy, cellWidth, ih);
				if(cy < maxY){
					lastVisibleIndex = ldIndex;
				}
				cy += ih;
				cell.setListCellStatus(this, isSelectedIndex(ldIndex), ldIndex);
			}else{
				cellCom.setVisible(false);
			}
			cellCom.validate();
		}
		firstVisibleIndex = startIndex;
    }
    
    private function layoutWhenNotShareCellsAndSameHeight():Void{
    	var factory:ListCellFactory = getCellFactory();
		var m:ListModel = getModel();
		var ir:IntRectangle = getInsets().getInsideBounds(getSize().getBounds());
    	var cellWidth:Int=Std.int( Math.max(ir.width, viewWidth));
    	ir.x = ir.y = 0; //this is because the cells is in cellPane, not in JList
    	
    	restrictionViewPos(viewPosition);
		var x:Int= viewPosition.x;
		var y:Int= viewPosition.y;
		var ih:Int= factory.getCellHeight();
		var startIndex:Int= Math.floor(y/ih);
		var listSize:Int= m.getSize();
		var startY:Int= startIndex*ih - y;
		
		var endIndex:Int= startIndex + Math.ceil((ir.height-(ih+startY))/ih);
		if(endIndex >= listSize){
			endIndex = listSize - 1;
		}
		
		var cx:Int= ir.x - x;
		var cy:Int= ir.y + startY;
		var maxY:Int= ir.y + ir.height;
		var i:Int;
		var cellCom:Component;
		//invisible last viewed
		for(i in Std.int(Math.max(0, firstVisibleIndex+firstVisibleIndexOffset))...startIndex){
			cellCom = AsWingUtils.as(cells.get(i),ListCell).getCellComponent();
			cellCom.setVisible(false);
			cellCom.validate();
		}
		var rlvi:Int= Std.int(Math.min(lastVisibleIndex+lastVisibleIndexOffset, listSize-1));
		for(i in endIndex+1...rlvi+1){
			cellCom = AsWingUtils.as(cells.get(i),ListCell).getCellComponent();
			cellCom.setVisible(false);
			cellCom.validate();
		}
		if(endIndex < 0 || startIndex > endIndex){
			lastVisibleIndex = -1;
		}
		//visible current needed
		for(i in startIndex...endIndex+1){
			var cell:ListCell = AsWingUtils.as(cells.get(i),ListCell);
			cellCom = cell.getCellComponent();
			cellCom.setVisible(true);
			var s:IntDimension = getCachedCellPreferSize(cell);
			if(s == null){
				s = cell.getCellComponent().getPreferredSize();
				trace("Warnning : cell size not cached index = " + i + ", value = " + cell.getCellValue());
			}
			var finalWidth:Int= Std.int(isTracksWidth() ? ir.width : Math.max(cellWidth, s.width));
			cellCom.setComBoundsXYWH(cx, cy, finalWidth, ih);
			if(cy < maxY){
				lastVisibleIndex = i;
			}
			cy += ih;
			cell.setListCellStatus(this, isSelectedIndex(i), i);
			cellCom.validate();
		}
		firstVisibleIndex = startIndex;
		firstVisibleIndexOffset = lastVisibleIndexOffset = 0;
    }
    
    private function getCachedCellPreferSize(cell:ListCell):IntDimension{
    	return AsWingUtils.as(cellPrefferSizes.get(cell.getCellComponent().getAwmlIndex()),IntDimension);
    }
    
    private function layoutWhenNotShareCellsAndNotSameHeight():Void{
		var m:ListModel = getModel();
		var ir:IntRectangle = getInsets().getInsideBounds(getSize().getBounds());
    	var cellWidth:Int= Std.int(Math.max(ir.width, viewWidth));
    	ir.x = ir.y = 0; //this is because the cells is in cellPane, not in JList
    	
    	restrictionViewPos(viewPosition);
		var x:Int= viewPosition.x;
		var y:Int= viewPosition.y;
		var startIndex:Int= 0;
		var cellsCount:Int= cells.getSize();
		
		var tryY:Int= 0;
		var startY:Int= 0;
		var i:Int;
		var s:IntDimension;
		var cell:ListCell;
		
		for(i in 0...cellsCount){
			cell = AsWingUtils.as(cells.get(i),ListCell);
			s = getCachedCellPreferSize(cell);
			if(s == null){
				s = cell.getCellComponent().getPreferredSize();
				trace("Warnning : cell size not cached index = " + i + ", value = " + cell.getCellValue());
			}
			tryY += s.height;
			if(tryY > y){
				startIndex = i;
				startY = -(s.height - (tryY - y));
				break;
			}
		}
		
		var listSize:Int= m.getSize();
		var cx:Int= ir.x - x;
		var cy:Int= ir.y + startY;
		var maxY:Int= ir.y + ir.height;
		var tempLastVisibleIndex:Int= -1;
		var cellCom:Component;
		//visible current needed
		var endIndex:Int= startIndex;
		for(i in startIndex...cellsCount){
			cell = AsWingUtils.as(cells.get(i),ListCell);
			cellCom = cell.getCellComponent();
			s = getCachedCellPreferSize(cell);
			if(s == null){
				s = cell.getCellComponent().getPreferredSize();
				trace("Warnning : cell size not cached index = " + i + ", value = " + cell.getCellValue());
			}
			cell.setListCellStatus(this, isSelectedIndex(i), i);
			cellCom.setVisible(true);
			var finalWidth:Int= Std.int(isTracksWidth() ? ir.width : Math.max(cellWidth, s.width));
			cellCom.setComBoundsXYWH(cx, cy, finalWidth, s.height);
			cellCom.validate();
			if(cy < maxY){
				tempLastVisibleIndex = i;
			}
			cy += s.height;
			endIndex = i;
			if(cy >= maxY){
				break;
			}
		}
		
		//invisible last viewed
		for(i in Std.int(Math.max(0, firstVisibleIndex+firstVisibleIndexOffset))...startIndex){
			cellCom = AsWingUtils.as(cells.get(i),ListCell).getCellComponent();
			cellCom.setVisible(false);
			cellCom.validate();
		}
		var rlvi:Int= Std.int(Math.min(lastVisibleIndex+lastVisibleIndexOffset, listSize-1));
		for(i in endIndex+1...rlvi+1){
			cellCom = AsWingUtils.as(cells.get(i),ListCell).getCellComponent();
			cellCom.setVisible(false);
			cellCom.validate();
		}
		lastVisibleIndex = tempLastVisibleIndex;
		firstVisibleIndex = startIndex;
		firstVisibleIndexOffset = lastVisibleIndexOffset = 0;
    }
    
	/**
	 * return 0
	 */
    public function getLayoutAlignmentX(target:Container):Float{
    	return 0;
    }

	/**
	 * return 0
	 */
    public function getLayoutAlignmentY(target:Container):Float{
    	return 0;
    }

    public function invalidateLayout(target:Container):Void{
    }
	
	//------------------------ListMode Listener Methods-----------------
	
	/**
	 * data in list has changed, update JList if needed.
	 */
    public function intervalAdded(e:ListDataEvent):Void{
    	var factory:ListCellFactory = getCellFactory();
		var m:ListModel = getModel();
		
		var w:Int= viewWidth;
		var h:Int= viewHeight;
		var sameHeight:Bool= factory.isAllCellHasSameHeight();
		
		var i0:Int= Std.int(Math.min(e.getIndex0(), e.getIndex1()));
		var i1:Int= Std.int(Math.max(e.getIndex0(), e.getIndex1()));
		
		if(factory.isShareCells()){
			w = getPreferredCellWidthWhenNoCount();
			h = m.getSize()*factory.getCellHeight();
		}else{
			for(i in i0...i1+1){
				var cell:ListCell = createNewCell();
				cells.append(cell, i);
				cell.setCellValue(m.getElementAt(i));
				addCellToContainer(cell);
				var s:IntDimension = cell.getCellComponent().getPreferredSize();
				cell.getCellComponent().setVisible(false);
				cellPrefferSizes.set(cell.getCellComponent().getAwmlIndex(), s);
				if(s.width > w){
					w = s.width;
					maxWidthCell = cell;
				}
				w = Std.int(Math.max(w, s.width));
				if(sameHeight!=true){
					h += s.height;
				}
			}
			if(sameHeight)	{
				h = m.getSize()*factory.getCellHeight();
			}
			
			if(i0 > lastVisibleIndex + lastVisibleIndexOffset){
				//nothing needed
			}else if(i0 >= firstVisibleIndex + firstVisibleIndexOffset){
				lastVisibleIndexOffset += (i1 - i0 + 1);
			}else if(i0 < firstVisibleIndex + firstVisibleIndexOffset){
				firstVisibleIndexOffset += (i1 - i0 + 1);
				lastVisibleIndexOffset += (i1 - i0 + 1);
			}
		}
		
		viewWidth = w;
		viewHeight = h;
		getSelectionModel().insertIndexInterval(i0, i1-i0+1, true);
		revalidate();
    }
    
	/**
	 * data in list has changed, update JList if needed.
	 */
    public function intervalRemoved(e:ListDataEvent):Void{
    	var factory:ListCellFactory = getCellFactory();
		var m:ListModel = getModel();
		
		var w:Int= viewWidth;
		var h:Int= viewHeight;
		var sameHeight:Bool= factory.isAllCellHasSameHeight();
		
		var i0:Int= Std.int(Math.min(e.getIndex0(), e.getIndex1()));
		var i1:Int= Std.int(Math.max(e.getIndex0(), e.getIndex1()));
		
		var i:Int;
		var s:IntDimension;
		var cell:ListCell;
		
		if(factory.isShareCells()){
			w = getPreferredCellWidthWhenNoCount();
			h = m.getSize()*factory.getCellHeight();
		}else{
			var needRecountWidth:Bool= false;
			for(i in i0...i1+1){
				cell = AsWingUtils.as(cells.get(i),ListCell);
				if(cell == maxWidthCell){
					needRecountWidth = true;
				}
				if(sameHeight!=true){
					s = getCachedCellPreferSize(cell);
					if(s == null){
						s = cell.getCellComponent().getPreferredSize();
						trace("Warnning : cell size not cached index = " + i + ", value = " + cell.getCellValue());
					}
					h -= s.height;
				}
				removeCellFromeContainer(cell);
				cellPrefferSizes.remove(cell.getCellComponent().getAwmlIndex());
			}
			cells.removeRange(i0, i1);
			if(sameHeight)	{
				h = m.getSize()*factory.getCellHeight();
			}
			if(needRecountWidth)	{
				w = 0;
				for(i in 0...cells.getSize() ){
					cell = AsWingUtils.as(cells.get(i),ListCell);
					s = getCachedCellPreferSize(cell);
					if(s == null){
						s = cell.getCellComponent().getPreferredSize();
						trace("Warnning : cell size not cached index = " + i + ", value = " + cell.getCellValue());
					}
					if(s.width > w){
						w = s.width;
						maxWidthCell = cell;
					}
				}
			}
			if(i0 > lastVisibleIndex + lastVisibleIndexOffset){
				//nothing needed
			}else if(i0 >= firstVisibleIndex + firstVisibleIndexOffset){
				lastVisibleIndexOffset -= (i1 - i0 + 1);
			}else if(i0 < firstVisibleIndex + firstVisibleIndexOffset){
				firstVisibleIndexOffset -= (i1 - i0 + 1);
				lastVisibleIndexOffset -= (i1 - i0 + 1);
			}
		}
		
		viewWidth = w;
		viewHeight = h;
		getSelectionModel().removeIndexInterval(i0, i1);
		revalidate();
    }
    
	/**
	 * data in list has changed, update JList if needed.
	 */
    public function contentsChanged(e:ListDataEvent):Void{
    	var factory:ListCellFactory = getCellFactory();
		var m:ListModel = getModel();
		
		var w:Int= viewWidth;
		var h:Int= viewHeight;
		var sameHeight:Bool= factory.isAllCellHasSameHeight();
		
		var i0:Int= Std.int(Math.min(e.getIndex0(), e.getIndex1()));
		var i1:Int= Std.int(Math.max(e.getIndex0(), e.getIndex1()));
		var i:Int;
		var s:IntDimension;
		var cell:ListCell;
		var ns:IntDimension;
		
		if(factory.isShareCells()){
			w = getPreferredCellWidthWhenNoCount();
			h = m.getSize()*factory.getCellHeight();
		}else{
			var needRecountWidth:Bool= false;
			for(i in i0...i1+1){
				var newValue:Dynamic= m.getElementAt(i);
				cell = AsWingUtils.as(cells.get(i),ListCell);
				s = getCachedCellPreferSize(cell);
				if(s == null){
					s = cell.getCellComponent().getPreferredSize();
					trace("Warnning : cell size not cached index = " + i + ", value = " + cell.getCellValue());
				}
				if(cell == maxWidthCell){
					h -= s.height;
					cell.setCellValue(newValue);
					ns = cell.getCellComponent().getPreferredSize();
					cellPrefferSizes.set(cell.getCellComponent().getAwmlIndex(), ns);
					if(ns.width < s.width){
						needRecountWidth = true;
					}else{
						w = ns.width;
					}
					h += ns.height;
				}else{
					h -= s.height;
					cell.setCellValue(newValue);
					ns = cell.getCellComponent().getPreferredSize();
					cellPrefferSizes.set(cell.getCellComponent().getAwmlIndex(), ns);
					h += ns.height;
					if(needRecountWidth!=true){
						if(ns.width > w){
							maxWidthCell = cell;
							w = ns.width;
						}
					}
				}
			}
			if(sameHeight)	{
				h = m.getSize()*factory.getCellHeight();
			}
			if(needRecountWidth || maxWidthCell == null){
				w = 0;
				for(i in 0...cells.getSize() ){
					cell = cells.get(i);
					s = getCachedCellPreferSize(cell);
					if(s == null){
						s = cell.getCellComponent().getPreferredSize();
						trace("Warnning : cell size not cached index = " + i + ", value = " + cell.getCellValue());
					}
					if(s.width > w){
						w = s.width;
						maxWidthCell = cell;
					}
				}
			}
		}
		
		viewWidth = w;
		viewHeight = h;
		
		revalidate();
    }
        
    private function __selectionListener(e:SelectionEvent):Void{
    	dispatchEvent(new SelectionEvent(SelectionEvent.LIST_SELECTION_CHANGED, e.getFirstIndex(), e.getLastIndex(), e.isProgrammatic()));
    	revalidate();
    }
    
    //-------------------------------Event Listener For All Items----------------
    
    private function addHandlersToCell(cellCom:Component):Void{
    	cellCom.addEventListener(MouseEvent.CLICK, __onItemClick, false, 0, false); 
    	cellCom.addEventListener(MouseEvent.DOUBLE_CLICK, __onItemDoubleClick , false, 0, false);
    	cellCom.addEventListener(MouseEvent.MOUSE_DOWN, __onItemMouseDown, false, 0, false);
    	cellCom.addEventListener(MouseEvent.ROLL_OVER, __onItemRollOver, false, 0, false);
    	cellCom.addEventListener(MouseEvent.ROLL_OUT, __onItemRollOut, false, 0, false);
    	cellCom.addEventListener(ReleaseEvent.RELEASE_OUT_SIDE, __onItemReleaseOutSide, false, 0, false);
    }
    
    private function removeHandlersFromCell(cellCom:Component):Void{
    	cellCom.removeEventListener(MouseEvent.CLICK, __onItemClick);
    	cellCom.removeEventListener(MouseEvent.DOUBLE_CLICK, __onItemDoubleClick);
    	cellCom.removeEventListener(MouseEvent.MOUSE_DOWN, __onItemMouseDown);
    	cellCom.removeEventListener(MouseEvent.ROLL_OVER, __onItemRollOver);
    	cellCom.removeEventListener(MouseEvent.ROLL_OUT, __onItemRollOut);
    	cellCom.removeEventListener(ReleaseEvent.RELEASE_OUT_SIDE, __onItemReleaseOutSide);
    }
    	
	private function createItemEventObj(cellCom:Dynamic, type:String, e:MouseEvent):ListItemEvent {
	 
		var cell:ListCell = getCellByCellComponent(AsWingUtils.as(cellCom, Component));
		var cellValue:Dynamic = null;
		if (cell != null) cellValue = cell.getCellValue();
		var event:ListItemEvent  =new ListItemEvent(type,cellValue , cell, e);
		return event;
	}
	
	private function getItemIndexByCellComponent(item:Component):Int{
		var cell:ListCell = comToCellMap.get(item.getAwmlIndex());
		trace(cell);
		return getItemIndexByCell(cell);
	}
	
	/**
	 * Returns the index of the cell.
	 */
	//why
	private function  cellsIndexOf(cell:ListCell):Int
	{ 
		for(i in 0...cells.size()){
			if(cells.get(i).getAwmlIndex() ==cell.getAwmlIndex()){
				return i;
			}
		}
		return -1;
		
	}
	public function getItemIndexByCell(cell:ListCell):Int {
		var itemIndex:Int; 
		if(getCellFactory().isShareCells()){
			itemIndex= firstVisibleIndex + cellsIndexOf(cell);
		}else{
			itemIndex= cellsIndexOf(cell);
		} 
		return itemIndex;
	}
	
	private function getCellByCellComponent(item:Component):ListCell{
		return comToCellMap.get(item.getAwmlIndex());
	}
	
	/**
	 * Returns the cell of the specified index
	 */
	public function getCellByIndex(index:Int):ListCell{
		if(getCellFactory().isShareCells()){
			return AsWingUtils.as(cells.get(index - firstVisibleIndex),ListCell);
		}else{
			return AsWingUtils.as(cells.get(index),ListCell);
		}
	}
	
	
    /**
     * Event Listener For All Items
     */
	private function __onItemMouseDown(e:MouseEvent):Void {
		 dispatchEvent(createItemEventObj(e.currentTarget, ListItemEvent.ITEM_MOUSE_DOWN, e));
	}
		
    /**
     * Event Listener For All Items
     */	
	private function __onItemClick(e:MouseEvent):Void {
	//why	 
		 dispatchEvent(createItemEventObj(e.currentTarget, ListItemEvent.ITEM_CLICK, e));
	}
	
    /**
     * Event Listener For All Items
     */	
	private function __onItemReleaseOutSide(e:ReleaseEvent):Void {
	//why	
 
		 dispatchEvent(createItemEventObj(e.currentTarget, ListItemEvent.ITEM_RELEASE_OUT_SIDE, e));
	}
	
    /**
     * Event Listener For All Items
     */	
	private function __onItemRollOver(e:MouseEvent):Void {
 //why 
		 dispatchEvent(createItemEventObj(e.currentTarget, ListItemEvent.ITEM_ROLL_OVER, e));
	}
	
    /**
     * Event Listener For All Items
     */	
	private function __onItemRollOut(e:MouseEvent):Void {
	//why	
		 dispatchEvent(createItemEventObj(e.currentTarget, ListItemEvent.ITEM_ROLL_OUT, e));
	}
	
    /**
     * Event Listener For All Items
     */	
	private function __onItemDoubleClick(e:MouseEvent):Void {
	//why	
		 dispatchEvent(createItemEventObj(e.currentTarget, ListItemEvent.ITEM_DOUBLE_CLICK, e));
	}
	
	//-------------------------------Drag and Drop---------------------------------

	/*private var dndAutoScrollTimer:Timer;	
	private var dnd_line_mc:MovieClip;
	
	private function __onDragRecognized(dragInitiator:Component, touchedChild:Component):void{
		if(isAutoDnDInitiatorAllown()){
			var data:Array = getSelectedIndices();
			var sourceData:ListSourceData = new ListSourceData("ListSourceData", data);
			
			var firstIndex:int = getFirstVisibleIndex();
			var lastIndex:int = getLastVisibleIndex();
			var mp:IntPoint = getMousePosition();
			var ib:Rectangle = new Rectangle();
			var offsetY:int = mp.y;
			for(var i:int=firstIndex; i<=lastIndex; i++){
				ib = getCellByIndex(i).getCellComponent().getBounds(ib);
				if(mp.y < ib.y + ib.height){
					offsetY = ib.y;
					break;
				}
			}
			
			DragManager.startDrag(this, sourceData, new ListDragImage(this, offsetY));
		}
	}
	private function __onDragEnter(source:Component, dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):void{
		dndInsertPosition = -1;
		if(!(isAcceptableListSourceData(dragInitiator, sourceData) && isAutoDnDDropTargetAllown())){
			DragManager.getCurrentDragImage().switchToRejectImage();
		}else{
			DragManager.getCurrentDragImage().switchToAcceptImage();
			checkStartDnDAutoScroll();
		}
	}
	private function __onDragOverring(source:Component, dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):void{
		if(isAcceptableListSourceData(dragInitiator, sourceData) && isAutoDnDDropTargetAllown()){
			checkStartDnDAutoScroll();
			drawInsertLine();
		}
	}
	private function __onDragExit(source:Component, dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):void{
		checkStopDnDAutoScroll();
	}
	private function __onDragDrop(source:Component, dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):void{
		checkStopDnDAutoScroll();
		if(isAcceptableListSourceData(dragInitiator, sourceData) && isAutoDnDDropTargetAllown()){
			if(dndInsertPosition >= 0){
				var indices:Array = (ListSourceData(sourceData)).getItemIndices();
				if(indices == null || indices.length == null || indices.length <= 0){
					return;
				}
				var initiator:JList = JList(dragInitiator);
				var items:Array = new Array(indices.length);
				for(var i:int=0; i<indices.length; i++){
					items[i] = initiator.getModel().getElementAt(indices[i]);
				}
				var insertOffset:int = 0;
				if(initiator.getAutoDragAndDropType() == DND_MOVE){
					var imm:MutableListModel = MutableListModel(initiator.getModel());
					var sameModel:Boolean = (imm == getModel());
					for(var i:int=0; i<indices.length; i++){
						var rindex:int = indices[i];
						imm.removeElementAt(rindex-i);
						if(sameModel && rindex<dndInsertPosition){
							insertOffset ++;
						}
					}
				}
				var index:int = dndInsertPosition - insertOffset;
				var mm:MutableListModel = MutableListModel(getModel());
				for(var i:int=0; i<items.length; i++){
					mm.insertElementAt(items[i], index);
					index++;
				}
				return;
			}
		}
		DragManager.setDropMotion(DragManager.DEFAULT_REJECT_DROP_MOTION);
	}
	*/
	/**
	 * Returns is the source data is acceptale to drop in this list as build-in support
	 */
	/*public function isAcceptableListSourceData(dragInitiator:Component, sd:SourceData):Boolean{
		return (sd is ListSourceData) && isDragAcceptableInitiator(dragInitiator);
	}*/
	
	/**
	 * Returns is the model is mutable
	 */
	public function isMutableModel():Bool{
		return Std.is(getModel(),MutableListModel);
	}
	
	/*private function checkStartDnDAutoScroll():void{
		if(dndAutoScrollTimer == null){
			dndAutoScrollTimer = new Timer(200);
			dndAutoScrollTimer.addActionListener(__dndAutoScroll, this);
		}
		if(!dndAutoScrollTimer.isRunning()){
			dndAutoScrollTimer.start();
		}
		if(!MCUtils.isMovieClipExist(dnd_line_mc)){
			dnd_line_mc = createMovieClip("line_mc");
		}
	}
	private function checkStopDnDAutoScroll():void{
		if(dndAutoScrollTimer != null){
			dndAutoScrollTimer.stop();
		}
		if(dnd_line_mc != null){
			dnd_line_mc.removeMovieClip();
			dnd_line_mc = null;
		}
	}
	
	private function __dndAutoScroll():void{
		var lastCellBounds:Rectangle = getCellByIndex(getLastVisibleIndex()).getCellComponent().getBounds();
		var firstCellBounds:Rectangle = getCellByIndex(getFirstVisibleIndex()).getCellComponent().getBounds();
		var vp:IntPoint = getViewPosition();
		var mp:IntPoint = getMousePosition();
		var ins:Insets = getInsets();
		
		if(mp.y < ins.top + firstCellBounds.height/2){
			vp.y -= firstCellBounds.height;
			setViewPosition(vp);
			drawInsertLine();
		}else if(mp.y > getHeight() - ins.bottom - lastCellBounds.height/2){
			vp.y += lastCellBounds.height;
			setViewPosition(vp);
			drawInsertLine();
		}
	}
	
	private var dndInsertPosition:int;
	private function drawInsertLine():void{
		var firstIndex:int = getFirstVisibleIndex();
		var lastIndex:int = getLastVisibleIndex();
		
		var mp:IntPoint = getMousePosition();
		var ib:Rectangle = new Rectangle();
		var insertIndex:int = -1;
		var insertY:int;
		for(var i:int=firstIndex; i<=lastIndex; i++){
			ib = getCellByIndex(i).getCellComponent().getBounds(ib);
			if(mp.y < ib.y + ib.height/2){
				insertIndex = i;
				insertY = ib.y;
				break;
			}
		}
		if(insertIndex < 0){
			ib = getCellByIndex(lastIndex).getCellComponent().getBounds(ib);
			insertIndex = lastIndex+1;
			insertY = ib.y + ib.height;
		}
		dndInsertPosition = insertIndex;
				
		dnd_line_mc.clear();
		var g:Graphics = new Graphics(dnd_line_mc);
		var pen:Pen = new Pen(0, 2, 70);
		var ins:Insets = this.getInsets();
		
		g.drawLine(pen, ins.left+1, insertY, getWidth()-ins.right-1, insertY);
	}
	
	
	private function ____onDragRecognized(dragInitiator:Component, touchedChild:Component):void{
		__onDragRecognized(dragInitiator, touchedChild);
	}
	private function ____onDragEnter(source:Component, dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):void{
		__onDragEnter(source, dragInitiator, sourceData, mousePos);
	}
	private function ____onDragOverring(source:Component, dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):void{
		__onDragOverring(source, dragInitiator, sourceData, mousePos);
	}
	private function ____onDragExit(source:Component, dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):void{
		__onDragExit(source, dragInitiator, sourceData, mousePos);
	}
	private function ____onDragDrop(source:Component, dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):void{
		__onDragDrop(source, dragInitiator, sourceData, mousePos);
	}	
	*/
}