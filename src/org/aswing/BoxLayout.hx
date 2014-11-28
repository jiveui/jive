/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing;

	
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.EmptyLayout;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.Insets;


/**
 * A layout manager that allows multiple components to be arranged either vertically or 
 * horizontally. The components will not be wrapped. The width, height, preferredWidth,preferredHeight doesn't affect the way 
 * this layout manager layout the components. Note, it does  not work the same way as Java swing boxlayout does.
 * <p>
 * If this boxlayout is set to X_AXIS, it will layout the child componnets evenly regardless the value of width,height,preferredWidth,preferredHeight.
 * The height of the child components is the same as the parent container.
 * The following picture illustrate this:
 * <img src="../../aswingImg/BoxLayout_X_AXIS.JPG" ></img>
 * </p>
 * <br/>
 * <br/>
 * <p>
 * It works the same way when it is set to Y_AXIS. 
 * </p>
 * <br>
 * Note that this layout will first subtract all of the gaps before it evenly layout the components.
 * If you have a container that is 100 pixel in width with 5 child components, the layout manager is boxlayout, and set to X_AXIS, the gap is 20.
 * You would not see any child componnet in visual. 
 * Because the layout mananager will first subtract 20(gap)*5(component) =100 pixels from the visual area. Then, each component's width would be 0.
 * Pay attention to this when you use this layout manager.
 * </br>
 * @author paling
 */
class BoxLayout extends EmptyLayout
{
	/**
     * Specifies that components should be laid out left to right.
     */
    inline public static var X_AXIS:Int= AsWingConstants.HORIZONTAL;
    
    /**
     * Specifies that components should be laid out top to bottom.
     */
    inline public static var Y_AXIS:Int= AsWingConstants.VERTICAL;
    
    
    private var axis:Int;
    private var gap:Int;
    
    /**
     * @param axis (optional)the layout axis, default is X_AXIS
     * @param gap  (optional)the gap between children, default is 0
     * 
     * @see #X_AXIS
     * @see #X_AXIS
     */
    public function new(axis:Int=X_AXIS, gap:Int=0){
    	setAxis(axis);
    	setGap(gap);
		super();
    }
    
    /**
     * Sets new axis.
     * @param axis new axis default is X_AXIS
     */
    public function setAxis(axis:Int=X_AXIS):Void{
    	this.axis = axis;
    }
    
    /**
     * Gets axis.
     * @return axis
     */
    public function getAxis():Int{
    	return axis;	
    }
    
    /**
     * Sets new gap.
     * @param get new gap
     */	
    public function setGap(gap:Int=0):Void{
    	this.gap = gap;
    }
    
    /**
     * Gets gap.
     * @return gap
     */
    public function getGap():Int{
    	return gap;	
    }
    
    override public function preferredLayoutSize(target:Container):IntDimension{
    	return getCommonLayoutSize(target, false);
    }

    override public function minimumLayoutSize(target:Container):IntDimension{
    	return target.getInsets().getOutsideSize();
    }
    
    override public function maximumLayoutSize(target:Container):IntDimension{
    	return getCommonLayoutSize(target, true);
    }    
    
    
    private function getCommonLayoutSize(target:Container, isMax:Bool):IntDimension{
    	var count:Int= target.getComponentCount();
    	var insets:Insets = target.getInsets();
    	var width:Int= 0;
    	var height:Int= 0;
    	var amount:Int= 0;
    	for(i in 0...count){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		var size:IntDimension = isMax ? c.getMaximumSize() : c.getPreferredSize();
	    		width = Std.int(Math.max(width, size.width));
	    		height =Std.int( Math.max(height, size.height));
	    		amount++;
    		}
    	}
    	if(axis == Y_AXIS){
    		height = height*amount;
    		if(amount > 0){
    			height += (amount-1)*gap;
    		}
    	}else{
    		width = width*amount;
    		if(amount > 0){
    			width += (amount-1)*gap;
    		}
    	}
    	var dim:IntDimension = new IntDimension(width, height);
    	return insets.getOutsideSize(dim);
    }
    
    override public function layoutContainer(target:Container):Void{
    	var count:Int= target.getComponentCount();
    	var amount:Int= 0;
    	for(i in 0...count){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		amount ++;
    		}
    	}
    	var size:IntDimension = target.getSize();
    	var insets:Insets = target.getInsets();
    	var rd:IntRectangle = insets.getInsideBounds(size.getBounds());
    	var ch:Int;
    	var cw:Int;
    	if(axis == Y_AXIS){
    		ch = Math.floor((rd.height - (amount-1)*gap)/amount);
    		cw = rd.width;
    	}else{
    		ch = rd.height;
    		cw = Math.floor((rd.width - (amount-1)*gap)/amount);
    	}
    	var x:Int= rd.x;
    	var y:Int= rd.y;
    	var xAdd:Int= (axis == Y_AXIS ? 0 : cw+gap);
    	var yAdd:Int= (axis == Y_AXIS ? ch+gap : 0);
    	
    	for(ii in 0...count){
    		var comp:Component = target.getComponent(ii);
    		if(comp.isVisible()){
	    		comp.setBounds(new IntRectangle(x, y, cw, ch));
	    		x += xAdd;
	    		y += yAdd;
    		}
    	}
    }
    
	/**
	 * return 0.5
	 */
    override public function getLayoutAlignmentX(target:Container):Float{
    	return 0.5;
    }

	/**
	 * return 0.5
	 */
    override public function getLayoutAlignmentY(target:Container):Float{
    	return 0.5;
    }
}