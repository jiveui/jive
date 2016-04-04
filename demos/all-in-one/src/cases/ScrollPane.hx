package cases;

	import flash.display.Sprite;
	class ScrollPane extends Sprite
	{
		public function new()
		{
			super();
			var panel:JPanel = new JPanel(new BorderLayout());
						
			var container:JPanel = new JPanel(new GridLayout(0, 8, 5, 5));
			for(i in 0...200){
				container.append(new JButton("Button " + i));
			}
			var scrollPane:JScrollPane = new JScrollPane(container);
			panel.append(scrollPane, BorderLayout.CENTER);
			
			panel.setSizeWH(300, 300);
			addChild(panel);
			panel.validate();
		}
		
	}