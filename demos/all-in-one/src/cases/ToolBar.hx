package cases;

import flash.display.Sprite;
class ToolBar extends Sprite
{
	public function new()
	{
		super();
		doToolBarTest();
	}
	
	
	private var frame:JFrame;
	private var bar:JToolBar;
	
	public function doToolBarTest():Void{
		frame = new JFrame(null, "ToolBar Test");
		bar = new JToolBar();
		
		bar.append(new JButton("Button1"));	
		bar.append(new JButton("Btn2"));	
		bar.append(new JButton("A long title Button"));
		bar.append(new JToggleButton("Toggle"));
		bar.append(new JCheckBox("Check"));
		bar.append(new JSeparator(JSeparator.VERTICAL));
		bar.append(new JLabel("Label"));
		
		var bar2:JToolBar = new JToolBar(JToolBar.VERTICAL);
		bar2.append(new JButton("Button1"));	
		bar2.append(new JButton("Btn2"));	
		bar2.append(new JButton("A long title Button"));
		bar2.append(new JToggleButton("Toggle"));
		bar2.append(new JCheckBox("Check"));
		bar2.append(new JSeparator(JSeparator.HORIZONTAL));
		bar2.append(new JLabel("Label"));
		
		frame.getContentPane().append(bar, BorderLayout.NORTH);
		frame.getContentPane().append(bar2, BorderLayout.WEST);
		
		frame.setSizeWH(400, 300);
		frame.show();
	}
}