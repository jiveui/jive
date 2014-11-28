/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf;

	
import flash.display.InteractiveObject;

import org.aswing.UIDefaults;
	import org.aswing.Component;
	import org.aswing.ASColor;
	import org.aswing.Border;
	import org.aswing.Icon;
	import org.aswing.GroundDecorator;
	import org.aswing.ASFont;
	import org.aswing.Insets;
	import org.aswing.StyleTune;
	import org.aswing.error.ImpMissError;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;

/**
 * The base class for ComponentUI.
 * @author paling
 */
class BaseComponentUI implements ComponentUI
{
	
	private var defaults:UIDefaults;
	
	public function new():Void
	{
		
	}
	public function installUI(c:Component):Void{
		throw new ImpMissError();
	}
	
	public function uninstallUI(c:Component):Void{
		throw new ImpMissError();
	}
	
    public function refreshStyleProperties():Void{
    	throw new ImpMissError();
    }	
	
	public function putDefault(key:String, value:Dynamic):Void{
		if(defaults == null){
			defaults = new UIDefaults();
		}
		defaults.set(key, value);
	}
	
	public function getDefault(key:String):Dynamic{
		if(containsDefaultsKey(key)){
			return defaults.get(key);
		}else{
			return UIManager.get(key);
		}
	}
	
	public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		paintBackGround(c, g, b);
	}
	
	public function paintFocus(c:Component, g:Graphics2D, b:IntRectangle):Void {
	//why	
		 
		 if (g != null){
    		g.drawRectangle(new Pen(getDefaultFocusColorInner(), 1), b.x+0.5, b.y+0.5, b.width-1, b.height-1);
    		g.drawRectangle(new Pen(getDefaultFocusColorOutter(), 1), b.x+1.5, b.y+1.5, b.width-3, b.height-3);
		}
		 
	}
	
    private function getDefaultFocusColorInner():ASColor{
    	return getColor("focusInner");
    }
    private function getDefaultFocusColorOutter():ASColor{
    	return getColor("focusOutter");
    }
    	
	private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(c.isOpaque()){
			g.fillRectangle(new SolidBrush(c.getBackground()), b.x, b.y, b.width, b.height);
		}
	}
	
    /**
     * Returns the object to receive the focus for the component.
     * The default implementation just return the component self.
     * @param c the component
     * @return the object to receive the focus.
     */
	public function getInternalFocusObject(c:Component):InteractiveObject{
		return c;
	}
	
	/**
	 * Returns null
	 */
	public function getMaximumSize(c:Component):IntDimension
	{
		return null;
	}
	/**
	 * Returns null
	 */	
	public function getMinimumSize(c:Component):IntDimension
	{
		return null;
	}
	/**
	 * Returns null
	 */	
	public function getPreferredSize(c:Component):IntDimension
	{
		return null;
	}
	
	//-----------------------------------------------------------
	//           Convernent methods
	//-----------------------------------------------------------

	public function containsDefaultsKey(key:String):Bool{
		return defaults != null && defaults.exists(key);
	}
	
	public function containsKey(key:String):Bool{
		return containsDefaultsKey(key) || UIManager.containsKey(key);
	}
	
	public function getBoolean(key:String):Bool{
		if(containsDefaultsKey(key)){
			return defaults.getBoolean(key);
		}
		return UIManager.getBoolean(key);
	}
	
	public function getNumber(key:String):Float{
		if(containsDefaultsKey(key)){
			return defaults.getNumber(key);
		}
		return UIManager.getNumber(key);
	}
	
	public function getInt(key:String):Int{
		if(containsDefaultsKey(key)){
			return defaults.getInt(key);
		}
		return UIManager.getInt(key);
	}
	
	public function getUint(key:String):Int{
		if(containsDefaultsKey(key)){
			return defaults.getUint(key);
		}
		return UIManager.getUint(key);
	}
	
	public function getString(key:String):String{
		if(containsDefaultsKey(key)){
			return defaults.getString(key);
		}
		return UIManager.getString(key);
	}
	
	public function getBorder(key:String):Border{
		if(containsDefaultsKey(key)){
			return defaults.getBorder(key);
		}
		return UIManager.getBorder(key);
	}
	
	public function getIcon(key:String):Icon{
		if(containsDefaultsKey(key)){
			return defaults.getIcon(key);
		}
		return UIManager.getIcon(key);
	}
	
	public function getGroundDecorator(key:String):GroundDecorator{
        if(containsDefaultsKey(key)){
			return defaults.getGroundDecorator(key);
		}
		return UIManager.getGroundDecorator(key);
	}
	
	public function getColor(key:String):ASColor{
		if(containsDefaultsKey(key)){
			return defaults.getColor(key);
		}
		return UIManager.getColor(key);
	}
	
	public function getFont(key:String):ASFont{
		if(containsDefaultsKey(key)){
			return defaults.getFont(key);
		}
		return UIManager.getFont(key);
	}
	
	public function getInsets(key:String):Insets{
		if(containsDefaultsKey(key)){
			return defaults.getInsets(key);
		}
		return UIManager.getInsets(key);
	}
	
	public function getStyleTune(key:String):StyleTune{
		if(containsDefaultsKey(key)){
			return defaults.getStyleTune(key);
		}
		return UIManager.getStyleTune(key);
	}
	
	public function getInstance(key:String):Dynamic{
		if(containsDefaultsKey(key)){
			return defaults.getInstance(key);
		}
		return UIManager.getInstance(key);
	}
	
	public function getClass(key:String):Class<Dynamic>{
		if(containsDefaultsKey(key)){
			return defaults.getConstructor(key);
		}
		return UIManager.getClass(key);
	}
}