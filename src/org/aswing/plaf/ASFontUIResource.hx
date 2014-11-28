/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf;

import org.aswing.ASFont;

/**
 * Font UI Resource.
 * @author paling
 */
class ASFontUIResource extends ASFont  implements UIResource
{
	public function new(name:String="Tahoma", size:Float=11, bold:Bool=false, italic:Bool=false, underline:Bool=false, embedFontsOrAdvancedPros:Dynamic=null)
	{
		super(name, size, bold, italic, underline, embedFontsOrAdvancedPros);
	}
		
	/**
	 * Create a font ui resource with a font.
	 */
	public static function createResourceFont(font:ASFont):ASFontUIResource{
		return new ASFontUIResource(font.getName(), font.getSize(), font.isBold(), font.isItalic(), font.isUnderline(), font.getAdvancedProperties());
	}
}