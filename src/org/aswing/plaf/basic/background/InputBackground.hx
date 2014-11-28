/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.background;


/**
 * @private
 */
class InputBackground extends TextComponentBackBround{
	
	public function new(){
		super();
	}
	
	override private function getChangeSharpen(enabled:Bool, editable:Bool):Float{
		if(enabled!=true){
			return 0.2;
		}else if(editable!=true){
			return 1;
		}else{
			return 1;
		}
	}
	
	override private function getChangeAlpha(enabled:Bool, editable:Bool):Float{
		if(enabled!=true){
			return 0.2;
		}else if(editable!=true){
			return 0.5;
		}else{
			return 1;
		}
	}	
}