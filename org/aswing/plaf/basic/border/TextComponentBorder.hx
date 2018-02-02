/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border;

	
import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.geom.IntRectangle;
import org.aswing.Border;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.EditableComponent;
	import org.aswing.Insets;
	import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;
	import org.aswing.plaf.ComponentUI;
	import org.aswing.error.ImpMissError;

/**
 * Discard in aswing 2.0(Background raped his job)
 * @private
 */
class TextComponentBorder implements Border implements UIResource{

    private var light:ASColor;
    private var shadow:ASColor;
    	
	public function new(){
		
	}
	
    private function getPropertyPrefix():String{
    	throw new ImpMissError();
        return "";
    }
	
	private function reloadColors(ui:ComponentUI):Void{
		light = ui.getColor(getPropertyPrefix()+"light");
		shadow = ui.getColor(getPropertyPrefix()+"shadow");
	}
    	
	public function updateBorder(c:Component, g:Graphics2D, r:IntRectangle):Void {
		 

		if(light == null){
			reloadColors(c.getUI());
		}
	    var x1:Float= r.x;
		var y1:Float= r.y;
		var w:Float= r.width;
		var h:Float= r.height;
		var textCom:EditableComponent = AsWingUtils.as(c, EditableComponent);
		//why	
		 
		if(textCom.isEditable() && c.isEnabled()){
			g.drawRectangle(new Pen(shadow, 1), x1+0.5, y1+0.5, w-1, h-1);
		}
		g.drawRectangle(new Pen(light, 1), x1+1.5, y1+1.5, w-3, h-3);	
		 
	}
	
	public function getBorderInsets(com:Component, bounds:IntRectangle):Insets
	{
		return new Insets(2, 2, 2, 2);
	}
	
	public function getDisplay(c:Component):DisplayObject
	{
		return null;
	}
	
}