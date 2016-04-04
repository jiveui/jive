package cases;

import flash.display.Sprite;
class LabelButton extends Sprite
{
	public function new()
	{
		super();
		var panel:JPanel = new JPanel();
		panel.setOpaque(true);
		var button:JLabelButton = new JLabelButton("LabelButton");
		
		var button1:JLabelButton = new JLabelButton("label button custom color");
		button1.setRollOverColor(ASColor.GREEN);
		button1.setPressedColor(ASColor.BLACK);
		button1.setForeground(ASColor.BLUE);
		var button2:JLabelButton = new JLabelButton("label disabled");
		button2.setEnabled(false);
		
		panel.append(button);
		panel.append(button1);
		panel.append(button2);
		panel.setSizeWH(200, 100);
		addChild(panel);
		panel.validate();
	}
}