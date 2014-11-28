package cases;

	import flash.display.Sprite;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	class Panel extends Sprite
	{
		public function new(){
			super();
			var popup:JWindow = new JWindow(this);
			var panel:JPanel = new JPanel();
			var button:JButton = new JButton("Button");
			panel.append(button);
			panel.append(new JButton("Button 1"));
			panel.append(new JButton("Button 2"));
			panel.append(new JButton("Button 3"));
			panel.setSizeWH(100, 60);
			
			popup.setContentPane(panel);
			popup.setSizeWH(200, 200);
			popup.show();
			
			var menus:ContextMenu = new ContextMenu();
			menus.customItems.push(new ContextMenuItem("My menu item"));
			panel.contextMenu = menus;
			
			menus = new ContextMenu();
			menus.customItems.push(new ContextMenuItem("My menu item 2"));
			button.contextMenu = menus;
		}
	}