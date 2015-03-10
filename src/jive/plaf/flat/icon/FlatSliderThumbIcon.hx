/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.plaf.flat.icon;


import org.aswing.graphics.SolidBrush;
import flash.display.Sprite;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.DisplayObject;
import flash.geom.Matrix;
import org.aswing.SimpleButton;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.Icon;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.GradientBrush;
import org.aswing.plaf.UIResource;
	/**
 * @private
 */
class FlatSliderThumbIcon implements Icon implements UIResource{
	
	private var thumb:Sprite;
	private var enabledButton:SimpleButton;
	private var disabledButton:SimpleButton;
	private var overButton:DisplayObjectContainer;
		
	public function new(){
		thumb = new Sprite();
	}
	
	private function getPropertyPrefix():String{
		return "Slider.";
	}	
	
	private function initThumb(c:Component):Void{
		//enabled 
		var upState:Shape = new Shape();
		var g:Graphics2D = new Graphics2D(upState.graphics);
    	paintThumb(g, c, true, false);

        var overState:Shape = new Shape();
        g = new Graphics2D(overState.graphics);
        paintThumb(g, c, true, true);

        var downState:Shape = new Shape();
        g = new Graphics2D(downState.graphics);
        paintThumb(g, c, true, true, true);

        enabledButton = new  SimpleButton();
    	enabledButton.upState = upState; 
		enabledButton.overState = upState;
		enabledButton.downState = downState;
		enabledButton.hitTestState = upState;
		enabledButton.useHandCursor = false;
		enabledButton.show();
		
		
		thumb.addChild(enabledButton);
		
		//disabled
		
		upState = new Shape();
		g = new Graphics2D(upState.graphics);
    	paintThumb(g, c, false, false);
		 
	 
		disabledButton = new  SimpleButton();
    	disabledButton.upState = upState; 
		disabledButton.overState = upState;
		disabledButton.downState = upState;
		disabledButton.hitTestState = upState;
		disabledButton.useHandCursor = false;
		disabledButton.show();
		thumb.addChild(disabledButton);
		disabledButton.visible = false;
	}
	
	private function paintThumb(g:Graphics2D, c:Component, enabled:Bool, over:Bool, down:Bool = false):Void{
    	var tune:StyleTune = c.getStyleTune().mide;
    	var cl:ASColor = c.getMideground().offsetHLS(0, 0.05, 0);
    	if(enabled!=true){//disabled
    		cl = cl.offsetHLS(0, 0.1, -0.5);
    	} else if(down)	{//pressed
            cl = cl.offsetHLS(0, -0.1, 0);
        } else if(over)	{
    		cl = cl.offsetHLS(0, 0.05, 0);
    	}
    	var w:Int= getIconWidth(null);
    	var h:Int= getIconHeight(null);
    	g.fillEllipse(new SolidBrush(cl), 0, 0, w, h);
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		if(enabledButton == null){
			initThumb(c);
		}
		thumb.x = x;
		thumb.y = y;
		disabledButton.visible = !c.isEnabled();
		enabledButton.visible = c.isEnabled();
	}
	
	public function getIconHeight(c:Component):Int{
		return 18;
	}
	
	public function getIconWidth(c:Component):Int{
		return 18;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return thumb;
	}
 
}