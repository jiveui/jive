/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;
 

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;

import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.event.ReleaseEvent;
import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.table.JTableHeader;
	import org.aswing.table.TableColumn;
	import org.aswing.table.TableCellFactory;
	import org.aswing.table.TableColumnModel;
	import org.aswing.table.TableCell;
	/**
 * @author paling
 * @private
 */
class BasicTableHeaderUI extends BaseComponentUI{
	
	private var header:JTableHeader;
	private var cells:Array<Dynamic>;
	private var mouseXOffset:Int;
	private var resizeCursor:DisplayObject;
	private var resizing:Bool;
	
	public function new() {
		super();
		mouseXOffset = 0;
		resizing = false;
		resizeCursor = Cursor.createCursor(Cursor.H_MOVE_CURSOR);
	}
	
	private function getPropertyPrefix():String{
		return "TableHeader.";
	}
	
	override public function installUI(c:Component):Void{
		header =AsWingUtils.as(c, JTableHeader);
		installDefaults();
		installComponents();
		installListeners();
	}
	
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
		LookAndFeel.installColorsAndFont(header, pp);
		LookAndFeel.installBorderAndBFDecorators(header, pp);
		LookAndFeel.installBasicProperties(header, pp);
		header.setOpaque(true);
	}
	
	private function installComponents():Void{
		cells = new Array<Dynamic>();
	}
	
	private function installListeners():Void{
		header.addEventListener(MouseEvent.ROLL_OVER, __onHeaderRollover);
		header.addEventListener(MouseEvent.ROLL_OUT, __onHeaderRollout);
		header.addEventListener(MouseEvent.MOUSE_DOWN, __onHeaderPressed);
		header.addEventListener(ReleaseEvent.RELEASE, __onHeaderReleased);
		header.addEventListener(Event.REMOVED_FROM_STAGE, __headerRemovedFromStage);
	}
	
	override public function uninstallUI(c:Component):Void{
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
	}
	
	private function uninstallDefaults():Void{
		LookAndFeel.uninstallBorderAndBFDecorators(header);
	}
	
	private function uninstallComponents():Void{
		removeAllCells();
		cells = null;
	}
	
	private function uninstallListeners():Void{
		header.removeEventListener(MouseEvent.ROLL_OVER, __onHeaderRollover);
		header.removeEventListener(MouseEvent.ROLL_OUT, __onHeaderRollout);
		header.removeEventListener(MouseEvent.MOUSE_DOWN, __onHeaderPressed);
		header.removeEventListener(ReleaseEvent.RELEASE, __onHeaderReleased);
		header.removeEventListener(Event.REMOVED_FROM_STAGE, __headerRemovedFromStage);
	}
	
	//*************************************************
	//			 Event Handlers
	//*************************************************
	
	private function __headerRemovedFromStage(e:Event):Void{
		AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, 
			__onRollOverMouseMoving);
		AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, 
			__onMouseMoving);
	}
	
	private function __onHeaderRollover(e:MouseEvent):Void{
		if(e.buttonDown!=true){
			if(AsWingManager.getStage()!=null)	{
				AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_MOVE, 
					__onRollOverMouseMoving, false, 0, false);
			}
		}
	}
	
	private function __onHeaderRollout(e:MouseEvent):Void{
		if(e == null || !e.buttonDown){
			CursorManager.getManager(AsWingManager.getStage()).hideCustomCursor(resizeCursor);
			if(AsWingManager.getStage()!=null)	{
				AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, 
					__onRollOverMouseMoving);
			}
		}
	}
	
	private function __onRollOverMouseMoving(e:Event):Void{
		if(resizing)	{
			return;
		}
		var p:IntPoint = header.getMousePosition();
		if(header.getTable().hitTestMouse() && 
			canResize(getResizingColumn(p, header.columnAtPoint(p)))){
			CursorManager.getManager(AsWingManager.getStage()).showCustomCursor(resizeCursor, true);
		}else{
			CursorManager.getManager(AsWingManager.getStage()).hideCustomCursor(resizeCursor);
		}
	}
	
	private function __onHeaderPressed(e:Event):Void{
		header.setResizingColumn(null);
		if(header.getTable().getCellEditor() != null){
			header.getTable().getCellEditor().cancelCellEditing();
		}
		
		var p:IntPoint = header.getMousePosition();
		//First find which header cell was hit
		var index:Int= header.columnAtPoint(p);
		if(index >= 0){
			//The last 3 pixels + 3 pixels of next column are for resizing
			var resizingColumn:TableColumn = getResizingColumn(p, index);
			if (canResize(resizingColumn)) {
				header.setResizingColumn(resizingColumn);
				mouseXOffset = p.x - resizingColumn.getWidth();
				if(AsWingManager.getStage()!=null)	{
					AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_MOVE, 
						__onMouseMoving, false, 0, false);
				}
				resizing = true;
			}
		}
	}
	
	private function __onHeaderReleased(e:Event):Void{
		if(AsWingManager.getStage()!=null)	{
			AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, 
				__onMouseMoving);
		}
		header.setResizingColumn(null);
		resizing = false;
		__onRollOverMouseMoving(null);
	}
		
	private function __onMouseMoving(e:MouseEvent):Void{
		var mouseX:Int= header.getMousePosition().x;
		var resizingColumn:TableColumn = header.getResizingColumn();
		if (resizingColumn != null) {
			var newWidth:Int;
			newWidth = mouseX - mouseXOffset;
			resizingColumn.setWidth(newWidth);
			e.updateAfterEvent();
		}
	}
	
	private function canResize(column:TableColumn):Bool{
		return (column != null) && header.getResizingAllowed()
			&& column.getResizable();
	}
	
	private function getResizingColumn(p:IntPoint, column:Int):TableColumn {
		if (column < 0) {
			return null;
		}
		var r:IntRectangle = header.getHeaderRect(column);
		r.grow(-3, 0);
		//if r contains p
		if ((p.x > r.x && p.x < r.x+r.width)) {
			return null;
		}
		var midPoint:Int= Std.int(r.x + r.width / 2);
		var columnIndex:Int;
		columnIndex = (p.x < midPoint) ? column - 1 : column;
		if (columnIndex == -1) {
			return null;
		}
		return header.getColumnModel().getColumn(columnIndex);
	}
	
	private function getHeaderRenderer(columnIndex:Int):TableCellFactory {
		var aColumn:TableColumn = header.getColumnModel().getColumn(columnIndex);
		var renderer:TableCellFactory = aColumn.getHeaderCellFactory();
		if (renderer == null) {
			renderer = header.getDefaultRenderer();
		}
		return renderer;
	}	
	
	override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		//do nothing, background decorator will do this job
	}
	
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		if (header.getColumnModel().getColumnCount() <= 0) {
			return;
		}
		synCreateCellInstances();
		
		var cm:TableColumnModel = header.getColumnModel();
		var cMin:Int= 0;
		var cMax:Int= cm.getColumnCount() - 1;
		var columnWidth:Float;
		var cellRect:IntRectangle = header.getHeaderRect(cMin);
		cellRect.x += Std.int(header.getTable().getColumnModel().getColumnMargin()/2);
		var aColumn:TableColumn;
		for (column in cMin...cMax+1){
			aColumn = cm.getColumn(column);
			columnWidth = aColumn.getWidth();
			cellRect.width = Std.int(columnWidth);
			var cell:TableCell = cells[column];
			cell.setCellValue(aColumn.getHeaderValue());
			cell.setTableCellStatus(header.getTable(), false, -1, column);
			cell.getCellComponent().setBounds(cellRect);
			cell.getCellComponent().setVisible(true);
			cell.getCellComponent().validate();
			cellRect.x +=Std.int(columnWidth);
		}
	}
	
	private var lastColumnCellFactories:Array<Dynamic>;
	private function synCreateCellInstances():Void{
		var columnCount:Int= header.getColumnModel().getColumnCount();
		var i:Int;
		if(lastColumnCellFactories==null || lastColumnCellFactories.length != columnCount){
			removeAllCells();
		}else{
			for(i in 0...columnCount){
				if(lastColumnCellFactories[i] != getHeaderRenderer(i)){
					removeAllCells();
					break;
				}
			}
		}
		if(cells.length == 0){
			lastColumnCellFactories = new Array<Dynamic>();
			for(i in 0...columnCount){
				var factory:TableCellFactory = getHeaderRenderer(i);
				lastColumnCellFactories[i] = factory;
				var cell:TableCell = factory.createNewCell(false);
				header.append(cell.getCellComponent());
				setCellComponentProperties(cell.getCellComponent());
				cells.push(cell);
			}
		}
	}
	
	private static function setCellComponentProperties(com:Component):Void{
		com.setFocusable(false);
		if(Std.is(com,Container)){
			var con:Container = AsWingUtils.as(com,Container);
			for(i in 0...con.getComponentCount()){
				setCellComponentProperties(con.getComponent(i));
			}
		}
	}	
	
	private function removeAllCells():Void{
		for(i in 0...cells.length){
			var cell:TableCell = AsWingUtils.as(cells[i],TableCell);
			cell.getCellComponent().removeFromContainer();
		}
		cells = new Array<Dynamic>();
	}
	//******************************************************************
	//							 Size Methods
	//******************************************************************
	private function createHeaderSize(width:Int):IntDimension {
		return header.getInsets().getOutsideSize(new IntDimension(width, header.getRowHeight()));
	}

	/**
	 * Return the minimum size of the table. The minimum height is the
	 * row height times the number of rows.
	 * The minimum width is the sum of the minimum widths of each column.
	 */
	override public function getMinimumSize(c:Component):IntDimension {
		var width:Int= 0;
//		var enumeration:Array = header.getColumnModel().getColumns();
//		for(var i:int=0; i<enumeration.length; i++){
//			var aColumn:TableColumn = TableColumn(enumeration[i]);
//			width = width + aColumn.getMinWidth();
//		}
		return createHeaderSize(width);
	}

	/**
	 * Return the preferred size of the table. The preferred height is the
	 * row height times the number of rows.
	 * The preferred width is the sum of the preferred widths of each column.
	 */
	override public function getPreferredSize(c:Component):IntDimension {
		var width:Int= 0;
		var enumeration:Array<Dynamic>= header.getColumnModel().getColumns();
		for(i in 0...enumeration.length){
			var aColumn:TableColumn = AsWingUtils.as(enumeration[i],TableColumn);
			width = width + aColumn.getPreferredWidth();
		}
		return createHeaderSize(width);
	}

	/**
	 * Return the maximum size of the table. The maximum height is the
	 * row heighttimes the number of rows.
	 * The maximum width is the sum of the maximum widths of each column.
	 */
	override public function getMaximumSize(c:Component):IntDimension {
		var width:Int= 100000;
//		var enumeration:Array = header.getColumnModel().getColumns();
//		for(var i:int=0; i<enumeration.length; i++){
//			var aColumn:TableColumn = TableColumn(enumeration[i]);
//			width = width + aColumn.getMaxWidth();
//		}
		return createHeaderSize(width);
	}	
	
	public function toString():String{
		return "BasicTableHeaderUI[]";
	}
}