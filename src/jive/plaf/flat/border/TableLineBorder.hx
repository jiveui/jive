package jive.plaf.flat.border;

import org.aswing.plaf.basic.border.LineBorderResource;
import org.aswing.Border;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.IntRectangle;
import org.aswing.Insets;

/**
 * ...
 * @author Nick Grebenshikov
 */
class TableLineBorder extends LineBorderResource {

	public function new(interior:Border = null, color:ASColor = null, thickness:Float = 1, round:Float = 0) {
		super(interior, color, thickness, round);
	}
	
	override public function getBorderInsetsImp(com:Component, bounds:IntRectangle):Insets {
    	return new Insets(0,0,1,0);
	}
}