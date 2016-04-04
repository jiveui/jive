/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.util;

import org.aswing.error.Error;
import org.aswing.util.ListNode;
/**
 * Linked list implementation of the List interface.
 * @author Tomato
 * @author paling
 */
class LinkedList implements List
{
	/**
	 * the head node in this list
	 */
	private var head:ListNode;
	/**
	 * the tail node in this list
	 */
	private var tail:ListNode;
	
	/**
	 * the number of nodes in this list
	 */
	private var count:Int;
	 
	 
	//constructor
	public function new(){
	 	count = 0;
	 	head = null;
	 	tail = null;
	}
	
	
	public function size():Int{
		return count;
	}
	
	public function getHead():ListNode{
		return head;
	}
	
	public function getTail():ListNode{
		return tail;	
	}
	
	/**
	 * @throws RangeError when index out of bounds
	 */
	public function append(data:Dynamic, index:Int= -1):Void{
		if(index == -1) index = size();
		if(size() == 0 && index == 0){
			setInitalFirstNode(data);
			return;
		}
		
		if(index < 0 || index > size()){
			throw new Error("Error index out of range : " + index + ", size:" + size());
		}
		var newNode:ListNode;
		if(index == size()){
			newNode = new ListNode(data , tail , null);
			tail.setNextNode(newNode);
			tail = newNode;
		}else if(index == 0){
			newNode = new ListNode(data , null , head);
			head.setPrevNode(newNode);
			head = newNode;
		}else{
			var preNode:ListNode = getNodeAt(index-1);
			var nexNode:ListNode = preNode.getNextNode();
			newNode = new ListNode(data , preNode , nexNode);
			preNode.setNextNode(newNode);
			nexNode.setPrevNode(newNode);
		}
		count += 1;
	}
	
	private function setInitalFirstNode(data:Dynamic):Void{
		var newNode:ListNode = new ListNode(data , null , null);
		head = newNode;
		tail = newNode;
		count = 1;
	}
	
	public function getNodeAt(index:Int):ListNode{
		if(index < 0 || index >= size()){
			return null;
		}
		var i:Int;
		var n:Int;
		var node:ListNode;
		if(index < size()/2){
			n = index;
			node = getHead();
			for(i in 0...n){
				node = node.getNextNode();
			}
			return node;
		}else{
			n = size() - index - 1;
			node = getTail();
			for(i in 0...n){
				node = node.getPrevNode();
			}
			return node;
		}
	}
	
	
	public function get(index : Int):Dynamic{
		if(index < 0 || index >= size()){
			return null;
		}else{
			return this.getNodeAt(index).getData();			
		}
	}

	/**
	 * @throws RangeError when index out of bounds
	 */
	public function appendAll(arr : Array<Dynamic>, index : Int= -1) : Void{
		if(index == -1) index = size();
		if(arr == null || arr.length == 0){
			return;
		}
		if(index < 0 || index > size()){
			throw new Error("Error index out of range : " + index + ", size:" + size());
		 
			
		}
		
		var tempList:LinkedList = new LinkedList();
		for(i in 0...arr.length){
			tempList.append(arr[i]);
		}
		
		if(size() == 0){
			head = tempList.getHead();
			tail = tempList.getTail();
		}else if(index == size()){
			tail.setNextNode(tempList.getHead());
			tempList.getHead().setPrevNode(tail);
			tail = tempList.getTail();
		}else if(index == 0){
			head.setPrevNode(tempList.getTail());
			tempList.getTail().setNextNode(head);
			head = tempList.getHead();
		}else{
			var preNode:ListNode = getNodeAt(index-1);
			var nexNode:ListNode = preNode.getNextNode();
			preNode.setNextNode(tempList.getHead());
			tempList.getHead().setPrevNode(preNode);
			tempList.getTail().setNextNode(nexNode);
			nexNode.setPrevNode(tempList.getTail());
		}
		count += tempList.size();
	}

	public function appendList(list : List, index : Int= -1) : Void{
		appendAll(list.toArray(), index);
	}

	public function replaceAt(index : Int, element:Dynamic):Dynamic{
		var node:ListNode = getNodeAt(index);
		var oldData:Dynamic= node.getData();
		node.setData(element);
		return oldData;
	}

	public function removeAt(index : Int):Dynamic{
		if(index < 0 || index >= size()){
			return null;
		}
		var element:Dynamic;
		if(index == 0){
			element = head.getData();
			head = head.getNextNode();
			if(head == null){
				tail = null;
			}else{
				head.setPrevNode(null);
			}
		}else if(index == size() - 1){
			element = tail.getData();
			tail = tail.getPrevNode();
			if(tail == null){
				head = null;
			}else{
				tail.setNextNode(null);
			}
		}else{
			var preNode:ListNode = getNodeAt(index-1);
			var nexNode:ListNode = preNode.getNextNode().getNextNode();
			element = preNode.getNextNode().getData();
			preNode.setNextNode(nexNode);
			nexNode.setPrevNode(preNode);
		}
		count --;
		return element;
	}

	public function remove(element:Dynamic):Dynamic {
	//		for(var node:ListNode = head; node!=null; node=node.getNextNode()){	
		var node:ListNode = head;
		while(node != null) {
		
			if(node.getData() == element){
				removeNode(node);
				return node.getData();
			}
			node = node.getNextNode();	
		}
		return null;
	}
	
	public function removeNode(node:ListNode):Void{
		if(node == head && node == tail){
			head = tail = null;
		}else if(node == head){
			head = head.getNextNode();
			head.setPrevNode(null);
		}else if(node == tail){
			tail = tail.getPrevNode();
			tail.setNextNode(null);
		}else{
			var preNode:ListNode = node.getPrevNode();
			var nexNode:ListNode = node.getNextNode();
			preNode.setNextNode(nexNode);
			nexNode.setPrevNode(preNode);
		}
		count --;
	}
	
	/**
	 * Returns null if out of bounds
	 */
	public function removeRange(fromIndex : Int, toIndex : Int) : Array<Dynamic>{
		if(fromIndex > toIndex){
			var temp:Int= fromIndex;
			fromIndex = toIndex;
			toIndex = temp; 
		}
		if(fromIndex < 0 || fromIndex >= size()){
			return null;
		}
		if(toIndex < 0 || toIndex >= size()){
			return null;
		}
		var preNode:ListNode = getNodeAt(fromIndex - 1);
		var nexNode:ListNode = getNodeAt(toIndex + 1);
		if(fromIndex == 0 && toIndex == size() - 1){
			var array:Array<Dynamic>= toArray();
			clear();
			return array;
		}
		
		var startNode:ListNode = preNode.getNextNode();
		var endNode:ListNode = nexNode.getPrevNode();
		if(preNode == null){
			startNode = head;
		}
		if(nexNode == null){
			endNode = tail;
		}
		var al:Int= toIndex-fromIndex+1;
		var arr:Array<Dynamic>= new Array<Dynamic>();
		for(i in 0...al){
			arr[i] = startNode;
			startNode = startNode.getNextNode();
		}
		
		if(fromIndex == 0){
			head = nexNode;
			head.setPrevNode(null);
		}else if(toIndex == size() - 1){
			tail = preNode;
			tail.setNextNode(null);
		}else{
			preNode.setNextNode(nexNode);
			nexNode.setPrevNode(preNode);
		}
		
		count -= al;
		return arr;
	}

	public function indexOf(element:Dynamic) : Int{
		var index:Int = 0;
		//for(var node:ListNode = head; node!=null; node=node.getNextNode()){
		var node:ListNode = head; 
		while(node!=null){
			if(node.getData() == element){
				return index;
			}
			index++;
			 node = node.getNextNode();
		}
		return -1;
	}

	public function contains(element:Dynamic) : Bool{
		return (indexOf(element) != -1);
	}

	public function first():Dynamic{
		return head.getData();
	}

	public function last():Dynamic{
		return tail.getData();
	}

	public function pop():Dynamic{
		return removeAt(size() - 1);
	}
	
	public function shift():Dynamic{
		return removeAt(0);
	}

	public function clear() : Void{
		head = tail = null;
		count = 0;
	}

	public function isEmpty() : Bool{
		return count == 0;
	}

	public function toArray() : Array<Dynamic>{
		var arr:Array<Dynamic>= new Array<Dynamic>();
		var index:Int= 0;
			//for(var node:ListNode = head; node!=null; node=node.getNextNode()){
		var node:ListNode = head; 
		while(node!=null){
			arr[index] = node.getData();
			index++;
			node = node.getNextNode();
		}
		return arr;
	}
	
	public function toString():String{
		return "LinkedList[" + toArray() + "]";
	}
	
}