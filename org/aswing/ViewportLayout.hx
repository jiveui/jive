/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	/**
 * The default layout manager for <code>JViewport</code>. 
 * <code>ViewportLayout</code> defines
 * a policy for layout that should be useful for most applications.
 * The viewport makes its view the same size as the viewport,
 * however it will not make the view smaller than its minimum size.
 * As the viewport grows the view is kept bottom justified until
 * the entire view is visible, subsequently the view is kept top
 * justified.
 * 
 * @author paling
 */
class ViewportLayout extends EmptyLayout{

    /**
     * Returns the preferred dimensions for this layout given the components
     * in the specified target container.
     * @param parent the component which needs to be laid out
     * @return a <code>Dimension</code> object containing the
     *		preferred dimensions
     * @see #minimumLayoutSize
     */
    override public function preferredLayoutSize(parent:Container):IntDimension {
		var vp:JViewport = AsWingUtils.as(parent,JViewport);
		var viewPreferSize:IntDimension = null;
		if(vp.getView() != null){
			viewPreferSize = vp.getView().getPreferredSize();
		}else{
			viewPreferSize = new IntDimension(0, 0);
		}
		return vp.getViewportPane().getInsets().getOutsideSize(viewPreferSize);
    }

    /**
     * Called by the AWT when the specified container needs to be laid out.
     *
     * @param parent  the container to lay out
     */
	override public function layoutContainer(parent:Container):Void{
		var vp:JViewport = AsWingUtils.as(parent,JViewport)	;
		if(vp == null){
			return;
		}
		var view:Component = vp.getView();
		if (view == null) {
		    return;
		}
	
		/* All of the dimensions below are in view coordinates, except
		 * vpSize which we're converting.
		 */
	
		//var insets:Insets = vp.getInsets();
		//var viewPrefSize:IntDimension = view.getPreferredSize();
		//var vpSize:IntDimension = vp.getSize();
		var extentSize:IntDimension = vp.getExtentSize();
		//var showBounds:IntRectangle = new IntRectangle(insets.left, insets.top, extentSize.width, extentSize.height);

		var viewSize:IntDimension = vp.getViewSize();
	
		var viewPosition:IntPoint = vp.getViewPosition();
		viewPosition.x = Math.round(viewPosition.x);
		viewPosition.y = Math.round(viewPosition.y);
	
		/* justify
		 * the view when the width of the view is smaller than the
		 * container.
		 */
	    if((viewPosition.x + extentSize.width) > viewSize.width){
			viewPosition.x = Std.int(Math.max(0, viewSize.width - extentSize.width));
	    }
	
		/* If the new viewport size would leave empty space below the
		 * view, bottom justify the view or top justify the view when
		 * the height of the view is smaller than the container.
		 */
		if ((viewPosition.y + extentSize.height) > viewSize.height) {
		    viewPosition.y = Std.int(Math.max(0, viewSize.height - extentSize.height));
		}
	
		vp.setViewPosition(viewPosition);
		view.setSize(viewSize);
		//trace("set View Pos : " + viewPosition);
		//trace("set View Size : " + viewSize);
    }
	
}