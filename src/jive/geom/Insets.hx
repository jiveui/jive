/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.geom;

import jive.geom.IntRectangle;
import jive.geom.IntDimension;

using jive.tools.TypeTools;

/**
*
* An Insets object is a representation of the borders of a container.
*
* It specifies the space that a container must leave at each of its edges.
* The space can be a border, a blank space, or a title.
*
* Author paling
*/
class Insets{
	
	/**
	 * Creates new `Insets` instance with identic edges.
	 * 
	 * @param edge the edge value for insets.
	 * @return new insets instance.
	 */
	public static function createIdentic(edge:Int):Insets {
		return new Insets(edge, edge, edge, edge);	
	}
	
	public var bottom:Int;
	public var top:Int;
	public var left:Int;
	public var right:Int;
	
	/**
	 * Creats an insets.
	 */
	public function new(top:Int=0, left:Int=0, bottom:Int=0, right:Int=0){
		this.bottom=0;
		this.top=0;
		this.left=0;
		this.right=0;
			this.top = top;
		this.left = left;
		this.bottom = bottom;
		this.right = right;
	}
	
	/**
	 * Add specified insets and return `this`.
	 */
	public function addInsets(insets:Insets):Insets{
		this.top += insets.top;
		this.left += insets.left;
		this.bottom += insets.bottom;
		this.right += insets.right;
		return this;
	}

	/**
	* @return `left + right`
	**/
	public function getMarginWidth():Int{
		return left + right;
	}

	/**
	* @return `top + bottom`
	**/
	public function getMarginHeight():Int{
		return top + bottom;
	}

	/**
	* Apply insets to the bounds and return inner bounds.
	**/
	public function getInsideBounds(bounds:IntRectangle):IntRectangle{
		var r:IntRectangle = if (null != bounds) bounds.clone() else new IntRectangle();
		r.x += left;
		r.y += top;
		r.width -= (left + right);
		r.height -= (top + bottom);
		return r;
	}

	/**
	* Apply insets to the bounds and return outer bounds.
	**/
	public function getOutsideBounds(bounds:IntRectangle):IntRectangle{
		var r:IntRectangle = bounds.clone();
		r.x -= left;
		r.y -= top;
		r.width += (left + right);
		r.height += (top + bottom);
		return r;
	}

	/**
	* Return the size after insets addition.
	**/
	public function getOutsideSize(size:IntDimension=null):IntDimension{
		if(size == null) size = new IntDimension();
		var s:IntDimension = size.clone();
		s.width += (left + right);
		s.height += (top + bottom);
		return s;
	}

	/**
	* Return the size after insets substraction.
	**/
	public function getInsideSize(size:IntDimension=null):IntDimension{
		if(size == null) size = new IntDimension();
		var s:IntDimension = size.clone();
		s.width -= (left + right);
		s.height -= (top + bottom);
		return s;
	}
	
	public function equals(o:Dynamic):Bool {
		var i:Insets = o.as(Insets);
		if(i == null){
			return false;
		}else{
			return i.bottom == bottom && i.left == left && i.right == right && i.top == top;
		}
	}
	
	public function clone():Insets {
		return new Insets(top, left, bottom, right);
	}
	
	public function toString():String{
		return "Insets(top:"+top+", left:"+left+", bottom:"+bottom+", right:"+right+")";
	}
}