package jive.plaf.flat;

import org.aswing.ASColor;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.Component;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicTableUI;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntPoint;
import flash.display.Shape;

/**
 * ...
 * @author Nick Grebenshikov
 */

class FlatTableUI extends BasicTableUI {
	
	var mask: Shape;

	public function new() { 
		super();
		mask = new Shape();
	}
	
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void 
	{
		super.paint(c, g, b);
		
		// Start ############ from super #############

		g = createGridGraphics();
		var rowCount:Int= table.getRowCount();
		var columnCount:Int= table.getColumnCount();
		if (rowCount <= 0 || columnCount <= 0) {
			return;
		}
		var extentSize:IntDimension = table.getExtentSize();
		var viewPos:IntPoint = table.getViewPosition();
		var startX:Int= - viewPos.x;
		var startY:Int= - viewPos.y;
		
		var vb:IntRectangle = new IntRectangle();
		vb.setSize(extentSize);
		vb.setLocation(viewPos);
		var upperLeft:IntPoint = vb.getLocation();
		var lowerRight:IntPoint = vb.rightBottom();
		var rMin:Int= table.rowAtPoint(upperLeft);
		var rMax:Int= table.rowAtPoint(lowerRight);
		if (rMin == -1) {
			rMin = 0;
		}
		if (rMax == -1) {
			rMax = rowCount - 1;
		}
		var cMin:Int= table.columnAtPoint(upperLeft);
		var cMax:Int= table.columnAtPoint(lowerRight);
		if (cMin == -1) {
			cMin = 0;
		}
		if (cMax == -1) {
			cMax = columnCount - 1;
		}
		
		var minCell:IntRectangle = table.getCellRect(rMin, cMin, true);
		var maxCell:IntRectangle = table.getCellRect(rMax, cMax, true);
		var damagedArea:IntRectangle = minCell.union(maxCell);
		damagedArea.setLocation(damagedArea.getLocation().move(startX, startY));
		
		// End ############ from super #############
		
		var rh:Int= table.getRowHeight();
		var x1:Float= damagedArea.x + 0.5;
		var x2:Float= damagedArea.x + damagedArea.width - 1;
		var y:Float= damagedArea.y + 0.5 + rh;
		for (row in rMin + 1...rMax + 1) {
			if(row == rowCount){
				y -= 1;
			}
			g.fillRectangle(new SolidBrush(c.mideground), x1, y, x2-x1, rh);
			y += 2*rh;
		}

		//Selection
		var rh:Int= table.getRowHeight();
		var x1:Float= damagedArea.x + 0.5;
		var x2:Float= damagedArea.x + damagedArea.width - 1;
		var y:Float= damagedArea.y + 0.5;
		for (row in rMin...rMax + 1) {
			if(row == rowCount){
				y -= 1;
			}
			if (row == table.getSelectedRow()) {
				g.fillRectangle(new SolidBrush(table.getSelectionBackground()), x1, y, x2 - x1, rh);
			}
			y += rh;
		}
		
		mask.graphics.clear();
		var mg = new Graphics2D(mask.graphics);
		var mb = new SolidBrush(ASColor.WHITE);
		mg.fillRoundRect(mb, b.x+1, b.y, extentSize.width-2, extentSize.height, c.styleTune.round);
		mg.fillRectangle(mb, b.x+1, b.y, extentSize.width-2, c.styleTune.round * 2);
	}
	
	private override function createGridGraphics():Graphics2D{
		if(gridShape == null){
			gridShape = new Shape();
			table.getCellPane().addChild(mask);
			table.getCellPane().mask = mask;
			table.getCellPane().addChildAt(gridShape, 0);
		}
		gridShape.graphics.clear();
		return new Graphics2D(gridShape.graphics);
	}
		

	
}