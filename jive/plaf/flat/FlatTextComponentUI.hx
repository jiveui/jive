package jive.plaf.flat;

import org.aswing.graphics.SolidBrush;
import org.aswing.ASColor;
import org.aswing.JTextComponent;
import org.aswing.AsWingUtils;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.Component;
import org.aswing.plaf.basic.BasicTextComponentUI;

/**
 * Flat TextComponent LayoutManager implementation.
 */
class FlatTextComponentUI extends BasicTextComponentUI{
	public function new() { super(); }

    override public function paintFocus(c:Component, g:Graphics2D, b:IntRectangle):Void {
        //Do nothing here. All work is done in the BackgroundDecorator
    }
}