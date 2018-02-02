package org.aswing.plaf;


import org.aswing.Component;	

class DefaultsDecoratorBase implements DefaultsDecorator{
	
	private var defaultsOwner:ComponentUI;
	
	public function new(){
		
	}
	
	public function setDefaultsOwner(owner:ComponentUI):Void{
		defaultsOwner = owner;
	}
	
	public function getDefaultsOwner(c:Component):ComponentUI{
		if(defaultsOwner!=null)	{
			return defaultsOwner;
		}else{
			return c.getUI();
		}
	}
}