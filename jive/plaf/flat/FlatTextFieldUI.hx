package jive.plaf.flat;

class FlatTextFieldUI extends FlatTextComponentUI{
	
	public function new() { super();	}

	override private function getPropertyPrefix():String{
		return "TextField.";
	}
}