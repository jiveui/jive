/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.plaf.flat.border;

	
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.geom.Matrix;
import org.aswing.graphics.Pen;
import org.aswing.table.DefaultTextHeaderCell;

import org.aswing.Border;
	import org.aswing.Component;
	import org.aswing.AbstractButton;
	import org.aswing.ASColor;
	import org.aswing.Insets;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.GradientBrush;
	import org.aswing.plaf.UIResource;
	import org.aswing.AsWingUtils;

/**
 * @private
 */
class TableHeaderCellBorder implements Border implements UIResource{
	
	private var shape:Shape;
    
	public function new(){
		shape = new Shape();
	}
		
	public function updateBorder(c:Component, g:Graphics2D, b:IntRectangle):Void{
		b = b.clone();
	
		if(Std.is(c,AbstractButton)){
			trace("header AbstractButton");
		}
		
		var headerCell: DefaultTextHeaderCell = AsWingUtils.as(c, DefaultTextHeaderCell);
		if (null == headerCell) return;
		
		if(b.height > 0 && headerCell.columnIndex < headerCell.table.getColumnCount()-1) {
			g.drawLine(new Pen(c.mideground),b.x+b.width-1, b.y, b.x+b.width-1, b.y + b.height);
		}
	}
	
	public function getBorderInsets(com:Component, bounds:IntRectangle):Insets{
		return new Insets(0, 0, 1, 1);
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
}