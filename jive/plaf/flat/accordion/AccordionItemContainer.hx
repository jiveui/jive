package jive.plaf.flat.accordion;

import org.aswing.UIManager;
import org.aswing.BorderLayout;
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
        setLayout(new BorderLayout());
		backgroundDecorator = new AccordionItemBackground();
		border = new AccordionItemBorder(new EmptyBorder(null, Insets.createIdentic(Std.int(UIManager.get("margin")/4))), new ASColor(0xbbbbbb), 1, UIManager.get("cornerSize"));
	}
}