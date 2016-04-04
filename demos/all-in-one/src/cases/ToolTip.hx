package cases;

	
import flash.display.Sprite;
class ToolTip extends Sprite
{
	public function new()
	{
		var panel:JPanel = new JPanel();
		var button:JButton = new JButton("Button");
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
		panel.setSizeWH(200, 400);
		addChild(panel);
		panel.validate();
		
		var tip1:JToolTip = new JToolTip();
		tip1.setTipText("Button Tip");
		tip1.setTargetComponent(button);
		
		check1.setToolTipText("Check box 1 tip!");
		check2.setToolTipText("Check box 2 tip!");
		
		var dot:Sprite = new Sprite();
		dot.graphics.beginFill(0xff0000);
		dot.graphics.drawCircle(100, 300, 40);
		dot.graphics.endFill();
		JSharedToolTip.getSharedInstance().registerComponent(dot, "Shared tip on a normal sprite!");
		addChild(dot);
		
		var tip2:JToolTip = new JToolTip();
		tip2.setTipText("A tip on a normal sprite!");
		dot = new Sprite();
		dot.graphics.beginFill(0x00ff00);
		dot.graphics.drawCircle(100, 200, 40);
		dot.graphics.endFill();
		addChild(dot);
		tip2.setTargetComponent(dot);
	}
	
}