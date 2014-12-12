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

/**
 * EmptyBorder not draw any graphics, only use to hold a blank space around component (margin, insets).
 *
 * Author: paling
 */
class EmptyBorder extends DecorateBorder{
	
	private var margin:Insets;
	
	public function new(interior:Border=null, margin:Insets=null){
		super(interior);
		if(margin == null){
			this.margin = new Insets();
		}else{
			this.margin = margin.clone();
		}
	}

	/**
	* A top margin, px
	**/
	public var top(get,set): Int;
	private function get_top(): Int { return getTop(); }
	private function set_top(v: Int): Int { setTop(v); return v; }

	/**
	* A left margin, px
	**/
	public var left(get,set): Int;
	private function get_left(): Int { return getLeft(); }
	private function set_left(v: Int): Int { setLeft(v); return v; }

	/**
	* A bottom margin, px
	**/
	public var bottom(get,set): Int;
	private function get_bottom(): Int { return getBottom(); }
	private function set_bottom(v: Int): Int { setBottom(v); return v; }

	/**
	* A right margin, px
	**/
	public var right(get,set): Int;
	private function get_right(): Int { return getRight(); }
	private function set_right(v: Int): Int { setRight(v); return v; }

	@:dox(hide)
	public function setTop(v:Int):Void{
		margin.top = v;
	}

	@:dox(hide)
	public function setLeft(v:Int):Void{
		margin.left = v;
	}

	@:dox(hide)
	public function setBottom(v:Int):Void{
		margin.bottom = v;
	}

	@:dox(hide)
	public function setRight(v:Int):Void{
		margin.right = v;
	}

	@:dox(hide)
	public function getTop():Int{
		return margin.top;
	}

	@:dox(hide)
	public function getLeft():Int{
		return margin.left;
	}

	@:dox(hide)
	public function getBottom():Int{
		return margin.bottom;
	}

	@:dox(hide)
	public function getRight():Int{
		return margin.right;
	}
	/**
	* Create an indent with the same top, left, bottom and right margins
	**/
	public static function createIndent(indent:Int):EmptyBorder{
		return new EmptyBorder(null, new Insets(indent, indent, indent, indent));
	}
	
	@:dox(hide)
	override public function updateBorderImp(com:Component, g:Graphics2D, bounds:IntRectangle):Void {
	}

	@:dox(hide)
    override public function getBorderInsetsImp(c:Component, bounds:IntRectangle):Insets{
    	return margin.clone();
    }
	
}