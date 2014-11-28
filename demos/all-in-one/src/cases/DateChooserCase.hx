package cases;


import flash.display.Sprite;

import org.aswing.Insets;
import org.aswing.JFrame;
import org.aswing.border.EmptyBorder;
import org.aswing.event.InteractiveEvent;
import org.aswing.ext.DateChooser;
import org.aswing.ext.DateRange;
import org.aswing.util.DateAs;

/**
 * @author iiley (Burstyx Studio)
 */
class DateChooserCase extends Sprite{
	private var chooser:DateChooser;
	public function new(){
		super();
		
		var frame:JFrame = new JFrame(this, "Date Chooser");
		chooser = new DateChooser();
		chooser.setDisabledDays([0, 6]);
		chooser.setAllowMultipleSelection(true);
		chooser.setBorder(new EmptyBorder(null, new Insets(4)));
		chooser.setDisabledRanges([
			new DateRange(new DateAs(2011, 2, 15,0,0,0), new DateAs(2011, 2, 25,0,0,0)), 
			DateRange.singleDay(new DateAs(1970,1,1,0,0,0))]);
		frame.setContentPane(chooser);
		frame.pack();
		frame.show();
		
		chooser.addEventListener(InteractiveEvent.SELECTION_CHANGED, __selection);
	}
	
	private function __selection(e:InteractiveEvent):Void{
		
		var str:String= "";
		if(e.isProgrammatic()){
			str += "---Programmatic";
		}else{
			str += "+++";
		}
		trace(str + " : " + chooser.getSelectedDates());
	}
}
