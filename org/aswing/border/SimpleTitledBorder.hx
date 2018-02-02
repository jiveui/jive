/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.border;

	
/**
 * A poor Title Border.
 * @author paling
 */
import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import org.aswing.ASFont;
	import org.aswing.ASColor;
	import org.aswing.Border;
	import org.aswing.Component;
	import org.aswing.Insets;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;

class SimpleTitledBorder extends DecorateBorder
{
	
	inline public static var TOP:Int= AsWingConstants.TOP;
	inline public static var BOTTOM:Int= AsWingConstants.BOTTOM;
	
	inline public static var CENTER:Int= AsWingConstants.CENTER;
	inline public static var LEFT:Int= AsWingConstants.LEFT;
	inline public static var RIGHT:Int= AsWingConstants.RIGHT;
	

    // Space between the border and the component's edge
    inline public static var EDGE_SPACING:Int= 0;	
	
	private var title:String;
	private var position:Int;
	private var align:Int;
	private var offset:Int;
	private var font:ASFont;
	private var color:ASColor;
	
	private var textField:TextField;
	private var textFieldSize:IntDimension;
	private var colorFontValid:Bool;
	
	/**
	 * Create a simple titled border.
	 * @param title the title text string.
	 * @param position the position of the title(TOP or BOTTOM), default is TOP
	 * @see #TOP
	 * @see #BOTTOM
	 * @param align the align of the title(CENTER or LEFT or RIGHT), default is CENTER
	 * @see #CENTER
	 * @see #LEFT
	 * @see #RIGHT
	 * @param offset the addition of title text's x position, default is 0
	 * @param font the title text's ASFont
	 * @param color the color of the title text
	 * @see org.aswing.border.TitledBorder
	 */
	public function new(interior:Border=null, title:String="", position:Int=AsWingConstants.TOP, align:Int=CENTER, offset:Int=0, font:ASFont=null, color:ASColor=null){
		super(interior);
		this.title = title;
		this.position = position;
		this.align = align;
		this.offset = offset;
		this.font = (font==null ? UIManager.getFont("systemFont") : font);
		this.color = (color==null ? UIManager.getColor("controlText") : color);
		textField = null;
		colorFontValid = false;
		textFieldSize = null;
	}
	
	
	//------------get set-------------
	
		
	public function getPosition():Int{
		return position;
	}

	public function setPosition(position:Int):Void{
		this.position = position;
	}

	public function getColor():ASColor {
		return color;
	}

	public function setColor(color:ASColor):Void{
		this.color = color;
		this.invalidateColorFont();
	}

	public function getFont():ASFont {
		return font;
	}

	public function setFont(font:ASFont):Void{
		this.font = font;
		invalidateColorFont();
		invalidateExtent();
	}

	public function getAlign():Int{
		return align;
	}

	public function setAlign(align:Int):Void{
		this.align = align;
	}

	public function getTitle():String{
		return title;
	}

	public function setTitle(title:String):Void{
		this.title = title;
		this.invalidateExtent();
		this.invalidateColorFont();
	}

	public function getOffset():Int{
		return offset;
	}

	public function setOffset(offset:Int):Void{
		this.offset = offset;
	}
	
	private function invalidateExtent():Void{
		textFieldSize = null;
	}
	private function invalidateColorFont():Void{
		colorFontValid = false;
	}
	
	private function getTextFieldSize():IntDimension{
    	if (textFieldSize == null){
	    	var tf:TextFormat = getFont().getTextFormat();
			textFieldSize = AsWingUtils.computeStringSize(tf, title);   	
    	}
    	return textFieldSize;
	}
	
	private function getTextField():TextField{
    	if(textField == null){
	    	textField = new TextField();
	    	textField.selectable = false;
	    	//textField.autoSize = TextFieldAutoSize.CENTER;	    	 
    	}
    	return textField;
	}
	
	override public function updateBorderImp(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
    	if(colorFontValid!=true){
    		textField.text = title;
    		AsWingUtils.applyTextFontAndColor(textField, font, color);
    		colorFontValid = true;
    	}
    	
    	var width:Int= Math.ceil(textField.width);
    	var height:Int= Math.ceil(textField.height);
    	var x:Int= offset;
    	if(align == LEFT){
    		x += bounds.x;
    	}else if(align == RIGHT){
    		x += (bounds.x + bounds.width - width);
    	}else{
    		x += Std.int(bounds.x + bounds.width/2 - width/2);
    	}
    	var y:Int= bounds.y + EDGE_SPACING;
    	if(position == BOTTOM){
    		y = bounds.y + bounds.height - height + EDGE_SPACING;
    	}
    	textField.x = x;
    	textField.y = y;
    }
    	   
    override public function getBorderInsetsImp(c:Component, bounds:IntRectangle):Insets{
    	var insets:Insets = new Insets();
    	var cs:IntDimension = bounds.getSize();
		if(cs.width < getTextFieldSize().width){
			var delta:Int= Math.ceil(getTextFieldSize().width) - cs.width;
			if(align == RIGHT){
				insets.left = delta;
			}else if(align == CENTER){
				insets.left = Std.int(delta/2);
				insets.right = Std.int(delta/2);
			}else{
				insets.right = delta;
			}
		}
    	if(position == BOTTOM){
    		insets.bottom = EDGE_SPACING*2 + Math.ceil(getTextFieldSize().height);
    	}else{
    		insets.top = EDGE_SPACING*2 + Math.ceil(getTextFieldSize().height);
    	}
    	return insets;
    }
	
	override public function getDisplayImp():DisplayObject
	{
		return getTextField();
	}	
}