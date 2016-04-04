/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.error.ImpMissError;
	import org.aswing.plaf.UIResource;
	import org.aswing.plaf.DefaultEmptyDecoraterResource;
	/**
 * Reserved for look and feel implementation.
 */	
class LookAndFeel
{
	/**
	 * Should override in sub-class to return a defaults.
	 */
	public function getDefaults():UIDefaults{
		throw new ImpMissError();
		return null;
	}
	
    /**
     * Convenience method for initializing a component's basic properties
     *  values from the current defaults table.  
     * 
     * @param c the target component for installing default color properties
     * @param componentUIPrefix the key for the default component UI Prefix
     * @see org.aswing.Component#setOpaque()
     * @see org.aswing.Component#setOpaqueSet()
     */	
	public static function installBasicProperties(c:Component, componentUIPrefix:String,
		defaultOpaquerName:String="opaque", defaultFocusableName:String="focusable"):Void{
		if(!c.isOpaqueSet()){
			c.setOpaque(c.getUI().getBoolean(componentUIPrefix + defaultOpaquerName));
			c.setOpaqueSet(false);
		}
		if(!c.isFocusableSet()){
			c.setFocusable(c.getUI().getBoolean(componentUIPrefix + defaultFocusableName));
			c.setFocusableSet(false);
		}
	}
	
    /**
     * Convenience method for initializing a component's foreground
     * and background color properties with values from the current
     * defaults table.  The properties are only set if the current
     * value is either null or a UIResource.
     * 
     * @param c the target component for installing default color properties
     * @param defaultBgName the key for the default background
     * @param defaultFgName the key for the default foreground
     * 
     * @see UIManager#getColor()
     */
    public static function installColors(c:Component, componentUIPrefix:String,
    	defaultBgName:String="background", defaultFgName:String="foreground", 
    	defaultMgName:String="mideground"):Void{
        var bg:ASColor = c.getBackground();
		if (bg == null || Std.is(bg,UIResource)) {
	    	c.setBackground(c.getUI().getColor(componentUIPrefix + defaultBgName));
		}

        var fg:ASColor = c.getForeground();
		if (fg == null || Std.is(fg,UIResource)) {
	    	c.setForeground(c.getUI().getColor(componentUIPrefix + defaultFgName));
		}

        var mg:ASColor = c.getMideground();
		if (mg == null || Std.is(mg,UIResource)) {
	    	c.setMideground(c.getUI().getColor(componentUIPrefix + defaultMgName));
		}
    }
    
    public static function installStyleTune(c:Component, componentUIPrefix:String, pname:String="colorAdjust"):Void{
    	var ca:StyleTune = c.getStyleTune();
    	if(ca == null || Std.is(ca,UIResource)){
    		c.setStyleTune(c.getUI().getStyleTune(componentUIPrefix+pname));
    	}
    }
    
    /**
     * Convenience method for initializing a component's font with value from 
     * the current defaults table.  The property are only set if the current
     * value is either null or a UIResource.
     * 
     * @param c the target component for installing default font property
     * @param defaultFontName the key for the default font
     * 
     * @see UIManager#getFont()
     */    
    public static function installFont(c:Component, componentUIPrefix:String, 
    	defaultFontName:String="font"):Void{
    	var f:ASFont = c.getFont();
		if (f == null || Std.is(f,UIResource)) {
			//trace(defaultFontName + " : " + UIManager.getFont(defaultFontName));
	    	c.setFont(c.getUI().getFont(componentUIPrefix + defaultFontName));
		}
    }
    
    /**
     * @see #installColors()
     * @see #installFont()
     * @see #installStyleTune()
     */
    public static function installColorsAndFont(c:Component, componentUIPrefix:String,
    	defaultBgName:String="background", defaultFgName:String="foreground", 
    	defaultFontName:String="font", defaultMgName:String="mideground", 
    	defaultCaName:String="colorAdjust"):Void{
    	installColors(c, componentUIPrefix, defaultBgName, defaultFgName, defaultMgName);
    	installFont(c, componentUIPrefix, defaultFontName);
    	installStyleTune(c, componentUIPrefix, defaultCaName);
    }
	
    /**
     * Convenience method for installing a component's default Border , background decorator and foreground decorator
     * object on the specified component if either the border is 
     * currently null or already an instance of UIResource.
     * @param c the target component for installing default border
     * @param defaultBorderName the key specifying the default border
     */
    public static function installBorderAndBFDecorators(c:Component, componentUIPrefix:String,
   		 defaultBorderName:String="border", defaultBGDName:String="bg", defaultFGDName:String="fg"):Void{
        var b:Border = c.getBorder();
        if (Std.is(b,UIResource)) {
            c.setBorder(c.getUI().getBorder(componentUIPrefix + defaultBorderName));
        }
        var bg:GroundDecorator = c.getBackgroundDecorator();
        if(Std.is(bg,UIResource)){
        	c.setBackgroundDecorator(c.getUI().getGroundDecorator(componentUIPrefix + defaultBGDName));
        }
        var fg:GroundDecorator = c.getForegroundDecorator();
        if(Std.is(fg,UIResource)){
        	c.setForegroundDecorator(c.getUI().getGroundDecorator(componentUIPrefix + defaultFGDName));
        }
    }

    /**
     * Convenience method for un-installing a component's default 
     * border, background decorator and foreground decorator on the specified component if the border is 
     * currently an instance of UIResource.
     * @param c the target component for uninstalling default border
     */
    public static function uninstallBorderAndBFDecorators(c:Component):Void{
        if (Std.is(c.getBorder() , UIResource)) {
            c.setBorder(DefaultEmptyDecoraterResource.INSTANCE);
			
        }
        if (Std.is(c.getBackgroundDecorator() , UIResource)){
            c.setBackgroundDecorator(DefaultEmptyDecoraterResource.INSTANCE);
        }
        if (Std.is(c.getForegroundDecorator() , UIResource)) {
            c.setForegroundDecorator(DefaultEmptyDecoraterResource.INSTANCE);
        }                
    }
}