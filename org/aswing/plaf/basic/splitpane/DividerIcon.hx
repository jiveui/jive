package org.aswing.plaf.basic.splitpane;

import flash.display.DisplayObject;

import org.aswing.Component;
import org.aswing.Icon;
import org.aswing.JSplitPane;
import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	/**
 * @private
 */
class DividerIcon implements Icon{
	public function new(){
	}
	
	public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int):Void{
    	var w:Float= com.getWidth();
    	var h:Float= com.getHeight();
    	var ch:Float= h/2;
    	var cw:Float= w/2;
    	var divider:Divider = AsWingUtils.as(com, Divider);
		//why	
		 
    	var p:Pen = new Pen(divider.getOwner().getForeground(), 0);
    	if(divider.getOwner().getOrientation() == JSplitPane.VERTICAL_SPLIT){
	    	var hl:Float= Math.min(5, w-1);
	    	g.drawLine(p, cw-hl, ch, cw+hl, ch);
	    	if(ch + 2 < h){
	    		g.drawLine(p, cw-hl, ch+2, cw+hl, ch+2);
	    	}
	    	if(ch - 2 > 0){
	    		g.drawLine(p, cw-hl, ch-2, cw+hl, ch-2);
	    	}
    	}else{
	    	var h2:Float= Math.min(5, h-1);
	    	g.drawLine(p, cw, ch-h2, cw, ch+h2);
	    	if(cw + 2 < h){
	    		g.drawLine(p, cw+2, ch-h2, cw+2, ch+h2);
	    	}
	    	if(cw - 2 > 0){
	    		g.drawLine(p, cw-2, ch-h2, cw-2, ch+h2);
	    	}
    	}	
		 
	}
	
	public function getIconHeight(c:Component):Int{
		return 0;
	}
	
	public function getIconWidth(c:Component):Int{
		return 0;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return null;
	}
	 
	
}