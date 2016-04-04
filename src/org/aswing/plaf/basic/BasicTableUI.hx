/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;
 

import flash.display.Shape;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import org.aswing.AWKeyboard;
import org.aswing.event.ReleaseEvent;
import org.aswing.JTable;
	import org.aswing.Component;
	import org.aswing.ASColor;
	import org.aswing.ListSelectionModel;
	import org.aswing.FocusManager;
	import org.aswing.event.ClickCountEvent;
	import org.aswing.event.FocusKeyEvent;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.TableUI;
	import org.aswing.plaf.UIResource;
	import org.aswing.table.TableCellEditor;
	import org.aswing.table.TableColumnModel;
	import org.aswing.table.TableColumn;
	/**
 * @author paling
 * @private
 */
class BasicTableUI extends BaseComponentUI  implements TableUI{
	
	private var table:JTable;
	private var gridShape:Shape;
	
	public function new() {
		super();
		focusRow = 0;
		focusColumn = 0;
	}
	
	override public function installUI(c:Component):Void{
		table = AsWingUtils.as(c,JTable);
		installDefaults();
		installListeners();
	}
	
	private function getPropertyPrefix():String{
		return "Table.";
	}
	
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
		LookAndFeel.installColorsAndFont(table, pp);
		LookAndFeel.installBorderAndBFDecorators(table, pp);
		LookAndFeel.installBasicProperties(table, pp);
		
		var sbg:ASColor = table.getSelectionBackground();
		if (sbg == null || Std.is(sbg,UIResource)) {
			table.setSelectionBackground(getColor(pp+"selectionBackground"));
		}

		var sfg:ASColor = table.getSelectionForeground();
		if (sfg == null || Std.is(sfg,UIResource)) {
			table.setSelectionForeground(getColor(pp+"selectionForeground"));
		}

		var gridColor:ASColor = table.getGridColor();
		if (gridColor == null || Std.is(gridColor,UIResource)) {
			table.setGridColor(getColor(pp+"gridColor"));
		}
	}
	
	private function installListeners():Void{
		table.addEventListener(MouseEvent.MOUSE_DOWN, __onTablePress);
		table.addEventListener(ReleaseEvent.RELEASE, __onTableRelease);
		table.addEventListener(ClickCountEvent.CLICK_COUNT, __onTableClicked);
		table.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onTableKeyDown);
		table.addEventListener(MouseEvent.MOUSE_WHEEL, __onTableMouseWheel);
	}
	
	override public function uninstallUI(c:Component):Void{
		uninstallDefaults();
		uninstallListeners();
	}
	
	private function uninstallDefaults():Void{
		LookAndFeel.uninstallBorderAndBFDecorators(table);
	}
	
	private function uninstallListeners():Void{
		table.removeEventListener(MouseEvent.MOUSE_DOWN, __onTablePress);
		table.removeEventListener(ReleaseEvent.RELEASE, __onTableRelease);
		table.removeEventListener(ClickCountEvent.CLICK_COUNT, __onTableClicked);
		table.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onTableKeyDown);
		table.removeEventListener(MouseEvent.MOUSE_WHEEL, __onTableMouseWheel);
		table.removeEventListener(MouseEvent.MOUSE_MOVE, __onTableMouseMove);
	}
	
	private function __onTablePress(e:MouseEvent):Void{
		if(!table.getCellPane().hitTestMouse()){
			return;
		}
		selectMousePointed(e);
		table.addEventListener(MouseEvent.MOUSE_MOVE, __onTableMouseMove);
		var editor:TableCellEditor = table.getCellEditor();
		if(editor != null && editor.isCellEditing()){
			table.getCellEditor().stopCellEditing();
		}
	}
	
	private function __onTableClicked(e:ClickCountEvent):Void{
		if(!table.getCellPane().hitTestMouse()){
			return;
		}
		var p:IntPoint = getMousePosOnTable();
		var row:Int= table.rowAtPoint(p);
		var column:Int= table.columnAtPoint(p);
		if(table.editCellAt(row, column, e.getCount())){
		}
	}
	
	private function __onTableRelease(e:Event):Void{
		table.removeEventListener(MouseEvent.MOUSE_MOVE, __onTableMouseMove);
	}
	
	private function __onTableMouseMove(e:Event):Void{
		addSelectMousePointed();
	}
	
	private function __onTableMouseWheel(e:MouseEvent):Void{
		if(!table.isEnabled()){
			return;
		}
		if(!table.getCellPane().hitTestMouse()){
			return;
		}
		var viewPos:IntPoint = table.getViewPosition();
		viewPos.y -= e.delta*table.getVerticalUnitIncrement();
		table.setViewPosition(viewPos);
	}
	
	private function selectMousePointed(e:MouseEvent):Void{
		var p:IntPoint = getMousePosOnTable();
		var row:Int= table.rowAtPoint(p);
		var column:Int= table.columnAtPoint(p);
		if ((column == -1) || (row == -1)) {
			return;
		}
		makeSelectionChange(row, column, e);
	}
	
	private function addSelectMousePointed():Void{
		var p:IntPoint = getMousePosOnTable();
		var row:Int= table.rowAtPoint(p);
		var column:Int= table.columnAtPoint(p);
		if ((column == -1) || (row == -1)) {
			return;
		}
		changeSelection(row, column, false, true);
	}
	
	private function makeSelectionChange(row:Int, column:Int, e:MouseEvent):Void{
		recordFocusIndecis(row, column);
		var ctrl:Bool= e.ctrlKey;
		var shift:Bool= e.shiftKey;

		// Apply the selection state of the anchor to all cells between it and the
		// current cell, and then select the current cell.
		// For mustang, where API changes are allowed, this logic will moved to
		// JTable.changeSelection()
		if (ctrl && shift) {
			var rm:ListSelectionModel = table.getSelectionModel();
			var cm:ListSelectionModel = table.getColumnModel().getSelectionModel();
			var anchorRow:Int= rm.getAnchorSelectionIndex();
			var anchorCol:Int= cm.getAnchorSelectionIndex();

			if (table.isCellSelected(anchorRow, anchorCol)) {
				rm.addSelectionInterval(anchorRow, row, false);
				cm.addSelectionInterval(anchorCol, column, false);
			} else {
				rm.removeSelectionInterval(anchorRow, row, false);
				rm.addSelectionInterval(row, row, false);
				rm.setAnchorSelectionIndex(anchorRow);
				cm.removeSelectionInterval(anchorCol, column, false);
				cm.addSelectionInterval(column, column, false);
				cm.setAnchorSelectionIndex(anchorCol);
			}
		} else {
			changeSelection(row, column, ctrl, !ctrl && shift);
		}
	}	
	
	private function changeSelection(rowIndex:Int, columnIndex:Int, toggle:Bool, extend:Bool):Void{
		recordFocusIndecis(rowIndex, columnIndex);
		table.changeSelection(rowIndex, columnIndex, toggle, extend, false);
	}
	
	private function getMousePosOnTable():IntPoint{
		var p:IntPoint = table.getMousePosition();
		return table.getLogicLocationFromPixelLocation(p);
	}
	
	private function getEditionKey():Int{
		return AWKeyboard.ENTER;
	}
	private function getSelectionKey():Int{
		return AWKeyboard.SPACE;
	}
	
	private function createGridGraphics():Graphics2D{
		if(gridShape == null){
			gridShape = new Shape();
			table.getCellPane().addChild(gridShape);
		}
		gridShape.graphics.clear();
		return new Graphics2D(gridShape.graphics);
	}
		
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		g = createGridGraphics();
		var rowCount:Int= table.getRowCount();
		var columnCount:Int= table.getColumnCount();
		if (rowCount <= 0 || columnCount <= 0) {
			return;
		}
		var extentSize:IntDimension = table.getExtentSize();
		var viewPos:IntPoint = table.getViewPosition();
		var startX:Int= - viewPos.x;
		var startY:Int= - viewPos.y;
		
		var vb:IntRectangle = new IntRectangle();
		vb.setSize(extentSize);
		vb.setLocation(viewPos);
		var upperLeft:IntPoint = vb.getLocation();
		var lowerRight:IntPoint = vb.rightBottom();
		var rMin:Int= table.rowAtPoint(upperLeft);
		var rMax:Int= table.rowAtPoint(lowerRight);
		if (rMin == -1) {
			rMin = 0;
		}
		if (rMax == -1) {
			rMax = rowCount - 1;
		}
		var cMin:Int= table.columnAtPoint(upperLeft);
		var cMax:Int= table.columnAtPoint(lowerRight);
		if (cMin == -1) {
			cMin = 0;
		}
		if (cMax == -1) {
			cMax = columnCount - 1;
		}
		
		var minCell:IntRectangle = table.getCellRect(rMin, cMin, true);
		var maxCell:IntRectangle = table.getCellRect(rMax, cMax, true);
		var damagedArea:IntRectangle = minCell.union(maxCell);
		damagedArea.setLocation(damagedArea.getLocation().move(startX, startY));
		//why	
		 
		var pen:Pen = new Pen(table.getGridColor(), 1);
		if (table.getShowHorizontalLines()) {
			var x1:Float= damagedArea.x + 0.5;
			var x2:Float= damagedArea.x + damagedArea.width - 1;
			var y:Float= damagedArea.y + 0.5;
			var rh:Int= table.getRowHeight();
			for (row in rMin...rMax+2){
				if(row == rowCount){
					y -= 1;
				}
				g.drawLine(pen, x1, y, x2, y);
				y += rh;
			}
		}
		if (table.getShowVerticalLines()) {
			var cm:TableColumnModel = table.getColumnModel();
			var x:Float= damagedArea.x + 0.5;
			var y1:Float= damagedArea.y + 0.5;
			var y2:Float= y1 + damagedArea.height - 1;
			for (column in cMin...cMax+2){
				if(column == columnCount){
					x -= 1;
				}
				g.drawLine(pen, x, y1, x, y2);
				if(column < columnCount){
					x += cm.getColumn(column).getWidth();
				}
			}
		}	
	 
	}	
	//******************************************************************
	//						Focus and Keyboard control
	//******************************************************************
	private function __onTableKeyDown(e:FocusKeyEvent):Void{
		if(!table.isEnabled()){
			return;
		}
		var rDir:Float= 0;
		var cDir:Float= 0;
		var code:Int= e.keyCode;
		if(code == AWKeyboard.LEFT){
			cDir = -1;
		}else if(code == AWKeyboard.RIGHT){
			cDir = 1;
		}else if(code == AWKeyboard.UP){
			rDir = -1;
		}else if(code == AWKeyboard.DOWN){
			rDir = 1;
		}
		if(cDir != 0 || rDir != 0){
			moveFocus(rDir, cDir, e);
    		var fm:FocusManager = FocusManager.getManager(table.stage);
			if(fm!=null)	fm.setTraversing(true);
			table.paintFocusRect();
			return;
		}
		if(code == getSelectionKey()){
			table.changeSelection(focusRow, focusColumn, true, false);
		}else if(code == getEditionKey()){
			table.editCellAt(focusRow, focusColumn, -1);
		}
	}
	
	private function recordFocusIndecis(row:Int, column:Int):Void{
		focusRow = row;
		focusColumn = column;
	}
	
	private function restrictRow(row:Int):Int{
		return Std.int(Math.max(0, Math.min(table.getRowCount()-1, row)));
	}
	
	private function restrictColumn(column:Int):Int{
		return Std.int(Math.max(0, Math.min(table.getColumnCount()-1, column)));
	}
	
	private function moveFocus(rDir:Float, cDir:Float, e:KeyboardEvent):Void{
		var ctrl:Bool= e.ctrlKey;
		var shift:Bool= e.shiftKey;
		focusRow += Std.int(rDir);
		focusRow = restrictRow(focusRow);
		focusColumn +=Std.int( cDir);
		focusColumn = restrictColumn(focusColumn);
		
		if(ctrl!=true){
			changeSelection(focusRow, focusColumn, ctrl, !ctrl && shift);
		}
		table.ensureCellIsVisible(focusRow, focusColumn);
	}
	
	private var focusRow:Int;
	private var focusColumn:Int;

	override public function paintFocus(c:Component, g:Graphics2D, b:IntRectangle):Void{
		paintCurrentCellFocus(g);
	}
	
	private function paintCurrentCellFocus(g:Graphics2D):Void{
		paintCellFocusWithRowColumn(g, focusRow, focusColumn);
	}
	
	private function paintCellFocusWithRowColumn(g:Graphics2D, row:Int, column:Int):Void{
		var rect:IntRectangle = table.getCellRect(row, column, true);
		rect.setLocation(table.getPixelLocationFromLogicLocation(rect.getLocation()));
		g.drawRectangle(new Pen(getDefaultFocusColorOutter(), 2), rect.x, rect.y, rect.width, rect.height);
	}

	//******************************************************************
	//							 Size Methods
	//******************************************************************

	private function createTableSize(width:Int):IntDimension {
		var height:Int= 0;
		var rowCount:Int= table.getRowCount();
		if (rowCount > 0 && table.getColumnCount() > 0) {
			var r:IntRectangle = table.getCellRect(rowCount - 1, 0, true);
			height = r.y + r.height;
		}
		height += table.getTableHeader().getPreferredHeight();
		if(table.getFooter()!=null){
			height += table.getFooter().getPreferredHeight();
		}
		return new IntDimension(width, height);
	}
		
	/**
	 * Returns the view size.
	 */	
	public function getViewSize(table:JTable):IntDimension{
		var width:Int= 0;
		var enumeration:Array<Dynamic>= table.getColumnModel().getColumns();
		for(i in 0...enumeration.length){
			var aColumn:TableColumn = enumeration[i];
			width += aColumn.getPreferredWidth();
		}
		
		var d:IntDimension = createTableSize(width);
		if(table.getAutoResizeMode() != JTable.AUTO_RESIZE_OFF){
			d.width = table.getExtentSize().width;
		}else{
			d.width = table.getColumnModel().getTotalColumnWidth();
		}
		d.height -= table.getTableHeader().getHeight();
		if(table.getFooter()!=null){
			d.height -= table.getFooter().getHeight();
		}
		return d;
	}

	/**
	 * Return the minimum size of the table. The minimum height is the
	 * row height times the number of rows.
	 * The minimum width is the sum of the minimum widths of each column.
	 */
	override public function getMinimumSize(c:Component):IntDimension {
		var width:Int= 0;
		var enumeration:Array<Dynamic>= table.getColumnModel().getColumns();
		for(i in 0...enumeration.length){
			var aColumn:TableColumn = enumeration[i];
			width += aColumn.getMinWidth();
		}
		return table.getInsets().getOutsideSize(new IntDimension(width, 0));
	}

	/**
	 * Return the preferred size of the table. The preferred height is the
	 * row height times the number of rows.
	 * The preferred width is the sum of the preferred widths of each column.
	 */
	override public function getPreferredSize(c:Component):IntDimension {
		var width:Int= 0;
		var enumeration:Array<Dynamic>= table.getColumnModel().getColumns();
		for(i in 0...enumeration.length){
			var aColumn:TableColumn = enumeration[i];
			width += aColumn.getPreferredWidth();
		}
		return table.getInsets().getOutsideSize(createTableSize(width));
		//return table.getInsets().getOutsideSize(getViewSize(JTable(c)));
	}

	/**
	 * Return the maximum size of the table. The maximum height is the
	 * row heighttimes the number of rows.
	 * The maximum width is the sum of the maximum widths of each column.
	 */
	override public function getMaximumSize(c:Component):IntDimension {
		/*var width:int = 0;
		var enumeration:Array = table.getColumnModel().getColumns();
		for(var i:int=0; i<enumeration.length; i++){
			var aColumn:TableColumn = enumeration[i];
			width += aColumn.getMaxWidth();
		}
		return table.getInsets().getOutsideSize(createTableSize(width));
		*/
		return IntDimension.createBigDimension();		
	}	
	
	public function toString():String{
		return "BasicTableUI[]";
	}

}