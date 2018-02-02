/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;

	
import org.aswing.error.ImpMissError;
import org.aswing.table.TableCell;
import org.aswing.JTable;
import org.aswing.Component;
	
/**
 * Abstract table cell.
 * @author senkay
 */
class AbstractTableCell implements TableCell{
	
	private var value:Dynamic;
	
	public function new(){
	}
	
	public function setTableCellStatus(table:JTable, isSelected:Bool, row:Int, column:Int):Void{
		var com:Component = getCellComponent();
		if(isSelected)	{
			com.setBackground(table.getSelectionBackground());
			com.setForeground(table.getSelectionForeground());
		}else{
			com.setBackground(table.getBackground());
			com.setForeground(table.getForeground());
		}
		com.setFont(table.getFont());
	}

	public function setCellValue(value:Dynamic) : Void{
		this.value = value;
	}

	public function getCellValue():Dynamic{
		return value;
	}
	
	/**
	 * Subclass should override this method
	 */
	public function getCellComponent() : Component {
		throw new ImpMissError();
		return null;
	}
}