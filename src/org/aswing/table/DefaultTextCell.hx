/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;

	
import org.aswing.Component;
import org.aswing.geom.IntRectangle;
import org.aswing.JLabel;
import org.aswing.JTable;

/**
 * Default table cell to render text
 * @author paling
 */
class DefaultTextCell extends JLabel  implements TableCell{
	
	private var value:Dynamic;
	
	public function new(){
		super();
		setHorizontalAlignment(JLabel.LEFT);
		setOpaque(true);
	}
	
	/**
	 * Simpler this method to speed up performance
	 */
	override public function setComBounds(b:IntRectangle):Void{
		readyToPaint = true;
		if(!b.equals(bounds)){
			if(b.width != bounds.width || b.height != bounds.height){
				repaint();
			}
			bounds.setRect(b);
			locate();
			valid = false;
		}
	}
	
	/**
	 * Simpler this method to speed up performance
	 */
	override public function invalidate():Void{
		valid = false;
	}
	
	/**
	 * Simpler this method to speed up performance
	 */
	override public function revalidate():Void{
		valid = false;
	}
	
	//**********************************************************
	//				  Implementing TableCell
	//**********************************************************
	public function setCellValue(value:Dynamic) : Void{
		this.value = value;
		setText(value + "");
	}
	
	public function getCellValue():Dynamic{
		return value;
	}
	
	public function setTableCellStatus(table:JTable, isSelected:Bool, row:Int, column:Int):Void{
		if(isSelected)	{
			setBackground(table.getSelectionBackground());
			setForeground(table.getSelectionForeground());
		}else{
			setBackground(table.getBackground());
			setForeground(table.getForeground());
		}
		setFont(table.getFont());
	}
	
	public function getCellComponent() : Component {
		return this;
	}
	
	override public function toString():String{
		return "TextCell[label:" + super.toString() + "]\n";
	}
}