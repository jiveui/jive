/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing;


import org.aswing.event.PropertyChangeEvent;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.EmptyLayout;
import org.aswing.geom.IntDimension;
import org.aswing.Insets;
import org.aswing.geom.IntRectangle;

/**
 * A border layout lays out a container, arranging and resizing
 * its components to fit in five regions:
 * north, south, east, west, and center.
 * Each region may contain no more than one component, and 
 * is identified by a corresponding constant:
 * <code>NORTH</code>, <code>SOUTH</code>, <code>EAST</code>,
 * <code>WEST</code>, and <code>CENTER</code>.  When adding a
 * component to a container with a border layout, use one of these
 * five constants, for example:
 * <pre>
 *    var p: JPanel = new JPanel();
 *    p.setLayout(new BorderLayout());
 *    p.append(new JButton("Ok"), BorderLayout.SOUTH);
 * </pre>
 * For convenience, <code>BorderLayout</code> interprets the
 * absence of a string specification the same as the constant
 * <code>CENTER</code>:
 * <pre>
 *    var p2: JPanel = new JPanel();
 *    p2.setLayout(new BorderLayout());
 *    p2.append(new TextArea());  // Same as p.add(new TextArea(), BorderLayout.CENTER);
 * </pre>
 * 
 * The following image illustrate the way the borderLayout layout child component.
 *
 * <img src="../../BorderLayout.jpg" ></img>
 *
 * Authors paling, ngrebenshikov
 */

class BorderExtLayout extends EmptyLayout{
	public var hgap:Int;
	public var vgap:Int;

	private var north:Component;

	private var west:Component;

	private var east:Component;

    private var south:Component;

	private var center:Component;
    
    private var firstLine:Component;

	private var lastLine:Component;

	private var firstItem:Component;

	private var lastItem:Component;

	private var beyondNorth: Component;
	private var beyondWest: Component;
	private var beyondEast: Component;
	private var beyondSouth: Component;

	private var overlay: Component;
	private var centerOverlay: Component;
	
	private var defaultConstraints:String;

    /**
     * The north layout constraint (top of container).
     */
    inline public static var NORTH:String= "North";

    /**
     * The south layout constraint (bottom of container).
     */
    inline public static var SOUTH:String= "South";

    /**
     * The east layout constraint (right side of container).
     */
    inline public static var EAST :String= "East";

    /**
     * The west layout constraint (left side of container).
     */
    inline public static var WEST :String= "West";

    /**
     * The center layout constraint (middle of container).
     */
    inline public static var CENTER:String= "Center";

	
	inline public static var BEFORE_FIRST_LINE:String= "First";


    inline public static var AFTER_LAST_LINE:String= "Last";


    inline public static var BEFORE_LINE_BEGINS:String= "Before";


    inline public static var AFTER_LINE_ENDS:String= "After";


    inline public static var PAGE_START:String= BEFORE_FIRST_LINE;


    inline public static var PAGE_END:String= AFTER_LAST_LINE;


    inline public static var LINE_START:String= BEFORE_LINE_BEGINS;


    inline public static var LINE_END:String= AFTER_LINE_ENDS;

	/**
     * The beyond north layout constraint (beyond top border of container).
     */
	inline public static var BEYOND_NORTH:String= "Beyond North";

	/**
     * The beyond west layout constraint (beyond left border of container).
     */
	inline public static var BEYOND_WEST:String= "Beyond West";

	/**
     * The beyond east layout constraint (beyond right border of container).
     */
	inline public static var BEYOND_EAST:String= "Beyond East";

	/**
     * The beyond south layout constraint (beyond bottom border of container).
     */
	inline public static var BEYOND_SOUTH:String= "Beyond South";

	/**
     * The layout overlay constraint (middle of container).
     */
	inline public static var OVERLAY:String= "Overlay";

	/**
     * The center layout overlay constraint (middle of container).
     */
	inline public static var CENTER_OVERLAY:String= "Center Overlay";

    /**
     * Constructs a border layout with the specified gaps
     * between components.
     * The horizontal gap is specified by <code>hgap</code>
     * and the vertical gap is specified by <code>vgap</code>.
     * @param   hgap   the horizontal gap.
     * @param   vgap   the vertical gap.
     */
    public function new(hgap:Int= 0, vgap:Int= 0) {
		this.hgap = hgap;
		this.vgap = vgap;
		this.defaultConstraints = CENTER;
		super();
    }
	
	/**
	 * 
	 */
	public function setDefaultConstraints(constraints:Dynamic):Void{
		defaultConstraints = constraints.toString();
	}

    @:dox(hide)
	public function getHgap():Int{
		return hgap;
    }
	
	/**
	 * Set horizontal gap
	 */
	@:dox(hide)
    public function setHgap(hgap:Int):Void{
		this.hgap = hgap;
    }

    @:dox(hide)
	public function getVgap():Int{
		return vgap;
    }
	
	/**
	 *  Set vertical gap
	 */
	@:dox(hide)
    public function setVgap(vgap:Int):Void{
		this.vgap = vgap;
    }
	
	@:dox(hide)
    override public function addLayoutComponent(comp:Component, constraints:Dynamic):Void{
    	var name:String= constraints != null ? constraints.toString() : null;
	    addLayoutComponentByAlign(name, comp);
    }

    private function addLayoutComponentByAlign(name:String, comp:Component):Void{
		if (name == null) {
	   		name = defaultConstraints;
		}

		if (CENTER == name) {
		    center = comp;
		} else if (NORTH == name) {
		    north = comp;
		} else if (SOUTH == name) {
		    south = comp;
		} else if (EAST == name) {
		    east = comp;
		} else if (WEST == name) {
		    west = comp;
		} else if (BEFORE_FIRST_LINE == name) {
		    firstLine = comp;
		} else if (AFTER_LAST_LINE == name) {
		    lastLine = comp;
		} else if (BEFORE_LINE_BEGINS == name) {
		    firstItem = comp;
		} else if (AFTER_LINE_ENDS == name) {
		    lastItem = comp;
		} else if (BEYOND_NORTH == name) {
			beyondNorth = comp;
		} else if (BEYOND_SOUTH == name) {
			beyondSouth = comp;
		} else if (BEYOND_EAST == name) {
			beyondEast = comp;
		} else if (BEYOND_WEST == name) {
			beyondWest = comp;

//			beyondWest.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e) {
//				var event: PropertyChangeEvent = AsWingUtils.as(e, PropertyChangeEvent);
//				if (event.getPropertyName() == "x") {
//					if (event.getNewValue() >= 0) {
//						beyondWest.setEnabled(true);
//					} else {
//						beyondWest.setEnabled(false);
//					}
//				}
//			});
//
//			beyondWest.setEnabled(false);
		} else if (CENTER_OVERLAY == name) {
			centerOverlay = comp;
		} else if (OVERLAY == name) {
			overlay = comp;
		} else {
			//defaut center
		    center = comp;
		}
    }
    
	@:dox(hide)
    override public function removeLayoutComponent(comp:Component):Void{
		if (comp == center) {
		    center = null;
		} else if (comp == north) {
		    north = null;
		} else if (comp == south) {
		    south = null;
		} else if (comp == east) {
		    east = null;
		} else if (comp == west) {
		    west = null;
		} else if (comp == beyondNorth) {
			beyondNorth = null;
		} else if (comp == beyondSouth) {
			beyondSouth = null;
		} else if (comp == beyondEast) {
			beyondEast = null;
		} else if (comp == beyondWest) {
			beyondWest = null;
		} else if (comp == centerOverlay) {
			centerOverlay = null;
		} else if (comp == overlay) {
			overlay = null;
		}

		if (comp == firstLine) {
		    firstLine = null;
		} else if (comp == lastLine) {
		    lastLine = null;
		} else if (comp == firstItem) {
		    firstItem = null;
		} else if (comp == lastItem) {
		    lastItem = null;
		}
    }

	@:dox(hide)
    override public function minimumLayoutSize(target:Container):IntDimension {
		return target.getInsets().getOutsideSize();
    }
	
	@:dox(hide)
    override public function preferredLayoutSize(target:Container):IntDimension {
    	var dim:IntDimension = new IntDimension(0, 0);
	    var ltr:Bool= true;
	    var c:Component = null;
		
		var d:IntDimension;
		if ((c=getChild(EAST,ltr)) != null) {
		    d = c.getPreferredSize();
		    dim.width += d.width + hgap;
		    dim.height =Std.int( Math.max(d.height, dim.height));
		}
		if ((c=getChild(WEST,ltr)) != null) {
		    d = c.getPreferredSize();
		    dim.width += d.width + hgap;
		    dim.height = Std.int( Math.max(d.height, dim.height));
		}
		if ((c=getChild(CENTER,ltr)) != null) {
		    d = c.getPreferredSize();
		    dim.width += d.width;
		    dim.height = Std.int( Math.max(d.height, dim.height));
		}
		if ((c=getChild(NORTH,ltr)) != null) {
		    d = c.getPreferredSize();
		    dim.width = Std.int( Math.max(d.width, dim.width));
		    dim.height += d.height + vgap;
		}
		if ((c=getChild(SOUTH,ltr)) != null) {
		    d = c.getPreferredSize();
		    dim.width =Std.int(  Math.max(d.width, dim.width));
		    dim.height += d.height + vgap;
		}
//		if ((c=getChild(BEYOND_EAST,ltr)) != null) {
//			d = c.getPreferredSize();
//			dim.width += d.width + hgap;
//			dim.height =Std.int( Math.max(d.height, dim.height));
//		}
//		if ((c=getChild(BEYOND_WEST,ltr)) != null) {
//			d = c.getPreferredSize();
//			dim.width += d.width + hgap;
//			dim.height = Std.int( Math.max(d.height, dim.height));
//		}
//		if ((c=getChild(BEYOND_NORTH,ltr)) != null) {
//			d = c.getPreferredSize();
//			dim.width = Std.int( Math.max(d.width, dim.width));
//			dim.height += d.height + vgap;
//		}
//		if ((c=getChild(BEYOND_SOUTH,ltr)) != null) {
//			d = c.getPreferredSize();
//			dim.width =Std.int(  Math.max(d.width, dim.width));
//			dim.height += d.height + vgap;
//		}

		var insets:Insets = target.getInsets();
		dim.width += insets.left + insets.right;
		dim.height += insets.top + insets.bottom;
		return dim;
    }

	@:dox(hide)
    override public function getLayoutAlignmentX(target:Container):Float{
    	return 0.5;
    }
	
	@:dox(hide)
    override public function getLayoutAlignmentY(target:Container):Float{
    	return 0.5;
    }

    /**
     * <p>
     * Lays out the container argument using this border layout.
     * </p>
     * <p>
     * This method actually reshapes the components in the specified
     * container in order to satisfy the constraints of this
     * <code>BorderLayout</code> object. The <code>NORTH</code>
     * and <code>SOUTH</code> components, if any, are placed at
     * the top and bottom of the container, respectively. The
     * <code>WEST</code> and <code>EAST</code> components are
     * then placed on the left and right, respectively. Finally,
     * the <code>CENTER</code> object is placed in any remaining
     * space in the middle.
     * </p>
     * <p>
     * Most applications do not call this method directly. This method
     * is called when a container calls its <code>doLayout</code> method.
     * </p>
     * @param   target   the container in which to do the layout.
     * @see     Container
     * @see     Container#doLayout()
     */
	@:dox(hide)
    override public function layoutContainer(target:Container):Void{
    	var td:IntDimension = target.getSize();
		var insets:Insets = target.getInsets();
		var top:Int= insets.top;
		var bottom:Int= td.height - insets.bottom;
		var left:Int= insets.left;
		var right:Int= td.width - insets.right;
	    var ltr:Bool= true;
	    var c:Component = null;
	
		var d:IntDimension;
		if ((c=getChild(BEYOND_NORTH,ltr)) != null) {
			d = c.getPreferredSize();
			c.setBounds(new IntRectangle(left, top - d.height, right - left, d.height));
//			top += d.height + vgap;
		}
		if ((c=getChild(BEYOND_SOUTH,ltr)) != null) {
			d = c.getPreferredSize();
			c.setBounds(new IntRectangle(left, bottom, right - left, d.height));
//			bottom -= d.height + vgap;
		}
		if ((c=getChild(BEYOND_EAST,ltr)) != null) {
			d = c.getPreferredSize();
			var x = Std.int(c.x);
			c.setBounds(new IntRectangle(x, top, d.width, bottom - top));
//			right -= d.width + hgap;
		}
		if ((c=getChild(BEYOND_WEST,ltr)) != null) {
			d = c.getPreferredSize();
//			if (x < 0) beyondWest.enabled = false else beyondWest.enabled = true;
			var x = Std.int(c.x); //left - d.width;
//			if (c.isEnabled()) x = Std.int(c.x) else x = left - d.width;
			c.setBounds(new IntRectangle(x, top, d.width, bottom - top));
//			left += d.width + hgap;
		}

		if ((c=getChild(NORTH,ltr)) != null) {
		    d = c.getPreferredSize();
		    c.setBounds(new IntRectangle(left, top, right - left, d.height));
		    top += d.height + vgap;
		}
		if ((c=getChild(SOUTH,ltr)) != null) {
		    d = c.getPreferredSize();
		    c.setBounds(new IntRectangle(left, bottom - d.height, right - left, d.height));
		    bottom -= d.height + vgap;
		}
		if ((c=getChild(EAST,ltr)) != null) {
		    d = c.getPreferredSize();
		    c.setBounds(new IntRectangle(right - d.width, top, d.width, bottom - top));
		    right -= d.width + hgap;
		    //Flashout.log("East prefer size : " + d);
		}
		if ((c=getChild(WEST,ltr)) != null) {
		    d = c.getPreferredSize();
		    c.setBounds(new IntRectangle(left, top, d.width, bottom - top));
		    left += d.width + hgap;
		}
		if ((c=getChild(CENTER,ltr)) != null) {
			d = c.getPreferredSize();
		    c.setBounds(new IntRectangle(Std.int(c.x), top, right - left, bottom - top));
		}
		if ((c=getChild(CENTER_OVERLAY,ltr)) != null) {
			c.setBounds(new IntRectangle(Std.int(c.x), top, right - left, bottom - top));
//			d = c.getPreferredSize();
//			c.setBounds(new IntRectangle(Std.int(c.x), Std.int(c.y), d.width, d.height));
		}
		if ((c=getChild(OVERLAY,ltr)) != null) {
//			c.setBounds(new IntRectangle(left, top, right - left, bottom - top));
			d = c.getPreferredSize();
			c.setBounds(new IntRectangle(Std.int(c.x), Std.int(c.y), d.width, d.height));
		}
    }

    /**
     * Get the component that corresponds to the given constraint location
     *
     * @param   key     The desired absolute position,
     *                  either NORTH, SOUTH, EAST, or WEST.
     * @param   ltr     Is the component line direction left-to-right?
     */
    private function getChild(key:String, ltr:Bool):Component {
        var result:Component = null;

        if (key == NORTH) {
            result = (firstLine != null) ? firstLine : north;
        }
        else if (key == SOUTH) {
            result = (lastLine != null) ? lastLine : south;
        }
        else if (key == WEST) {
            result = ltr ? firstItem : lastItem;
            if (result == null) {
                result = west;
            }
        }
        else if (key == EAST) {
            result = ltr ? lastItem : firstItem;
            if (result == null) {
                result = east;
            }
        }
		else if (key == BEYOND_NORTH) {
			result = beyondNorth;
		}
		else if (key == BEYOND_WEST) {
			result = beyondWest;
		}
		else if (key == BEYOND_EAST) {
			result = beyondEast;
		}
		else if (key == BEYOND_SOUTH) {
			result = beyondSouth;
		}
		else if (key == CENTER_OVERLAY) {
			result = centerOverlay;
		}
		else if (key == OVERLAY) {
			result = overlay;
		}
        else if (key == CENTER) {
            result = center;
        }
        if (result != null && !result.isVisible()) {
            result = null;
        }
        return result;
    }

    public function toString():String{
		return "BorderLayout[hgap=" + hgap + ",vgap=" + vgap + "]";
    }
}