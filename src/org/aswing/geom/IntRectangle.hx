/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.geom;
	import org.aswing.geom.IntPoint;
import flash.geom.Rectangle;

/**
 * A Rectangle specifies an area in a coordinate space that is enclosed by the Rectangle 
 * object's top-left point (x, y) in the coordinate space, its width, and its height.
 */
class IntRectangle
{
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	
	/**
	 * Creates a rectangle.
	 */
	public function new(?x:Int=0, ?y:Int=0, ?width:Int=0, ?height:Int=0){
	this.x=0;
	this.y=0;
	this.width=0;
	this.height=0;
	setRectXYWH(x, y, width, height);
	}
	

	/**
	 * Return a Point instance with same value.
	 */
	public function toRectangle():Rectangle{
		return new Rectangle(x, y, width, height);
	}
	
	/**
	 * Sets the location with a <code>Point</code>, the value will be transfer to int.
	 * @param p the location to be set.
	 */
	public function setWithRectangle(r:Rectangle):Void{
		x = Std.int(r.x);
		y = Std.int(r.y);
		width = Std.int(r.width);
		height = Std.int(r.height);
	}
	
	/**
	 * Create a int point with point.
	 */
	public static function creatWithRectangle(r:Rectangle):IntRectangle{
		return new IntRectangle(Std.int(r.x), Std.int(r.y), Std.int(r.width), Std.int(r.height));
	}
	
	/**
	 * Sets the rectangle to be as same as rect.
	 */
	public function setRect(rect:IntRectangle):Void{
		setRectXYWH(rect.x, rect.y, rect.width, rect.height);
	}
	
	/**
	 * Sets the rect with x, y, width and height.
	 */
	public function setRectXYWH(x:Int, y:Int, width:Int, height:Int):Void{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}
	
	/**
	 * Sets the x, y property of the rectangle.
	 */
	public function setLocation(p:IntPoint):Void{
		this.x = p.x;
		this.y = p.y;
	}
	
	/**
	 * Sets the width and height properties of the rectangle
	 */
	public function setSize(size:IntDimension):Void{
		this.width = size.width;
		this.height = size.height;
	}
	
	
	/**
	 * Returns the size of this rectangle.
	 */
	public function getSize():IntDimension{
		return new IntDimension(width, height);
	}
	
	/**
	 * Returns the location of this rectangle.
	 */
	public function getLocation():IntPoint{
		return new IntPoint(x, y);
	}
	
    /**
     * Computes the union of this <code>Rectangle</code> with the 
     * specified <code>Rectangle</code>. Returns a new 
     * <code>Rectangle</code> that 
     * represents the union of the two rectangles
     * @param r the specified <code>Rectangle</code>
     * @return    the smallest <code>Rectangle</code> containing both 
     *		  the specified <code>Rectangle</code> and this 
     *		  <code>Rectangle</code>.
     */
    public function union(r:IntRectangle):IntRectangle{
		var x1:Int= Std.int(Math.min(x, r.x));
		var x2:Int= Std.int(Math.max(x + width, r.x + r.width));
		var y1:Int= Std.int(Math.min(y, r.y));
		var y2:Int= Std.int(Math.max(y + height, r.y + r.height));
		return new IntRectangle(x1, y1, x2 - x1, y2 - y1);
    }
    
    /**
     * Resizes the <code>Rectangle</code> both horizontally and vertically.
     * <br><br>
     * This method modifies the <code>Rectangle</code> so that it is 
     * <code>h</code> units larger on both the left and right side, 
     * and <code>v</code> units larger at both the top and bottom. 
     * <br><br>
     * The new <code>Rectangle</code> has (<code>x&nbsp;-&nbsp;h</code>, 
     * <code>y&nbsp;-&nbsp;v</code>) as its top-left corner, a 
     * width of 
     * <code>width</code>&nbsp;<code>+</code>&nbsp;<code>2h</code>, 
     * and a height of 
     * <code>height</code>&nbsp;<code>+</code>&nbsp;<code>2v</code>. 
     * <br><br>
     * If negative values are supplied for <code>h</code> and 
     * <code>v</code>, the size of the <code>Rectangle</code> 
     * decreases accordingly. 
     * The <code>grow</code> method does not check whether the resulting 
     * values of <code>width</code> and <code>height</code> are 
     * non-negative. 
     * @param h the horizontal expansion
     * @param v the vertical expansion
     */
    public function grow(h:Int, v:Int):Void{
		x -= h;
		y -= v;
		width += h * 2;
		height += v * 2;
    }
    
    public function move(dx:Int, dy:Int):Void{
    	x += dx;
    	y += dy;
    }

    public function resize(dwidth:Int=0, dheight:Int=0):Void{
    	width += dwidth;
    	height += dheight;
    }
	
	public function leftTop():IntPoint{
		return new IntPoint(x, y);
	}
	
	public function rightTop():IntPoint{
		return new IntPoint(x + width, y);
	}
	
	public function leftBottom():IntPoint{
		return new IntPoint(x, y + height);
	}
	
	public function rightBottom():IntPoint{
		return new IntPoint(x + width, y + height);
	}
	
	public function containsPoint(p:IntPoint):Bool{
		if(p.x < x || p.y < y || p.x > x+width || p.y > y+height){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 *
	 */
	public function equals(o:Dynamic):Bool{
		var r:IntRectangle = AsWingUtils.as(o,IntRectangle)	;
		if(r == null) return false;
		return x==r.x && y==r.y && width==r.width && height==r.height;
	}
		
	/**
	 * Duplicates current instance.
	 * @return copy of the current instance.
	 */
	public function clone():IntRectangle {
		return new IntRectangle(x, y, width, height);
	}
		
	public function toString():String{
		return "IntRectangle[x:"+x+",y:"+y+", width:"+width+",height:"+height+"]";
	}
	
}