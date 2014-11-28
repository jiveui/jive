package cases;

	import flash.display.Sprite;
	class Frame extends Sprite
	{
		private var pop1:JFrame;
		private var pop2:JFrame;
		private var button2:JButton;
		
		public function new()
		{
			super();
			var panel:JPanel = new JPanel();
			var button1:JButton = new JButton("Popygup 1");
			button2 = new JButton("Popup 2");
			panel.append(button1);
			panel.append(button2);
			panel.pack();
			addChild(panel);
			panel.validate();
			
			button1.addActionListener(__pop1Listener);
			button2.addActionListener(__pop2Listener);
			
			pop1 = new JFrame(this, "Frame 1");
			pop1.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
			pop1.getContentPane().setLayout(new FlowLayout());
			pop1.getContentPane().append(new JCheckBox("CheckBox"));
			pop1.setSizeWH(200, 200);
			pop1.setLocationXY(100, 10);
			
			var pppp:JFrame = new JFrame(this, "xxx");
			pppp.setSizeWH(200, 200);
			pppp.show();
			
			pop2 = new JFrame(this, "Long Title Frame, Really very Long?", true);
			//pop2.setActivable(false);
			pop2.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
			var defaultButton:JButton = new JButton("Default Button");
			pop2.getContentPane().setLayout(new FlowLayout());
			pop2.getContentPane().append(defaultButton);
			pop2.getContentPane().append(new JButton("Normal Button"));
			pop2.setSizeWH(200, 200);
			pop2.setLocationXY(200, 140);
			pop2.setDefaultButton(defaultButton);
			defaultButton.addActionListener(
				function(e:Event):Void{
					trace("defaultButton entered!");});
			
			//pop1.addEventListener(MouseEvent.MOUSE_DOWN, __top1);
			//pop1.addEventListener(ReleaseEvent.RELEASE, __top1Released);
			//pop2.addEventListener(MouseEvent.MOUSE_DOWN, __top2);
			
			__pop1Listener(null);
			__pop2Listener(null);
		}
		
		private function __pop1Listener(e:Event):Void{
			pop1.show();
			button2.setEnabled(true);
		}
		private function __pop2Listener(e:Event):Void{
			pop2.show();
			button2.setEnabled(false);
		}
		private function __top1(e:Event):Void{
			pop1.toFront();
			pop1.startDrag();
		}
		private function __top1Released(e:Event):Void{
			pop1.stopDrag();
		}
		private function __top2(e:Event):Void{
			pop2.toFront();
		}
	}