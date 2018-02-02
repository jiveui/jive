/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.ext;


import flash.events.Event;
	import flash.events.MouseEvent;
	import org.aswing.JViewport;
	import org.aswing.ListCell;
	import org.aswing.ListModel;
	import org.aswing.ListSelectionModel;
	import org.aswing.VectorListModel;
	import org.aswing.DefaultListSelectionModel;
	import org.aswing.Container;
	import org.aswing.Component;
	import org.aswing.event.ListDataListener;
	import org.aswing.event.SelectionEvent;
	import org.aswing.event.ListDataEvent;
	import org.aswing.event.ReleaseEvent;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntDimension;
	import org.aswing.util.ArrayList;


/**
 * Dispatched when the list selection changed.
 * @eventType org.aswing.event.SelectionEvent.LIST_SELECTION_CHANGED
 */
// [Event(name="listSelectionChanged", type="org.aswing.event.SelectionEvent")]

/**
 * Dispatched when the list item be click.
 * @eventType org.aswing.ext.GridListItemEvent.ITEM_CLICK
 */
// [Event(name="itemClick", type="org.aswing.ext.GridListItemEvent")]

/**
 * Dispatched when the list item be double click.
 * @eventType org.aswing.ext.GridListItemEvent.ITEM_DOUBLE_CLICK
 */
// [Event(name="itemDoubleClick", type="org.aswing.ext.GridListItemEvent")]

/**
 * Dispatched when the list item be mouse down.
 * @eventType org.aswing.ext.GridListItemEvent.ITEM_MOUSE_DOWN
 */
// [Event(name="itemMouseDown", type="org.aswing.ext.GridListItemEvent")]

/**
 * Dispatched when the list item be roll over.
 * @eventType org.aswing.ext.GridListItemEvent.ITEM_ROLL_OVER
 */
// [Event(name="itemRollOver", type="org.aswing.ext.GridListItemEvent")]

/**
 * Dispatched when the list item be roll out.
 * @eventType org.aswing.ext.GridListItemEvent.ITEM_ROLL_OUT
 */
// [Event(name="itemRollOut", type="org.aswing.ext.GridListItemEvent")]

/**
 * Dispatched when the list item be released out side.
 * @eventType org.aswing.ext.GridListItemEvent.ITEM_RELEASE_OUT_SIDE
 */
// [Event(name="itemReleaseOutSide", type="org.aswing.ext.GridListItemEvent")]

/**
 * GridList usage is similar to JList, GridList provide a grid like container, 
 * you can put GridList into a JScrollPane.<br/>
 * GridList doesn't share cell instances, it means it will create cells for every cell value, 
 * it's not suitable for large data model.<br/>
 * GridList doesn't support key board navigation/selection yet.
 * 
 * @author paling
 */
class GridList extends JViewport  implements ListDataListener{
		 	
	/**
	 * Only can select one most item at a time.
	 */
	inline public static var SINGLE_SELECTION:Int= DefaultListSelectionModel.SINGLE_SELECTION;
	/**
	 * Can select any item at a time.
	 */
	inline public static var MULTIPLE_SELECTION:Int= DefaultListSelectionModel.MULTIPLE_SELECTION;
	
	private var tileHolder:GridCellHolder;
	private var gridLayout:GridListLayout;
	
	private var cellFactory:GridListCellFactory;
	private var model:ListModel;
	private var selectionModel:ListSelectionModel;
	private var cells:ArrayList;
	private  var selectable:Bool;
	private  var autoScroll:Bool;
	private  var tileWidth:Int;
	private  var tileHeight:Int;
	
	
	/**
	 * Creates a GridList
	 * @param model the data provider model
	 * @param cellFactory the cell factory, null to be a default factory to generate text cell
	 * @param columns if == 0 it will auto (only one of col or row can be == 0)
	 * @param rows if == 0 it will auto (only one of col or row can be == 0)
	 */
	public function new(model:ListModel=null, cellFactory:GridListCellFactory=null, columns:Int=0, rows:Int=2){
		selectable=true;
			autoScroll=true;
			tileWidth=40;
			tileHeight=20;
			super(createHolder(columns, rows));
		setHorizontalAlignment(AsWingConstants.LEFT);
		setVerticalAlignment(AsWingConstants.TOP);
		cells = new ArrayList();
		if(model == null) model = new VectorListModel();
		if(cellFactory == null) cellFactory = new GeneralGridListCellFactory(DefaultGridCell);
		this.cellFactory = cellFactory;
		setSelectionModel(new DefaultListSelectionModel());
		setModel(model);
	}
	
	/**
	 * Sets whether selectable by user interactive.
	 */
	public function setSelectable(b:Bool):Void{
		selectable = b;
	}
	
	public function isSelectable():Bool{
		return selectable;
	}
	
	public function setTileWidth(w:Int):Void{
		if(tileWidth != w){
			tileWidth = w;
			gridLayout.setTileWidth(w);
			tileHolder.revalidate();
		}
	}
	
	public function setTileHeight(h:Int):Void{
		if(tileHeight != h){
			tileHeight = h;
			gridLayout.setTileHeight(h);
			tileHolder.revalidate();
		}
	}	
	
	public function getTileWidth():Int{
		return tileWidth;
	}
	
	public function getTileHeight():Int{
		return tileHeight;
	}
	
	/**
	 * Auto scroll to view selection?
	 */
	public function setAutoScroll(b:Bool):Void{
		autoScroll = b;
	}
	
	public function isAutoScroll():Bool{
		return autoScroll;
	}
	
	private function createHolder(columns:Int, rows:Int):Container{
		tileHolder = new GridCellHolder(this);
		gridLayout = new GridListLayout(rows, columns, 2, 2);
		gridLayout.setTileWidth(getTileWidth());
		gridLayout.setTileHeight(getTileHeight());
		tileHolder.setLayout(gridLayout);
		return tileHolder;
	}
	
	public function setHolderLayout(layout:GridListLayout):Void{
		if(layout != gridLayout){
			gridLayout = layout;
			gridLayout.setTileWidth(getTileWidth());
			gridLayout.setTileHeight(getTileHeight());
			tileHolder.setLayout(gridLayout);
		}
	}
	
	/**
	 * Set the list mode to provide the data to GridList.
	 * @see org.aswing.ListModel
	 */
	public function setModel(m:ListModel):Void{
		if(m != model){
			if(model != null){
				model.removeListDataListener(this);
			}
			model = m;
			model.addListDataListener(this);
			rebuildListView();
		}
	}
	
	/**
	 * Set a array to be the list data, a new model will be created and the values is copied to the model.
	 * This is not a good way, its slow. So suggest you to create a ListMode for example VectorListMode to JList,
	 * When you modify ListMode, it will automatic update GridList if necessary.
	 * @see #setModel()
	 * @see org.aswing.ListModel
	 */
	public function setListData(ld:Array<Dynamic>):Void{
		var m:ListModel = new VectorListModel(ld);
		setModel(m);
	}	
	
	/**
	 * @return the model of this List
	 */
	public function getModel():ListModel{
		return model;
	}
	
	public function setSelectionModel(m:ListSelectionModel):Void{
		if(m != selectionModel){
			if(selectionModel != null){
				selectionModel.removeListSelectionListener(__selectionListener);
			}
			selectionModel = m;
			selectionModel.setSelectionMode(DefaultListSelectionModel.SINGLE_SELECTION);
			selectionModel.addListSelectionListener(__selectionListener);
		}
	}
	
	public function getSelectionModel():ListSelectionModel{
		return selectionModel;
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
	
	public function addSelectionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(SelectionEvent.LIST_SELECTION_CHANGED, listener, false, priority, useWeakReference);
	}	
	
	/**
	 * Clears the selection - after calling this method isSelectionEmpty will return true. 
	 * This is a convenience method that just delegates to the selectionModel.
     * @param programmatic indicate if this is a programmatic change.
	 */
	public function clearSelection(programmatic:Bool=true):Void{
		selectionModel.clearSelection(programmatic);
	}
		
	public function setColsRows(cols:Int, rows:Int):Void{
		gridLayout.setColumns(cols);
		gridLayout.setRows(rows);
    	tileHolder.revalidate();
    	revalidate();
	}
		
	public function setColumns(cols:Int):Void{
		gridLayout.setColumns(cols);
    	tileHolder.revalidate();
    	revalidate();
	}
		
	public function setRows(rows:Int):Void{
		gridLayout.setRows(rows);
    	tileHolder.revalidate();
    	revalidate();
	}
		
	public function getColumns():Int{
		return gridLayout.getColumns();
	}
		
	public function getRows():Int{
		return gridLayout.getRows();
	}
	
	public function setHGap(g:Int):Void{
		gridLayout.setHgap(g);
    	tileHolder.revalidate();
    	revalidate();
	}
	
	public function setVGap(g:Int):Void{
		gridLayout.setVgap(g);
    	tileHolder.revalidate();
    	revalidate();
	}
	
	public function getHGap():Int{
		return gridLayout.getHgap();
	}
	
	public function getVGap():Int{
		return gridLayout.getVgap();
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
	public function setSelectionInterval(index0:Int, index1:Int, programmatic:Bool=true):Void{
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
     * Selects a single cell.
     * @param index the index to be seleted.
     * @param programmatic indicate if this is a programmatic change.
     * @see ListSelectionModel#setSelectionInterval
     * @see #isSelectedIndex()
	 */	
	public function setSelectedIndex(index:Int, programmatic:Bool=true):Void{
		if(index >= getModel().getSize()){
			return;
		}
		getSelectionModel().setSelectionInterval(index, index, programmatic);
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
	 * @return true if the index is selected, otherwise false.
	 */	
	public function isSelectedIndex(index:Int):Bool{
		return getSelectionModel().isSelectedIndex(index);
	}
	
	/**
	 * Selects the specified object from the list. This will not cause a scroll, if you want to 
	 * scroll to visible the selected value, call ensureIndexIsVisible().
	 * @param value the value to be selected.
     * @param programmatic indicate if this is a programmatic change.
	 * @see #setSelectedIndex()
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
	 * Returns the first selected value, or null if the selection is empty.
	 * @return the first selected value
	 */	
	public function getSelectedValue():Dynamic{
		if(isSelectionEmpty()){
			return null;
		}else{
			return this.getModel().getElementAt(getSelectedIndex());
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
	 * Returns the cell by index.
	 */
	public function getCellByIndex(index:Int):GridListCell{
		return cells.elementAt(index);
	}
	
	public function scrollToView(value:Dynamic):Void{	
		var n:Int= model.getSize();
		for(i in 0...n){
			if(model.getElementAt(i) == value){
				scrollToViewIndex(i);
				return;
			}
		}
	}
	
	public function scrollToViewIndex(index:Int):Void{
		if(index >=0 && index<model.getSize()){
			var c:Component = tileHolder.getComponent(index);
			var p:IntPoint = c.getLocation();
			var vp:IntPoint = getViewPosition();
			var range:IntDimension = getExtentSize();
			if(p.x + gridLayout.getTileWidth() > vp.x + range.width){
				vp.x = p.x + gridLayout.getTileWidth() - range.width;
			}
			if(p.y + gridLayout.getTileHeight() > vp.y + range.height){
				vp.y = p.y + gridLayout.getTileHeight() - range.height;
			}
			if(p.x < vp.x){
				vp.x = p.x;
			}
			if(p.y < vp.y){
				vp.y = p.y;
			}
			setViewPosition(vp);
		}
	}
	
	override public function getVerticalUnitIncrement():Int{
		return gridLayout.getTileHeight() + gridLayout.getVgap();
	}
	
	override public function getVerticalBlockIncrement():Int{
		return getInsets().getInsideSize(getSize()).height - gridLayout.getVgap();
	}
	
	override public function getHorizontalUnitIncrement():Int{
		return gridLayout.getTileWidth() + gridLayout.getHgap();
	}
	
	override public function getHorizontalBlockIncrement():Int{
		return getInsets().getInsideSize(getSize()).width - gridLayout.getHgap();
	}
    
    private function rebuildListView():Void{
    	clearSelection();
    	var cell:GridListCell;
    	for(i in 0...cells.size()){
    		cell = cells.get(i);
    		removeHandlersFromCell(cell.getCellComponent());
    	}
    	tileHolder.removeAll();
    	cells.clear();
    	var model:ListModel = getModel();
    	for(i in 0...model.getSize()){
			cell = createNewCell();
			cells.append(cell, i);
			cell.setCellValue(model.getElementAt(i));
			cell.setGridListCellStatus(this, false, i);
			addCellToContainer(cell, i);
    	}
    	tileHolder.revalidate();
    	revalidate();
    }
        
    private function __selectionListener(e:SelectionEvent):Void{
    	var n:Int= cells.size();
    	for(i in 0...n){
    		var cell:GridListCell = cells.elementAt(i);
    		cell.setGridListCellStatus(this, getSelectionModel().isSelectedIndex(i), i);
    	}
    	dispatchEvent(new SelectionEvent(SelectionEvent.LIST_SELECTION_CHANGED, e.getFirstIndex(), e.getLastIndex(), e.isProgrammatic()));
    	
    	if(!(getSelectionModel().isSelectionEmpty()) && isAutoScroll()){
    		scrollToViewIndex(e.getLastIndex());
    	}
    }
    
    override public function getViewSize():IntDimension{
		if(getView() == null){
			return new IntDimension();
		}else{
			if(isTracksWidth() && isTracksHeight()){
				return getExtentSize();
			}else{
				return gridLayout.getViewSize(tileHolder);
			}
		}	
    }
	
	//------------------------ListMode Listener Methods-----------------
	
	private function createNewCell():GridListCell{
		return cellFactory.createNewGridListCell();
	}
	
	private function addCellToContainer(cell:GridListCell, index:Int):Void{
		tileHolder.insert(index, cell.getCellComponent());
		addHandlersToCell(cell.getCellComponent());
	}
	
	private function removeCellFromeContainer(cell:GridListCell):Void{
		tileHolder.remove(cell.getCellComponent());
		removeHandlersFromCell(cell.getCellComponent());
	}
	
	/**
	 * data in list has changed, update JList if needed.
	 */
    public function intervalAdded(e:ListDataEvent):Void{
		var m:ListModel = getModel();
				
		var i0:Int= Std.int(Math.min(e.getIndex0(), e.getIndex1()));
		var i1:Int= Std.int(Math.max(e.getIndex0(), e.getIndex1()));
		
		for(i in i0...i1+1){
			var cell:GridListCell = createNewCell();
			cells.append(cell, i);
			cell.setCellValue(m.getElementAt(i));
			cell.setGridListCellStatus(this, false, i);
			addCellToContainer(cell, i);
		}
		
		selectionModel.insertIndexInterval(i0, i1-i0+1, true);
    	tileHolder.revalidate();
    	revalidate();
    }
    
	/**
	 * data in list has changed, update JList if needed.
	 */
    public function intervalRemoved(e:ListDataEvent):Void{
		var i0:Int= Std.int(Math.min(e.getIndex0(), e.getIndex1()));
		var i1:Int= Std.int(Math.max(e.getIndex0(), e.getIndex1()));
		
		var i:Int;
		var cell:GridListCell;
		
		for(i in i0...i1){
			cell = AsWingUtils.as(cells.get(i),GridListCell);
			removeCellFromeContainer(cell);
		}
		cells.removeRange(i0, i1);
		selectionModel.removeIndexInterval(i0, i1);
    	tileHolder.revalidate();
    	revalidate();
    }
    
	/**
	 * data in list has changed, update JList if needed.
	 */
    public function contentsChanged(e:ListDataEvent):Void{
		var m:ListModel = getModel();
				
		var i0:Int= Std.int(Math.min(e.getIndex0(), e.getIndex1()));
		var i1:Int= Std.int(Math.max(e.getIndex0(), e.getIndex1()));
		
		for(i in i0...i1+1){
			var cell:GridListCell = cells.get(i);
			cell.setCellValue(m.getElementAt(i));
		}
    	//tileHolder.revalidate();
    }

    //-------------------------------Event Listener For All Items----------------
    
    private function addHandlersToCell(cellCom:Component):Void{
    	cellCom.addEventListener(MouseEvent.CLICK, __onItemClick);
    	cellCom.addEventListener(MouseEvent.DOUBLE_CLICK, __onItemDoubleClick);
    	cellCom.addEventListener(MouseEvent.MOUSE_DOWN, __onItemMouseDown);
    	cellCom.addEventListener(MouseEvent.ROLL_OVER, __onItemRollOver);
    	cellCom.addEventListener(MouseEvent.ROLL_OUT, __onItemRollOut);
    	cellCom.addEventListener(ReleaseEvent.RELEASE_OUT_SIDE, __onItemReleaseOutSide);
    }
    
    private function removeHandlersFromCell(cellCom:Component):Void{
    	cellCom.removeEventListener(MouseEvent.CLICK, __onItemClick);
    	cellCom.removeEventListener(MouseEvent.DOUBLE_CLICK, __onItemDoubleClick);
    	cellCom.removeEventListener(MouseEvent.MOUSE_DOWN, __onItemMouseDown);
    	cellCom.removeEventListener(MouseEvent.ROLL_OVER, __onItemRollOver);
    	cellCom.removeEventListener(MouseEvent.ROLL_OUT, __onItemRollOut);
    	cellCom.removeEventListener(ReleaseEvent.RELEASE_OUT_SIDE, __onItemReleaseOutSide);
    }
    
    private var pressedIndex:Float;
    private var pressedCtrl:Bool;
    private var pressedShift:Bool;
    private var doSelectionWhenRelease:Bool;   
	//why
    private function  cellsIndexOf(cell:GridListCell):Int 
	{ 
		for(i in 0...cells.size()){
			if(cells.get(i).getAwmlIndex() ==cell.getAwmlIndex()){
				return i;
			}
		}
		return -1;
		
	}
    private function __onItemMouseDownSelection(e:GridListItemEvent):Void{
		var index:Int= cellsIndexOf(e.getCell());
		pressedIndex = index;
		pressedCtrl = e.ctrlKey;
		pressedShift = e.shiftKey;
		doSelectionWhenRelease = false;
		
		if(getSelectionMode() == MULTIPLE_SELECTION){
			if(getSelectionModel().isSelectedIndex(index)){
				doSelectionWhenRelease = true;
			}else{
				doSelection();
			}
		}else{
			getSelectionModel().setSelectionInterval(index, index, false);
		}
    }
    
    private function doSelection():Void{
    	var index:Int= Std.int(pressedIndex);
		if(pressedShift)	{
			var archor:Int= getSelectionModel().getAnchorSelectionIndex();
			if(archor < 0){
				archor = index;
			}
			getSelectionModel().setSelectionInterval(archor, index, false);
		}else if(pressedCtrl)	{
			if(!isSelectedIndex(index)){
				getSelectionModel().addSelectionInterval(index, index, false);
			}else{
				getSelectionModel().removeSelectionInterval(index, index, false);
			}
		}else{
			getSelectionModel().setSelectionInterval(index, index, false);
		}
    }
    
    private function __onItemClickSelection(e:GridListItemEvent):Void{
    	if(doSelectionWhenRelease)	{
    		doSelection();
    		doSelectionWhenRelease = false;
    	}
    }    
    
	private function createItemEventObj(cellCom:Dynamic, type:String, me:MouseEvent):GridListItemEvent{
		var index:Int= tileHolder.getIndex(cellCom);
		var cell:GridListCell = cells.get(index);
		var event:GridListItemEvent = new GridListItemEvent(type, getModel().getElementAt(index), index, cell, me);
		return event;
	}
	
    /**
     * Event Listener For All Items
     */
	private function __onItemMouseDown(e:MouseEvent):Void{
		var event:GridListItemEvent = createItemEventObj(e.currentTarget, GridListItemEvent.ITEM_MOUSE_DOWN, e);
		if(isSelectable()){
			__onItemMouseDownSelection(event);
		}
		dispatchEvent(event);
	}
	
    /**
     * Event Listener For All Items
     */	
	private function __onItemClick(e:MouseEvent):Void{
		var event:GridListItemEvent = createItemEventObj(e.currentTarget, GridListItemEvent.ITEM_CLICK, e);
		if(isSelectable()){
			__onItemClickSelection(event);
		}
		dispatchEvent(event);
	}
	
    /**
     * Event Listener For All Items
     */	
	private function __onItemReleaseOutSide(e:ReleaseEvent):Void{
		dispatchEvent(createItemEventObj(e.currentTarget, GridListItemEvent.ITEM_RELEASE_OUT_SIDE, e));
	}
	
    /**
     * Event Listener For All Items
     */	
	private function __onItemRollOver(e:MouseEvent):Void{
		dispatchEvent(createItemEventObj(e.currentTarget, GridListItemEvent.ITEM_ROLL_OVER, e));
	}
	
    /**
     * Event Listener For All Items
     */	
	private function __onItemRollOut(e:MouseEvent):Void{
		dispatchEvent(createItemEventObj(e.currentTarget, GridListItemEvent.ITEM_ROLL_OUT, e));
	}
	
    /**
     * Event Listener For All Items
     */	
	private function __onItemDoubleClick(e:MouseEvent):Void{
		dispatchEvent(createItemEventObj(e.currentTarget, GridListItemEvent.ITEM_DOUBLE_CLICK, e));
	}
}