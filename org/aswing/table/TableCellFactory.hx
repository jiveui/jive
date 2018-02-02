/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


/**
 * TableCellFactory for create cells for table
 * @author paling
 */
interface TableCellFactory{
	
	/**
	 * Creates a new table cell.
	 * @param isHeader is it a header cell
	 * @return the table cell
	 */
	function createNewCell(isHeader:Bool):TableCell;
}