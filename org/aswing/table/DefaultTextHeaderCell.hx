/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;

 
import org.aswing.JLabel;
import org.aswing.JTable;
import org.aswing.UIManager;
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
/**
 * Default table header cell to render text
 * @author paling
 */
class DefaultTextHeaderCell extends DefaultTextCell {
	
	public var columnIndex(default, null): Int;
	public var table(default, null): JTable;
	
	public function new() {
		super();
		super.setHorizontalAlignment(JLabel.CENTER);
		super.setBorder(UIManager.getBorder("TableHeader.cellBorder"));
		super.setBackgroundDecorator(UIManager.getGroundDecorator("TableHeader.cellBackground"));
		super.setOpaque(false);
	}
	
	override public function setTableCellStatus(table:JTable, isSelected:Bool, row:Int, column:Int):Void {
		columnIndex = column;
		this.table = table;
		
		var header:JTableHeader = table.getTableHeader();
		if(header != null){
			super.setBackground(header.getBackground());
			super.setForeground(header.getForeground());
			super.setFont(header.getFont());
		}
	}
}