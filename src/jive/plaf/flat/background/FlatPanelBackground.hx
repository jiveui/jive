package jive.plaf.flat.background;


import org.aswing.UIManager;
import flash.display.DisplayObject;

import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;

class FlatPanelBackground implements GroundDecorator implements UIResource{
	
	public function new(){
	}

	public function getDisplay(c:Component):DisplayObject{
		return null;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(c.isOpaque()){
			g.fillRoundRect(new SolidBrush(c.getBackground()), b.x, b.y, b.width, b.height, UIManager.get("cornerSize"));
		}		
	}
	
}