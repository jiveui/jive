package cases.color;

import flash.display.Sprite;

import flash.events.Event;

class ColorChooserTest extends Sprite
{

	
	private var infoText:JTextArea;
	private var chooserDialog:JFrame;
	
	public function new(){
		super();
		var frame:JFrame = new JFrame(this, "Choose color");
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);		
		frame.getContentPane().setLayout(new BorderLayout());	
			
		var button:JButton = new JButton("Choose Color");
		button.addActionListener(__openColorChooserDialog);
		
		frame.getContentPane().append(button, BorderLayout.NORTH);
		
		infoText = new JTextArea();
		frame.getContentPane().append(new JScrollPane(infoText), BorderLayout.CENTER);
		
		chooserDialog = JColorChooser.createDialog(new JColorChooser(), frame, "Chooser a color to test", 
			false, __colorSelected, 
			__colorCanceled);
		//center it
		var location:IntPoint = AsWingUtils.getScreenCenterPosition();
		location.x -= chooserDialog.getWidth()/2;
		location.y -= chooserDialog.getHeight()/2;
		chooserDialog.setLocation(location);
		
		frame.setLocationXY(0, 0);
		frame.setSizeWH(400,400);
		frame.show();
	}
	
	private function __openColorChooserDialog(e:Event):Void{
		chooserDialog.show();
	}
	
	private function __colorSelected(color:ASColor):Void{
		infoText.appendText("Selected Color : " + color + "\n");
	}
	private function __colorCanceled():Void{
		infoText.appendText("Selecting canceled!\n");
	}	
	
}