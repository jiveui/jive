package cases;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	class Popup extends Sprite
	{
		private var pop1:JPopup;
		private var pop2:JPopup;
		private var button2:JButton;
		
		public function new()
		{
			super();
			var panel:JRootPane = new JRootPane();
			panel.setLayout(new FlowLayout());
			var button1:JButton = new JButton("&Popup 1");
			button2 = new JButton("P&opup 2");
			panel.append(button1);
			panel.append(button2);
			panel.append(new JLabel("Press tab key first to get the focus!"));
			panel.pack();
			addChild(panel);
			panel.validate();
			
			button1.addActionListener(__pop1Listener);
			button2.addActionListener(__pop2Listener);
			
			pop1 = new JPopup();
			
			pop1.addEventListener(MovedEvent.MOVED, function(e:MovedEvent):Void{
				trace( "moved : " + e.getNewLocation()); });
				
			pop1.setBackgroundDecorator(new SolidBackground(ASColor.WHITE));
			pop1.setLayout(new FlowLayout());
			pop1.append(new JCheckBox("&CheckBox"));
			pop1.setSizeWH(200, 200);
			pop1.setLocationXY(100, 10);
			
			pop2 = new JPopup();
			pop2.setBackgroundDecorator(new SolidBackground(ASColor.RED));
			pop2.setLayout(new FlowLayout());
			pop2.append(new JButton("Popuped Button"));
			pop2.setSizeWH(200, 200);
			pop2.setLocationXY(200, 10);
			
			pop1.addEventListener(MouseEvent.MOUSE_DOWN, __top1);
			pop1.addEventListener(ReleaseEvent.RELEASE, __top1Released);
			pop2.addEventListener(MouseEvent.MOUSE_DOWN, __top2);
		}
		
		private function __pop1Listener(e:Event):Void{
			pop1.show();
			pop1.getComponent(0).requestFocus();
			//button2.setEnabled(true);
		}
		private function __pop2Listener(e:Event):Void{
			pop2.show();
			pop2.getComponent(0).requestFocus();
			//button2.setEnabled(false);
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