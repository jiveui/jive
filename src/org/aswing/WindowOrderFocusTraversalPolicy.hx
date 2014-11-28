/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * The focus traversal policy for windows, the only different from 
 * <code>ContainerOrderFocusTraversalPolicy</code> is that it choose the first 
 * content pane component to be the default component.
 */
class WindowOrderFocusTraversalPolicy extends ContainerOrderFocusTraversalPolicy{
	
	public function new(){
		super();
	}
	
	/**
	 * This will return the first focusable component in the container.
	 * @return the default component to be focused.
	 */
	override public function getDefaultComponent(container:Container):Component{
		if(Std.is(container,JWindow)){
			var window:JWindow = AsWingUtils.as(container,JWindow)	;
			var content:Container = window.getContentPane();
			if(content.isShowing() && content.isVisible() && content.isFocusable()){
				return content;
			}
			var dc:Component = getFirstComponent(content);
			if(dc == null){
				return super.getDefaultComponent(container);
			}else{
				return dc;
			}
		}else{
			return super.getDefaultComponent(container);
		}
	}
}