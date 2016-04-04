/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.util.List;

/**
 * The mutable list model vector implementation.
 * @author paling
 */
class VectorListModel extends AbstractListModel  implements MutableListModel implements List{

	private var _elements:Array<Dynamic>;
	inline public static var CASEINSENSITIVE:Int=1;
	inline public static var DESCENDING :Int=2;
	inline public static var UNIQUESORT :Int=4;
	inline public static var RETURNINDEXEDARRAY :Int=8;	
	inline public static var NUMERIC  :Int=16;	
	
	/**
	 * Create a VectorListModel instance.
	 * @param initalData (optional)the to be copid to the model.
	 */
	public function new(initalData:Array<Dynamic>=null){
		super();
		if(initalData != null){
			_elements = initalData.copy();
		}else{
			_elements = new Array<Dynamic>();
		}
	}
	
	
	public function get(i:Int):Dynamic{
		return _elements[i];
	}
	
	/**
	 * implemented ListMode
	 */
	public function getElementAt(i:Int):Dynamic{
		return _elements[i];
	}
	
	public function append(obj:Dynamic, index:Int=-1):Void{
		if(index == -1){
			index = _elements.length;
			_elements.push(obj);
		}else{
			_elements.insert(index,obj);
		}
		fireIntervalAdded(this, index, index);
	}
	
	public function replaceAt(index:Int, obj:Dynamic):Dynamic{
		if(index<0 || index>= size()){
			return null;
		}
		var oldObj:Dynamic= _elements[index];
		_elements[index] = obj;
		fireContentsChanged(this, index, index, [oldObj]);
		return oldObj;
	}	
	
	/**
	 * Append all the elements of a array(arr) to the specified position of the 
	 * vector.
	 * @param arr the elements array
	 * @param index the position to be append, default is -1 means the end of the vector.
	 */
	public function appendAll(arr:Array<Dynamic>, index:Int=-1):Void{
		if(arr == null || arr.length <= 0){
			return;
		}
		if(index == -1){
			index = _elements.length;
		}
		if(index == 0){
			_elements = arr.concat(_elements);
		}else if(index == _elements.length){
			_elements = _elements.concat(arr);
		}else{
			var right:Array<Dynamic>= _elements.splice(index,_elements.length-index);
			_elements = _elements.concat(arr);
			_elements = _elements.concat(right);
		}
		fireIntervalAdded(this, index, index+arr.length-1);
	}
	
	/**
	 * Notice the listeners the specified obj's value changed.
	 */
	public function valueChanged(obj:Dynamic):Void{
		valueChangedAt(indexOf(obj));
	}
	
	/**
	 * Notice the listeners the specified obj's value changed.
	 */
	public function valueChangedAt(index:Int):Void{
		if(index>=0 && index<_elements.length){
			fireContentsChanged(this, index, index, []);
		}
	}
	
	/**
	 * Notice the listeners the specified range values changed.
	 * [from, to](include "from" and "to").
	 */
	public function valueChangedRange(from:Int, to:Int):Void{
		fireContentsChanged(this, from, to, []);
	}
	
	public function removeAt(index:Int):Dynamic{
		if(index < 0 || index >= size()){
			return null;
		}
		var obj:Dynamic= _elements[index];
		_elements.splice(index, 1);
		fireIntervalRemoved(this, index, index, [obj]);
		return obj;
	}
	
	public function remove(obj:Dynamic):Dynamic{
		var i:Int= indexOf(obj);
		if(i>=0){
			return removeAt(i);
		}else{
			return null;
		}
	}	
	
	/**
	 * Removes from this List all of the elements whose index is between fromIndex, 
	 * and toIndex(both inclusive). Shifts any succeeding elements to the left (reduces their index). 
	 * This call shortens the ArrayList by (toIndex - fromIndex) elements. (If toIndex==fromIndex, 
	 * this operation has no effect.) 
	 * @return the elements were removed from the vector
	 */
	public function removeRange(fromIndex:Int, toIndex:Int):Array<Dynamic>{
		if(_elements.length > 0){
			fromIndex = Std.int(Math.max(0, fromIndex));
			toIndex = Std.int(Math.min(toIndex, _elements.length-1));
			if(fromIndex > toIndex){
				return [];
			}else{
				var removed:Array<Dynamic>= _elements.splice(fromIndex, toIndex-fromIndex+1);
				fireIntervalRemoved(this, fromIndex, toIndex, removed);
				return removed;
			}
		}else{
			return [];
		}
	}
	
	/**
	 * @see #removeAt()
	 */
	public function removeElementAt(index:Int):Void{
		removeAt(index);
	}
		
	/**
	 * @see #append()
	 */
	public function insertElementAt(item:Dynamic, index:Int):Void{
		append(item, index);
	}
	
	public function indexOf(obj:Dynamic):Int{
		for(i in 0..._elements.length){
			if(_elements[i] == obj){
				return i;
			}
		}
		return -1;
	}
	
	public function contains(obj:Dynamic):Bool{
		return indexOf(obj) >=0;
	}
	
	public function appendList(list:List, index:Int=-1) : Void{
		appendAll(list.toArray(), index);
	}

	public function pop():Dynamic{
		if(size() > 0){
			return removeAt(size()-1);
		}else{
			return null;
		}
	}

	public function shift():Dynamic{
		if(size() > 0){
			return removeAt(0);
		}else{
			return null;
		}
	}
	
	
	public function first():Dynamic{
		return _elements[0];
	}
	
	public function last():Dynamic{
		return _elements[_elements.length - 1];
	}
	
	public function size():Int{
		return _elements.length;
	}

	public function isEmpty():Bool{
		return _elements.length <= 0;
	}	
	
	/**
	 * Implemented ListMode
	 */
	public function getSize():Int{
		return size();
	}
	
	public function clear():Void{
		var ei:Int= size() - 1;
		if(ei >= 0){
			var temp:Array<Dynamic>= toArray();
			_elements.slice(0);
			fireIntervalRemoved(this, 0, ei, temp);
		}
	}
	
	public function toArray():Array<Dynamic>{
		return _elements.copy(); 
	}
	
	/**
	 * Returns a array that contains elements start with startIndex and has length elements.
	 * @param startIndex the element started index(include)
	 * @param length length of the elements, if there is not enough elements left, return the elements ended to the end of the vector.
	 */
	public function subArray(startIndex:Int, length:Int):Array<Dynamic>{
		if(size() == 0 || length <= 0){
			return new Array<Dynamic>();
		}
		return _elements.slice(startIndex, Std.int(Math.min(startIndex+length, size())));
	}	
		
	public function sort(compare:Dynamic, options:Int):Array<Dynamic>{
		  _elements.sort(function(a:Int,b:Int):Int {
													if (a == b)
														return 0;
													if (a > b)
														return 1;
													else
														return -1;
												});
		fireContentsChanged(this, 0, _elements.length-1, []);
		return  _elements;
	}
	
	public function sortOn(key:Dynamic, options:Int):Array<Dynamic>{
	     _elements.sort(function(a:Int,b:Int):Int {
													if (a == b)
														return 0;
													if (a > b)
														return 1;
													else
														return -1;
												});
		fireContentsChanged(this, 0, _elements.length-1, []);
		return   _elements;
	}
	
	public function toString():String{
		return "VectorListModel : " + _elements.toString();
	}
}