/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


import org.aswing.error.Error;
import org.aswing.Container;
import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.JTable;
import org.aswing.plaf.ComponentUI;
import org.aswing.UIManager;
import org.aswing.plaf.basic.BasicTableHeaderUI;

/**
 * This is the object which manages the header of the <code>JTable</code>.
 * <p>
 * @author paling
 */
class JTableHeader extends Container  implements TableColumnModelListener{

	private static var uiClassID:String= "TableHeaderUI";
	private var table:JTable;
	private var columnModel:TableColumnModel;
	private var reorderingAllowed:Bool;
	private var resizingAllowed:Bool;
	private var resizingColumn:TableColumn;
	private var defaultRenderer:TableCellFactory;
	private var rowHeight:Int;

	/**
	 * Constructs a <code>JTableHeader</code> which is initialized with
	 * <code>cm</code> as the column model.  If <code>cm</code> is
	 * <code>null</code> this method will initialize the table header
	 * with a default <code>TableColumnModel</code>.
	 *
	 * @param cm	the column model for the table
	 * @see #createDefaultColumnModel()
	 */
	public function new(cm:TableColumnModel){
		super();
		setName("JTableHeader");
		setFocusable(false);
		if (cm == null){
			cm = createDefaultColumnModel();
		}
		setColumnModel(cm);
		initializeLocalVars();
		updateUI();
	}
	
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
		resizeAndRepaint();
		invalidate();
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicTableHeaderUI;
    }

	
	override public function getUIClassID():String{
		return uiClassID;
	}	
	
	/**
	 * Make it do not invalidate parents if it located in a JTable
	 */
	override public function invalidate():Void{
		if(parent == getTable()){
			valid = false;
		}else{
			super.invalidate();
		}
	}
	
	override public function revalidate():Void{
		if(parent == getTable()){
			valid = false;
		}else{
			super.revalidate();
		}
	}
	
	/**
	 * If it located in a JTable return true.
	 */
	override public function isValidateRoot():Bool{
		return (parent == getTable());
	}
	
	/**
	 * Make it do not repaint if it located in a JTable
	 */	
	override public function repaint():Void{
		if(parent == getTable()){
		}else{
			super.repaint();
		}
	}
	
	/** 
	 * Sets the table associated with this header. 
	 * @param table the new table
	 */
	public function setTable(table:JTable):Void{
		//var old:JTable = this.table;
		this.table = table;
		//firePropertyChange("table", old, table);
	}
	
	/** 
	 * Returns the table associated with this header. 
	 * @return  the <code>table</code> property
	 */	
	public function getTable():JTable{
		return table;
	}
	
	/**
	 * Sets the height, in pixels, of all cells to <code>rowHeight</code>,
	 * revalidates, and repaints.
	 * The height of the cells will be equal to the row height minus
	 * the row margin.
	 *
	 * @param   rowHeight					   new row height
	 * @exception Error	  if <code>rowHeight</code> is
	 *										  less than 1
	 * @see	 #getAllRowHeight()
	 */	
	public function setRowHeight(rowHeight:Int):Void{
		if (rowHeight < 1){
			trace("Error : New row height less than 1");
			throw new Error("New row height less than 1"); 
		}
		//var old:int = this.rowHeight;
		this.rowHeight = rowHeight;
		resizeAndRepaint();
		//firePropertyChange("rowHeight", old, rowHeight);
	}
	
	/**
	 * Returns the height of row, in pixels.
	 * The default row height is 16.0.
	 *
	 * @return  the height in pixels of row
	 * @see	 #setAllRowHeight()
	 */	
	public function getRowHeight():Int{
		return rowHeight;
	}
		
	/**
	 * Sets whether the user can drag column headers to reorder columns.
	 *
	 * @param reorderingAllowed	true if the table view should allow reordering; otherwise false
	 * @see	#getReorderingAllowed()
	 */	
	public function setReorderingAllowed(reorderingAllowed:Bool):Void{
		//var old:Boolean = this.reorderingAllowed;
		this.reorderingAllowed = reorderingAllowed;
		//firePropertyChange("reorderingAllowed", old, reorderingAllowed);
	}

	/**
	 * Returns true if the user is allowed to rearrange columns by
	 * dragging their headers, false otherwise. The default is true. You can
	 * rearrange columns programmatically regardless of this setting.
	 *
	 * @return the <code>reorderingAllowed</code> property
	 * @see	#setReorderingAllowed
	 */	
	public function getReorderingAllowed():Bool{
		return reorderingAllowed;
	}
	
	/**
	 * Sets whether the user can resize columns by dragging between headers.
	 *
	 * @param resizingAllowed true if table view should allow resizing
	 * @see	#getResizingAllowed()   
	 */	
	public function setResizingAllowed(resizingAllowed:Bool):Void{
		//var old:Boolean = this.resizingAllowed;
		this.resizingAllowed = resizingAllowed;
		//firePropertyChange("resizingAllowed", old, resizingAllowed);
	}
	
	/**
	 * Returns true if the user is allowed to resize columns by dragging
	 * between their headers, false otherwise. The default is true. You can
	 * resize columns programmatically regardless of this setting.
	 *
	 * @return the <code>resizingAllowed</code> property
	 * @see	#setResizingAllowed()
	 */	
	public function getResizingAllowed():Bool{
		return resizingAllowed;
	}
	
	/**
	 * Returns the resizing column.  If no column is being
	 * resized this method returns <code>null</code>.
	 *
	 * @return	the resizing column, if a resize is in process, otherwise
	 *		returns <code>null</code>
	 */	
	public function getResizingColumn():TableColumn{
		return resizingColumn;
	}
	
	/**
	 * Sets the default renderer to be used when no <code>headerRenderer</code>
	 * is defined by a <code>TableColumn</code>.
	 * @param defaultRenderer  the default renderer
	 */	
	public function setDefaultRenderer(defaultRenderer:TableCellFactory):Void{
		this.defaultRenderer = defaultRenderer;
	}
	
	/**
	 * Returns the default renderer used when no <code>headerRenderer</code>
	 * is defined by a <code>TableColumn</code>.  
	 * @return the default renderer
	 */	
	public function getDefaultRenderer():TableCellFactory{
		return defaultRenderer;
	}
	
	/**
	 * Returns the index of the column that <code>point</code> lies in, or -1 if it
	 * lies out of bounds.
	 *
	 * @return the index of the column that <code>point</code> lies in, or -1 if it
	 *			lies out of bounds
	 */	
	public function columnAtPoint(point:IntPoint):Int{
		var x:Int= point.x;
		return getColumnModel().getColumnIndexAtX(x);
	}
	
	/**
	 * Returns the rect containing the header tile at <code>column</code>.
	 * When the <code>column</code> parameter is out of bounds this method uses the 
	 * same conventions as the <code>JTable</code> method <code>getCellRect</code>. 
	 *
	 * @return the rect containing the header tile at <code>column</code>
	 * @see JTable#getCellRect()
	 */	
	public function getHeaderRect(column:Int):IntRectangle{
		var r:IntRectangle = new IntRectangle();
		var cm:TableColumnModel = getColumnModel();
		r.height = getHeight();
		if (column < 0){
		}else if (column >= cm.getColumnCount()){
			r.x = getWidth();
		}else{
			for (i in 0...column){
				r.x += cm.getColumn(i).getWidth();
			}
			r.width = cm.getColumn(column).getWidth();
		}
		return r;
	}
	
	/**
	 *  Sets the column model for this table to <code>newModel</code> and registers
	 *  for listener notifications from the new column model. 
	 *  if <code>newModel</code> is <code>null</code>, nothing will happen except a trace.
	 *
	 * @param	columnModel	the new data source for this table
	 * @see	#getColumnModel()
	 */	
	public function setColumnModel(columnModel:TableColumnModel):Void{
		if (columnModel == null){
			trace("Cannot set a null ColumnModel, Ignored");
			return;
		}
		var old:TableColumnModel = this.columnModel;
		if (columnModel != old){
			if (old != null){
				old.removeColumnModelListener(this);
			}
			this.columnModel = columnModel;
			columnModel.addColumnModelListener(this);
			//firePropertyChange("columnModel", old, columnModel);
			resizeAndRepaint();
		}
	}
	
	/**
	 * Returns the <code>TableColumnModel</code> that contains all column information
	 * of this table header.
	 *
	 * @return	the <code>columnModel</code> property
	 * @see	#setColumnModel()
	 */	
	public function getColumnModel():TableColumnModel{
		return columnModel;
	}
	
	//****************************************************
	//	 TableColumnModelListener implementation
	//****************************************************
	public function columnAdded(e:TableColumnModelEvent):Void{
		resizeAndRepaint();
	}
	public function columnRemoved(e:TableColumnModelEvent):Void{
		resizeAndRepaint();
	}
	public function columnMoved(e:TableColumnModelEvent):Void{
		repaint();
	}
	public function columnMarginChanged(source:TableColumnModel):Void{
		resizeAndRepaint();
	}
	public function columnSelectionChanged(source:TableColumnModel, firstIndex:Int, lastIndex:Int, programmatic:Bool):Void{
	}
	
	
	/**
	 *  Returns the default column model object which is
	 *  a <code>DefaultTableColumnModel</code>.  A subclass can override this
	 *  method to return a different column model object
	 *
	 * @return the default column model object
	 */	
	private function createDefaultColumnModel():TableColumnModel{
		return new DefaultTableColumnModel();
	}
	
	/**
	 *  Returns a default renderer to be used when no header renderer 
	 *  is defined by a <code>TableColumn</code>. 
	 *
	 *  @return the default table column renderer
	 */	
	private function createDefaultRenderer():TableCellFactory{
		return new GeneralTableCellFactoryUIResource(DefaultTextHeaderCell);
	}
	
	/**
	 * Initializes the local variables and properties with default values.
	 * Used by the constructor methods.
	 */	
	private function initializeLocalVars():Void{
		setOpaque(true);
		setRowHeight(24);
		table = null;
		reorderingAllowed = true;
		resizingAllowed = true;
		resizingColumn = null;
		setDefaultRenderer(createDefaultRenderer());
	}
	
	/**
	 * Sizes the header and marks it as needing display.  Equivalent
	 * to <code>revalidate</code> followed by <code>repaint</code>.
	 */	
	public function resizeAndRepaint():Void{
		revalidate();
		repaint();
	}
	
	/**  
	 * Sets the header's <code>resizingColumn</code> to <code>aColumn</code>.
	 * <p>
	 * Application code will not use this method explicitly, it
	 * is used internally by the column sizing mechanism.
	 *
	 * @param aColumn  the column being resized, or <code>null</code> if
	 *			no column is being resized
	 */	
	public function setResizingColumn(aColumn:TableColumn):Void{
		resizingColumn = aColumn;
	}
}