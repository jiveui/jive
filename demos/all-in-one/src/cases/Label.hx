package cases;

	import flash.display.Sprite;
	class Label extends Sprite
	{
		public function new()
		{
			super();
			var panel:JPanel = new JPanel();
			var button:JButton = new JButton("Button", new ColorDotIcon(40));
			button.setHorizontalTextPosition(AbstractButton.LEFT);
			panel.append(button);
			panel.append(new JLabel("Label 1"));
			panel.append(new JLabel("Label 2", new ColorDotIcon(10, ASColor.BLUE)));
			panel.append(new JLabel("Label 3"));
			panel.setSizeWH(100, 160);
			addChild(panel);
			panel.validate();
		}
		
	}