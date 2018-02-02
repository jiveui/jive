/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
 

import org.aswing.AbstractCellEditor;
import org.aswing.Component;
import org.aswing.JTextField;

/**
 * The default editor for table and tree cells, use a textfield.
 * <p>
 * @author paling
 */
class DefaultTextFieldCellEditor extends AbstractCellEditor{
	
	private var textField:JTextField;
	
	public function new(){
		super();
		setClickCountToStart(2);
	}
	
	public function getTextField():JTextField{
		if(textField == null){
			textField = new JTextField();
			//textField.setBorder(null);
			#if (flash9)
			textField.setRestrict(getRestrict());
			#end
		}
		return textField;
	}
	
	/**
	 * Subclass override this method to implement specified input restrict
	 */
	private function getRestrict():String{
		return null;
	}
	
	/**
	 * Subclass override this method to implement specified value transform
	 */
	private function transforValueFromText(text:String):Dynamic{
		return text;
	}
	
 	override public function getEditorComponent():Component{
 		return getTextField();
 	}
	
	override public function getCellEditorValue():Dynamic{		
		return transforValueFromText(getTextField().getText());
	}
	
   /**
    * Sets the value of this cell. 
    * @param value the new value of this cell
    */
	override private function setCellEditorValue(value:Dynamic):Void{
		getTextField().setText(value + "");
		#if (flash9)
		getTextField().selectAll();
		#end
	}
	
	public function toString():String{
		return "DefaultTextFieldCellEditor[]";
	}
}