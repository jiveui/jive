/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.plaf.flat.icon;


import org.aswing.AsWingUtils;
import org.aswing.AsWingUtils;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite; 
import flash.filters.BitmapFilterType; 

import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
import org.aswing.AsWingManager;
import org.aswing.Icon;
import org.aswing.Component;
import org.aswing.ASColor;
import org.aswing.AbstractButton;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.ButtonModel;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

/**
 * Frame title bar icon base.
 * @author paling
 * @private
 */
class FrameIcon implements Icon implements UIResource {
			
	private var width:Int;
	private var height:Int;
	private var box:Shape;
	private var dot:Shape;
	
	private var sprite:Sprite;
		
	/**
	 * @param width the width of the icon square.
	 */	
	public function new(width:Int=16){
		this.width = width;
		height = width;
		sprite = new Sprite();
		sprite.mouseChildren = false;
		sprite.mouseEnabled = false;
		
		box = new Shape();
		dot = new Shape();
		sprite.addChild(box);
		sprite.addChild(dot);
	}
	
	public function getColor(c:Component):ASColor{
		return c.getMideground();
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		box.graphics.clear();
		g = new Graphics2D(box.graphics);
		
		var b:AbstractButton = AsWingUtils.as(c,AbstractButton)	;
		if(b == null){
			return;
		}
		var bounds:IntRectangle = new IntRectangle(x, y, width, height);
		// make 1 pixel space for shadow filter effect
		bounds.width -= 1;
		bounds.height -= 1;
		
		var cl:ASColor = c.mideground;

		var model:ButtonModel = b.getModel();
    	var isPressing:Bool= model.isArmed() || model.isSelected();
		var shadowScale:Float= 1;

    	if(!b.isEnabled()){//disabled
    		cl = cl.offsetHLS(0, 0.2, 0);
    	} else if(model.isRollOver()){//over
    		cl = cl.offsetHLS(0, -0.2, 0);
    	}

		var box_f:Array<BitmapFilter> = new Array<BitmapFilter>();
		box_f.push(new  DropShadowFilter(1, 45, 0xFFFFFF, c.styleTune.shadowAlpha * shadowScale, 1, 1, 1, 1));
		box.filters = box_f;
		dot.graphics.clear();
		updateIconImp(cl, new Graphics2D(dot.graphics), x, y);
	}
	
	public function updateIconImp(color: ASColor, g:Graphics2D, x:Int, y:Int):Void{}
	
	public function getSize():Int{
		return width;
	}
	
	public function getIconHeight(c:Component):Int{
		return width;
	}
	
	public function getIconWidth(c:Component):Int{
		return height;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return sprite;
	}
 
}