/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.colorchooser;
 
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.EmptyLayout;
import org.aswing.Insets;
import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	/**
 * @author paling
 */
class VerticalLayout extends EmptyLayout {
	
    /**
     * This value indicates that each row of components
     * should be left-justified.
     */
    inline public static var LEFT:Int= 0;

    /**
     * This value indicates that each row of components
     * should be centered.
     */
    inline public static var CENTER:Int= 1;

    /**
     * This value indicates that each row of components
     * should be right-justified.
     */
    inline public static var RIGHT:Int= 2;	
	
	private var align:Int;
	private var gap:Int;
	
	public function new(align:Int=LEFT, gap:Int=0){
		this.align = align;
		this.gap   = gap;
		super();
	}
	
    
    /**
     * Sets new gap.
     * @param get new gap
     */	
    public function setGap(gap:Int):Void{
    	this.gap = gap;
    }
    
    /**
     * Gets gap.
     * @return gap
     */
    public function getGap():Int{
    	return gap;	
    }
    
    /**
     * Sets new align. Must be one of:
     * <ul>
     *  <li>LEFT
     *  <li>RIGHT
     *  <li>CENTER
     *  <li>TOP
     *  <li>BOTTOM
     * </ul> Default is LEFT.
     * @param align new align
     */
    public function setAlign(align:Int):Void{
    	this.align = align;
    }
    
    /**
     * Returns the align.
     * @return the align
     */
    public function getAlign():Int{
    	return align;
    }
   	
	/**
	 * Returns preferredLayoutSize;
	 */
    override public function preferredLayoutSize(target:Container):IntDimension{
    	var count:Int= target.getComponentCount();
    	var width:Int= 0;
    	var height:Int= 0;
    	for(i in 0...count){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		var size:IntDimension = c.getPreferredSize();
	    		width = Std.int(Math.max(width, size.width));
	    		var g:Int= i > 0 ? gap : 0;
	    		height += (size.height + g);
    		}
    	}
    	
    	var dim:IntDimension = new IntDimension(width, height);
    	return dim;
    }
        
	/**
	 * Returns minimumLayoutSize;
	 */
    override public function minimumLayoutSize(target:Container):IntDimension{
    	return target.getInsets().getOutsideSize();
    }
    
    /**
     * do nothing
     */
    override public function layoutContainer(target:Container):Void{
    	var count:Int= target.getComponentCount();
    	var size:IntDimension = target.getSize();
    	var insets:Insets = target.getInsets();
    	var rd:IntRectangle = insets.getInsideBounds(size.getBounds());
    	var cw:Int= rd.width;
    	var x:Int= rd.x;
    	var y:Int= rd.y;
		var right:Int= x + cw;
    	for(i in 0...count){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		var ps:IntDimension = c.getPreferredSize();
	    		if(align == RIGHT){
    				c.setBounds(new IntRectangle(right - ps.width, y, ps.width, ps.height));
	    		}else if(align == CENTER){
	    			c.setBounds(new IntRectangle(Std.int(x + cw/2 - ps.width/2), y, ps.width, ps.height));
	    		}else{
	    			c.setBounds(new IntRectangle(x, y, ps.width, ps.height));
	    		}
    			y += ps.height + gap;
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