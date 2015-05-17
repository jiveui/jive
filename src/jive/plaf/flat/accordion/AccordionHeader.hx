package jive.plaf.flat.accordion;

import org.aswing.AsWingUtils;
import org.aswing.ASColor;
import jive.plaf.flat.icon.ExpandIcon;
import org.aswing.AbstractButton;
import org.aswing.AsWingConstants;
import org.aswing.Icon;
import org.aswing.plaf.basic.accordion.BasicAccordionHeader;

/**
 * ...
 * @author Nick Grebenshikov
 */

class AccordionHeader extends BasicAccordionHeader {

	public function new() {
		super();
	}
	
	override private function createHeaderButton():AbstractButton {
		var b:AbstractButton = new AccordionHeaderButton();
		b.setHorizontalAlignment(AsWingConstants.LEFT);
        b.setIcon(new ExpandIcon(8, new ASColor(0xcccccc), false));
		return b;
	}
	
	override public function setSelected(b:Bool):Void{
		if (button.selected == b) return;
        button.setSelected(b);
		if (b) {
			button.setIcon(new ExpandIcon(8, new ASColor(0xcccccc), true));
		} else {
			button.setIcon(new ExpandIcon(8, new ASColor(0xcccccc), false));
		}
	}
	
	override public function setHorizontalAlignment(alignment:Int):Void{
		//always left
    }
	
	override public function setTextAndIcon(text:String, icon:Icon):Void 
	{
		button.setText(text);
	}

    override public function setTabPlacement(tp:Int):Void{
        super.setTabPlacement(tp);
        var b: AccordionHeaderButton = AsWingUtils.as(button, AccordionHeaderButton);
        b.tabPlacement = tp;
    }

    override private function set_maxPlacement(v: Int): Int {
        maxPlacement = v;
        var b: AccordionHeaderButton = AsWingUtils.as(button, AccordionHeaderButton);
        b.maxPlacement = v;
        return v;
    }
	
}