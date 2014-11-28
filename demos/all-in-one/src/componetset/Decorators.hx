package componetset;

import flash.display.Loader;
import flash.net.URLRequest;
import org.aswing.border.SideLineBorder;
	import org.aswing.border.LineBorder;
	import org.aswing.CenterLayout;
	import org.aswing.Box;
	import org.aswing.border.EmptyBorder;
	import org.aswing.SoftBox;
	import org.aswing.JRadioButton;
	import org.aswing.ASColor;
	import org.aswing.border.TitledBorder;
	import org.aswing.BorderLayout;
	import org.aswing.AsWingConstants;
	import org.aswing.JLabel;
	import org.aswing.GradientBackground;
	import org.aswing.ButtonGroup;
	import org.aswing.JPanel;
	import org.aswing.AssetBackground;
	import org.aswing.border.BevelBorder;
	import flash.display.GradientType;
	import org.aswing.Insets;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.SolidBackground;
	import org.aswing.graphics.GradientBrush;
	import org.aswing.AsWingUtils;
	import flash.display.Bitmap;
	import flash.events.Event;
class Decorators extends JPanel{
	
	private var thePane:JPanel;
	
	private var titleBorder:JRadioButton;
	private var bevelBorder:JRadioButton;
	private var lineBorder:JRadioButton;
	private var emptyBorder:JRadioButton;
	private var sideLineBorder:JRadioButton;
	private var noBorder:JRadioButton;
	
	private var solidBg:JRadioButton;
	private var gradientBg:JRadioButton;
	private var pictureBg:JRadioButton;
	private var noBg:JRadioButton;
	private var imgClass:Loader; 
	public function new(){
		super(new BorderLayout(5, 5));
		name = "Decorators";
		this.addEventListener( Event.ADDED_TO_STAGE, __init);
	}
	private function __init(e:Event):Void
	{
		this.removeEventListener( Event.ADDED_TO_STAGE, __init);
		thePane = new JPanel();
		thePane.setOpaque(true);
		thePane.setLayout(new CenterLayout());
		thePane.append(new JLabel("Decorated Panel"));
		append(thePane, BorderLayout.CENTER);
		
		var top:Box = Box.createHorizontalBox(2);
		append(top, BorderLayout.NORTH);
		
		var borders:SoftBox = SoftBox.createVerticalBox(2);
		borders.setBorder(new TitledBorder(null, "Border Set", TitledBorder.BOTTOM));
		titleBorder = new JRadioButton("Title Border");
		bevelBorder = new JRadioButton("Bevel Border");
		lineBorder = new JRadioButton("Line Border");
		sideLineBorder = new JRadioButton("Side Line Border");
		emptyBorder = new JRadioButton("Empty Border");
		noBorder = new JRadioButton("No Border");
		borders.append(titleBorder);
		borders.append(bevelBorder);
		borders.append(lineBorder);
		borders.append(sideLineBorder);
		borders.append(emptyBorder);
		borders.append(noBorder);
		var group:ButtonGroup = new ButtonGroup();
		group.append(titleBorder);
		group.append(bevelBorder);
		group.append(lineBorder);
		group.append(sideLineBorder);
		group.append(emptyBorder);
		group.append(noBorder);
		top.append(borders);
		
		var bgs:SoftBox = SoftBox.createVerticalBox(2);
		bgs.setBorder(new TitledBorder(null, "Background Set", TitledBorder.BOTTOM));
		solidBg = new JRadioButton("Solid Background");
		gradientBg = new JRadioButton("Gradient Background");
		pictureBg = new JRadioButton("Picture Background");
		noBg = new JRadioButton("No Background");
		bgs.append(solidBg);
		bgs.append(gradientBg);
		bgs.append(pictureBg);
		bgs.append(noBg);
		group = new ButtonGroup();
		group.append(solidBg);
		group.append(gradientBg);
		group.append(pictureBg);
		group.append(noBg);
		top.append(bgs);
		
		doListen(titleBorder);
		doListen(bevelBorder);
		doListen(lineBorder);
		doListen(sideLineBorder);
		doListen(emptyBorder);
		doListen(noBorder);
		
		doListen(solidBg);
		doListen(gradientBg);
		doListen(pictureBg);
		doListen(noBg);
		imgClass = new Loader();
		imgClass.load(new URLRequest("princess.jpg")); 
	}
	
	private function doListen(radio:JRadioButton):Void{
		radio.addSelectionListener(__selectionChanged);
		radio.setHorizontalAlignment(AsWingConstants.LEFT); 
	}
	 
	
	private function __selectionChanged(e:InteractiveEvent):Void{
		var target:JRadioButton = cast(e.target,JRadioButton)	;
		if(!target.isSelected()){
			return;
		}
		if(target == titleBorder){
			thePane.setBorder(new TitledBorder(null, "Title Border"));
		}else if(target == lineBorder){
			thePane.setBorder(new LineBorder(null, ASColor.RED, 1));
		}else if(target == bevelBorder){
			thePane.setBorder(new BevelBorder());
		}else if(target == sideLineBorder){
			thePane.setBorder(new SideLineBorder(null, SideLineBorder.EAST));
		}else if(target == emptyBorder){
			thePane.setBorder(new EmptyBorder(null, new Insets(5, 5, 5, 5)));
		}else if(target == noBorder){
			thePane.setBorder(null);
		}else if(target == solidBg){
			thePane.setBackgroundDecorator(new SolidBackground(ASColor.GREEN));
			thePane.repaint();
		}else if(target == gradientBg){
	        var colors:Array<Int>= [0xFFFFFF, 0xEE8844];
			var alphas:Array<Dynamic>= [1, 1];
			var ratios:Array<Dynamic>= [0, 255];
			thePane.setBackgroundDecorator(new GradientBackground(
				GradientBrush.LINEAR, 
				colors, 
				alphas, 
				ratios,
				Math.PI/2));
			thePane.repaint();
		}else if (target == pictureBg) {
			var bmp:Bitmap  = untyped imgClass.content;	
			thePane.setBackgroundDecorator(new AssetBackground(bmp));
			thePane.repaint();
		}else{
			thePane.setBackgroundDecorator(null);
			thePane.repaint();
		}
	}
}