/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


/**
 * @author paling
 */
class GeneralTableCellFactory implements TableCellFactory{
	
	private var cellClass:Class<Dynamic>;
	
	/**
	 * Creates a TableCellFactory with specified cell class.
	 * @param cellClass the cell class
	 */
	public function new(cellClass:Class<Dynamic>){
		this.cellClass = cellClass;
	}
	
	/**
	 * Creates and returns a new table cell.
	 * @param isHeader is it a header cell
	 * @return the table cell
	 */
	public function createNewCell(isHeader:Bool):TableCell{
		return AsWingUtils.as(Type.createInstance( cellClass,[]) , TableCell);
	}
	
	public function toString():String{
		return "GeneralTableCellFactory[cellClass:" + cellClass + "]";
	}
}