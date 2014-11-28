/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import org.aswing.geom.IntDimension;

/**
 * Font that specified the font name, size, style and whether or not embed.
 * @author paling
 */
class ASFont{
	
 	private var name:String;
 	private var size:Int;
 	private var bold:Bool;
 	private var italic:Bool;
 	private var underline:Bool;
 	private var textFormat:TextFormat;
 	
 	private var advancedProperties:ASFontAdvProperties;
 	
 	/**
 	 * Create a font.
 	 * @param embedFontsOrAdvancedPros a boolean to indicate whether or not embedFonts or 
 	 * 			a <code>ASFontAdvProperties</code> instance.
 	 * @see org.aswing.ASFontAdvProperties
 	 */
	public function new(name:String="Tahoma", size:Float=11, bold:Bool=false, italic:Bool=false, underline:Bool=false, 
		embedFontsOrAdvancedPros:Dynamic=null){
		this.name = name;
		this.size = Std.int(size);
		this.bold = bold;
		this.italic = italic;
		this.underline = underline;
		if(Std.is(embedFontsOrAdvancedPros,ASFontAdvProperties)){
			advancedProperties = AsWingUtils.as(embedFontsOrAdvancedPros, ASFontAdvProperties)	;
		
		}else{
			advancedProperties = new ASFontAdvProperties(embedFontsOrAdvancedPros==true);
		}
		textFormat = getTextFormat();
	}
	
	public function getName():String{
		return name;
	}
	
	public function changeName(name:String):ASFont{
		return new ASFont(name, size, bold, italic, underline, advancedProperties);
	}
	
	public function getSize():Int{
		return size;
	}
	
	public function changeSize(size:Int):ASFont{
		return new ASFont(name, size, bold, italic, underline, advancedProperties);
	}
	
	public function isBold():Bool{
		return bold;
	}
	
	public function changeBold(bold:Bool):ASFont{
		return new ASFont(name, size, bold, italic, underline, advancedProperties);
	}
	
	public function isItalic():Bool{
		return italic;
	}
	
	public function changeItalic(italic:Bool):ASFont{
		return new ASFont(name, size, bold, italic, underline, advancedProperties);
	}
	
	public function isUnderline():Bool{
		return underline;
	}
	
	public function changeUnderline(underline:Bool):ASFont{
		return new ASFont(name, size, bold, italic, underline, advancedProperties);
	}
	
	public function isEmbedFonts():Bool{
		return advancedProperties.isEmbedFonts();
	}
	
	public function getAdvancedProperties():ASFontAdvProperties{
		return advancedProperties;
	}
	
	/**
	 * Applys the font to the specified text field.
	 * @param textField the text filed to be applied font.
	 * @param beginIndex The zero-based index position specifying the first character of the desired range of text. 
	 * @param endIndex The zero-based index position specifying the last character of the desired range of text. 
	 */
	public function apply(textField:TextField, beginIndex:Int=-1, endIndex:Int=-1):Void{
		//why
		advancedProperties.apply(textField);
		#if(flash9 || cpp || html5)
    		textField.setTextFormat(textFormat, beginIndex, endIndex);
	    	textField.defaultTextFormat = textFormat;
	    #end
	}
	
	/**
	 * Return a new text format that contains the font properties.
	 * @return a new text format.
	 */
	public function getTextFormat():TextFormat{
		return new TextFormat(
			name, size, null, bold, italic, underline, 
			"", "", TextFormatAlign.LEFT, 0, 0, 0, 0 
			);
	}
	
	/**
	 * Computes text size with this font.
	 * @param text the text to be compute
	 * @includeGutters whether or not include the 2-pixels gutters in the result
	 * @return the computed size of the text
	 * @see org.aswing.AsWingUtils#computeStringSizeWithFont
	 */
	public function computeTextSize(text:String, includeGutters:Bool = true):IntDimension {
	 
		return AsWingUtils.computeStringSizeWithFont(this, text, includeGutters);
	}
	
	/**
	 * Clone a ASFont, most time you dont need to call this because ASFont 
	 * is un-mutable class, but to avoid UIResource, you can call this.
	 */
	public function clone():ASFont{
		return new ASFont(name, size, bold, italic, underline, advancedProperties);
	}	
	
	public function toString():String{
		return "ASFont[" 
			+ "name : " + name 
			+ ", size : " + size 
			+ ", bold : " + bold 
			+ ", italic : " + italic 
			+ ", underline : " + underline 
			+ ", advanced : " + advancedProperties 
			+ "]";
	}
}