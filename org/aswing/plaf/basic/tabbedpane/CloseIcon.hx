/**

 * Close Icon for tab.

 */
package org.aswing.plaf.basic.tabbedpane;
import flash.display.DisplayObject;
import flash.display.Shape;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;
import org.aswing.Component;
import org.aswing.Icon;
import org.aswing.ASColor;
import org.aswing.graphics.Pen;

class CloseIcon implements Icon implements UIResource {

	var width : Int;
	var height : Int;
	var shape : Shape;
	var color : ASColor;
	public function new() {
		width = 12;
		height = width;
		shape = new Shape();
	}

	public function getColor() : ASColor {
		return color;
	}

	public function updateIcon(c : Component, g : Graphics2D, x : Int, y : Int) : Void {
		if(color == null)  {
			color = c.getUI().getColor("ClosableTabbedPane.darkShadow");
		}
		shape.graphics.clear();
		if(!c.isEnabled())  {
			return;
			//do not paint X when not enabled
		}
		var w : Float = width / 2;
		g.drawLine(new Pen(getColor(), w / 3), x + (width - w) / 2, y + (width - w) / 2, x + (width + w) / 2, y + (width + w) / 2);
		g.drawLine(new Pen(getColor(), w / 3), x + (width - w) / 2, y + (width + w) / 2, x + (width + w) / 2, y + (width - w) / 2);
	}

	public function getIconHeight(c : Component) : Int {
		return width;
	}

	public function getIconWidth(c : Component) : Int {
		return height;
	}

	public function getDisplay(c : Component) : DisplayObject {
		return shape;
	}

}

