package cases;

import flash.display.Sprite;

class OptionPane extends Sprite
{
	public function new(){
		super();
		JOptionPane.showMessageDialog("System", "Input your Name:", __entered);
	}
	
	public static function __entered(r:Int):Void{
		if(r == JOptionPane.CLOSE){
			JOptionPane.showMessageDialog("Result", "User canceled");
		}else{
			JOptionPane.showMessageDialog("Result", "it is: OK");
		}
	}	
}