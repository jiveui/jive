/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table.sorter;


import flash.events.MouseEvent;

import org.aswing.Icon;
	import org.aswing.event.TableModelListener;
	import org.aswing.event.TableModelEvent;
	import org.aswing.event.ReleaseEvent;
	import org.aswing.geom.IntPoint;
	import org.aswing.table.AbstractTableModel;
import org.aswing.table.JTableHeader;
import org.aswing.table.TableCellFactory;
import org.aswing.table.TableColumnModel;
import org.aswing.table.TableModel;
import org.aswing.util.ArrayUtils;
 

/**
 * A class that make your JTable sortable. Usage:
 * <pre>
 * var sorter:TableSorter = new TableSorter(yourTableModel);
 * sorter.setTableHeader(yourTable.getTableHeader());
 * yourTable.setModel(sorter);
 * </pre>
 * @author paling
 */
class TableSorter extends AbstractTableModel  implements TableModelListener{
	
    inline public static var DESCENDING:Int= -1;
    inline public static var NOT_SORTED:Int= 0;
    inline public static var ASCENDING:Int= 1;

    private static var EMPTY_DIRECTIVE:Directive;
    public static var NUMBER_COMAPRATOR:Dynamic ->Dynamic-> Int;
    public static var LEXICAL_COMPARATOR:Dynamic ->Dynamic-> Int;
    
    private static var inited:Bool= false;

    private var tableModel:TableModel;
    private var viewToModel:Array<Dynamic>; //Row[]
    private var modelToView:Array<Dynamic>; //int[]
    private var columnSortables:Array<Dynamic>;

    private var tableHeader:JTableHeader;
    private var tableModelListener:TableModelListener;
    private var columnComparators:haxe.ds.StringMap<Dynamic ->Dynamic-> Int>;
    private var sortingColumns:Array<Dynamic>;
	
	/**
	 * TableSorter(tableModel:TableModel, tableHeader:JTableHeader)<br>
	 * TableSorter(tableModel:TableModel)<br>
	 * TableSorter()<br>
	 */
    public function new(tableModel:TableModel, tableHeader:JTableHeader=null) {
        super();
        initStatics();
        columnComparators  = new haxe.ds.StringMap<Dynamic ->Dynamic-> Int>();
        sortingColumns     = new Array<Dynamic>();
        columnSortables    = new Array<Dynamic>();
        tableModelListener = this;
        setTableHeader(tableHeader);
        setTableModel(tableModel);
    }
    
    private function initStatics():Void{
        if(inited!=true){
			EMPTY_DIRECTIVE = new Directive(-1, NOT_SORTED);

			NUMBER_COMAPRATOR = function(o1:Dynamic, o2:Dynamic):Int{
				o1 = Std.parseFloat(o1);
				o2 = Std.parseFloat(o2);
				return o1 == o2 ? 0 : (o1 > o2 ? 1 : -1);
		    };
    
			LEXICAL_COMPARATOR = function(o1:Dynamic, o2:Dynamic):Int{
		    	o1 = o1.toString();
		    	o2 = o2.toString();
				return o1 == o2 ? 0 : (o1 > o2 ? 1 : -1);
		    };
        	inited = true;
        }
    }

    private function clearSortingState():Void{
        viewToModel = null;
        modelToView = null;
    }

    public function getTableModel():TableModel {
        return tableModel;
    }
	
	/**
	 * Sets the tableModel
	 * @param tableModel the tableModel
	 */
    public function setTableModel(tableModel:TableModel):Void{
        if (this.tableModel != null) {
            this.tableModel.removeTableModelListener(tableModelListener);
        }

        this.tableModel = tableModel;
        if (this.tableModel != null) {
            this.tableModel.addTableModelListener(tableModelListener);
        }

        clearSortingState();
        fireTableStructureChanged();
    }

    public function getTableHeader():JTableHeader {
        return tableHeader;
    }
	
	/**
	 * Sets the table header
	 * @param tableHeader the table header
	 */
    public function setTableHeader(tableHeader:JTableHeader):Void{
        if (this.tableHeader != null) {
            this.tableHeader.removeEventListener(MouseEvent.MOUSE_DOWN, __mousePress);
            this.tableHeader.removeEventListener(ReleaseEvent.RELEASE, __mouseRelease);
            var defaultRenderer:TableCellFactory = this.tableHeader.getDefaultRenderer();
            if (Std.is(defaultRenderer,SortableHeaderRenderer)) {
                this.tableHeader.setDefaultRenderer((AsWingUtils.as(defaultRenderer,SortableHeaderRenderer)).getTableCellFactory());
            }
        }
        this.tableHeader = tableHeader;
        if (this.tableHeader != null) {
            this.tableHeader.addEventListener(MouseEvent.MOUSE_DOWN, __mousePress);
            this.tableHeader.addEventListener(ReleaseEvent.RELEASE, __mouseRelease);
			new SortableHeaderRenderer(this.tableHeader.getDefaultRenderer(), this);
            this.tableHeader.setDefaultRenderer(  new SortableHeaderRenderer(this.tableHeader.getDefaultRenderer(), this));
        }
    }

    public function isSorting():Bool{
        return sortingColumns.length != 0;
    }
    
    public function getSortingColumns():Array<Dynamic>{
    	return sortingColumns;
    }
    
    /**
     * Sets specified column sortable, default is true.
     * @param column   column
     * @param sortable true to set the column sortable, false to not
     */
    public function setColumnSortable(column:Int, sortable:Bool):Void{
    	if(isColumnSortable(column) != sortable){
    		columnSortables[column] = sortable;
    		if(!sortable && getSortingStatus(column) != NOT_SORTED){
    			setSortingStatus(column, NOT_SORTED);
    		}
    	}
    }
    
    /**
     * Returns specified column sortable, default is true.
     * @return true if the column is sortable, false otherwish
     */    
    public function isColumnSortable(column:Int):Bool{
    	return columnSortables[column] != false;
    }
    
    private function getDirective(column:Int):Directive {
        for (i in 0...sortingColumns.length){
            var directive:Directive = AsWingUtils.as(sortingColumns[i],Directive);
            if (directive.column == column) {
                return directive;
            }
        }
        return EMPTY_DIRECTIVE;
    }

    public function getSortingStatus(column:Int):Int{
        return Std.int(getDirective(column).direction);
    }

    private function sortingStatusChanged():Void{
        clearSortingState();
        fireTableDataChanged();
        if (tableHeader != null) {
            tableHeader.repaint();
        }
    }
	
	/**
	 * Sets specified column to be sort as specified direction.
	 * @param column the column to be sort
	 * @param status sort direction, should be one of these values:
	 * <ul>
	 * <li> DESCENDING : descending sort 
	 * <li> NOT_SORTED : not sort
	 * <li> ASCENDING  : ascending sort
	 * </ul>
	 */
    public function setSortingStatus(column:Int, status:Int):Void{
        var directive:Directive = getDirective(column);
        if (directive != EMPTY_DIRECTIVE) {
        	ArrayUtils.removeFromArray(sortingColumns, directive);
        }
        if (status != NOT_SORTED) {
        	sortingColumns.push(new Directive(column, status));
        }
        sortingStatusChanged();
    }

    public function getHeaderRendererIcon(column:Int, size:Int):Icon {
        var directive:Directive = getDirective(column);
        if (directive == EMPTY_DIRECTIVE) {
            return null;
        }
        return new Arrow(directive.direction == DESCENDING, size);//, sortingColumns.indexOf(directive));
    }
	
	/**
	 * Cancels all sorting column to be NOT_SORTED.
	 */
    public function cancelSorting():Void{
        sortingColumns.splice(0,sortingColumns.length);
        sortingStatusChanged();
    }
	
	/**
	 * Sets a comparator the specified columnClass. For example:
	 * <pre>
	 * setColumnComparator("Number", aNumberComparFunction);
	 * </pre>
	 * @param columnClass the column class name
	 * @param comparator the comparator function should be this spec:
	 * 			function(o1, o2):int, it should return -1 or 0 or 1.
	 * @see org.aswing.table.TableModel#getColumnClass()
	 */
    public function setColumnComparator(columnClass:String, comparator:Dynamic ->Dynamic-> Int):Void{
        if (comparator == null) {
            columnComparators.remove(columnClass);
        } else {
            columnComparators.set(columnClass, comparator);
        }
    }
	
	/**
	 * Returns the comparator function for given column.
	 * @return the comparator function for given column.
	 * @see #setColumnComparator()
	 */
    public function getComparator(column:Int):Dynamic ->Dynamic-> Int{
        var columnType:String= tableModel.getColumnClass(column);
        var comparator:Dynamic -> Dynamic->Int=  columnComparators.get(columnType)  ;
        if (comparator != null) {
            return comparator;
        }
        if(columnType == "Number"){
			return NUMBER_COMAPRATOR;
        }else{
        	return LEXICAL_COMPARATOR;
        }
    }

    private function getViewToModel():Array<Dynamic>{
        if (viewToModel == null) {
            var tableModelRowCount:Int= tableModel.getRowCount();
            viewToModel = new Array<Dynamic>();
            for (row in 0...tableModelRowCount){
                viewToModel[row] = new Row(this, row);
            }

            if (isSorting()) {
                viewToModel.sort(sortImp);
            }
        }
        return viewToModel;
    }
    
    private function sortImp(row1:Row, row2:Row):Int{
    	return row1.compareTo(row2);
    }
	
	/**
	 * Calculates the model index from the sorted index.
	 * @return the index in model from the sorter model index
	 */
    public function modelIndex(viewIndex:Int):Int{
        return getViewToModel()[viewIndex].getModelIndex();
    }

    private function getModelToView():Array<Dynamic>{ //int[]
        if (modelToView == null) {
            var n:Int= getViewToModel().length;
            modelToView = new Array<Dynamic>();
            for (i in 0...n){
                modelToView[modelIndex(i)] = i;
            }
        }
        return modelToView;
    }

    // TableModel interface methods 

    override public function getRowCount():Int{
        return (tableModel == null) ? 0 : tableModel.getRowCount();
    }

    override public function getColumnCount():Int{
        return (tableModel == null) ? 0 : tableModel.getColumnCount();
    }

    override public function getColumnName(column:Int):String{
        return tableModel.getColumnName(column);
    }

    override public function getColumnClass(column:Int):String{
        return tableModel.getColumnClass(column);
    }

    override public function isCellEditable(row:Int, column:Int):Bool{
        return tableModel.isCellEditable(modelIndex(row), column);
    }

    override public function getValueAt(row:Int, column:Int):Dynamic{
        return tableModel.getValueAt(modelIndex(row), column);
    }

    override public function setValueAt(aValue:Dynamic, row:Int, column:Int):Void{
        tableModel.setValueAt(aValue, modelIndex(row), column);
    }

    public function tableChanged(e:TableModelEvent):Void{
        // If we're not sorting by anything, just pass the event along.             
        if (!isSorting()) {
            clearSortingState();
            fireTableChanged(e);
            return;
        }
            
        // If the table structure has changed, cancel the sorting; the             
        // sorting columns may have been either moved or deleted from             
        // the model. 
        if (e.getFirstRow() == TableModelEvent.HEADER_ROW) {
            cancelSorting();
            fireTableChanged(e);
            return;
        }

        // We can map a cell event through to the view without widening             
        // when the following conditions apply: 
        // 
        // a) all the changes are on one row (e.getFirstRow() == e.getLastRow()) and, 
        // b) all the changes are in one column (column != TableModelEvent.ALL_COLUMNS) and,
        // c) we are not sorting on that column (getSortingStatus(column) == NOT_SORTED) and, 
        // d) a reverse lookup will not trigger a sort (modelToView != null)
        //
        // Note: INSERT and DELETE events fail this test as they have column == ALL_COLUMNS.
        // 
        // The last check, for (modelToView != null) is to see if modelToView 
        // is already allocated. If we don't do this check; sorting can become 
        // a performance bottleneck for applications where cells  
        // change rapidly in different parts of the table. If cells 
        // change alternately in the sorting column and then outside of             
        // it this class can end up re-sorting on alternate cell updates - 
        // which can be a performance problem for large tables. The last 
        // clause avoids this problem. 
        var column:Int= e.getColumn();
        if (e.getFirstRow() == e.getLastRow()
                && column != TableModelEvent.ALL_COLUMNS
                && getSortingStatus(column) == NOT_SORTED
                && modelToView != null) {
            var viewIndex:Int= getModelToView()[e.getFirstRow()];
            fireTableChanged(new TableModelEvent(this, 
                                                 viewIndex, viewIndex, 
                                                 column, e.getType()));
            return;
        }

        // Something has happened to the data that may have invalidated the row order. 
        clearSortingState();
        fireTableDataChanged();
        return;
    }
    
    private var pressedPoint:IntPoint;
    private function __mousePress(e:MouseEvent):Void{
    	var header:JTableHeader = AsWingUtils.as(e.currentTarget,JTableHeader)	;
    	pressedPoint = header.getMousePosition();
    }

    private function __mouseRelease(e:ReleaseEvent):Void{
    	if(e.isReleasedOutSide()){
    		return;
    	}
        var h:JTableHeader = AsWingUtils.as(e.currentTarget,JTableHeader)	;
        var point:IntPoint = h.getMousePosition();
        //if user are dragging the header, not sort
        if(!point.equals(pressedPoint)){
        	return;
        }
        var columnModel:TableColumnModel = h.getColumnModel();
        var viewColumn:Int= columnModel.getColumnIndexAtX(h.getMousePosition().x);
        if(viewColumn == -1){
        	return;
        }
        var column:Int= columnModel.getColumn(viewColumn).getModelIndex();
        if (column != -1 && isColumnSortable(column)) {
            var status:Int= getSortingStatus(column);
            if(e.ctrlKey!=true) {
                cancelSorting();
            }
            status = nextSortingStatus(status, e.shiftKey);
            setSortingStatus(column, status);
        }
    }
    
    // Cycle the sorting states through {NOT_SORTED, ASCENDING, DESCENDING} or 
    // {NOT_SORTED, DESCENDING, ASCENDING} depending on whether shift is pressed.     
    // You can override this method to change the arithmetic
    private function nextSortingStatus(curStatus:Int, shiftKey:Bool):Int{
    	var status:Int= curStatus;
	    status = status + (shiftKey ? -1 : 1);
        status = (status + 4) % 3 - 1; // signed mod, returning {-1, 0, 1}
        return status;
    }
}