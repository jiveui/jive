package org.aswing;


import org.aswing.BorderLayout;
import org.aswing.Container;
import org.aswing.FrameTitleBar;
import org.aswing.JLabel;
import org.aswing.UIManager;
import org.aswing.geom.IntDimension;
import org.aswing.plaf.ComponentUI;

class FrameTitleBarLayout extends BorderLayout{
	
	private var minSize:IntDimension;
	
	public function new(minWidth:Int=50, height:Int=20){
		super();
		minSize = new IntDimension(minWidth, height);
	}
	
	private function countMinSize(target:Container):Void{
		var bar:FrameTitleBar =AsWingUtils.as( target,FrameTitleBar );
		minSize.height = bar.getMinimizeHeight();
	}
	
    override public function minimumLayoutSize(target:Container):IntDimension {
    	countMinSize(target);
		return preferredLayoutSize(target);
    }
	
	/**
	 * 
	 */
    override public function preferredLayoutSize(target:Container):IntDimension {
    	countMinSize(target);
    	var size:IntDimension = super.preferredLayoutSize(target);
		var bar:FrameTitleBar = AsWingUtils.as( target,FrameTitleBar );
    	var label:JLabel = bar.getLabel();
    	if(label!=null && label.isVisible()){
    		size.width -= Std.int(Math.max(0, label.getPreferredWidth()-60));
    	}
    	size.width = Std.int(Math.max(minSize.width, size.width));
    	size.height = Std.int(Math.max(minSize.height, size.height));
    	return size;
    }	
}