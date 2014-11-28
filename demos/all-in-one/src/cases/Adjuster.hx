package cases;

import flash.display.Sprite;
import flash.events.Event;

class Adjuster extends Sprite
{
	public function new()
	{
		super();
		testAdjuster();
	}

	private var adjuster1:JAdjuster;
	private var adjuster2:JAdjuster;
	private var adjuster3:JAdjuster;
	private var frame:JFrame;
	
	public function testAdjuster():Void{
		frame = new JFrame(null, "AdjusterTest");
		
		var p:JPanel = new JPanel();
		adjuster1 = new JAdjuster(4);
		adjuster1.setName("adjuster1");
		//adjuster1.setValues(1250, 0, 1250, 1350);
		adjuster1.setMaximum(1350);
		adjuster1.setMinimum(1250);		
		adjuster2 = new JAdjuster(5);
		adjuster2.setName("adjuster2");
		adjuster3 = new JAdjuster(6);
		adjuster3.setName("adjuster3");
		adjuster3.setOrientation(JAdjuster.HORIZONTAL);
		
		adjuster2.setValueTranslator(
			function(value:Int):String{
				return Math.round(value) + "%";
			}
		);
		
		adjuster3.setValueTranslator(
			function(value:Int):String{
				return Math.round(value) + " cm";
			}
		);
		
		p.append(adjuster1);
		p.append(adjuster2);
		p.append(adjuster3);
		
		frame.getContentPane().append(p, BorderLayout.EAST);
		
		frame.setSizeWH(400, 250);
		frame.show();
		
		adjuster1.addActionListener(__handler);
		adjuster2.addActionListener(__handler);
		adjuster3.addActionListener(__handler);
		adjuster1.addStateListener(__handler);
		adjuster2.addStateListener(__handler);
		adjuster3.addStateListener(__handler);
	}
	
	private function __handler(e:Event):Void{
		var ad:JAdjuster = flash.Lib.as(e.target,JAdjuster)	;
		trace(ad.getName() + " " + e.type + " handled : " + ad.getValue());
	}
}