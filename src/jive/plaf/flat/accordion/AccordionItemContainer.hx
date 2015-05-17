package jive.plaf.flat.accordion;

import jive.plaf.flat.border.ExtendedLineBorder;
import org.aswing.border.EmptyBorder;
import org.aswing.Insets;
import org.aswing.JPanel;
import org.aswing.ASColor;

/**
 * ...
 * @author Nick Grebenshikov
 */
class AccordionItemContainer extends JPanel {
	public function new() {
		super();
		backgroundDecorator = new AccordionItemBackground();
		border = new AccordionItemBorder(new EmptyBorder(null, new Insets(15, 15, 15, 15)), new ASColor(0xbbbbbb), 1, 5);
	}
}