/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.util;

	
	
/**
 * A collection that contains no duplicate elements. More formally, 
 * sets contain no pair of elements e1 and e2 such that e1 == e2.
 * @author paling
 */
class HashSet
{
	 
	private var length:Int; 
    private var container:Array<Dynamic>;
		
 	public function new(){
        length = 0;
	 
        container = new Array<Dynamic>();
 	}
	public function getKeyIndex(key:Dynamic ):Int {
		 
  		for(i in 0...container.length){
   			if(container[i] == key){
    			return i;
   			}
  		}
  		return -1;
 	}
	
	public function size():Int{
		return length;
	}
	
	public function add(o:Dynamic):Void{
		if(!contains(o)){
			length++;
		}
		  container.push(o);
	}
	
	public function contains(o:Dynamic):Bool{
		return getKeyIndex(o)>-1;
	}
	
	public function isEmpty():Bool{
		return length == 0;
	}
	
	public function remove(o:Dynamic):Bool{
		if(contains(o)){
			// delete container[o];
			container.splice(getKeyIndex(o),1);
			length--;
			return true;
		}else{
			return false;
		}
	}
	
	public function clear():Void{
		container = new Array<Dynamic>();
		length = 0;
	}
	
	public function addAll(arr:Array<Dynamic>):Void{
		for (i in arr ){
			add(i);
		}
	}
	
	public function removeAll(arr:Array<Dynamic>):Void{
		for (i in arr ){
			remove(i);
		}
	}
	
	public function containsAll(arr:Array<Dynamic>):Bool{
		for(i in 0...arr.length){
			if(!contains(arr[i])){
				return false;
			}
		}
		return true;
	}
	
	public function each(func:Dynamic -> Void):Void{
		var itr:Iterator<Dynamic> =  container.iterator();	
  		for(i in itr){	
			func(i);
		}
	}
	
	public function toArray():Array<Dynamic>{
		 
		return  container.copy();
	}
}