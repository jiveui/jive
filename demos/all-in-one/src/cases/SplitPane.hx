package cases;

import flash.display.Sprite;

import org.aswing.ASColor;
import org.aswing.BorderLayout;
import org.aswing.JButton;
import org.aswing.JPanel;
import org.aswing.JSplitPane;
import org.aswing.border.LineBorder;

class SplitPane extends Sprite
{
	public function new(){
		super();
		var pane:JPanel = new JPanel(new BorderLayout());
		pane.setOpaque(true);
		var sp:JSplitPane = new JSplitPane();
		sp.setBorder(new LineBorder(null, ASColor.BLUE, 1));
		//pane.setTopComponent(new JButton("Top"));
		var left:JPanel = new JPanel();
		left.appendAll(new JButton("Left gfdsfds"), new JButton("Left 2"), new JButton("Left 43243"), new JButton("Left 54354353"));
		sp.setLeftComponent(left);
		var right:JPanel = new JPanel();
		right.appendAll(new JButton("Left gfdsfds"), new JButton("Left 2"), new JButton("Left 43243"), new JButton("Left 54354353"));
		sp.setRightComponent(right);
		//sp.setBottomComponent(new JButton("Bottom"));
		//sp.setContinuousLayout(true);
		sp.setOrientation(JSplitPane.HORIZONTAL_SPLIT);
		sp.setOneTouchExpandable(false);
		pane.append(sp, BorderLayout.CENTER);
		pane.setSizeWH(300,300);
		this.addChild(pane);
		pane.validate();
	}
}