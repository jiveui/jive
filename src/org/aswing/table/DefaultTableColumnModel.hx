/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


import org.aswing.error.Error;
import org.aswing.DefaultListSelectionModel;
import org.aswing.ListSelectionModel;
import org.aswing.util.ArrayUtils;
import org.aswing.event.PropertyChangeEvent;
import org.aswing.event.SelectionEvent;

/**
 * The standard column-handler for a <code>JTable</code>.
 * <p>
 * @author paling
 */
class DefaultTableColumnModel implements TableColumnModel{
	
	/** Array of TableColumn objects in this model */
	private var tableColumns:Array<Dynamic>;
	/** Model for keeping track of column selections */
	private var selectionModel:ListSelectionModel;
	/** Width margin between each column */
	private var columnMargin:Int;
	/** List of TableColumnModelListener */
	private var listenerList:Array<Dynamic>;
	/** Column selection allowed in this column model */
	private var columnSelectionAllowed:Bool;
	/** A local cache of the combined width of all columns */
	private var totalColumnWidth:Int;
		
	/**
	 * Creates a default table column model.
	 */	
	public function new(){
		tableColumns = new Array<Dynamic>();
		listenerList = new Array<Dynamic>();
		
		setSelectionModel(createSelectionModel());
		setColumnMargin(1);
		invalidateWidthCache();
		setColumnSelectionAllowed(false);
	}
	
	/**
	 *  Appends <code>aColumn</code> to the end of the
	 *  <code>tableColumns</code> array.
	 *  This method also posts the <code>columnAdded</code>
	 *  event to its listeners.
	 *
	 * @param aColumn the <code>TableColumn</code> to be added
	 * @see	#removeColumn()
	 */	
	public function addColumn(aColumn:TableColumn):Void{
		if (aColumn == null){
			trace("Adding null column ignored");
			return;
		}
		tableColumns.push(aColumn);
		aColumn.addPropertyChangeListener(__propertyChanged);
		invalidateWidthCache();
		checkLeadAnchor();
		fireColumnAdded(new TableColumnModelEvent(this, 0, (getColumnCount() - 1)));
	}
	
	/**
	 *  Deletes the <code>column</code> from the
	 *  <code>tableColumns</code> array.  This method will do nothing if
	 *  <code>column</code> is not in the table's columns list.
	 *  <code>tile</code> is called
	 *  to resize both the header and table views.
	 *  This method also posts a <code>columnRemoved</code>
	 *  event to its listeners.
	 *
	 * @param column the <code>TableColumn</code> to be removed
	 * @see	#addColumn()
	 */	
	public function removeColumn(column:TableColumn):Void{
		var columnIndex:Int= ArrayUtils.indexInArray(tableColumns, column);
		if (columnIndex != (- 1)){
			if (selectionModel != null){
				selectionModel.removeIndexInterval(columnIndex, columnIndex);
			}
			checkLeadAnchor();
			column.removePropertyChangeListener(__propertyChanged);
			tableColumns.splice(columnIndex, 1);
			invalidateWidthCache();
			fireColumnRemoved(new TableColumnModelEvent(this, columnIndex, 0));
		}
	}
	
	/**
	 * Moves the column and heading at <code>columnIndex</code> to
	 * <code>newIndex</code>.  The old column at <code>columnIndex</code>
	 * will now be found at <code>newIndex</code>.  The column
	 * that used to be at <code>newIndex</code> is shifted
	 * left or right to make room.  This will not move any columns if
	 * <code>columnIndex</code> equals <code>newIndex</code>.  This method
	 * also posts a <code>columnMoved</code> event to its listeners.
	 *
	 * @param columnIndex the index of column to be moved
	 * @param newIndex	  new index to move the column
	 * @exception Error	if <code>column</code> or
	 * 						<code>newIndex</code>
	 *						are not in the valid range
	 */	
	public function moveColumn(columnIndex:Int, newIndex:Int):Void{
		if ((((columnIndex < 0) || (columnIndex >= getColumnCount())) || (newIndex < 0)) || (newIndex >= getColumnCount())){
			trace("Error : moveColumn() - Index out of range");
			throw new Error("moveColumn() - Index out of range");
			return;
		}
		var aColumn:TableColumn;
		if (columnIndex == newIndex){
			fireColumnMoved(new TableColumnModelEvent(this, columnIndex, newIndex));
			return ;
		}
		aColumn =AsWingUtils.as(tableColumns[columnIndex], TableColumn);
		tableColumns.splice(columnIndex, 1);
		var selected:Bool= selectionModel.isSelectedIndex(columnIndex);
		selectionModel.removeIndexInterval(columnIndex, columnIndex);
		tableColumns.insert(newIndex, aColumn);
		selectionModel.insertIndexInterval(newIndex, 1, true);
		if(selected)	{
			selectionModel.addSelectionInterval(newIndex, newIndex);
		}else{
			selectionModel.removeSelectionInterval(newIndex, newIndex);
		}
		fireColumnMoved(new TableColumnModelEvent(this, columnIndex, newIndex));
	}
	
	/**
	 * Sets the column margin to <code>newMargin</code>.  This method
	 * also posts a <code>columnMarginChanged</code> event to its
	 * listeners.
	 *
	 * @param newMargin the new margin width, in pixels
	 * @see	#getColumnMargin()
	 * @see	#getTotalColumnWidth()
	 */	
	public function setColumnMargin(newMargin:Int):Void{
		if (newMargin != columnMargin){
			columnMargin = newMargin;
			fireColumnMarginChanged();
		}
	}
	
	/**
	 * Returns the number of columns in the <code>tableColumns</code> array.
	 *
	 * @return	the number of columns in the <code>tableColumns</code> array
	 * @see	#getColumns()
	 */	
	public function getColumnCount():Int{
		return tableColumns.length;
	}
	
	/**
	 * Returns an <code>Array</code> of all the columns in the model.
	 * @return an <code>Array</code> of the columns in the model
	 */	
	public function getColumns():Array<Dynamic>{
		return tableColumns.copy();
	}
	
	/**
	 * Returns the index of the first column in the <code>tableColumns</code>
	 * array whose identifier is equal to <code>identifier</code>,
	 * when compared using <code>equals</code>.
	 *
	 * @param identifier the identifier object
	 * @return the index of the first column in the 
	 *			<code>tableColumns</code> array whose identifier
	 *			is equal to <code>identifier</code>
	 * @exception Error  if <code>identifier</code>
	 *				is <code>null</code>, or if no
	 *				<code>TableColumn</code> has this
	 *				<code>identifier</code>
	 * @see #getColumn()
	 */	
	public function getColumnIndex(identifier:Dynamic):Int{
		if (identifier == null){
			trace("Error : Identifier is null");
			throw new Error("Identifier is null");
		}
		var enumeration:Array<Dynamic>= getColumns();
		var aColumn:TableColumn;
		var index:Int= 0;
		for(i in 0...enumeration.length){
			aColumn = AsWingUtils.as(enumeration[i],TableColumn);
			if (identifier == aColumn.getIdentifier()){
				return index;
			}
			index++;
		}
		trace("Error : Identifier is null");
		throw new Error("Identifier not found");
	}
	
	/**
	 * Returns the <code>TableColumn</code> object for the column
	 * at <code>columnIndex</code>.
	 *
	 * @param	columnIndex	the index of the column desired
	 * @return	the <code>TableColumn</code> object for the column
	 *				at <code>columnIndex</code>
	 */	
	public function getColumn(columnIndex:Int):TableColumn{
		return AsWingUtils.as(tableColumns[columnIndex],TableColumn);
	}
	
	/**
	 * Returns the width margin for <code>TableColumn</code>.
	 * The default <code>columnMargin</code> is 1.
	 *
	 * @return the maximum width for the <code>TableColumn</code>
	 * @see	#setColumnMargin()
	 */	
	public function getColumnMargin():Int{
		return columnMargin;
	}
	
	/**
	 * Returns the index of the column that lies at position <code>x</code>,
	 * or -1 if no column covers this point.
	 * <p>
	 * In keeping with Swing's separable model architecture, a
	 * TableColumnModel does not know how the table columns actually appear on
	 * screen.  The visual presentation of the columns is the responsibility
	 * of the view/controller object using this model (typically JTable).  The
	 * view/controller need not display the columns sequentially from left to
	 * right.  For example, columns could be displayed from right to left to
	 * accomodate a locale preference or some columns might be hidden at the
	 * request of the user.  Because the model does not know how the columns
	 * are laid out on screen, the given <code>xPosition</code> should not be
	 * considered to be a coordinate in 2D graphics space.  Instead, it should
	 * be considered to be a width from the start of the first column in the
	 * model.  If the column index for a given X coordinate in 2D space is
	 * required, <code>JTable.columnAtPoint</code> can be used instead.
	 *
	 * @param x  the horizontal location of interest
	 * @return the index of the column or -1 if no column is found
	 * @see org.aswing.JTable#columnAtPoint()
	 */	
	public function getColumnIndexAtX(x:Int):Int{
		if (x < 0){
			return -1;
		}
		var cc:Int= getColumnCount();
		for (column in 0...cc){
			x = (x - getColumn(column).getWidth());
			if (x < 0){
				return column;
			}
		}
		return -1;
	}
	
	/**
	 * Returns the total combined width of all columns.
	 * @return the <code>totalColumnWidth</code> property
	 */	
	public function getTotalColumnWidth():Int{
		if (totalColumnWidth == (-1)){
			recalcWidthCache();
		}
		return totalColumnWidth;
	}
	
	/**
	 *  Sets the selection model for this <code>TableColumnModel</code>
	 *  to <code>newModel</code>
	 *  and registers for listener notifications from the new selection
	 *  model.  If <code>newModel</code> is <code>null</code>,
	 *  nothing will be changed. 
	 *
	 * @param newModel the new selection model
	 * @see	#getSelectionModel()
	 */	
	public function setSelectionModel(newModel:ListSelectionModel):Void{
		if (newModel == null){
			trace("Setting null ListSelectionModel ignored");
			return;
		}
		var oldModel:ListSelectionModel = selectionModel;
		if (newModel != oldModel){
			if (oldModel != null){
				oldModel.removeListSelectionListener(__selectionChanged);
			}
			selectionModel = newModel;
			newModel.addListSelectionListener(__selectionChanged);
			checkLeadAnchor();
		}
	}
	
	/**
	 * Returns the <code>ListSelectionModel</code> that is used to
	 * maintain column selection state.
	 *
	 * @return	the object that provides column selection state.  Or
	 *		<code>null</code> if row selection is not allowed.
	 * @see	#setSelectionModel()
	 */	
	public function getSelectionModel():ListSelectionModel{
		return selectionModel;
	}
	
	/**
	 * Initialize the lead and anchor of the selection model
	 * based on what the column model contains.
	 */	
	private function checkLeadAnchor():Void{
		var lead:Int= selectionModel.getLeadSelectionIndex();
		var count:Int= tableColumns.length;
		if (count == 0){
			if (lead != (- 1)){
				//TODO check if this is needed to add
				//selectionModel.setValueIsAdjusting(true);
				selectionModel.setAnchorSelectionIndex(- 1);
				selectionModel.setLeadSelectionIndex(- 1);
				//selectionModel.setValueIsAdjusting(false);
			}
		}else{
			if (lead == (- 1)){
				if (selectionModel.isSelectedIndex(0)){
					selectionModel.addSelectionInterval(0, 0);
				}else{
					selectionModel.removeSelectionInterval(0, 0);
				}
			}
		}
	}
	
	/**
	 * Sets whether column selection is allowed.  The default is false.
	 * @param  flag true if column selection will be allowed, false otherwise
	 */	
	public function setColumnSelectionAllowed(flag:Bool):Void{
		columnSelectionAllowed = flag;
	}
	/**
	 * Returns true if column selection is allowed, otherwise false.
	 * The default is false.
	 * @return the <code>columnSelectionAllowed</code> property
	 */	
	public function getColumnSelectionAllowed():Bool{
		return columnSelectionAllowed;
	}
	/**
	 * Returns an array of selected columns.  If <code>selectionModel</code>
	 * is <code>null</code>, returns an empty array.
	 * @return an array of selected columns or an empty array if nothing
	 *			is selected or the <code>selectionModel</code> is
	 *			<code>null</code>
	 */	
	public function getSelectedColumns():Array<Dynamic>{
		if (selectionModel != null){
			var iMin:Int= selectionModel.getMinSelectionIndex();
			var iMax:Int= selectionModel.getMaxSelectionIndex();
			if ((iMin == (- 1)) || (iMax == (- 1))){
				return new Array<Dynamic>();
			}
			var rv:Array<Dynamic>= new Array<Dynamic>();
			for (i in iMin...iMax+1){
				if (selectionModel.isSelectedIndex(i)){
					rv.push(i);
				}
			}
			return rv;
		}
		return new Array<Dynamic>();
	}
	
	/**
	 * Returns the number of columns selected.
	 * @return the number of columns selected
	 */	
	public function getSelectedColumnCount():Int{
		if (selectionModel != null){
			var iMin:Int= selectionModel.getMinSelectionIndex();
			var iMax:Int= selectionModel.getMaxSelectionIndex();
			var count:Int= 0;
			for (i in iMin...iMax+1){
				if (selectionModel.isSelectedIndex(i)){
					count++;
				}
			}
			return count;
		}
		return 0;
	}
	
	public function addColumnModelListener(x:TableColumnModelListener):Void{
		listenerList.push(x);
	}
	
	public function removeColumnModelListener(x:TableColumnModelListener):Void{
		ArrayUtils.removeFromArray(listenerList, x);
	}
	
	public function getColumnModelListeners():Array<Dynamic>{
		return listenerList.copy();
	}
	
	private function fireColumnAdded(e:TableColumnModelEvent):Void{
		var listeners:Array<Dynamic>= listenerList;
		// Process the listeners last to first, notifying
		// those that are interested in this event
		for (i in 0...(listeners.length ) ){
			var lis:TableColumnModelListener = AsWingUtils.as(listeners[i],TableColumnModelListener);
			lis.columnAdded(e);
		}
	}
	
	private function fireColumnRemoved(e:TableColumnModelEvent):Void{
		var listeners:Array<Dynamic>= listenerList;
		// Process the listeners last to first, notifying
		// those that are interested in this event
		for (i in 0...(listeners.length  ) ){
			var lis:TableColumnModelListener = AsWingUtils.as(listeners[i],TableColumnModelListener);
			lis.columnRemoved(e);
		}
	}
	
	private function fireColumnMoved(e:TableColumnModelEvent):Void{
		var listeners:Array<Dynamic>= listenerList;
		// Process the listeners last to first, notifying
		// those that are interested in this event
		for (i in 0...(listeners.length ) ){
			var lis:TableColumnModelListener = AsWingUtils.as(listeners[i],TableColumnModelListener);
			lis.columnMoved(e);
		}
	}
	
	private function fireColumnSelectionChanged(firstIndex:Int, lastIndex:Int, programmatic:Bool):Void{
		var listeners:Array<Dynamic>= listenerList;
		// Process the listeners last to first, notifying
		// those that are interested in this event
		for (i in 0...(listeners.length ) ){
			var lis:TableColumnModelListener = AsWingUtils.as(listeners[i],TableColumnModelListener);
			lis.columnSelectionChanged(this, firstIndex, lastIndex, programmatic);
		}
	}
	
	private function fireColumnMarginChanged():Void{
		var listeners:Array<Dynamic>= listenerList;
		// Process the listeners last to first, notifying
		// those that are interested in this event
		for (i in 0...(listeners.length  ) ){
			var lis:TableColumnModelListener = AsWingUtils.as(listeners[i],TableColumnModelListener);
			lis.columnMarginChanged(this);
		}
	}
	
	public function getListeners():Array<Dynamic>{
		return listenerList.copy();
	}
	
	private function __propertyChanged(e:PropertyChangeEvent):Void{
		if ((e.getPropertyName() == "width") || (e.getPropertyName() == "preferredWidth")){
			invalidateWidthCache();
			// This is a misnomer, we're using this method 
			// simply to cause a relayout. 
			fireColumnMarginChanged();
		}
	}
	
	private function __selectionChanged(e:SelectionEvent):Void{
		fireColumnSelectionChanged(e.getFirstIndex(), e.getLastIndex(), e.isProgrammatic());
	}
	
	private function createSelectionModel():ListSelectionModel{
		return new DefaultListSelectionModel();
	}
	
	/**
	 * Recalculates the total combined width of all columns.  Updates the
	 * <code>totalColumnWidth</code> property.
	 */	
	private function recalcWidthCache():Void{
		var enumeration:Array<Dynamic>= tableColumns;
		totalColumnWidth = 0;
		for(i in 0...enumeration.length){
			var c:TableColumn = enumeration[i];
			totalColumnWidth += c.getWidth();
		}
	}
	
	private function invalidateWidthCache():Void{
		totalColumnWidth = -1;
	}
	
	public function toString():String{
		return "DefaultTableColumnModel[]";
	}
}