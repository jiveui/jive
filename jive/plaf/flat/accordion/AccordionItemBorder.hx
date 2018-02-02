package jive.plaf.flat.accordion;

import org.aswing.AsWingUtils;
import org.aswing.JAccordion;
import org.aswing.ASColor;
import org.aswing.Border;
import org.aswing.Component;
import org.aswing.Insets;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.geom.IntRectangle;
import flash.display.DisplayObject;
import org.aswing.border.DecorateBorder;

class AccordionItemBorder extends DecorateBorder {
	
	private var color:ASColor;
	private var thickness:Float;
    private var radius: Int;

	/**
	 * Create a line border.
	 * @param interior interior border. Default is null;
	 * @param color the color of the border. Default is null, means ASColor.BLACK
	 * @param thickness the thickness of the border. Default is 1
 	 */
	public function new(interior:Border=null, color:ASColor=null, thickness:Float=1, radius:Int=5)
	{
		super(interior);
		if(color == null) color = ASColor.BLACK;
		
		this.color = color;
		this.thickness = thickness;
		this.radius = radius;
	}
	
	override public function updateBorderImp(com:Component, g:Graphics2D, b:IntRectangle):Void{

        var accordion: JAccordion = AsWingUtils.as(com.parent, JAccordion);
        if (null == accordion) return;

        var itemIndex: Int = accordion.getIndex(com);
        var isLast: Bool = itemIndex == accordion.getComponentCount()-1;
        var isSelected: Bool = itemIndex == accordion.getSelectedIndex();

        var topLeftRadius = 0;
        var topRightRadius = 0;
        var bottomLeftRadius = if (isLast && isSelected) radius else 0;
        var bottomRightRadius = if (isLast && isSelected) radius else 0;

 		g.beginFill(new SolidBrush(color));
		g.roundRect(b.x, b.y, b.width, b.height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius);
		
		var innerTopLeftRadius = topLeftRadius - thickness;
		var innerTopRightRadius = topRightRadius - thickness;
		var innerBottomLeftRadius = bottomLeftRadius - thickness;
		var innerBottomRightRadius = bottomRightRadius - thickness;
		
		g.roundRect(b.x+thickness, b.y+thickness, b.width-thickness*2, b.height-thickness*2, innerTopLeftRadius, innerTopRightRadius, innerBottomLeftRadius, innerBottomRightRadius);
		g.endFill();
  }
	
	override public function getBorderInsetsImp(com:Component, bounds:IntRectangle):Insets
	{
    	var width:Int= Std.int(Math.ceil(thickness + radius - radius*0.707106781186547)); //0.707106781186547 = Math.sin(45 degrees);
    	return new Insets(width, width, width, width);
	}
	
	override public function getDisplayImp():DisplayObject
	{
		return null;
	}    	
}