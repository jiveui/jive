/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.border;

	
import org.aswing.graphics.Graphics2D;
import org.aswing.Border;
import org.aswing.geom.IntRectangle;
import org.aswing.Component;
import org.aswing.Insets;
import flash.display.DisplayObject;
import flash.display.Sprite;
import org.aswing.error.ImpMissError;

/**
 * DecorateBorder make your border can represented as many border arounded.
 * DecorateBorder is a abstract class, you need to inherit it to implement your 
 * real decrator border.
 * <p>
 * <b>Note:You should only need to override:</b>
 * <ul>
 * <li><code>getDisplayImp</code></li>
 * <li><code>updateBorderImp</code></li>
 * <li><code>getBorderInsetsImp</code></li>
 * </ul>
 * methods in sub-class.
 * </p>
 * @author paling
 */
class DecorateBorder implements Border{
		
	private var interior:Border;
	private var disContainer:Sprite;
	
	public function new(interior:Border){
		this.interior = interior;
	}
	
	/**
	 * Sets new interior border.
	 * @param interior the new interior border
	 */
	public function setInterior(interior:Border):Void{
		this.interior = interior;	
	}

	/**
	 * Returns current interior border.
	 * @return current interior border
	 */
	public function getInterior():Border {
		return interior;	
	}
	
	/**
	 * Override this method in sub-class to return the display object if needed.
	 * @return a display object, or null, do not need a display object.
	 */
	public function getDisplayImp():DisplayObject{
		return null;
	}
	
	/**
	 * Override this method in sub-class to draw border on the specified mc.
	 * @param c the component for which this border is being painted 
	 * @param g the paint graphics
	 * @param bounds the bounds of border
	 */
	public function updateBorderImp(com:Component, g:Graphics2D, bounds:IntRectangle):Void{
    	throw new ImpMissError();
	}
	
    /**
     * You should override this method to count this border's insets.
     * @see #getBorderInsets
     */
    public function getBorderInsetsImp(c:Component, bounds:IntRectangle):Insets{
    	throw new ImpMissError();
    	return new Insets();
    }
	
    /**
     * You should override this method to return the display object.
     * @see #getDisplayImp()
     */	   
	 public function getDisplay(c:Component):DisplayObject
	{
		var inter:Border = getInterior();
		if(inter != null){
			var interDis:DisplayObject = inter.getDisplay(c);
			var selfDis:DisplayObject = getDisplayImp();
			if(interDis == null){
				return selfDis;
			}else if(selfDis == null){
				return interDis;
			}else{
				if(disContainer == null){
					disContainer = new Sprite();
					disContainer.addChild(selfDis);
					disContainer.addChild(interDis);
				}
				return disContainer;
			}
		}else{
			return getDisplayImp();
		}
	}
	
	/**
	 * call <code>super.paintBorder</code> paint the border first and then 
	 * paint the interior border on the interior bounds.
	 * <br>
	 * Note:subclass should not override this method, should override paintBorderImp.
	 * @see #paintBorderImp
	 */
	  public function updateBorder(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
    	updateBorderImp(c, g, bounds);
    	//then paint interior border
    	if(getInterior() != null){
    		var interiorBounds:IntRectangle = getBorderInsetsImp(c, bounds).getInsideBounds(bounds);
    		getInterior().updateBorder(c, g, interiorBounds);
    	}
    }
    

    /**
     * Returns the insets of the border.<br>
     * Note:subclass should not override this method, should override getBorderInsetsImp.
     * @see #getBorderInsetsImp
     * @param c the component for which this border insets value applies
     * @param bounds the bounds of the border would paint in.
     */
      public function getBorderInsets(c:Component, bounds:IntRectangle):Insets{
    	var insets:Insets = getBorderInsetsImp(c, bounds);
    	if(getInterior() != null){
    		var interiorBounds:IntRectangle = insets.getInsideBounds(bounds);
    		insets.addInsets(getInterior().getBorderInsets(c, interiorBounds));
    	}
    	return insets;
    }	
}