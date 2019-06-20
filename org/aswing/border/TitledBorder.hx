/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.border;

	
import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.aswing.ASFont;
	import org.aswing.ASColor;
	import org.aswing.Border;
	import org.aswing.Component;
	import org.aswing.Insets;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.UIManager;
	/**
 * TitledBorder, a border with a line rectangle and a title text.
 * @author paling
 */	
class TitledBorder extends DecorateBorder {
	public var DEFAULT_LINE_LIGHT_COLOR (get, null):ASColor;

	public var DEFAULT_LINE_COLOR (get, null):ASColor;

	public var DEFAULT_COLOR (get, null):ASColor;

	public var DEFAULT_FONT (get, null):ASFont;	
	
	public   function get_DEFAULT_FONT():ASFont{
		return   UIManager.getFont("systemFont");
	}
	public   function get_DEFAULT_COLOR():ASColor{
		return   UIManager.getColor("controlText");
	}
	public   function get_DEFAULT_LINE_COLOR():ASColor{
		return ASColor.GRAY;
	}
	public   function get_DEFAULT_LINE_LIGHT_COLOR():ASColor{
		return ASColor.WHITE;
	}
	inline public static var DEFAULT_LINE_THICKNESS:Int= 1;
		
	inline public static var TOP:Int= AsWingConstants.TOP;
	inline public static var BOTTOM:Int= AsWingConstants.BOTTOM;
	
	inline public static var CENTER:Int= AsWingConstants.CENTER;
	inline public static var LEFT:Int= AsWingConstants.LEFT;
	inline public static var RIGHT:Int= AsWingConstants.RIGHT;
	

	public var textGap(get, set): Int;
	private var _textGap: Int;
	private function get_textGap(): Int { return _textGap; }
	private function set_textGap(v: Int): Int {
	    _textGap = v;
	    return v;
	}

	public var title(get, set): String;
	private var _title: String;
	private function get_title(): String { return _title; }
	private function set_title(v: String): String {
	    _title = v;
	    return v;
	}

	public var edge(get, set): Float;
	private var _edge: Float;
	private function get_edge(): Float { return _edge; }
	private function set_edge(v: Float): Float {
	    _edge = v;
	    return v;
	}

	public var position(get, set): Int;
	private var _position: Int;
	private function get_position(): Int { return _position; }
	private function set_position(v: Int): Int {
	    _position = v;
	    return v;
	}

	public var align(get, set): Int;
	private var _align: Int;
	private function get_align(): Int { return _align; }
	private function set_align(v: Int): Int {
	    _align = v;
	    return v;
	}

	public var color(get, set): ASColor;
	private var _color: ASColor;
	private function get_color(): ASColor { return _color; }
	private function set_color(v: ASColor): ASColor {
	    _color = v;
	    return v;
	}

	public var round(get, set): Float;
	private var _round: Float;
	private function get_round(): Float { return _round; }
	private function set_round(v: Float): Float {
	    _round = v;
	    return v;
	}

	public var font(get, set): ASFont;
	private var _font: ASFont;
	private function get_font(): ASFont { return _font; }
	private function set_font(v: ASFont): ASFont {
	    _font = v;
	    return v;
	}

	public var lineColor(get, set): ASColor;
	private var _lineColor: ASColor;
	private function get_lineColor(): ASColor { return _lineColor; }
	private function set_lineColor(v: ASColor): ASColor {
	    _lineColor = v;
	    return v;
	}

	public var lineThickness(get, set): Float;
	private var _lineThickness: Float;
	private function get_lineThickness(): Float { return _lineThickness; }
	private function set_lineThickness(v: Float): Float {
	    _lineThickness = v;
	    return v;
	}
	
	public var lineLightColor(get, set): ASColor;
	private var _lineLightColor: ASColor;
	private function get_lineLightColor(): ASColor { return _lineLightColor; }
	private function set_lineLightColor(v: ASColor): ASColor {
	    _lineLightColor = v;
	    return v; 
	}
	
	public var beveled(get, set): Bool;
	private var _beveled: Bool;
	private function get_beveled(): Bool { return _beveled; }
	private function set_beveled(v: Bool): Bool {
	    _beveled = v;
	    return v; 
	}

	private var textField:TextField;
	private var textFieldSize:IntDimension;
	
	/**
	 * Create a titled border.
	 * @param title the title text string.
	 * @param position the position of the title(TOP or BOTTOM), default is TOP
	 * @param align the align of the title(CENTER or LEFT or RIGHT), default is CENTER
	 * @param edge the edge space of title position, defaut is 0.
	 * @param round round rect radius, default is 0 means normal rectangle, not rect.
	 * @see org.aswing.border.SimpleTitledBorder
	 * @see #setColor()
	 * @see #setLineColor()
	 * @see #setFont()
	 * @see #setLineThickness()
	 * @see #setBeveled()
	 */
	public function new(interior:Border=null, title:String="", position:Int=AsWingConstants.TOP, align:Int=CENTER, edge:Float=0, round:Float=0){
		super(interior);
		this.title = title;
		this.position = position;
		this.align = align;
		this.edge = edge;
		this.round = round;

		textGap = 1;
		font = DEFAULT_FONT;
		color = DEFAULT_COLOR;
		lineColor = DEFAULT_LINE_COLOR;
		lineLightColor = DEFAULT_LINE_LIGHT_COLOR;
		lineThickness = DEFAULT_LINE_THICKNESS;
		beveled = true;
		textField = null;
		textFieldSize = null;
	}
	
	private function getTextField():TextField{
    	if(textField == null){
	    	textField = new TextField();
	    	textField.selectable = false;
			#if(flash9 || html5 || cpp)
	    	textField.autoSize = TextFieldAutoSize.LEFT;
			#end
    	}
    	return textField;
	}
	
	override public function updateBorderImp(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
    	var textHeight:Float= Math.ceil(getTextFieldSize().height);
    	var x1:Float= bounds.x + lineThickness*0.5;
    	var y1:Float= bounds.y + lineThickness*0.5;
    	if(position == TOP){
    		y1 += textHeight/2;
    	}
    	var w:Float= bounds.width - lineThickness;
    	var h:Float= bounds.height - lineThickness - textHeight/2;
    	if(beveled)	{
    		w -= lineThickness;
    		h -= lineThickness;
    	}
    	var x2:Float= x1 + w;
    	var y2:Float= y1 + h;
    	
    	var textR:IntRectangle = new IntRectangle();
    	var viewR:IntRectangle = new IntRectangle(bounds.x, bounds.y, bounds.width, bounds.height);
    	var text:String= title;
        var verticalAlignment:Float= position;
        var horizontalAlignment:Float= align;
    	
    	var pen:Pen = new Pen(lineColor, lineThickness);
    	if(round <= 0){
    		if(bounds.width <= edge*2){
    			g.drawRectangle(pen, x1, y1, w, h);
    			if(beveled)	{
    				pen.setColor(lineLightColor);
    				g.beginDraw(pen);
    				g.moveTo(x1+lineThickness, y2-lineThickness);
    				g.lineTo(x1+lineThickness, y1+lineThickness);
    				g.lineTo(x2-lineThickness, y1+lineThickness);
    				g.moveTo(x2+lineThickness, y1);
    				g.lineTo(x2+lineThickness, y2+lineThickness);
    				g.lineTo(x1, y2+lineThickness);
    			}
    			textField.text="";
    		}else{
    			viewR.x += Std.int(edge);
    			viewR.width -= Std.int(edge*2);
    			text = AsWingUtils.layoutText(font, text, verticalAlignment, horizontalAlignment, viewR, textR);
    			//draw dark rect
    			g.beginDraw(pen);
    			if(position == TOP){
	    			g.moveTo(textR.x - textGap, y1);
	    			g.lineTo(x1, y1);
	    			g.lineTo(x1, y2);
	    			g.lineTo(x2, y2);
	    			g.lineTo(x2, y1);
	    			g.lineTo(textR.x + textR.width+textGap, y1);
	    				    			
    			}else{
	    			g.moveTo(textR.x - textGap, y2);
	    			g.lineTo(x1, y2);
	    			g.lineTo(x1, y1);
	    			g.lineTo(x2, y1);
	    			g.lineTo(x2, y2);
	    			g.lineTo(textR.x + textR.width+textGap, y2);
    			}
    			g.endDraw();
    			if(beveled)	{
	    			//draw hightlight
	    			pen.setColor(lineLightColor);
	    			g.beginDraw(pen);
	    			if(position == TOP){
		    			g.moveTo(textR.x - textGap, y1+lineThickness);
		    			g.lineTo(x1+lineThickness, y1+lineThickness);
		    			g.lineTo(x1+lineThickness, y2-lineThickness);
		    			g.moveTo(x1, y2+lineThickness);
		    			g.lineTo(x2+lineThickness, y2+lineThickness);
		    			g.lineTo(x2+lineThickness, y1);
		    			g.moveTo(x2-lineThickness, y1+lineThickness);
		    			g.lineTo(textR.x + textR.width+textGap, y1+lineThickness);
		    				    			
	    			}else{
		    			g.moveTo(textR.x - textGap, y2+lineThickness);
		    			g.lineTo(x1, y2+lineThickness);
		    			g.moveTo(x1+lineThickness, y2-lineThickness);
		    			g.lineTo(x1+lineThickness, y1+lineThickness);
		    			g.lineTo(x2-lineThickness, y1+lineThickness);
		    			g.moveTo(x2+lineThickness, y1);
		    			g.lineTo(x2+lineThickness, y2+lineThickness);
		    			g.lineTo(textR.x + textR.width+textGap, y2+lineThickness);
	    			}
	    			g.endDraw();
    			}
    		}
    	}else{
    		if(bounds.width <= (edge*2 + round*2)){
    			if(beveled)	{
    				g.drawRoundRect(new Pen(lineLightColor, lineThickness), 
    							x1+lineThickness, y1+lineThickness, w, h, 
    							Math.min(round, Math.min(w/2, h/2)));
    			}
    			g.drawRoundRect(pen, x1, y1, w, h, 
    							Math.min(round, Math.min(w/2, h/2)));
    			textField.text="";
    		}else{
    			viewR.x += Std.int(edge+round);
    			viewR.width -= Std.int((edge+round)*2);
    			text = AsWingUtils.layoutText(font, text, verticalAlignment, horizontalAlignment, viewR, textR);
				var r:Float= round;

    			if(beveled)	{
    				pen.setColor(lineLightColor);
	    			g.beginDraw(pen);
	    			var t:Float= lineThickness;
    				x1+=t;
    				x2+=t;
    				y1+=t;
    				y2+=t;
	    			if(position == TOP){
			    		g.moveTo(textR.x - textGap, y1);
						//Top left
						g.lineTo (x1+r, y1);
						g.curveTo(x1, y1, x1, y1+r);
						//Bottom left
						g.lineTo (x1, y2-r );
						g.curveTo(x1, y2, x1+r, y2);
						//bottom right
						g.lineTo(x2-r, y2);
						g.curveTo(x2, y2, x2, y2-r);
						//Top right
						g.lineTo (x2, y1+r);
						g.curveTo(x2, y1, x2-r, y1);
						g.lineTo(textR.x + textR.width+textGap, y1);
	    			}else{
			    		g.moveTo(textR.x + textR.width+textGap, y2);
						//bottom right
						g.lineTo(x2-r, y2);
						g.curveTo(x2, y2, x2, y2-r);
						//Top right
						g.lineTo (x2, y1+r);
						g.curveTo(x2, y1, x2-r, y1);
						//Top left
						g.lineTo (x1+r, y1);
						g.curveTo(x1, y1, x1, y1+r);
						//Bottom left
						g.lineTo (x1, y2-r );
						g.curveTo(x1, y2, x1+r, y2);
						g.lineTo(textR.x - textGap, y2);
	    			}
	    			g.endDraw();  
    				x1-=t;
    				x2-=t;
    				y1-=t;
    				y2-=t;  				
    			}		
    			pen.setColor(lineColor);		
    			g.beginDraw(pen);
    			if(position == TOP){
		    		g.moveTo(textR.x - textGap, y1);
					//Top left
					g.lineTo (x1+r, y1);
					g.curveTo(x1, y1, x1, y1+r);
					//Bottom left
					g.lineTo (x1, y2-r );
					g.curveTo(x1, y2, x1+r, y2);
					//bottom right
					g.lineTo(x2-r, y2);
					g.curveTo(x2, y2, x2, y2-r);
					//Top right
					g.lineTo (x2, y1+r);
					g.curveTo(x2, y1, x2-r, y1);
					g.lineTo(textR.x + textR.width+textGap, y1);
    			}else{
		    		g.moveTo(textR.x + textR.width+textGap, y2);
					//bottom right
					g.lineTo(x2-r, y2);
					g.curveTo(x2, y2, x2, y2-r);
					//Top right
					g.lineTo (x2, y1+r);
					g.curveTo(x2, y1, x2-r, y1);
					//Top left
					g.lineTo (x1+r, y1);
					g.curveTo(x1, y1, x1, y1+r);
					//Bottom left
					g.lineTo (x1, y2-r );
					g.curveTo(x1, y2, x1+r, y2);
					g.lineTo(textR.x - textGap, y2);
    			}
    			g.endDraw();
    		}
    	}
    	textField.text = text;
		AsWingUtils.applyTextFontAndColor(textField, font, color);
    	textField.x = textR.x;
    	textField.y = textR.y;   	
    }
    	   
   override public function getBorderInsetsImp(c:Component, bounds:IntRectangle):Insets{
    	var cornerW:Float= Math.ceil(lineThickness*2 + round - round*0.707106781186547);
    	var insets:Insets = new Insets(Std.int(cornerW), Std.int(cornerW), Std.int(cornerW), Std.int(cornerW));
    	if(position == BOTTOM){
    		insets.bottom += Math.ceil(getTextFieldSize().height);
    	}else{
    		insets.top += Math.ceil(getTextFieldSize().height);
    	}
    	return insets;
    }
	
	override public function getDisplayImp():DisplayObject
	{
		return getTextField();
	}		
	
	//-----------------------------------------------------------------

	public function getFont():ASFont {
		return font;
	}

	public function setFont(font:ASFont):Void{
		if(this.font != font){
			if(font == null) font = DEFAULT_FONT;
			this.font = font;
			textFieldSize == null;
		}
	}

	public function getLineColor():ASColor {
		return lineColor;
	}

	public function setLineColor(lineColor:ASColor):Void{
		if (lineColor != null){
			this.lineColor = lineColor;
		}
	}
	
	public function getLineLightColor():ASColor{
		return lineLightColor;
	}
	
	public function setLineLightColor(lineLightColor:ASColor):Void{
		if (lineLightColor != null){
			this.lineLightColor = lineLightColor;
		}
	}
	
	public function isBeveled():Bool{
		return beveled;
	}
	
	public function setBeveled(b:Bool):Void{
		beveled = b;
	}

	public function getEdge():Float{
		return edge;
	}

	public function setEdge(edge:Float):Void{
		this.edge = edge;
	}

	public function getTitle():String{
		return title;
	}

	public function setTitle(title:String):Void{
		if(this.title != title){
			this.title = title;
			textFieldSize == null;
		}
	}

	public function getRound():Float{
		return round;
	}

	public function setRound(round:Float):Void{
		this.round = round;
	}

	public function getColor():ASColor {
		return color;
	}

	public function setColor(color:ASColor):Void{
		this.color = color;
	}

	public function getAlign():Int{
		return align;
	}
	
	/**
	 * Sets the align of title text.
	 * @see #CENTER
	 * @see #LEFT
	 * @see #RIGHT
	 */
	public function setAlign(align:Int):Void{
		this.align = align;
	}

	public function getPosition():Int{
		return position;
	}
	
	/**
	 * Sets the position of title text.
	 * @see #TOP
	 * @see #BOTTOM
	 */
	public function setPosition(position:Int):Void{
		this.position = position;
	}	
	
	public function getLineThickness():Int{
		return Std.int(lineThickness);
	}

	public function setLineThickness(lineThickness:Float):Void{
		this.lineThickness = lineThickness;
	}
		
	private function getTextFieldSize():IntDimension{
    	if (textFieldSize == null){
			textFieldSize = getFont().computeTextSize(title);  	
    	}
    	return textFieldSize;
	}


}