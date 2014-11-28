/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


/**
 * @private
 */
class BasicTextFieldUI extends BasicTextComponentUI{
	
	public function new(){
		super();
	}
	
	//override this to the sub component's prefix
	override private function getPropertyPrefix():String{
		return "TextField.";
	}
}