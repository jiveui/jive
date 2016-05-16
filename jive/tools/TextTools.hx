package jive.tools;

import jive.Font;
import jive.geom.IntDimension;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFieldAutoSize;

class TextTools {
	private static var TEXT_FIELD_EXT:TextField = null;

	public static function computeStringSizeWithFont(font:Font, str:String, includeGutters:Bool=true):IntDimension{
		TEXT_FIELD_EXT = new flash.text.TextField();
		TEXT_FIELD_EXT.autoSize = TextFieldAutoSize.LEFT;
		TEXT_FIELD_EXT.type = TextFieldType.DYNAMIC;
		TEXT_FIELD_EXT.text = str;
		font.apply(TEXT_FIELD_EXT);
		
		if (includeGutters)
			return new IntDimension(Math.ceil(TEXT_FIELD_EXT.width), Math.ceil(TEXT_FIELD_EXT.height));
		else
			return new IntDimension(Math.ceil(TEXT_FIELD_EXT.textWidth), Math.ceil(TEXT_FIELD_EXT.textHeight));
	}
}