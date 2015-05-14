package jive.plaf.flat.accordion;

import flash.text.TextFormat;
import org.aswing.AbstractButton;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.basic.BasicButtonUI;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
/**
 * ...
 * @author Nick Grebenshikov
 */

class AccordionHeaderButtonUI extends BasicButtonUI {
	public function new() {
		super();
	}
	
	private override function getPropertyPrefix():String{
        return "AccordionHeaderButton.";
    }
	
	override private function paintIcon(b:AbstractButton, g:Graphics2D, iconRect:IntRectangle):Void 
	{
		if (b.isSelected()) {
			iconRect.y+=2;
		}
		super.paintIcon(b, g, iconRect);
	}

}