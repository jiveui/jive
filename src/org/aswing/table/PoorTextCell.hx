/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


import flash.text.TextFieldAutoSize;
import org.aswing.Component;
	import org.aswing.JTable;
	import org.aswing.geom.IntRectangle;
	import org.aswing.plaf.ComponentUI;
import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import flash.text.TextField;
	/**
 * A poor table cell to render text faster.
 * @author paling
 */
class PoorTextCell extends Component  implements TableCell{
	
	private var textField:TextField;
	private var text:String;
	private var cellValue:Dynamic;
	
	public function new() {
		super();
		setOpaque(true);
		textField = new TextField();
		textField.autoSize = TextFieldAutoSize.LEFT;
		textField.selectable = false;
		textField.mouseEnabled = false;
		setFontValidated(false);
		addChild(textField);
	}
	
	override private function paint(b:IntRectangle):Void{
		var t:String= text == null ? "" : text;
		if(textField.text !=t){
			textField.text = t;
		}
		if(!isFontValidated()){
			AsWingUtils.applyTextFont(textField, getFont());
			setFontValidated(true);
		}
		AsWingUtils.applyTextColor(textField, getForeground());
		textField.x = b.x;
		textField.y = b.y + (b.height-textField.textHeight)/2;
		if(isOpaque()){
			graphics.clear();
			var g:Graphics2D = new Graphics2D(graphics);
			g.fillRectangle(new SolidBrush(getBackground()), b.x, b.y, b.width, b.height);
		}
	}
		
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
	
	public function setText(text:String):Void{
		if(text != this.text){
			this.text = text;
			repaint();
		}
	}
	
	public function getText():String{
		return text;
	}
	
	//------------------------------------------------------------------------------------------------

	public function setTableCellStatus(table : JTable, isSelected : Bool, row : Int, column : Int) : Void{
		if(isSelected)	{
			setBackground(table.getSelectionBackground());
			setForeground(table.getSelectionForeground());
		}else{
			setBackground(table.getBackground());
			setForeground(table.getForeground());
		}
		setFont(table.getFont());
	}

	public function setCellValue(value:Dynamic) : Void{
		cellValue = value;
		setText(value + "");
	}

	public function getCellValue():Dynamic{
		return cellValue;
	}

	public function getCellComponent() : Component {
		return this;
	}

	override public function toString():String{
		return "PoorTextCell[component:" + super.toString() + "]\n";
	}
}