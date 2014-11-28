/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table.sorter;


import org.aswing.table.TableCell;
import org.aswing.table.TableCellFactory;

/**
 * @author paling
 */
class SortableHeaderRenderer implements TableCellFactory{
	
	private var tableSorter:TableSorter;
	private var originalRenderer:TableCellFactory;
	
	public function new(originalRenderer:TableCellFactory, tableSorter:TableSorter){
		this.originalRenderer = originalRenderer;
		this.tableSorter = tableSorter;
	}
	
	public function createNewCell(isHeader : Bool) : TableCell {
		return new SortableTextHeaderCell(tableSorter);
	}
	
	public function getTableCellFactory():TableCellFactory{
		return null;
	}
}