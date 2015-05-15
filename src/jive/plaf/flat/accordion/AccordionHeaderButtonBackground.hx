package jive.plaf.flat.accordion;

import flash.display.DisplayObject;
import org.aswing.AsWingUtils;
import org.aswing.graphics.SolidBrush;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.AbstractButton;
import org.aswing.ButtonModel;
import org.aswing.GroundDecorator;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.ComponentUI;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;

class AccordionHeaderButtonBackground implements GroundDecorator implements UIResource {
	private var cornerRaduis: Float = -1;
	
    private var normalColors: Array<Int>;
    private var normalRanges: Array<Float>;
    private var hoverColors: Array<Int>;
    private var hoverRanges: Array<Float>;
    private var pressedColors: Array<Int>;
    private var pressedRanges: Array<Float>;
    private var border: ASColor;

	public function new(){
	} 
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle){
		
		var b:AbstractButton = AsWingUtils.as(c, AbstractButton);
		if (b == null) return;
		
		if(cornerRaduis <= 0){
			cornerRaduis = c.getUI().getNumber("AccordionHeaderButton.cornerRadius");
		}

		bounds = bounds.clone();

		if (c.isOpaque()) {
			var model:ButtonModel = b.getModel();
	    	var isPressing:Bool = model.isArmed() && b.isEnabled();
	    	var isRollover:Bool = (model.isRollOver() || model.isSelected()) && b.isEnabled() && !isPressing;
			var isSelected:Bool = model.isSelected();

			var topLeftRadius = cornerRaduis;
			var topRightRadius = cornerRaduis;
			var bottomLeftRadius = if (isSelected) 0 else cornerRaduis;
			var bottomRightRadius = if (isSelected) 0 else cornerRaduis;
						
			var color: ASColor = 
				if (isPressing && !isSelected) c.background.offsetHLS(0, -0.1, 0)
				else if (isRollover && !isSelected) c.background.offsetHLS(0, 0.1, 0)
				else c.background;
			g.fillRoundRect(new SolidBrush(color), bounds.x, bounds.y, bounds.width, bounds.height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius);
		}
	}
	
	public function getDisplay(c:Component):DisplayObject
	{
		return null;
	}
	
}