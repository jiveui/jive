/*
 Copyright aswing.org, see the LICENCE.txt.
*/


package org.aswing;


import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import org.aswing.event.SelectionEvent;

/**
 * Default data model for list selections.
 * @author paling
 */
class DefaultListSelectionModel extends EventDispatcher  implements ListSelectionModel{

	/**
	 * Only can select one most item at a time.
	 */
	inline public static var SINGLE_SELECTION:Int= 0;
	/**
	 * Can select any item at a time.
	 */
	inline public static var MULTIPLE_SELECTION:Int= 1;
		
	private static var MIN:Int= -1;
	private static var MAX:Int= AsWingConstants.MAX_VALUE;
	
	private var value:Array<Dynamic>;
	private var minIndex:Int;
	private var maxIndex:Int;
	private var anchorIndex:Int;
	private var leadIndex:Int;
	private var selectionMode:Int;
	
	public function new(){
		value       = [];
		minIndex    = MAX;
		maxIndex    = MIN;
		anchorIndex = -1;
		leadIndex   = -1;
		selectionMode = MULTIPLE_SELECTION;
		super();
	}
	
	public function setSelectionInterval(index0 : Int, index1 : Int, programmatic:Bool=true) : Void{
		if (index0 < 0 || index1 < 0) {
			clearSelection(programmatic);
			return;
		}
		if (getSelectionMode() == SINGLE_SELECTION) {
			index0 = index1;
		}
		var i:Int;
		updateLeadAnchorIndices(index0, index1);
		var min:Int= Std.int(Math.min(index0, index1));
		var max:Int= Std.int(Math.max(index0, index1));
		var changed:Bool= false;
		if(min == minIndex && max == maxIndex){
			for(i in min...max+1){
				if(value[i] != true){
					changed = true;
					break;
				}
			}
		}else{
			changed = true;
		}
		if(changed)	{
			minIndex = min;
			maxIndex = max;
			clearSelectionImp();
			for(i in minIndex...maxIndex+1){
				value[i] = true;
			}
			fireListSelectionEvent(min, max, programmatic);
		}
	}

	public function addSelectionInterval(index0 : Int, index1 : Int, programmatic:Bool=true) : Void{
		if (index0 < 0 || index1 < 0) {
			return;
		}
		if (getSelectionMode() == SINGLE_SELECTION) {
			setSelectionInterval(index0, index1);
			return;
		}
		updateLeadAnchorIndices(index0, index1);
		var min:Int= Std.int(Math.min(index0, index1));
		var max:Int= Std.int(Math.max(index0, index1));
		var changed:Bool= false;
		for(i in min...max+1){
			if(value[i] != true){
				value[i] = true;
				changed = true;
			}
		}
		minIndex = Std.int(Math.min(min, minIndex));
		maxIndex = Std.int(Math.max(max, maxIndex));
		if(changed)	{
			fireListSelectionEvent(min, max, programmatic);
		}
	}

	public function removeSelectionInterval(index0 : Int, index1 : Int, programmatic:Bool=true) : Void{
		if (index0 < 0 || index1 < 0) {
			return;
		}		
		var min:Int= Std.int(Math.min(index0, index1));
		var max:Int= Std.int(Math.max(index0, index1));
		min = Std.int(Math.max(min, minIndex));
		max = Std.int(Math.min(max, maxIndex));
		if(min > max){
			return;
		}
		
		updateLeadAnchorIndices(index0, index1);
		
		if(min == minIndex && max == maxIndex){
			clearSelection();
			return;
		}else if(min > minIndex && max < maxIndex){
		}else if(min > minIndex && max == maxIndex){
			maxIndex = min - 1;
		}else{//min==minIndex && max<maxIndex
			minIndex = max + 1;
		}
		for(i in min...max+1){
			value[i] = null;
		}
		fireListSelectionEvent(min, max, programmatic);
	}

	public function getMinSelectionIndex() : Int{
		if(isSelectionEmpty()){
			return -1;
		}else{
			return minIndex;
		}
	}

	public function getMaxSelectionIndex() : Int{
		return maxIndex;
	}

	public function isSelectedIndex(index : Int) : Bool{
		return value[index] == true;
	}
	
	private function updateLeadAnchorIndices(anchor:Int, lead:Int):Void{
		anchorIndex = anchor;
		leadIndex   = lead;
	}

	public function getAnchorSelectionIndex() : Int{
		return anchorIndex;
	}

	public function setAnchorSelectionIndex(index : Int) : Void{
		anchorIndex = index;
	}

	public function getLeadSelectionIndex() : Int{
		return leadIndex;
	}

	public function setLeadSelectionIndex(index : Int) : Void{
		leadIndex = index;
	}

	public function clearSelection(programmatic:Bool=true) : Void{
		if(!isSelectionEmpty()){
			var max:Int= maxIndex;
			minIndex	= MAX;
			maxIndex	= MIN;
			clearSelectionImp();
			fireListSelectionEvent(0, max, programmatic);
		}
	}
	
	private function clearSelectionImp():Void{
		value = [];
	}

	public function isSelectionEmpty() : Bool{
		return minIndex > maxIndex;
	}
	
	public function insertIndexInterval(index:Int, length:Int, before:Bool, programmatic:Bool=true):Void{
		/* The first new index will appear at insMinIndex and the last
		 * one will appear at insMaxIndex
		 */
		var insMinIndex:Int= (before) ? index : index + 1;
		var insMaxIndex:Int= (insMinIndex + length) - 1;
	
		var needInstertArray:Bool= false;
		
		if(isSelectionEmpty()){
			//need do nothing
		}else if(minIndex >= insMinIndex){
			minIndex += length;
			maxIndex += length;
			needInstertArray = true;
		}else if(maxIndex < insMinIndex){
			//do nothing
		}else if(insMinIndex > minIndex && insMinIndex <= maxIndex){
			maxIndex += length;
			needInstertArray = true;
		}
		
		if(needInstertArray)	{
			if(insMinIndex == 0){
				value = (new Array<Dynamic>()).concat(value);
			}else{
				var right:Array<Dynamic>= value.splice(insMinIndex,value.length-insMinIndex);
				value = value.concat(new Array<Dynamic>()).concat(right);
			}
		}
	
		var leadIn:Int= leadIndex;
		if (leadIn > index || (before && leadIn == index)) {
			leadIn = leadIndex + length;
		}
		var anchorIn:Int= anchorIndex;
		if (anchorIn > index || (before && anchorIn == index)) {
			anchorIn = anchorIndex + length;
		}
		if (leadIn != leadIndex || anchorIn != anchorIndex) {
			updateLeadAnchorIndices(anchorIn, leadIn);
		}
		
		if(needInstertArray)	{
			fireListSelectionEvent(insMinIndex, insMaxIndex+length, programmatic);
		}
	}

	public function removeIndexInterval(index0:Int, index1:Int, programmatic:Bool=true):Void{
		var rmMinIndex:Int= Std.int(Math.min(index0, index1));
		var rmMaxIndex:Int= Std.int(Math.max(index0, index1));
		var gapLength:Int= (rmMaxIndex - rmMinIndex) + 1;

		var needFireEvent:Bool= true;
		var i:Int;
		
		if(isSelectionEmpty()){
			//need do nothing
			needFireEvent = false;
		}else if(minIndex >= rmMinIndex && maxIndex <= rmMaxIndex){
			minIndex	= MAX;
			maxIndex	= MIN;
			clearSelectionImp();
		}else if(maxIndex < rmMinIndex){
			value.splice(rmMinIndex, gapLength);
		}else if(minIndex > rmMaxIndex){
			value.splice(rmMinIndex, gapLength);
			minIndex -= gapLength;
			maxIndex -= gapLength;
		}else if(minIndex < rmMinIndex && maxIndex >= rmMinIndex && maxIndex <= rmMaxIndex){
			value.splice(rmMinIndex, gapLength);
		
			//for(i = rmMinIndex-1; i>=minIndex; i--){
			for(i  in minIndex...rmMinIndex){
				maxIndex = i;
				if(value[i] == true){
					break;
				}
			}
		}else if(minIndex >= rmMinIndex && maxIndex > rmMaxIndex){
			value.splice(rmMinIndex, gapLength);
			maxIndex -= gapLength;
			//		for(i = rmMinIndex-1; i<=maxIndex; i++){
			for(i  in rmMinIndex-1...maxIndex+1){
				minIndex = i;
				if(value[i] == true){
					break;
				}
			}
		}else if(minIndex < rmMinIndex && maxIndex > rmMaxIndex){
			value.splice(rmMinIndex, gapLength);
			maxIndex -= gapLength;
		}else{
			needFireEvent = false;
		}

		var leadIn:Int= leadIndex;
		if (leadIn == 0 && rmMinIndex == 0) {
			// do nothing
		} else if (leadIn > rmMaxIndex) {
			leadIn = leadIndex - gapLength;
		} else if (leadIn >= rmMinIndex) {
			leadIn = rmMinIndex - 1;
		}

		var anchorIn:Int= anchorIndex;
		if (anchorIn == 0 && rmMinIndex == 0) {
			// do nothing
		} else if (anchorIn > rmMaxIndex) {
			anchorIn = anchorIndex - gapLength;
		} else if (anchorIn >= rmMinIndex) {
			anchorIn = rmMinIndex - 1;
		}
		
		if (leadIn != leadIndex || anchorIn != anchorIndex) {
			updateLeadAnchorIndices(anchorIn, leadIn);
		}
		
		if(needFireEvent)	{
			fireListSelectionEvent(rmMinIndex, rmMaxIndex+gapLength, programmatic);
		}
	}	
	
	/**
	 * Sets the selection mode.  The default is
	 * MULTIPLE_SELECTION.
	 * @param selectionMode  one of three values:
	 * <ul>
	 * <li>SINGLE_SELECTION
	 * <li>MULTIPLE_SELECTION
	 * </ul>
	 */
	public function setSelectionMode(selectionMode : Int) : Void{
		this.selectionMode = selectionMode;
	}

	public function getSelectionMode() : Int{
		return selectionMode;
	}

	public function addListSelectionListener(listener:Dynamic -> Void):Void{
		addEventListener(SelectionEvent.LIST_SELECTION_CHANGED, listener);
	}
	
	public function removeListSelectionListener(listener:Dynamic -> Void):Void{
		removeEventListener(SelectionEvent.LIST_SELECTION_CHANGED, listener);
	}
	
	private function fireListSelectionEvent(firstIndex:Int, lastIndex:Int, programmatic:Bool):Void{
		dispatchEvent(new SelectionEvent(SelectionEvent.LIST_SELECTION_CHANGED, firstIndex, lastIndex, programmatic));
	} 
	override public function toString():String{
		return "DefaultListSelectionModel[]";
	}
}