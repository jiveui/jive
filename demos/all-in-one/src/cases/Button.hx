package cases;


import flash.display.Sprite;
class Button extends Sprite
{
	public function new()
	{
		super();
		var button:JButton = new JButton("A &Button");
		button.setRollOverEnabled(true);
		button.setSize(button.getPreferredSize());
		addChild(button);
		button.addActionListener(__buttonAction);
		button.doubleClickEnabled = true;
	}
	
	private function __buttonAction(e:AWEvent):Void{
		trace("button act");
	}
		
}