/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.resizer;

	
import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.Component;

/**
 * A basic implementation of ResizeStrategy.
 * 
 * <p>It will return the resized rectangle, the rectangle is not min than 
 * getResizableMinSize and not max than getResizableMaxSize if these method are defineded
 * in the resized comopoent.
 * </p>
 * @author paling
 */
class ResizeStrategyImp implements ResizeStrategy{
	
	private var wSign:Float;
	private var hSign:Float;
	
	public function new(wSign:Float, hSign:Float){
		this.wSign = wSign;
		this.hSign = hSign;
	}
	
	/**
	 * Count and return the new bounds what the component would be resized to.<br>
	 * 
 	 * It will return the resized rectangle, the rectangle is not min than 
 	 * getResizableMinSize and not max than getResizableMaxSize if these method are defineded
 	 * in the resized comopoent.
	 */
	public function getBounds(origBounds:IntRectangle, minSize:IntDimension, maxSize:IntDimension, movedX:Int, movedY:Int):IntRectangle{
		var currentBounds:IntRectangle = origBounds.clone();
		if(minSize == null){
			minSize = new IntDimension(0, 0);
		}
		if(maxSize == null){
			maxSize = IntDimension.createBigDimension();
		}		
		var newX:Float;
		var newY:Float;
		var newW:Float;
		var newH:Float;
		if(wSign == 0){
			newW = currentBounds.width;
		}else{
			newW = currentBounds.width + wSign*movedX;
			newW = Math.min(maxSize.width, Math.max(minSize.width, newW));
		}
		if(wSign < 0){
			newX = currentBounds.x + (currentBounds.width - newW);
		}else{
			newX = currentBounds.x;
		}
		
		if(hSign == 0){
			newH = currentBounds.height;
		}else{
			newH = currentBounds.height + hSign*movedY;
			newH = Math.min(maxSize.height, Math.max(minSize.height, newH));
		}
		if(hSign < 0){
			newY = currentBounds.y + (currentBounds.height - newH);
		}else{
			newY = currentBounds.y;
		}
		newX = Math.round(newX);
		newY = Math.round(newY);
		newW = Math.round(newW);
		newH = Math.round(newH);
		return new IntRectangle(Std.int(newX), Std.int(newY), Std.int(newW), Std.int(newH));
	}
		
}