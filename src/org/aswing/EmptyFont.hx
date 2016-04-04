/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.text.TextField;
	import flash.text.TextFormat;
	/**
 * EmptyFont is a font that will not change text field's format.
 */
class EmptyFont extends ASFont{
	
	public function new(){
		super();
	}
	
	/**
	 * Do nothing here.
	 * @param textField the text filed to be applied font.
	 * @param beginIndex The zero-based index position specifying the first character of the desired range of text. 
	 * @param endIndex The zero-based index position specifying the last character of the desired range of text. 
	 */
	override public function apply(textField:TextField, beginIndex:Int=-1, endIndex:Int=-1):Void{
	}
	
	/**
	 * Returns <code>new TextFormat()</code>.
	 * @return <code>new TextFormat()</code>.
	 */
	override public function getTextFormat():TextFormat{
		return new TextFormat();
	}	
}