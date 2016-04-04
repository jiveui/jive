package cases;

import flash.display.Sprite;
import org.aswing.JButton;
import org.aswing.border.LineBorder;
import org.aswing.border.SimpleTitledBorder;
import org.aswing.border.TitledBorder;
import org.aswing.border.BevelBorder;
import org.aswing.JPanel;
import org.aswing.BorderLayout;
import org.aswing.border.EmptyBorder;
import org.aswing.ASColor;
import org.aswing.border.SideLineBorder;

class Borders extends Sprite
{
	public function new(){
		super();
		var panel:JPanel = new JPanel(new BorderLayout());
		var button:JButton = new JButton("我是一个按�?);
		var border1:LineBorder = new LineBorder(null, ASColor.RED, 10, 10);
		var border2:SimpleTitledBorder = new SimpleTitledBorder(border1, "SimpleTitledBorder");
		var border3:SideLineBorder = new SideLineBorder(border2, SideLineBorder.NORTH, ASColor.GREEN);
		var border4:TitledBorder = new TitledBorder(border3, "TitledBorder");
		var border5:BevelBorder = new BevelBorder(border4);
		panel.append(button);
		panel.setBorder(border5);
		panel.setSizeWH(300,300);
		this.addChild(panel);
		panel.validate();
	}
}