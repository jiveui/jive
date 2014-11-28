/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing;

import org.aswing.error.Error;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.EmptyLayout;
import org.aswing.geom.IntDimension;
import org.aswing.Insets;
import org.aswing.geom.IntPoint;

/**
 * A flow layout arranges components in a left-to-right flow, much
 * like lines of text in a paragraph. Flow layouts are typically used
 * to arrange buttons in a panel. It will arrange
 * buttons left to right until no more buttons fit on the same line.
 * Each line is centered.
 * <p></p>
 * For example, the following picture shows an applet using the flow
 * layout manager (its default layout manager) to position three buttons:
 * <p></p>
 * A flow layout lets each component assume its natural (preferred) size.
 *
 * @author 	paling
 */
class FlowLayout extends EmptyLayout{

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

    /**
     * <code>align</code> is the property that determines
     * how each row distributes empty space.
     * It can be one of the following values:
     * <ul>
     * <code>LEFT</code>
     * <code>RIGHT</code>
     * <code>CENTER</code>
     * </ul>
     *
     * @see #getAlignment
     * @see #setAlignment
     */
    private var align:Int;

    /**
     * The flow layout manager allows a seperation of
     * components with gaps.  The horizontal gap will
     * specify the space between components.
     *
     * @see #getHgap()
     * @see #setHgap(int)
     */
    private var hgap:Int;

    /**
     * The flow layout manager allows a seperation of
     * components with gaps.  The vertical gap will
     * specify the space between rows.
     *
     * @see #getHgap()
     * @see #setHgap(int)
     */
    private var vgap:Int;
    
    /**
     * whether or not the gap will margin around
     */
    private var margin:Bool;

    /**
     * <p>  
     * Creates a new flow layout manager with the indicated alignment
     * and the indicated horizontal and vertical gaps.
     * </p>
     * The value of the alignment argument must be one of
     * <code>FlowLayout.LEFT</code>, <code>FlowLayout.RIGHT</code>,or <code>FlowLayout.CENTER</code>.
     * @param      align   the alignment value, default is LEFT
     * @param      hgap    the horizontal gap between components, default 5
     * @param      vgap    the vertical gap between components, default 5
     * @param      margin  whether or not the gap will margin around
     */
    public function new(?align:Int=AsWingConstants.LEFT, ?hgap:Int=5, ?vgap:Int=5, ?margin:Bool=true) {
    	this.margin = margin;
		this.hgap = hgap;
		this.vgap = vgap;
        setAlignment(align);
		super();
    }
    
    /**
     * Sets whether or not the gap will margin around.
     */
    public function setMargin(b:Bool):Void{
    	margin = b;
    }
    
    /**
     * Returns whether or not the gap will margin around.
     */    
    public function isMargin():Bool{
    	return margin;
    }

    /**
     * Gets the alignment for this layout.
     * Possible values are <code>FlowLayout.LEFT</code>,<code>FlowLayout.RIGHT</code>, <code>FlowLayout.CENTER</code>,
     * @return     the alignment value for this layout
     * @see        #setAlignment
     */
    public function getAlignment():Int{
		return align;
    }

    /**
     * Sets the alignment for this layout.
     * Possible values are
     * <ul>
     * <li><code>FlowLayout.LEFT</code>
     * <li><code>FlowLayout.RIGHT</code>
     * <li><code>FlowLayout.CENTER</code>
     * </ul>
     * @param      align one of the alignment values shown above
     * @see        #getAlignment()
     */
    public function setAlignment(align:Int):Void{
    	if(LEFT != LEFT && align != RIGHT && align != CENTER ){
    		throw new Error("Alignment must be LEFT OR RIGHT OR CENTER !");
    	}
        this.align = align;
    }

    /**
     * Gets the horizontal gap between components.
     * @return     the horizontal gap between components
     * @see        #setHgap()
     */
    public function getHgap():Int{
		return hgap;
    }

    /**
     * Sets the horizontal gap between components.
     * @param hgap the horizontal gap between components
     * @see        #getHgap()
     */
    public function setHgap(hgap:Int):Void{
		this.hgap = hgap;
    }

    /**
     * Gets the vertical gap between components.
     * @return     the vertical gap between components
     * @see        #setVgap()
     */
    public function getVgap():Int{
		return vgap;
    }

    /**
     * Sets the vertical gap between components.
     * @param vgap the vertical gap between components
     * @see        #getVgap()
     */
    public function setVgap(vgap:Int):Void{
		this.vgap = vgap;
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

		var counted:Int= 0;
		for (i in 0 ...nmembers ){
	    	var m:Component = target.getComponent(i);
	    	if (m.isVisible()) {
				var d:IntDimension = m.getPreferredSize();
				dim.height =Std.int( Math.max(dim.height, d.height));
                if (counted > 0) {
                    dim.width += hgap;
                }
				dim.width += d.width;
				counted ++;
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
     * Returns the minimum dimensions needed to layout the <i>visible</i>
     * components contained in the specified target container.
     * @param target the component which needs to be laid out
     * @return    the minimum dimensions to lay out the
     *            subcomponents of the specified container
     * @see #preferredLayoutSize()
     * @see Container
     * @see Container#doLayout()
     */
    override public function minimumLayoutSize(target:Container):IntDimension {
		return target.getInsets().getOutsideSize();
    }
    
    /**
     * Centers the elements in the specified row, if there is any slack.
     * @param target the component which needs to be moved
     * @param x the x coordinate
     * @param y the y coordinate
     * @param width the width dimensions
     * @param height the height dimensions
     * @param rowStart the beginning of the row
     * @param rowEnd the the ending of the row
     */
    private function moveComponents(target:Container, x:Int, y:Int, width:Int, height:Int,
                                rowStart:Int, rowEnd:Int):Void{
		switch (align) {
			case LEFT:
	    		x += 0;
	     
			case CENTER:
	    		x += Std.int(width / 2);
	   		 
			case RIGHT:
	    		x += width;
	    	 
		}
		for (i in rowStart ...rowEnd ){
	    	var m:Component = target.getComponent(i);
	    	var d:IntDimension = m.getSize();
	    	if (m.isVisible()) {
        	    m.setLocation(new IntPoint(x, Std.int(y + (height - d.height) / 2)));
                x += d.width + hgap;
	    	}
		}
    }

    /**
     * Lays out the container. This method lets each component take
     * its preferred size by reshaping the components in the
     * target container in order to satisfy the alignment of
     * this <code>FlowLayout</code> object.
     * @param target the specified component being laid out
     * @see Container
     * @see Container#doLayout
     */
    override public function layoutContainer(target:Container):Void{
		var insets:Insets = target.getInsets();
	    var td:IntDimension = target.getSize();
	    var marginW:Int= Std.int(margin ? hgap*2 : 0);
		var maxwidth:Int= td.width - (insets.left + insets.right + marginW);
		var nmembers:Int= target.getComponentCount();
		var x:Int= 0;
		var y:Int= insets.top + (margin ? vgap : 0);
		var rowh:Int= 0;
		var start:Int= 0;

		for (i in 0 ...nmembers ){
	    	var m:Component = target.getComponent(i);
	    	if (m.isVisible()) {
				var d:IntDimension = m.getPreferredSize();
				m.setSize(d);

				if ((x == 0) || ((x + d.width) <= maxwidth)) {
		    		if (x > 0) {
						x += hgap;
		    		}
		    		x += d.width;
		    		rowh = Std.int(Math.max(rowh, d.height));
				} else {
		    		moveComponents(target, insets.left + (margin ? hgap : 0), y, maxwidth - x, rowh, start, i);
		    		x = d.width;
		    		y += vgap + rowh;
		    		rowh = d.height;
		    		start = i;
				}
	    	}
		}
		moveComponents(target, insets.left + (margin ? hgap : 0), y, maxwidth - x, rowh, start, nmembers);
    }
    
    /**
     * Returns a string representation of this <code>FlowLayout</code>
     * object and its values.
     * @return     a string representation of this layout
     */
    public function toString():String{
		var str:String= "";
		switch (align) {
	 	 	case LEFT:        str = ",align=left";  
	 		case CENTER:      str = ",align=center"; 
	  		case RIGHT:       str = ",align=right";  
		}
		return "FlowLayout[hgap=" + hgap + ",vgap=" + vgap + str + "]";
    }
}