package cases;

	import flash.display.Sprite;
	import flash.text.TextFormat;

	class TextAreaCase extends Sprite
	{
		private var textArea:JTextArea;
		
		public function new()
		{
			super();
			var panel:JPanel = new JPanel(new BorderLayout());
						
			textArea = new JTextArea();
			for(i in 0...40){
				textArea.appendText("text " + i + "\n");
				if(i % 2 == 0){
					textArea.setDefaultTextFormat(new TextFormat(null, 24, 0xFF0000));
				}else{
					textArea.setDefaultTextFormat(new TextFormat(null, 11, 0x000000));
				}
			}
			
			var scrollPane:JScrollPane = new JScrollPane(textArea);
			panel.append(scrollPane, BorderLayout.CENTER);
			
			panel.setSizeWH(300, 300);
			addChild(panel);
			panel.validate();
		}
		
	}