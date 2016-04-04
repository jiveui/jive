/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


/**
 * @private
 */
class BasicTextAreaUI extends BasicTextComponentUI{
	
	public function new(){
		super();
	}
	
	//override this to the sub component's prefix
	override private function getPropertyPrefix():String{
		return "TextArea.";
	}
}