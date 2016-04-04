package cases;

import flash.events.Event;
class PopupMenu extends Sprite
{
	public function new()
	{
		super();
		doPopupMenuTest();
	}
	
	private var popupMenu:JPopupMenu;
	private var textArea:JTextArea;
	private var frame:JFrame;
	
	public function doPopupMenuTest():Void{
		frame = new JFrame(null, "PopupMenuTest");
		
		popupMenu = new JPopupMenu();
		popupMenu.setInvoker(frame);
		popupMenu.addMenuItem("Menu Item Begin").addActionListener(__menuItemAction);
		popupMenu.addMenuItem("Menu Item Long Long item 2").addActionListener(__menuItemAction);
		popupMenu.addMenuItem("Short3").addActionListener(__menuItemAction);
		var iconItem:JMenuItem = new JMenuItem("Has Icon Long Long Long item", new ColorIcon(ASColor.RED, 20, 20));
		popupMenu.append(iconItem);
		iconItem.addActionListener(__menuItemAction);
		
		var menu:JMenu = new JMenu("Sub Menus");
		menu.addMenuItem("Sub Menu 1");
		menu.addMenuItem("Sub Menu 2");
		popupMenu.append(menu);
		
		var button:JButton = new JButton("PopupMenu");
		textArea = new JTextArea();
		frame.getContentPane().append(button, BorderLayout.SOUTH);
		frame.getContentPane().append(new JScrollPane(textArea), BorderLayout.CENTER);
		
		button.addActionListener(__popupMenu);
		
		frame.setSizeWH(400, 400);
		frame.show();
	}
	
	private function __popupMenu(e:Event):Void{
		var source:Component = flash.Lib.as(e.target,Component)	;
		popupMenu.show(source, source.getMousePosition().x, source.getMousePosition().y);
	}
	
	private function __menuItemAction(e:Event):Void{
		var source:JMenuItem = flash.Lib.as(e.target,JMenuItem)	;
		textArea.appendText("Menu " + source.getText() + " acted!\n");
	}	
}