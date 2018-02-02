/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import org.aswing.AWKeyboard;

import org.aswing.event.AWEvent;

class LabelComboBoxEditor extends EventDispatcher  implements ComboBoxEditor{

    public var hint(get, set): String;
    private var _hint: String;
    private function get_hint(): String { return _hint; }
    private function set_hint(v: String): String {
        _hint = v;
        setValue(getValue());
        return v;
    }

    private var label(get, null): JLabel;
    private var _label: JLabel;
    private function get_label(): JLabel {
        if (null == _label) {
            _label = new JLabel();
            _label.setBorder(null);
            _label.setOpaque(false);
            _label.setFocusable(false);
            _label.setBackgroundDecorator(null);
            _label.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        }
        return _label;
    }

    private var lostingFocus:Bool;
    private var value:Dynamic;
    private var valueText:String;
    	
	public function new(){
		lostingFocus = false;
		super();
	}
	
	public function selectAll():Void{
	}
	
	public function setValue(value:Dynamic):Void{
		this.value = value;
		if(value == null){
			label.text = if (null != hint) hint else "";
		}else{
			label.text = Std.string(value);
		}
		valueText = label.text;
	}
	
	public function addActionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
	}
	
	public function getValue():Dynamic{
		return value;
	}
	
	public function removeActionListener(listener:Dynamic -> Void):Void{
	}
	
	public function setEditable(b:Bool):Void{
	}
	
	public function getEditorComponent():Component{
		return label;
	}
	
	public function isEditable():Bool{
		return false;
	} 
	override public function toString():String{
        return "LabelComboBoxEditor[]";
    }	
}