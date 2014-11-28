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
class DefaultTextHeaderCell extends DefaultTextCell{
	
	public function new() {
		super();
		super.setHorizontalAlignment(JLabel.CENTER);
		super.setBorder(UIManager.getBorder("TableHeader.cellBorder"));
		super.setBackgroundDecorator(UIManager.getGroundDecorator("TableHeader.cellBackground"));
		super.setOpaque(false);
		 
		var f :Array<BitmapFilter> = new Array<BitmapFilter>();
		f.push(new  DropShadowFilter(1, 45, 0xFFFFFF, 0.2, 1, 1, 1, 1));
		super.setTextFilters(f);
		 
	}
	
	override public function setTableCellStatus(table:JTable, isSelected:Bool, row:Int, column:Int):Void{
		var header:JTableHeader = table.getTableHeader();
		if(header != null){
			super.setBackground(header.getBackground());
			super.setForeground(header.getForeground());
			super.setFont(header.getFont());
		}
	}
}