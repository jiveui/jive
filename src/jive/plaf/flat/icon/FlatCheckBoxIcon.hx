/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.plaf.flat.icon;


import org.aswing.JCheckBox;
import org.aswing.AsWingUtils;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite; 
import flash.filters.BitmapFilterType; 
import flash.geom.Matrix;
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import org.aswing.graphics.Pen;
import org.aswing.Icon;
import org.aswing.Component;
import org.aswing.AbstractButton;
import org.aswing.ButtonModel;
import org.aswing.ASColor;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;
import org.aswing.graphics.GradientBrush;

class FlatCheckBoxIcon implements Icon implements UIResource{
	
	private var sprite:Sprite;
	private var box:Sprite;
	private var dot:Sprite;
	
	public function new(){
		sprite = new Sprite();
		sprite.mouseChildren = false;
		sprite.mouseEnabled = false;
		box = new Sprite();
		dot = new Sprite();
		sprite.addChild(box);
		sprite.addChild(dot);
	}
		
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		var b:JCheckBox = AsWingUtils.as(c,JCheckBox);
		var model:ButtonModel = b.getModel();

		box.graphics.clear();
		var g:Graphics2D = new Graphics2D(box.graphics);
		
		var w:Int= getIconWidth(c);
		var h:Int= getIconHeight(c);

		var cl:ASColor = c.background;
    	var drawDot: Bool = model.isArmed() || model.isSelected() || model.isRollOver();

        if (b.transitBackgroundFactor < 0) {
            trace(b.transitBackgroundFactor);
            cl = ASColor.getColorBetween(c.background, c.mideground, -b.transitBackgroundFactor);
        }

        if (!b.enabled) {
      		cl = cl.offsetHLS(0, 0.1, -0.4);
    	}

        g.fillRoundRect(new SolidBrush(cl), x, y, w, h, b.styleTune.round);

        // Draw dot
		dot.graphics.clear();

        if(drawDot) {
			g = new Graphics2D(dot.graphics);
			cl = b.tickColor;

			g.beginDraw(new Pen(cl, 1.6));
			g.moveTo(x + w*5/20, y + h/2);
			g.lineTo(x + w*9/20, y + h*14/20);
			g.lineTo(x + w*15/20, y + h*7/20);
			g.endDraw();
		 	
		}

		dot.visible = drawDot;
	}
	
	public function getIconHeight(c:Component):Int{
		return 20;
	}
	
	public function getIconWidth(c:Component):Int{
		return 20;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return sprite;
	}
 
	
}