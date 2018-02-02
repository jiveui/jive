package jive.plaf.flat.tabbedpane;


import jive.plaf.flat.tabbedpane.FlatTabButton;
import org.aswing.AsWingUtils;
import org.aswing.plaf.basic.tabbedpane.Tab;
import flash.display.DisplayObject;
import flash.display.Shape;

import org.aswing.ASColor;
import org.aswing.AbstractButton;
import org.aswing.ButtonModel;
import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.JTabbedPane;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

class FlatTabBackground implements GroundDecorator implements UIResource{

    private static var luminanceFactor: Float = 0.1;

    private var shape:Shape;
	private var tab:Tab;
	
	public function new(tab:Tab){
		this.tab = tab;
		shape = new Shape();
	}

	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
		shape.graphics.clear();

		var button:FlatTabButton = AsWingUtils.as(c, FlatTabButton);

		if(button!=null && tab != null)	{
            bounds = bounds.clone();
            g = new Graphics2D(shape.graphics);
            var model:ButtonModel = button.model;

            var color: ASColor = button.normalColor;

            if (button.transitBackgroundFactor < 0) {
                color = ASColor.getColorBetween(button.normalColor, button.selectedColor, -button.transitBackgroundFactor);
            } else {
                color = ASColor.getColorBetween(button.normalColor, button.rolloverColor, button.transitBackgroundFactor);
            }

			var placement:Int= tab.getTabPlacement();
			if(placement == JTabbedPane.TOP){
				bounds.height +=Std.int(c.styleTune.round*2);
			}else if(placement == JTabbedPane.BOTTOM){
				bounds.height += Std.int(c.styleTune.round*2);
				bounds.y -= Std.int(c.styleTune.round*2);
			}else if(placement == JTabbedPane.LEFT){
				bounds.width += Std.int(c.styleTune.round*2);
			}else{//right
				bounds.width += Std.int(c.styleTune.round*2);
				bounds.x -= Std.int(c.styleTune.round*2);
			}

            if (null != color) {
                g.fillRoundRect(new SolidBrush(color), bounds.x, bounds.y, bounds.width, bounds.height, c.styleTune.round);
            }

            if (model.isSelected()) {
                g.fillRoundRectRingWithThickness(new SolidBrush(button.borderColor), bounds.x, bounds.y, bounds.width, bounds.height, c.styleTune.round, 1, c.styleTune.round-1);
            }
		}
	}
	
}