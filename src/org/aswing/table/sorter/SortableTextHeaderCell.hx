/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table.sorter;


import org.aswing.JTable;
import org.aswing.table.DefaultTextHeaderCell;
import org.aswing.UIManager;
import org.aswing.JLabel;

/**
 * @author paling
 */
class SortableTextHeaderCell extends DefaultTextHeaderCell{
	
	private var tableSorter:TableSorter;
	
	public function new(tableSorter:TableSorter) {
		super();
		setBorder(UIManager.getBorder("TableHeader.sortableCellBorder"));
		setBackgroundDecorator(UIManager.getGroundDecorator("TableHeader.sortableCellBackground"));
		this.tableSorter = tableSorter;
		setHorizontalTextPosition(JLabel.LEFT);
		setIconTextGap(6);
		//make it user parent property
		setMideground(null);
		setStyleTune(null);
	}
	
	override public function setTableCellStatus(table:JTable, isSelected:Bool, row:Int, column:Int):Void{
		super.setTableCellStatus(table, isSelected, row, column);
		var modelColumn:Int = table.convertColumnIndexToModel(column); 
		setIcon(tableSorter.getHeaderRendererIcon(modelColumn, getFont().getSize()-2));
	}
}