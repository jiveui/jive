/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	/**
 * An Insets object is a representation of the borders of a container. 
 * It specifies the space that a container must leave at each of its edges. 
 * The space can be a border, a blank space, or a title. 
 * 
 * @author paling
 */
class Insets{
	
	/**
	 * Creates new <code>Insets</code> instance with identic edges.
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
	 * This insets add specified insets and return itself.
	 */
	public function addInsets(insets:Insets):Insets{
		this.top += insets.top;
		this.left += insets.left;
		this.bottom += insets.bottom;
		this.right += insets.right;
		return this;
	}
	
	public function getMarginWidth():Int{
		return left + right;
	}
	
	public function getMarginHeight():Int{
		return top + bottom;
	}
	
	public function getInsideBounds(bounds:IntRectangle):IntRectangle{
		var r:IntRectangle = bounds.clone();
		r.x += left;
		r.y += top;
		r.width -= (left + right);
		r.height -= (top + bottom);
		return r;
	}
	
	public function getOutsideBounds(bounds:IntRectangle):IntRectangle{
		var r:IntRectangle = bounds.clone();
		r.x -= left;
		r.y -= top;
		r.width += (left + right);
		r.height += (top + bottom);
		return r;
	}
	
	public function getOutsideSize(size:IntDimension=null):IntDimension{
		if(size == null) size = new IntDimension();
		var s:IntDimension = size.clone();
		s.width += (left + right);
		s.height += (top + bottom);
		return s;
	}
	
	public function getInsideSize(size:IntDimension=null):IntDimension{
		if(size == null) size = new IntDimension();
		var s:IntDimension = size.clone();
		s.width -= (left + right);
		s.height -= (top + bottom);
		return s;
	}
	
	public function equals(o:Dynamic):Bool{
		var i:Insets = AsWingUtils.as(o,Insets)	;
		if(i == null){
			return false;
		}else{
			return i.bottom == bottom && i.left == left && i.right == right && i.top == top;
		}
	}
	
	public function clone():Insets{
		return new Insets(top, left, bottom, right);
	}
	
	public function toString():String{
		return "Insets(top:"+top+", left:"+left+", bottom:"+bottom+", right:"+right+")";
	}
}