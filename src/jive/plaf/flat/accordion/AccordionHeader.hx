package jive.plaf.flat.accordion;

import org.aswing.AbstractButton;
import org.aswing.AssetIcon;
import org.aswing.AsWingConstants;
import org.aswing.border.EmptyBorder;
import org.aswing.Icon;
import org.aswing.Insets;
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
		b.setBorder(new EmptyBorder(null, new Insets(5, 0, 0, 0)));
		return b;
	}
	
	override public function setSelected(b:Bool):Void{
		button.setSelected(b);
		if (b) {
			button.setBorder(new EmptyBorder(null, new Insets(4, 0, -1, 0)));
			button.setIcon(new AssetIcon(openfl.Assets.getMovieClip("icons/arrow-icon-opened.swf:")));
			
		} else {
			button.setBorder(new EmptyBorder(null, new Insets(5, 0, 0, 0)));
			button.setIcon(new AssetIcon(openfl.Assets.getMovieClip("icons/arrow-icon-closed.swf:")));
		}
	}
	
	override public function setHorizontalAlignment(alignment:Int):Void{
		//always left
    }
	
	override public function setTextAndIcon(text:String, icon:Icon):Void 
	{
		button.setText(text);
	}
	
}