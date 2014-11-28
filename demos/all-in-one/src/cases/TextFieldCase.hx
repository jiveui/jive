package cases;

	import flash.display.Sprite;
	import flash.events.Event;

	class TextFieldCase extends Sprite
	{
		private var panel:JWindow;
		
		public function new()
		{
			super();
			
			panel = new JFrame(null);
			panel.getContentPane().setLayout(new FlowLayout());
			var text:JTextField = new JTextField("input");
			text.setCachePreferSizes(false);
			text.setToolTipText("Text tool tip");
			panel.getContentPane().append(text);
			text.addActionListener(__revalidate);
			panel.getContentPane().append(new JTextField("JTextField1", 8));
			panel.getContentPane().append(new JTextField("JTextField2", 10));
			panel.getContentPane().append(new JTextField("JTextField3", 20));
			panel.getContentPane().append(new JButton("&Button"));
			
			var button:JButton = new JButton("Revalidate");
			panel.getContentPane().append(button);
			panel.setSizeWH(300, 200);
			panel.show();
			
			button.addActionListener(__revalidate);
		}
		
		private function __revalidate(e:Event):Void{
			panel.revalidate();
		}
	}