package cases;
	import org.aswing.JScrollPane;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JButton;
	import org.aswing.JTree;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.aswing.BorderLayout;

class Tree extends Sprite
{
	public function new()
	{
		super();
		doTreeTest();
	}
	
	private var tree:JTree;
	private var frame:JFrame;
	
	public function doTreeTest():Void{
		frame = new JFrame(null, "TreeTest");
		var pane:JPanel = new JPanel(new BorderLayout());
		tree = new JTree();
		tree.setEditable(true);
		tree.setRowHeight(20);
		//tree.setFixedCellWidth(80);
		pane.append(new JScrollPane(tree), BorderLayout.CENTER);
		var button:JButton = new JButton("Expand");
		pane.append(button, BorderLayout.SOUTH);
		frame.setContentPane(pane);
		button.addActionListener(__repaintTree);
		
		//tree.setModel(new DefaultTreeModel(new DefaultMutableTreeNode("tree")));
		tree.setRootVisible(false);
		
		frame.setSizeWH(200, 200);
		frame.show();
	}
	
	private function __repaintTree(e:Event):Void{
		tree.expandPath(tree.getPathForRow(1));
		tree.expandPath(tree.getPathForRow(0));
	}
}