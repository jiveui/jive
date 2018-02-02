/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * Cell Pane is just a container, it do not layout children, 
 * do not invalidate parent.
 * @author paling
 */
class CellPane extends Container{
	
	public function new(){
		super();
	}
	
	override public function revalidate():Void{
		valid = true;
	}
	
	override public function invalidate():Void{
		valid = true;
	}
	
	override private function invalidateTree():Void{
		valid = true;
	}
	
	override public function validate():Void{
		valid = true;
	}
}