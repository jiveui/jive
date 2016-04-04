/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
package org.aswing.util;


/**
 * Utils functions about Array.
 * @author paling
 */
class ArrayUtils{
	
	/**
	 * Call the operation by pass each element of the array once.
	 * <p>
	 * for example:
	 * <pre>
	 * //hide all component in vector components
	 * ArrayUtils.each( 
	 *     components,
	 *     function(c:Component){
	 *         c.setVisible(false);
	 *     });
	 * <pre>
	 * @param arr the array for each element will be operated.
	 * @param the operation function for each element
	 * @see Vector#each
	 */
	public static function each(arr:Array<Dynamic>, operation:Dynamic -> Void):Void{
		for(i in 0...arr.length){
			operation(arr[i]);
		}
	}
	
	/**
	 * Sets the size of the array. If the new size is greater than the current size, 
	 * new undefined items are added to the end of the array. If the new size is less than 
	 * the current size, all components at index newSize and greater are removed.
	 * @param arr the array to resize
	 * @param size the new size of this vector 
	 */
	public static function setSize(arr:Array<Dynamic>, size:Int):Void{
		//TODO test this method
		if(size < 0) size = 0;
		if(size == arr.length){
			return;
		}
		if(size > arr.length){
			arr[size - 1] = null;
		}else{
			arr.splice(size,1);
		}
	}
	
	/**
	 * Removes the object from the array and return the index.
	 * @return the index of the object, -1 if the object is not in the array
	 */
	public static function removeFromArray(arr:Array<Dynamic>, obj:Dynamic):Int{
		for(i in 0...arr.length){
			if(arr[i] == obj){
				arr.splice(i, 1);
				return i;
			}
		}
		return -1;
	}
	
	public static function removeAllFromArray(arr:Array<Dynamic>, obj:Dynamic):Void{
		for(i in 0...arr.length ){
			if(arr[i] == obj){
				arr.splice(i, 1);
			
			}
		}
	}
	
	public static function removeAllBehindSomeIndex(array:Array<Dynamic>, index:Int):Void{
		if(index <= 0){
			array.splice(0, array.length);
			return;
		}
		var arrLen:Int= array.length;
		for(i in index+1 ...arrLen ){
			array.pop();
		}
	}	
	
	public static function indexInArray(arr:Array<Dynamic>, obj:Dynamic):Int{
		for(i in 0...arr.length){
			if(arr[i] == obj){
				return i;
			}
		}
		return -1;
	}
	
	public static function cloneArray(arr:Array<Dynamic>):Array<Dynamic>{
		return arr.copy();
	}
	/** Reverses <i>x</i>, e.g. Hello -> olleH */
	inline public static function reverse(x:String):String
	{
		var t = '';
		var i = x.length;
		while (i-- >= 0) t += x.charAt(i);
		return t;
	}
	
}