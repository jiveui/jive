package jive.plaf.flat.accordion;

import org.aswing.JButton;

/**
 * ...
 * @author Nick Grebenshikov
 */

class AccordionHeaderButton extends JButton {

	public var tabPlacement(default, set): Int;
    private function set_tabPlacement(v: Int): Int {
        tabPlacement = v;
        repaint();
        return v;
    }

    public var maxPlacement: Int;
    private function set_maxPlacement(v: Int): Int {
        maxPlacement = v;
        repaint();
        return v;
    }

    public function new() {
		super();
	}
	
	override public function getUIClassID():String{
		return "AccordionHeaderButtonUI";
	}
}