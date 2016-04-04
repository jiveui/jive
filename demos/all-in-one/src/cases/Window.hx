package cases;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	class Window extends Sprite
	{
		private var pop1:JWindow;
		private var pop2:JWindow;
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
			
			pop1 = new JWindow();
			
			pop1.addEventListener(MovedEvent.MOVED, function(e:MovedEvent):Void{
				trace( "moved : " + e.getNewLocation()); });
				
			pop1.setBackgroundDecorator(new SolidBackground(ASColor.WHITE));
			pop1.getContentPane().setLayout(new FlowLayout());
			pop1.getContentPane().append(new JCheckBox("CheckBox"));
			pop1.setSizeWH(200, 200);
			pop1.setLocationXY(100, 10);
			
			pop2 = new JWindow();
			pop2.setBackgroundDecorator(new SolidBackground(ASColor.RED));
			pop2.getContentPane().setLayout(new FlowLayout());
			pop2.getContentPane().append(new JButton("PopupedButton"));
			pop2.setSizeWH(200, 200);
			pop2.setLocationXY(200, 10);
			
			pop1.addEventListener(MouseEvent.MOUSE_DOWN, __top1);
			pop1.addEventListener(ReleaseEvent.RELEASE, __top1Released);
			pop2.addEventListener(MouseEvent.MOUSE_DOWN, __top2);
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