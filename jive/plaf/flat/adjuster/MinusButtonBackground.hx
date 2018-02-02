package jive.plaf.flat.adjuster;

import flash.display.DisplayObject;
import org.aswing.graphics.SolidBrush;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.ButtonModel;
import org.aswing.JButton;
import org.aswing.GroundDecorator;
import org.aswing.plaf.UIResource;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;

class MinusButtonBackground implements GroundDecorator implements UIResource {

	private var normalBg: ASColor;
	private var rolloverBg: ASColor;
	private var pressedBg: ASColor;
	private var cornerRadius: Float;
	
	public function new(normalBg: ASColor, rolloverBg: ASColor, pressedBg: ASColor, cornerRadius: Float) {
		this.normalBg = normalBg;
		this.rolloverBg = rolloverBg;
		this.pressedBg = pressedBg;
		this.cornerRadius = cornerRadius;
	} 
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle) {
		var b: JButton = cast(c);
		var model:ButtonModel = b.getModel();
		var isPressing:Bool = model.isArmed() && b.isEnabled();
		var isRollover:Bool = (model.isRollOver() || model.isSelected()) && b.isEnabled() && !isPressing;
		
		var color: ASColor = if (isPressing) pressedBg else if (isRollover) rolloverBg else normalBg;
		
		g.beginFill(new SolidBrush(color));
		g.moveTo(bounds.x, bounds.y);
		g.lineTo(bounds.x + bounds.width, bounds.y);
		g.lineTo(bounds.x + bounds.width, bounds.y + bounds.height - cornerRadius);
		g.curveTo(bounds.x + bounds.width, bounds.y + bounds.height, bounds.x + bounds.width - cornerRadius, bounds.y + bounds.height);
		g.lineTo(bounds.x, bounds.y + bounds.height);
		g.lineTo(bounds.x, bounds.y);
		g.endFill();
	}
	
	public function getDisplay(c:Component):DisplayObject {
		return null;
	}
	
}