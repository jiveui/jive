package org.aswing;


import org.aswing.Component;
import org.aswing.Container;
import org.aswing.EmptyLayout;
import org.aswing.geom.IntDimension;
import org.aswing.Insets;
import org.aswing.geom.IntPoint;

/**
 * FlowWrapLayout wrap layout is extended FlowLayout, 
 * the only different is that it has a prefer width, the prefer width means that when count the preffered size, 
 * it assume to let chilren arrange to a line when one reach the prefer width, then wrap next to next line.
 * FlowLayout is different, when counting the preferred size, FlowLayout assumes all children should be arrange to one line.
 *
 * @author 	paling
 */
class FlowWrapLayout extends FlowLayout{
	
    /**
     * This value indicates that each row of components
     * should be left-justified.
     */
    inline public static var LEFT:Int= AsWingConstants.LEFT;

    /**
     * This value indicates that each row of components
     * should be centered.
     */
    inline public static var CENTER:Int= AsWingConstants.CENTER;

    /**
     * This value indicates that each row of components
     * should be right-justified.
     */
    inline public static var RIGHT:Int= AsWingConstants.RIGHT;
    
    private var preferWidth:Int;

    /**
     * <p>  
     * Creates a new flow wrap layout manager with the indicated prefer width, alignment
     * and the indicated horizontal and vertical gaps.
     * </p>
     * The value of the alignment argument must be one of
     * <code>FlowWrapLayout.LEFT</code>, <code>FlowWrapLayout.RIGHT</code>,or <code>FlowWrapLayout.CENTER</code>.
     * @param      preferWidth the width that when component need to wrap to second line
     * @param      align   the alignment value, default is LEFT
     * @param      hgap    the horizontal gap between components, default 5
     * @param      vgap    the vertical gap between components, default 5
     * @param      margin  whether or not the gap will margin around
     */
    public function new(preferWidth:Int=200, align:Int=AsWingConstants.LEFT, hgap:Int=5, vgap:Int=5, margin:Bool=true) {
    	super(align, hgap, vgap, margin);
		this.preferWidth = preferWidth;
    }
    
    /**
     * Sets the prefer width for all should should arranged.
     * @param preferWidth the prefer width for all should should arranged.
     */
    public function setPreferWidth(preferWidth:Int):Void{
    	this.preferWidth = preferWidth;
    }
    
    /**
     * Returns the prefer width for all should should arranged.
     * @return the prefer width for all should should arranged.
     */    
    public function getPreferWidth():Int{
    	return preferWidth;
    }
    
    /**
     * Returns the preferred dimensions for this layout given the 
     * <i>visible</i> components in the specified target container.
     * @param target the component which needs to be laid out
     * @return    the preferred dimensions to lay out the
     *            subcomponents of the specified container
     * @see Container
     * @see #doLayout()
     */
    override public function preferredLayoutSize(target:Container):IntDimension {
		var dim:IntDimension = new IntDimension(0, 0);
		var nmembers:Int= target.getComponentCount();
		var x:Int= 0;
		var rowHeight:Int= 0;
		var visibleNum:Int= 0;
		var count:Int= 0;
		
		for (i in 0 ...nmembers ){
	    	if (target.getComponent(i).isVisible()) {
	    		visibleNum++;
	    	}
		}
		for (i  in 0 ...nmembers ){
	    	var m:Component = target.getComponent(i);
	    	if (m.isVisible()) {
	    		count++;
				var d:IntDimension = m.getPreferredSize();
				rowHeight = Std.int(Math.max(rowHeight, d.height));
                if (x > 0) {
                    x += hgap;
                }
				x += d.width;
                if(x >= preferWidth || count == visibleNum){
                	dim.width = Std.int(Math.max(dim.width, x));
                	dim.height += rowHeight;
                	if(count != visibleNum){
                		dim.height += vgap;
                	}
                	x = 0;
					//ghdu's way to make the layout more reasonable
					rowHeight = 0;
                }
	    	}
		}
		var insets:Insets = target.getInsets();
		dim.width += insets.left + insets.right;
		dim.height += insets.top + insets.bottom;
		if(margin)	{
			dim.width += hgap*2;
			dim.height += vgap*2;
		}
    	return dim;
    }
  
    /**
     * Returns a string representation of this <code>FlowWrapLayout</code>
     * object and its values.
     * @return     a string representation of this layout
     */
    override public function toString():String{
		var str:String= "";
		switch (align) {
	 	 	case LEFT:        str = ",align=left"; 
	 		case CENTER:      str = ",align=center";  
	  		case RIGHT:       str = ",align=right";  
		}
		return "FlowWrapLayout[hgap=" + hgap + ",vgap=" + vgap + str + "]";
    }
}