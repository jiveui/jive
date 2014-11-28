package org.aswing.util;
 
  
class WeakMap <K, T> {
	/** @private */ private var hashKeys: haxe.ds.IntMap<K>;
	/** @private */ private var hashValues: haxe.ds.IntMap<T>;

	/** @private */ private static var nextObjectID:Int = 0;
	
	private var length:Int;
	public function new () {
		
		hashKeys = new haxe.ds.IntMap<K> ();
		hashValues = new haxe.ds.IntMap<T> ();
		length = 0;
		
	}
	
	
	public inline function exists (key:K):Bool {
		return hashValues.exists (getID (key));
	}
	
	
	public inline function get (key:K):T {
		return hashValues.get (getID (key));
	}
	
	
	/** @private */ private inline function getID (key:K):Int {
		
		#if cpp
		
		return untyped __global__.__hxcpp_obj_id (key);
		
		#else
		
		if (untyped key.___id___ == null) {
			
			untyped key.___id___ = nextObjectID ++;
			
			if (nextObjectID == #if neko 0x3fffffff #else 0x7fffffff #end) {
				
				nextObjectID = 0;
				
			}
			
		}
		
		return untyped key.___id___;
		#end
		
	}
	
	
	public inline function iterator ():Iterator <T> {
		return hashValues.iterator ();
	}
	
	
	public inline function keys ():Iterator <K> {
		return hashKeys.iterator ();
	}
	
	
	public inline function remove (key:K):Void {
		var id = getID (key);
		
		hashKeys.remove (id);
		hashValues.remove (id);
	}
	
	
	public inline function set (key:K, value:T):Void {
		var id = getID (key);
		
		hashKeys.set (id, key);
		hashValues.set (id, value);
	}
	
	
	 
 	//-------------------public methods--------------------

 	/**
  	 * Returns the number of keys in this HashMap.
  	 */
 	public function size():Int{
  		return length;
 	}

 	/**
  	 * Returns if this HashMap maps no keys to values.
  	 */
 	public function isEmpty():Bool{
  		return (length==0);
 	}

 
 	
 	/**
 	 * Call func(key) for each key.
 	 * @param func the function to call
 	 */
 	public function eachKey(func:Dynamic -> Void):Void {
	 
  		for(i in keys()){
  			func(i);
  		}
 	}
 	
 	/**
 	 * Call func(value) for each value.
 	 * @param func the function to call
 	 */ 	
 	public function eachValue(func:Dynamic -> Void):Void{ 
  		for(i in iterator()){
  			func(i);
  		}
 	}
  
 	/**
  	 * Tests if some key maps into the specified value in this HashMap.
  	 * This operation is more expensive than the containsKey method.
  	 */
 	public function containsValue(value:T):Bool{
  		var itr:Iterator<T> =  iterator();	
  		for(i in itr){
   			if(i == value){
    			return true;
   			}
  		}
 		return false;
 	}

 	/**
  	 * Tests if the specified object is a key in this HashMap.
  	 * This operation is very fast if it is a string.
     * @param   key   The key whose presence in this map is to be tested
     * @return <tt>true</tt> if this map contains a mapping for the specified
  	 */
 	public function containsKey(key:Dynamic ):Bool {
 
  		return exists(key);
 	}
	
 	 
 	
 	/**
 	 * Same functionity method with different name to <code>get</code>.
 	 * 
     * @param   key the key whose associated value is to be returned.
     * @return  the value to which this map maps the specified key, or
     *          <tt>null</tt> if the map contains no mapping for this key
     *           or it is null value originally.
 	 */
 	public function getValue(key:Dynamic):Dynamic{
 		return get(key);
 	}

 	/**
 	 * Associates the specified value with the specified key in this map. 
 	 * If the map previously contained a mapping for this key, the old value is replaced. 
 	 * If value is null, means remove the key from the map.
     * @param key key with which the specified value is to be associated.
     * @param value value to be associated with the specified key. null to remove the key.
     * @return previous value associated with specified key, or <tt>null</tt>
     *	       if there was no mapping for key.  A <tt>null</tt> return can
     *	       also indicate that the HashMap previously associated
     *	       <tt>null</tt> with the specified key.
  	 */
 	public function put(key:K, value:T):T {
		if (!exists(key)) length++;
		set(key, value);
		return value;
 	}
 
 	/**
 	 * Clears this HashMap so that it contains no keys no values.
 	 */
 	public function clear():Void{
		var itr:Iterator<K> =  keys();	
  		for(i in itr){
   			remove(i);
  		}
 	}

 	/**
 	 * Return a same copy of WeakMap object
 	 */
 	public function clone():WeakMap<K,T>{
  		var temp:WeakMap<K,T> = new WeakMap<K,T>();
  		var itr:Iterator<K> =  keys();	
  		for(i in itr){
   			 temp.put(i , get(i));
  		}
  		return temp;
 	}
}