/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

	
/**
 * Basic CheckBox implementation.
 * @author paling
 * @private
 */		
class BasicCheckBoxUI extends BasicRadioButtonUI{
	
	public function new(){
		super();
	}
	
    override private function getPropertyPrefix():String{
        return "CheckBox.";
    }
}