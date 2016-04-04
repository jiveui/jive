package cases;

import flash.display.Sprite;
import org.aswing.event.InteractiveEvent;

class Slider extends Sprite
{
	private var frame:JFrame;
	private var hSlider:JSlider;
	private var vSlider:JSlider;
	private var valueLabel:JLabel;	
	private var slider3:JSlider;
	
	public function new()
	{
		super();
		doSliderTest();
	}
	
	public function doSliderTest():Void{
		frame = new JFrame(null, "ForJSlider");
		valueLabel = new JLabel("slider value");
		hSlider = new JSlider(JSlider.HORIZONTAL);
		vSlider = new JSlider(JSlider.VERTICAL);
		
		vSlider.setMajorTickSpacing(50);
		vSlider.setMinorTickSpacing(10);
		vSlider.setSnapToTicks(true);
		vSlider.setPaintTicks(true);
		vSlider.setPaintTrack(false);
		vSlider.setShowValueTip(true);
		
		hSlider.setEnabled(false);
		//vSlider.setInverted(true);
		hSlider.setPaintTrack(true);
		hSlider.setPaintTicks(false);
		hSlider.setMajorTickSpacing(25);
		hSlider.setMinorTickSpacing(5);
		//hSlider.setEnabled(false);
		
		frame.getContentPane().append(hSlider, BorderLayout.CENTER);
		frame.getContentPane().append(vSlider, BorderLayout.EAST);
		hSlider.setExtent(50);
		hSlider.setSnapToTicks(true);
		
		slider3 = new JSlider(JSlider.HORIZONTAL);
		slider3.setShowValueTip(true);
		slider3.setValues(0, 0, 0, 100);
		slider3.setToolTipText("This Slider has a value tip!");
		slider3.setPaintTicks(true);
		slider3.setPaintTrack(true);
		slider3.setMajorTickSpacing(25);
		slider3.setMinorTickSpacing(5);
		//slider3.setInverted(true);
		frame.getContentPane().append(slider3, BorderLayout.SOUTH);
		frame.getContentPane().append(valueLabel, BorderLayout.NORTH);
		
		//hSlider.addStateListener(__valueChanged);
		vSlider.addStateListener(__valueChanged);
		slider3.addStateListener(__valueChanged);
		
		frame.setComBoundsXYWH(0, 0, 400, 300);
		frame.setVisible(true);
	}
	
	private function __valueChanged(e:InteractiveEvent):Void{
		var slider:JSlider = flash.Lib.as(e.target,JSlider)	;
		valueLabel.setText(slider.getValue()+"");
		vSlider.setValue(slider.getValue());
		//slider3.setValue(slider.getValue());
	}
}