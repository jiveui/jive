/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


import org.aswing.Cell;
import org.aswing.JTable;

/**
 * @author paling
 */
interface TableCell extends Cell{
	
	/**
	 * Sets the table cell status, include the owner-JTable isSelected, row position, column position.
	 * @param the cell's owner, a JTable
	 * @param isSelected true to set the cell selected, false to set not selected.
	 * @param row the row position
	 * @param column the column position
	 */
	function setTableCellStatus(table:JTable, isSelected:Bool, row:Int, column:Int):Void;
}