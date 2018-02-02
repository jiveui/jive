/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * A FocusTraversalPolicy that determines traversal order based on the order
 * of child Components in a Container.
 * 
 * @author paling 
 */
class ContainerOrderFocusTraversalPolicy implements FocusTraversalPolicy{
		
	public function new(){
	}
	
	public function getComponentAfter(c:Component):Component
	{
		return getComponentAfterImp(c, true);
	}
	
	private function getComponentAfterImp(c:Component, deepIn:Bool=true):Component{
		if(c == null){
			return null;
		}
		if((Std.is(c,Container)) && deepIn){
			var fc:Component = getFirstComponent(AsWingUtils.as(c,Container)	);
			if(fc != null){
				return fc;
			}
		}
		var container:Container = c.getParent();
		if(container == null){
			return getFirstComponent(AsWingUtils.as(c,Container)	);
		}
		var index:Int= container.getIndex(c);
		var n:Int= container.getComponentCount();
		if(index >= 0){
			while((++index) < n){
				var nc:Component = getFocusableComponent(container.getComponent(index));
				if(nc != null){
					return nc;
				}
			}
		}
		//up circle
		return getComponentAfterImp(container, false);
	}
	
	public function getComponentBefore(c:Component):Component
	{
		return getComponentBeforeImp(c);
	}
	
	private function getComponentBeforeImp(c:Component):Component{
		if(c == null){
			return null;
		}
		var container:Container = c.getParent();
		if(container == null){
			return getLastComponent(AsWingUtils.as(c,Container)	);
		}
		var index:Int= container.getIndex(c);
		while((--index) >= 0){
			var nc:Component = getLastComponent(container.getComponent(index));
			if(nc != null){
				return nc;
			}
		}
		if(accept(container)){
			return container;
		}
		//up circle
		return getComponentBeforeImp(container);
	}
	
	/**
	 * This will return the first focusable component in the container.
	 * @return the default component to be focused.
	 */
	public function getDefaultComponent(container:Container):Component
	{
		return getFirstComponent(container);
	}
	
	/**
	 * Returns the first focusable component in the container.
	 */
	private function getFirstComponent(container:Container):Component{
		if(container == null){
			return null;
		}
		var index:Int= -1;
		var n:Int= container.getComponentCount();
		while((++index) < n){
			var nc:Component = getFocusableComponent(container.getComponent(index));
			if(nc != null){
				return nc;
			}
		}
		//do not up cirle here
		return null;
	}
	
	/**
	 * Returns the last focusable component in the component, if it is a container 
	 * deep into it to find the last.
	 */
	private function getLastComponent(c:Component):Component{
		var container:Container = AsWingUtils.as(c,Container)	;
		if(container == null){
			if(accept(c)){
				return c;
			}else{
				return null;
			}
		}
		var index:Int= container.getComponentCount();
		while((--index) >= 0){
			var theC:Component = container.getComponent(index);
			if(isLeaf(theC)){
				if(accept(theC)){
					return theC;
				}
			}
			var nc:Component = getLastComponent(AsWingUtils.as(theC,Container)	);
			if(nc != null){
				return nc;
			}
		}
		if(accept(container)){
			return container;
		}
		//do not up cirle here
		return null;
	}
	
	private function isLeaf(c:Component):Bool{
		if(Std.is(c,Container)){
			var con:Container = AsWingUtils.as(c,Container)	;
			return con.getComponentCount() == 0;
		}
		return true;
	}
	
	private function accept(c:Component):Bool{
		return c != null && c.isShowing() && c.isFocusable() && c.isEnabled();
	}
	
	private function getFocusableComponent(c:Component):Component{
		if(c.isShowing() && c.isEnabled()){
			if(c.isFocusable()){
				return c;
			}else if(Std.is(c,Container)){//down circle
				var con:Container = AsWingUtils.as(c,Container)	;
				var conDefault:Component = con.getFocusTraversalPolicy().getDefaultComponent(con);
				if(conDefault != null){
					return conDefault;
				}
			}
		}
		return null;
	}
	
}