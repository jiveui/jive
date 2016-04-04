/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.cursor;

	
import flash.display.Shape;
import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.UIManager;
import org.aswing.ASColor;

/**
 * @private
 * @author valley
 */
class HV_ResizeCursor extends Shape{
	
	private var resizeArrowColor:ASColor;
	private var resizeArrowLightColor:ASColor;
	private var resizeArrowDarkColor:ASColor;
	
	public function new(){
		super();
		
	    resizeArrowColor = UIManager.getColor("Frame.resizeArrow");
	    resizeArrowLightColor = UIManager.getColor("Frame.resizeArrowLight");
	    resizeArrowDarkColor = UIManager.getColor("Frame.resizeArrowDark");

		var w:Float= 1; //arrowAxisHalfWidth
		var r:Float= 4;
		var arrowPoints:Array<Dynamic>;
		
		arrowPoints = [{y:-r*2, x:0}, {y:-r, x:-r}, {y:-r, x:-w},
						 {y:-w,x:-w}, {y:-w,x:-r}, {y:-r,x:-r}, {y:0,x:-2*r}, 
						 {y:r ,x:-r }, {y:w,x:-r}, {y:w ,x:-w }, 
						 {y:r, x:-w}, {y:r, x:-r}, {y:r*2, x:0},
						 {y:r, x:r}, {y:r, x:w}, 
						 {y:w,x:w}, {y:w,x:r}, {y:r,x:r}, {y:0,x:2*r}, 
						 {y:-r,x:r}, {y:-w,x:r}, {y:-w,x:w}, 
						 {y:-r, x:w}, {y:-r, x:r}];
						 
		var gdi:Graphics2D = new Graphics2D(graphics);
		//why	
		 
		gdi.drawPolygon(new Pen(resizeArrowColor.changeAlpha(0.4), 4), arrowPoints);
		gdi.fillPolygon(new SolidBrush(resizeArrowLightColor), arrowPoints);
		gdi.drawPolygon(new Pen(resizeArrowDarkColor, 1), arrowPoints);			
	}
}