package jive.plaf.flat.adjuster;
import flash.display.DisplayObject;
import org.aswing.ASColor;
import org.aswing.Border;
import org.aswing.border.DecorateBorder;
import org.aswing.border.EmptyBorder;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.Insets;
import org.aswing.plaf.basic.BasicTextFieldUI;
import flash.geom.Matrix;
import org.aswing.graphics.GradientBrush;
import org.aswing.plaf.basic.BasicComboBoxUI;
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.UIResource;

class AdjusterBorder implements Border implements UIResource {

	public function new() {}
    	
	public function updateBorder(c:org.aswing.Component, g:org.aswing.graphics.Graphics2D, r:org.aswing.geom.IntRectangle):Void {
		g.fillRoundRectRingWithThickness(new SolidBrush(c.background.offsetHLS(0,-0.2,-0.2)), r.x, r.y, r.width, r.height, 5, 1);
	}
	
	public function getBorderInsets(com:Component, bounds:IntRectangle):Insets {
		return new Insets(2,1,2,1);
	}
	
	public function getDisplay(c:Component):DisplayObject {
		return null;
	}
}