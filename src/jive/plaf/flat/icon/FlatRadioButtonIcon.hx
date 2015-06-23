/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.plaf.flat.icon;


import org.aswing.UIManager;
import org.aswing.JRadioButton;
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

class FlatRadioButtonIcon implements Icon implements UIResource {
	
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
		var b:JRadioButton = AsWingUtils.as(c,JRadioButton);
		var model:ButtonModel = b.getModel();

		box.graphics.clear();
		var g:Graphics2D = new Graphics2D(box.graphics);
		
		var w:Int= getIconWidth(c);
		var h:Int= getIconHeight(c);

		var cl:ASColor = c.background;
    	var drawDot: Bool = model.isArmed() || model.isSelected() || model.isRollOver();

        if (b.transitBackgroundFactor < 0) {
            cl = ASColor.getColorBetween(c.background, c.mideground, -b.transitBackgroundFactor);
        }

        if (!b.enabled) {
      		cl = cl.offsetHLS(0, 0.1, -0.4);
    	}

        g.fillCircle(new SolidBrush(cl), w/2, h/2, w*10/20);
        g.fillCircle(new SolidBrush(new ASColor(0xffffff)), w/2, h/2, w*6/20);

        // Draw dot
		dot.graphics.clear();

        if(drawDot) {
			g = new Graphics2D(dot.graphics);
            g.fillCircle(new SolidBrush(cl), w/2, h/2, w*3/20);
		}

		dot.visible = drawDot;
	}
	
	public function getIconHeight(c:Component):Int{
        return if(null != UIManager.get("iconSize")) UIManager.get("iconSize") else 20;
	}
	
	public function getIconWidth(c:Component):Int{
        return if(null != UIManager.get("iconSize")) UIManager.get("iconSize") else 20;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return sprite;
	}
 
	
}