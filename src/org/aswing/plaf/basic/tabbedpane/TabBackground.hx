package org.aswing.plaf.basic.tabbedpane;


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

class TabBackground implements GroundDecorator implements UIResource{
	
	private var shape:Shape;
	private var tab:Tab;
	
	public function new(tab:Tab){
		this.tab = tab;
		shape = new Shape();
	}

	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		shape.graphics.clear();
		var btn:AbstractButton = AsWingUtils.as(c,AbstractButton)	;
		if(btn!=null)	{
			var model:ButtonModel = btn.getModel();
			var isPressing:Bool= model.isPressed() || model.isSelected();
			g = new Graphics2D(shape.graphics);
			var cl:ASColor = c.getMideground();
			var style:StyleResult;
			var adjuster:StyleTune = c.getStyleTune().mide.clone();
			if(!c.isEnabled()){
				adjuster = adjuster.sharpen(0.4);
			}else if(isPressing)	{
				cl = cl.offsetHLS(0, 0.08, 0);
			}else if(model.isRollOver()){
				cl = cl.offsetHLS(-0.2, 0, 0.37);
				//cl = cl.offsetHLS(0, 0.08, 0);
			}
			style = new StyleResult(cl, adjuster);
			if(isPressing)	{
				style.cdark = style.cdark.changeAlpha(0);
			}
			var direction:Float= Math.PI/2;
			var matrixB:IntRectangle = b.clone();
			b = b.clone();
			
			var placement:Int= tab.getTabPlacement();
			var highlightBrush:SolidBrush = new SolidBrush(style.clight.offsetHLS(0, 0.14, 0.1));
			if(placement == JTabbedPane.TOP){
				direction = Math.PI/2;
				b.height +=Std.int(style.round*2);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.width - style.round*2 > 0){
					g.fillRectangle(highlightBrush, b.x+style.round, b.y+1, b.width - style.round*2, 1);
				}
			}else if(placement == JTabbedPane.BOTTOM){
				direction = -Math.PI/2;
				b.height += Std.int(style.round*2);
				b.y -= Std.int(style.round*2);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.width - style.round*2 > 0){
					g.fillRectangle(highlightBrush, b.x+style.round, b.y+b.height-2, b.width - style.round*2, 1);
				}
			}else if(placement == JTabbedPane.LEFT){
				direction = 0;
				b.width += Std.int(style.round*2);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.height - style.round*2 > 0){
					g.fillRectangle(highlightBrush, 
						b.x+1, b.y+style.round, 1, b.height - style.round*2);
				}
			}else{//right				
				direction = Math.PI;
				b.width += Std.int(style.round*2);
				b.x -= Std.int(style.round*2);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.height - style.round*2 > 0){
					g.fillRectangle(highlightBrush, 
						b.x+b.width-2, b.y+style.round, 1, b.height - style.round*2);
				}
			}
		}
	}
	
}