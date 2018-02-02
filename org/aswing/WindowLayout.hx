/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.error.Error;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;

/**
 * Layout for `JWindow` and `JFrame`.
 *
 * Author paling
 */
class WindowLayout extends EmptyLayout {
	/**
	* A title bar that is set in the `JWindow` via `window.append(comp, WindowLayout.TITLE);` (readonly)
	**/
	public var titleBar(default, null):Component;

	/**
	* A content pane that is set in the `JWindow` via `window.append(comp, WindowLayout.TITLE);` (readonly)
	**/
	public var contentPane(default, null):Component;

    /**
     * The title bar layout constraint.
     */
    inline public static var TITLE:String= "Title";

    /**
     * The content pane layout constraint.
     */
    inline public static var CONTENT:String= "Content";
    
	public function new() {
		super();
	}
	
	/**
	 * @param comp the child to add to the layout
	 * @param constraints the constraints indicate what position the child will be added.
	 *
	 * It throws `ArgumentError` when the constraints is not `TITLE` either `CONTENT`.
	 */
    override public function addLayoutComponent(comp:Component, constraints:Dynamic):Void{
	    if(constraints == TITLE){
	    	titleBar = comp;
	    }else if(constraints == CONTENT){
	    	contentPane = comp;
	    }else{
	    	throw new Error("ERROR When add component to JWindow/JFrame, constraints must be TITLE or CONTENT : " + constraints);
	    }
    }

	@:dox(hide)
    public function getTitleBar():Component{
    	return titleBar;
    }

	@:dox(hide)
    public function getContentPane():Component{
    	return contentPane;
    }

	@:dox(hide)
    override public function removeLayoutComponent(comp:Component):Void{
     	if(comp == titleBar){
     		titleBar = null;
     	}else if(comp == contentPane){
     		contentPane = null;
     	}
     }

	@:dox(hide)
	override public function minimumLayoutSize(target:Container):IntDimension {
		var insets:Insets = target.getInsets();
		var size:IntDimension = insets.getOutsideSize();
		if(titleBar != null){
			size.increaseSize(titleBar.getMinimumSize());
		}
		return size;
	}

	@:dox(hide)
	override public function preferredLayoutSize(target:Container):IntDimension {
		var insets:Insets = target.getInsets();
		var size:IntDimension = insets.getOutsideSize();
		var titleBarSize:IntDimension, contentSize:IntDimension;
		if(titleBar != null){
			titleBarSize = titleBar.getPreferredSize();
		}else{
			titleBarSize = new IntDimension(0, 0);
		}
		if(contentPane != null){
			contentSize = contentPane.getPreferredSize();
		}else{
			contentSize = new IntDimension(0, 0);
		}
		size.increaseSize(new IntDimension(Std.int(Math.max(titleBarSize.width, contentSize.width)), Std.int(titleBarSize.height + contentSize.height)));
		return size;
	}
	
	@:dox(hide)
	override public function layoutContainer(target:Container):Void{
    	var td:IntDimension = target.getSize();
		var insets:Insets = target.getInsets();
		var r:IntRectangle = insets.getInsideBounds(td.getBounds());
		
		var d:IntDimension;
		if(titleBar != null){
			d = titleBar.getPreferredSize();
			titleBar.setBounds(new IntRectangle(r.x, r.y, r.width, d.height));
			r.y += d.height;
			r.height -= d.height;
		}
		if(contentPane != null){
			contentPane.setBounds(new IntRectangle(r.x, r.y, r.width, r.height));
		}
	}
	
    public function toString():String{
		return "WindowLayout[]";
    }
}