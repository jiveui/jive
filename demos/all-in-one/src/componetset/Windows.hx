package componetset;
	import org.aswing.border.LineBorder;
	import org.aswing.JFrame;
	import org.aswing.JButton;
	import org.aswing.ASColor;
	import org.aswing.KeySequence;
	import org.aswing.border.TitledBorder; 
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.FlowLayout;
	import org.aswing.AsWingUtils;
	import org.aswing.JPopup;
	import flash.events.Event;
	import org.aswing.KeyStroke;
class Windows extends JPanel{
	
	private var popup:JPopup;
	private var frame:JFrame;
	
	public function new(){
		super();
	
		name = "Windows, Keys";
			append(new JLabel("Ctrl+Shift+MnemonicKey to act the button"));
		
		var popButton:JButton = new JButton("Show a simple &Popup");
		var frameButton:JButton = new JButton("Show a &Frame");
			
		super.append(popButton);
		 
		append(frameButton);
		
		
			 
		//TODO modify ComSetSkin yo ComSet when you are deploy ComSet
		popup = new JPopup(this, true);
		var closeButton:JButton = new JButton("Close");
		var cancelbutton:JButton = new JButton("Do nothing");
	
		popup.setLayout(new FlowLayout());
		popup.setBorder(new TitledBorder(null, "Popup, just a simple popup"));
		popup.append(closeButton);
		popup.append(cancelbutton);
	
		popup.setSizeWH(400, 200);
		popup.setLocationXY(100, 100);
			
			closeButton.addActionListener(__closePopup);
		popButton.addActionListener(__showPopup);
		frameButton.addActionListener(__showFrame);
		 
		//TODO modify ComSetSkin yo ComSet when you are deploy ComSet
		frame = new JFrame(AsWingUtils.getPopupAncestor(this), "A Frame");
		frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
		var pane:JPanel = new JPanel();
		pane.append(new JLabel("Default button is close button(Press Enter to act)"));
		var closeButton2:JButton = new JButton("Close");
		closeButton2.addActionListener(__closeFrame);
		pane.append(closeButton2);
		var popupChild:JButton = new JButton("Popup a owned modal Frame(Shift+P)");
		popupChild.addActionListener(__popupChild);
		pane.append(popupChild);
		frame.setContentPane(pane);
		pane.setBorder(new LineBorder(null, ASColor.RED));
		frame.setDefaultButton(closeButton2);
		frame.setComBoundsXYWH(100, 100, 400, 240);
		frame.getKeyboardManager().registerKeyAction(
			new KeySequence([KeyStroke.VK_SHIFT, KeyStroke.VK_P]), 
			__popupChild);
			
	}
	
	private function __showFrame(e:Event):Void{
		frame.changeOwner(AsWingUtils.getPopupAncestor(this));
		frame.show();
	}
	
	private function __closeFrame(e:Event):Void{
		frame.tryToClose();
	}
	
	private function __popupChild(e:Event=null):Void{
		var fr:JFrame = new JFrame(frame, "Modal Frame", true);
		fr.setComBoundsXYWH(150, 150, 150, 80);
		fr.show();
	}
	
	private function __showPopup(e:Event):Void{
		popup.show();
	}
	
	private function __closePopup(e:Event):Void{
		popup.dispose();
	}
}
