package org.aswing.util;

 
	
/**
 * WeakReference, the value will be weak referenced.
 * @author paling
 */
class WeakReference{
	
	private var weakDic:Dynamic;
	
	public function new(){
 
	}
	
	public function set_value(v:Dynamic):Dynamic{
		if(v == null){
			weakDic = null;
		}else{
			weakDic = v; 
		}
	
			return v;
		}
	
	public function get_value():Dynamic{
		if (weakDic != null)	{
		 
		 
				return weakDic;
			 
		}
		return null;
	}
	
	/**
	 * Clear the value, same to <code>WeakReference.value=null;</code>
	 */
	public function clear():Void{
		weakDic = null;
	}

		public var value (get, set):Dynamic;
}