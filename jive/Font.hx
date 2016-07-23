/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive;


import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;

import jive.geom.IntDimension;
import jive.tools.TypeTools;
import jive.tools.TextTools;

/**
 * Font that specified the font name, size, style and whether or not embed.
 *
 * Author paling, ngrebenshikov
 */
class Font {
	
 	public var family: String;

    public var name(default, set):String;
	private function set_name(v: String): String {

		#if flash
			if (Assets.exists(v, AssetType.FONT)) v = Assets.getFont(v).fontName;
        #elseif html5
            #if !openfl_snapsvg
            if (Assets.exists(v, AssetType.FONT)) v = Assets.getFont(v).fontName;
            #end
		#end

//        #if iphone
//        #if nme
//        if (Assets.hFont(v)) {
//        #else
//        if (Assets.exists(v, AssetType.FONT)) {
//        #end
//            var font = Assets.getFont(v);
//            var details = Font.load(font.fontName);
//            if (null != details) {
//                trace(details);
//                family = details.family_name;
//            } else {
//                family = v;
//            }
//            v = font.fontName;
//        }
//        #else
        family = v;
//        #end

        // TODO: get rid of the hack
        // Hack
        #if iphone
        if (v.indexOf("PTS") >= 0) {
            family = "PT Sans";
        }
        #end

		name = v; textFormat = getTextFormat(); return v;
	}

 	public var size(default, set):Int;
	private function set_size(v: Int): Int {
		size = v; textFormat = getTextFormat(); return v;
	}

 	public var bold(default, set):Bool;
	private function set_bold(v: Bool): Bool {
		bold = v; textFormat = getTextFormat(); return v;
	}

 	public var italic(default, set):Bool;
	private function set_italic(v: Bool): Bool {
		italic = v; textFormat = getTextFormat(); return v;
	}

	public var underline(default, set):Bool;
	private function set_underline(v: Bool): Bool {
		underline = v; textFormat = getTextFormat(); return v;
	}

	private var textFormat:TextFormat;
 	private var advancedProperties:FontAdvProperties;

 	
	/**
	* Create a font.
	*
	* @see FontAdvProperties
	*
	* @param embedFontsOrAdvancedPros a boolean to indicate whether or not embedFonts or a `FontAdvProperties` instance.
	*/
	public function new(name:String="Tahoma", size:Float=11, bold:Bool=false, italic:Bool=false, underline:Bool=false, 
		embedFontsOrAdvancedPros:Dynamic=null, family=null){
		this.name = name;
		this.size = Std.int(size);
		this.bold = bold;
		this.italic = italic;
		this.underline = underline;
		if(Std.is(embedFontsOrAdvancedPros,FontAdvProperties)){
			advancedProperties = TypeTools.as(embedFontsOrAdvancedPros, FontAdvProperties);
		
		}else{
			advancedProperties = new FontAdvProperties(embedFontsOrAdvancedPros==true);
		}
		textFormat = getTextFormat();
	}
	
	@:dox(hide)
	@:deprecated
	public function getName():String{
		return name;
	}

	/**
	* Clones a font with the different name property
	**/
	public function changeName(name:String):Font{
		return new Font(name, size, bold, italic, underline, advancedProperties);
	}

	@:dox(hide)
	@:deprecated
	public function getSize():Int{
		return size;
	}

	/**
	* Clones a font with the different size property
	**/
	public function changeSize(size:Int):Font{
		return new Font(name, size, bold, italic, underline, advancedProperties);
	}

	@:dox(hide)
	@:deprecated
	public function isBold():Bool{
		return bold;
	}

	/**
	* Clones a font with the different bold property
	**/
	public function changeBold(bold:Bool):Font{
		return new Font(name, size, bold, italic, underline, advancedProperties);
	}

	@:dox(hide)
	@:deprecated
	public function isItalic():Bool{
		return italic;
	}

	/**
	* Clones a font with the different italic property
	**/
	public function changeItalic(italic:Bool):Font{
		return new Font(name, size, bold, italic, underline, advancedProperties);
	}

	@:dox(hide)
	public function isUnderline():Bool{
		return underline;
	}

	/**
	* Clones a font with the different underline property
	**/
	public function changeUnderline(underline:Bool):Font{
		return new Font(name, size, bold, italic, underline, advancedProperties);
	}
	
	public function isEmbedFonts():Bool{
		return advancedProperties.isEmbedFonts();
	}
	
	public function getAdvancedProperties():FontAdvProperties{
		return advancedProperties;
	}
	
	/**
	 * Applys the font to the specified text field.
	 *
	 * @param textField the text filed to be applied font.
	 * @param beginIndex The zero-based index position specifying the first character of the desired range of text. 
	 * @param endIndex The zero-based index position specifying the last character of the desired range of text. 
	 */
	public function apply(textField:TextField, beginIndex:Int=-1, endIndex:Int=-1):Void{
		advancedProperties.apply(textField);
		#if(flash9 || cpp || html5)
            textField.setTextFormat(textFormat, beginIndex, endIndex);
        	textField.defaultTextFormat = textFormat;
	    #end
	}
	
	/**
	 * Creates a text format that contains the font properties.
	 *
	 * @return a text format.
	 */
	public function getTextFormat():TextFormat {
		return new TextFormat(
			name, size, null, bold, italic, underline,
			"", "", TextFormatAlign.LEFT, 0, 0, 0, 0);
	}
	
	/**
	 * Computes text size with this font.
	 *
	 * @see AsWingUtils.computeStringSizeWithFont
	 *
	 * @param text the text to be compute
	 * @param includeGutters whether or not include the 2-pixels gutters in the result
	 * @return the computed size of the text
	 */
	public function computeTextSize(text:String, includeGutters:Bool = true):IntDimension {
		return TextTools.computeStringSizeWithFont(this, text, includeGutters);
	}
	
	/**
	 * Clone a Font, most time you dont need to call this but to avoid UIResource, you can call this.
	 */
	public function clone():Font{
		return new Font(name, size, bold, italic, underline, advancedProperties);
	}	
	
	public function toString():String{
		return "Font[" 
			+ "name : " + name 
			+ ", size : " + size 
			+ ", bold : " + bold 
			+ ", italic : " + italic 
			+ ", underline : " + underline 
			+ ", advanced : " + advancedProperties 
			+ "]";
	}
}