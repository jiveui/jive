package cases;

import flash.display.Sprite;
import org.aswing.geom.IntRectangle;
import org.aswing.geom.IntDimension;
class Buttons extends Sprite
{
	public function new()
	{
		super();
		var panel:JPanel = new JPanel();
		var button:JButton = new JButton("Button");
		button.addActionListener(__buttonAction);
		var radio1:JRadioButton = new JRadioButton("Radio button 1");
		var radio2:JRadioButton = new JRadioButton("Radio button 2");
		var check1:JCheckBox = new JCheckBox("Check Box 1");
		var check2:JCheckBox = new JCheckBox("Check Box 2");
		var toggle:JToggleButton = new JToggleButton("Toggle Button");
		var group:ButtonGroup = new ButtonGroup();
		group.append(radio1);
		group.append(radio2);
		
		panel.append(button);
		panel.append(toggle);
		panel.append(radio1);
		panel.append(radio2);
		panel.append(check1);
		panel.append(check2);
		panel.setSizeWH(200, 100);
		addChild(panel);
		panel.validate();
	}
	
	private function __buttonAction(e:AWEvent):Void{
		var btn:JButton = flash.Lib.as(e.target,JButton)	;
		if(btn.getIcon() != null){
			btn.setIcon(null);
		}else{
			btn.setIcon(new CircleIcon(ASColor.BLUE, Math.random()*40, Math.random()*40))
		}
		btn.revalidate();
	}
}