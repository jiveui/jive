/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
 

import org.aswing.AbstractCellEditor;
import org.aswing.Component;
import org.aswing.JCheckBox;

/**
 * @author paling
 */
class DefaultCheckBoxCellEditor extends AbstractCellEditor{
	
	private var checkBox:JCheckBox;
	
	public function new(){
		super();
		setClickCountToStart(1);
	}
	
	public function getCheckBox():JCheckBox{
		if(checkBox == null){
			checkBox = new JCheckBox();
		}
		return checkBox;
	}
	
 	override public function getEditorComponent():Component{
 		return getCheckBox();
 	}
	
	override public function getCellEditorValue():Dynamic{		
		return getCheckBox().isSelected();
	}
	
    /**
     * Sets the value of this cell. 
     * @param value the new value of this cell
     */
	override private function setCellEditorValue(value:Dynamic):Void{
		var selected:Bool= false;
		if(value == true){
			selected = true;
		}
		if(Std.is(value , String)){
			var va:String= AsWingUtils.as(value , String);
			if(va.toLowerCase() == "true"){
				selected = true;
			}
		}
		getCheckBox().setSelected(selected);
	}
	
	public function toString():String{
		return "DefaultCheckBoxCellEditor[]";
	}
}