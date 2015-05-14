package jive.plaf.flat.accordion;

import org.aswing.JButton;

/**
 * ...
 * @author Nick Grebenshikov
 */

class AccordionHeaderButton extends JButton {

	public function new() {
		super();
	}
	
	override public function getUIClassID():String{
		return "AccordionHeaderButtonUI";
	}
}