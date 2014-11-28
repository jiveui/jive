/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf;

	
import flash.display.DisplayObject;

import org.aswing.Icon;
	import org.aswing.Border;
	import org.aswing.GroundDecorator;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.StyleTune;
	import org.aswing.Component;
	import org.aswing.Insets;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	/**
 * The default empty border to be the component border as default. So it can be 
 * replaced by LAF specified.
 * 
 * @author paling
 */
class DefaultEmptyDecoraterResource implements Icon implements Border implements GroundDecorator implements UIResource
{
	/**
	 * Shared instance.
	 */
	public static var INSTANCE:DefaultEmptyDecoraterResource = new DefaultEmptyDecoraterResource();
	
	public static var DEFAULT_BACKGROUND_COLOR:ASColorUIResource = new ASColorUIResource(0);
	public static var DEFAULT_FOREGROUND_COLOR:ASColorUIResource = new ASColorUIResource(0xFFFFFF);
	public static var DEFAULT_MIDEGROUND_COLOR:ASColorUIResource = new ASColorUIResource(0x1987FF);
	public static var DEFAULT_FONT:ASFontUIResource = new ASFontUIResource();
	public static var DEFAULT_STYLE_TUNE:UIStyleTune = new UIStyleTune();
	
	/**
	 * Used to be a null ui resource color. it is not a UIResource instance, so can't be replace by another LAF.
	 */
	public static var NULL_COLOR:ASColor = new ASColor(0);
	
	/**
	 * Used to be a null ui resource font. it is not a UIResource instance, so can't be replace by another LAF.
	 */
	public static var NULL_FONT:ASFont = new ASFont();
	
	/**
	 * Used to be a null ui resource style tune. it is not a UIResource instance, so can't be replace by another LAF.
	 */
	public static var NULL_STYLE_TUNE:StyleTune = new StyleTune(0, 0, 0);
	
	public function new(){
	}
	
	/**
	 * return null
	 */
	public function getDisplay(c:Component):DisplayObject{
		return null;
	}	
	
	/**
	 * return 0
	 */
	public function getIconWidth(c:Component):Int{
		return 0;
	}
	
	/**
	 * return 0
	 */
	public function getIconHeight(c:Component):Int{
		return 0;
	}
	
	/**
	 * do nothing
	 */
	public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int):Void{
	}	
	

	/**
	 * do nothing
	 */
	public function updateBorder(com:Component, g:Graphics2D, bounds:IntRectangle):Void{
	}
	
	/**
	 * return new Insets(0,0,0,0)
	 */
	public function getBorderInsets(com:Component, bounds:IntRectangle):Insets{
		return new Insets(0,0,0,0);
	}
	
	/**
	 * do nothing
	 */
	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):Void{
	}
	 
}