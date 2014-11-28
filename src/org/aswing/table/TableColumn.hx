/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


import org.aswing.Component;
import org.aswing.event.PropertyChangeEvent;
	import flash.events.EventDispatcher;
	
/**
 * Dispatched when a property changed.
 * @eventType org.aswing.event.PropertyChangeEvent.PROPERTY_CHANGE
 */
// [Event(name="propertyChange", type="org.aswing.event.PropertyChangeEvent")]

/**
 *  A <code>TableColumn</code> represents all the attributes of a column in a
 *  <code>JTable</code>, such as width, resizibility, minimum and maximum width.
 *  In addition, the <code>TableColumn</code> provides slots for a renderer and 
 *  an editor that can be used to display and edit the values in this column. 
 *  <p>
 *  It is also possible to specify renderers and editors on a per type basis
 *  rather than a per column basis - see the 
 *  <code>setDefaultRenderer</code> method in the <code>JTable</code> class.
 *  This default mechanism is only used when the renderer (or
 *  editor) in the <code>TableColumn</code> is <code>null</code>.
 * <p>
 *  The <code>TableColumn</code> stores the link between the columns in the
 *  <code>JTable</code> and the columns in the <code>TableModel</code>.
 *  The <code>modelIndex</code> is the column in the
 *  <code>TableModel</code>, which will be queried for the data values for the
 *  cells in this column. As the column moves around in the view this
 *  <code>modelIndex</code> does not change.
 *  <p>
 * <b>Note:</b> Some implementations may assume that all 
 *    <code>TableColumnModel</code>s are unique, therefore we would 
 *    recommend that the same <code>TableColumn</code> instance
 *    not be added more than once to a <code>TableColumnModel</code>.
 *    To show <code>TableColumn</code>s with the same column of
 *    data from the model, create a new instance with the same
 *    <code>modelIndex</code>.
 *  <p>
 * @author paling
 */
class TableColumn extends EventDispatcher{
	
	inline public static var COLUMN_WIDTH_PROPERTY:String= "columWidth";
	inline public static var HEADER_VALUE_PROPERTY:String= "headerValue";
	inline public static var HEADER_RENDERER_PROPERTY:String= "headerRenderer";
	inline public static var CELL_RENDERER_PROPERTY:String= "cellRenderer";
	
	private var modelIndex:Int;
	private var identifier:Dynamic;
	private var width:Int;
	private var minWidth:Int;
	private var preferredWidth:Int;
	private var maxWidth:Int;
	private var headerRenderer:TableCellFactory;
	private var headerValue:Dynamic;
	private var cellRenderer:TableCellFactory;
	private var cellEditor:TableCellEditor;
	private var isResizable:Bool;
	
	/**
	 * Create a TableColumn.
	 * @param modelIndex modelIndex
	 * @param width the    (optional)width of the column, default to 75
	 * @param cellRenderer (optional)the cell renderer for this column cells
	 * @param cellEditor   (optional)the cell editor for this column cells
	 */
	public function new(modelIndex:Int=0, width:Int=75, cellRenderer:TableCellFactory=null, cellEditor:TableCellEditor=null){
		this.modelIndex = modelIndex;
		this.width = width;
		this.preferredWidth = width;
		this.cellRenderer = cellRenderer;
		this.cellEditor = cellEditor;
		minWidth = 17;
		maxWidth = 100000; //default max width
		isResizable = true;
		//resizedPostingDisableCount = 0;
		headerValue = null;
		super();
	}
	
	private function firePropertyChangeIfReallyChanged(propertyName:String, oldValue:Dynamic, newValue:Dynamic):Void{
		if(oldValue != newValue){
			dispatchEvent(new PropertyChangeEvent(propertyName, oldValue, newValue));
		}
	}
	
	public function setModelIndex(modelIndex:Int):Void{
		var old:Int= this.modelIndex;
		this.modelIndex = modelIndex;
		firePropertyChangeIfReallyChanged("modelIndex", old, modelIndex);
	}
	
	public function getModelIndex():Int{
		return modelIndex;
	}
	
	public function setIdentifier(identifier:Dynamic):Void{
		var old:Dynamic= this.identifier;
		this.identifier = identifier;
		firePropertyChangeIfReallyChanged("identifier", old, identifier);
	}
	
	public function getIdentifier():Dynamic{
		return (((identifier != null) ? identifier : getHeaderValue()));
	}
	
	public function setHeaderValue(headerValue:Dynamic):Void{
		var old:Dynamic= this.headerValue;
		this.headerValue = headerValue;
		firePropertyChangeIfReallyChanged("headerValue", old, headerValue);
	}
	
	public function getHeaderValue():Dynamic{
		return headerValue;
	}
	
	public function setHeaderCellFactory(headerRenderer:TableCellFactory):Void{
		var old:TableCellFactory = this.headerRenderer;
		this.headerRenderer = headerRenderer;
		firePropertyChangeIfReallyChanged("headerRenderer", old, headerRenderer);
	}
	
	public function getHeaderCellFactory():TableCellFactory{
		return headerRenderer;
	}
	
	public function setCellFactory(cellRenderer:TableCellFactory):Void{
		var old:TableCellFactory = this.cellRenderer;
		this.cellRenderer = cellRenderer;
		firePropertyChangeIfReallyChanged("cellRenderer", old, cellRenderer);
	}
	
	public function getCellFactory():TableCellFactory{
		return cellRenderer;
	}
	
	public function setCellEditor(cellEditor:TableCellEditor):Void{
		var old:TableCellEditor = this.cellEditor;
		this.cellEditor = cellEditor;
		firePropertyChangeIfReallyChanged("cellEditor", old, cellEditor);
	}
	
	public function getCellEditor():TableCellEditor{ 
		return cellEditor;
	}
	
	public function setWidth(width:Int):Void{
		var old:Int= this.width;
		this.width = Std.int(Math.min(Math.max(width, minWidth), maxWidth));
		firePropertyChangeIfReallyChanged("width", old, this.width);
	}
	
	public function getWidth():Int{
		return width;
	}
	
	public function setPreferredWidth(preferredWidth:Int):Void{
		var old:Int= this.preferredWidth;
		this.preferredWidth = Std.int(Math.min(Math.max(preferredWidth, minWidth), maxWidth));
		firePropertyChangeIfReallyChanged("preferredWidth", old, this.preferredWidth);
	}
	
	public function getPreferredWidth():Int{
		return preferredWidth;
	}
	
	public function setMinWidth(minWidth:Int):Void{
		var old:Int= this.minWidth;
		this.minWidth = Std.int(Math.max(minWidth, 0));
		if (width < minWidth){
			setWidth(minWidth);
		}
		if (preferredWidth < minWidth){
			setPreferredWidth(minWidth);
		}
		firePropertyChangeIfReallyChanged("minWidth", old, this.minWidth);
	}
	
	public function getMinWidth():Int{
		return minWidth;
	}
	
	public function setMaxWidth(maxWidth:Int):Void{
		var old:Int= this.maxWidth;
		this.maxWidth =Std.int( Math.max(minWidth, maxWidth));
		if (width > maxWidth){
			setWidth(maxWidth);
		}
		if (preferredWidth > maxWidth){
			setPreferredWidth(maxWidth);
		}
		firePropertyChangeIfReallyChanged("maxWidth", old, this.maxWidth);
	}
	
	public function getMaxWidth():Int{
		return maxWidth;
	}
	
	public function setResizable(isResizable:Bool):Void{
		var old:Bool= this.isResizable;
		this.isResizable = isResizable;
		firePropertyChangeIfReallyChanged("isResizable", old, this.isResizable);
	}
	
	public function getResizable():Bool{
		return isResizable;
	}
	
    /**
     * Resizes the <code>TableColumn</code> to fit the width of its header cell.
     * This method does nothing if the header renderer is <code>null</code>
     * (the default case). Otherwise, it sets the minimum, maximum and preferred 
     * widths of this column to the widths of the minimum, maximum and preferred 
     * sizes of the Component delivered by the header renderer. 
     * The transient "width" property of this TableColumn is also set to the 
     * preferred width. Note this method is not used internally by the table 
     * package. 
     *
     * @see	#setPreferredWidth()
     */	
	public function sizeWidthToFit():Void{
		if (headerRenderer == null){
			return;
		}
		var cell:TableCell = headerRenderer.createNewCell(true);
		cell.setCellValue(getHeaderValue());
		var c:Component = cell.getCellComponent();
		setMinWidth(c.getMinimumSize().width);
		setMaxWidth(c.getMaximumSize().width);
		setPreferredWidth(c.getPreferredSize().width);
		setWidth(getPreferredWidth());
	}
	
    /**
     * Adds a property change listener.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.PropertyChangeEvent#PROPERTY_CHANGE
     */
    public function addPropertyChangeListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
    	addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, listener, false, priority, useWeakReference);
    }
	/**
	 * Removes a property change listener.
	 * @param listener the listener to be removed.
	 */
	public function removePropertyChangeListener(listener:Dynamic -> Void):Void{
		removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, listener);
	}
	
	public function createDefaultHeaderRenderer():TableCellFactory{
		var factory:TableCellFactory = new GeneralTableCellFactoryUIResource(DefaultTextCell);
		//TODO header cell
		return factory;
	}
}