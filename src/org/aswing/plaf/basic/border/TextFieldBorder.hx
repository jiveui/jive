/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border;


/**
 * Discard in aswing 2.0(Background raped his job)
 * @private
 */
class TextFieldBorder extends TextComponentBorder{
	
	public function new(){
		super();
	}
	
	//override this to the sub component's prefix
	override private function getPropertyPrefix():String{
		return "TextField.";
	}
}