/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.plaf.basic.BasicLabelUI;
import flash.display.DisplayObject;
import flash.filters.BitmapFilter;	
/**
 * A display area for a short text string or an image, 
 * or both.
 * A label does not react to input events.
 * As a result, it cannot get the keyboard focus.
 * A label can, however, display a keyboard alternative
 * as a convenience for a nearby component
 * that has a keyboard alternative but can't display it.
 * <p>
 * A <code>JLabel</code> object can display
 * either text, an image, or both.
 * You can specify where in the label's display area
 * the label's contents are aligned
 * by setting the vertical and horizontal alignment.
 * By default, labels are vertically centered 
 * in their display area.
 * Text-only labels are leading edge aligned, by default;
 * image-only labels are horizontally centered, by default.
 * </p>
 * <p>
 * You can also specify the position of the text
 * relative to the image.
 * By default, text is on the trailing edge of the image,
 * with the text and image vertically aligned.
 * </p>
 * <p>
 * Finally, you can use the <code>setIconTextGap</code> method
 * to specify how many pixels
 * should appear between the text and the image.
 * The default is 4 pixels.
 * </p>
 * @author paling
 */
class JLabel extends Component{
	
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	inline public static var CENTER:Int= AsWingConstants.CENTER;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	inline public static var TOP:Int= AsWingConstants.TOP;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var LEFT:Int= AsWingConstants.LEFT;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var BOTTOM:Int= AsWingConstants.BOTTOM;
 	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var RIGHT:Int= AsWingConstants.RIGHT;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */        
	inline public static var HORIZONTAL:Int= AsWingConstants.HORIZONTAL;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	inline public static var VERTICAL:Int= AsWingConstants.VERTICAL;
	
	
	private var icon:Icon;
	private var _text:String;
	public var text(get, set): String;
	private var disabledIcon:Icon;
	
	// Icon/Label Alignment
    private var verticalAlignment:Int;
    private var horizontalAlignment:Int;
    
    private var verticalTextPosition:Int;
    private var horizontalTextPosition:Int;

    private var iconTextGap:Int;
    private var selectable:Bool;
    private var textFilters:Array<BitmapFilter>;
    
    /**
     * Creates a label.
     * @param text the text
     * @param icon the icon
     * @param horizontalAlignment the horizontal alignment, default is <code>CENTER</code>
     */
	public function new(?text:String="", ?icon:Icon=null, ?horizontalAlignment:Int=0) {
		textFilters=null;
			super();
			setClipMasked(true);
		setName("JLabel");
		//default
    	this.verticalAlignment = CENTER;
    	this.verticalTextPosition = CENTER;
    	this.horizontalTextPosition = RIGHT;
    	
    	this.text = text;
    	this.icon = icon;
    	installIcon(icon);
    	this.horizontalAlignment = horizontalAlignment;
    	
    	iconTextGap = 4;
    	selectable = false;
		
		updateUI();
	}
	
    override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicLabelUI;
    }
	
	override public function getUIClassID():String{
		return "LabelUI";
	}

	private function installIcon(icon:Icon):Void{
		if(icon != null && icon.getDisplay(this) != null){
			addChild(icon.getDisplay(this));
		}
	}
	
	private function uninstallIcon(icon:Icon):Void{
		var iconDis:DisplayObject = (icon == null ? null : icon.getDisplay(this));
		if(iconDis != null && isChild(iconDis)){
			removeChild(icon.getDisplay(this)); 
			//org.aswing.table.sorter.SortableTextHeaderCell err;
		}
	}
	
	public function setText(text:String):Void {
		
		if(this._text != text){
			this._text = text;
			repaint();
			invalidate();
		}
	}
	
	public function getText():String {

		return _text;
	}
	
	public function setSelectable(b:Bool):Void{
		selectable = b;
	}
	
	public function isSelectable():Bool{
		return selectable;
	}
	
	public function setTextFilters(fs:Array < BitmapFilter > ):Void {	
		textFilters = fs;
		repaint();
	}
	
	public function getTextFilters():Array<BitmapFilter>{
		return textFilters;
	}
	
	public function setIcon(icon:Icon):Void{
		if(this.icon != icon){
			uninstallIcon(this.icon);
			this.icon = icon;
			installIcon(this.icon);
			repaint();
			invalidate();
		}
	}

	public function getIcon():Icon{
		return icon;
	}

    /**
     * Returns the icon used by the label when it's disabled.
     * If no disabled icon has been set, the button constructs
     * one from the default icon if defalut icon setted. otherwish 
     * return null; 
     * <p>
     * The disabled icon really should be created 
     * (if necessary) by the L&F.-->
     *
     * @return the <code>disabledIcon</code> property
     * @see #setDisabledIcon()
     * @see #getEnabled()
     */
    public function getDisabledIcon():Icon {
        if(disabledIcon == null) {
            if(icon != null) {
            	//TODO imp
                //disabledIcon = new GrayFilteredIcon(icon);
            }
        }
        return disabledIcon;
    }
    
    /**
     * Sets the disabled icon for the label.
     * @param disabledIcon the icon used as the disabled image
     * @see #getDisabledIcon()
     * @see #setEnabled()
     */
    public function setDisabledIcon(disabledIcon:Icon):Void{
        var oldValue:Icon = this.disabledIcon;
        this.disabledIcon = disabledIcon;
        if (disabledIcon != oldValue) {
        	uninstallIcon(oldValue);
        	installIcon(disabledIcon);
            if (!isEnabled()) {
                repaint();
				invalidate();
            }
        }
    }

    /**
     * Returns the vertical alignment of the text and icon.
     *
     * @return the <code>verticalAlignment</code> property, one of the
     *		following values: 
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function getVerticalAlignment():Float{
        return verticalAlignment;
    }
    
    /**
     * Sets the vertical alignment of the icon and text.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function setVerticalAlignment(alignment:Float):Void{
        if (alignment == verticalAlignment){
        	return;
        }else{
        	verticalAlignment = Std.int(alignment);
        	repaint();
        }
    }
    
    /**
     * Returns the horizontal alignment of the icon and text.
     * @return the <code>horizontalAlignment</code> property,
     *		one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)
     * <li>AsWingConstants.LEFT
     * <li>AsWingConstants.CENTER
     * </ul>
     */
    public function getHorizontalAlignment():Float{
        return horizontalAlignment;
    }
    
    /**
     * Sets the horizontal alignment of the icon and text.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)
     * <li>AsWingConstants.LEFT
     * <li>AsWingConstants.CENTER
     * </ul>
     */
    public function setHorizontalAlignment(alignment:Float):Void{
        if (alignment == horizontalAlignment){
        	return;
        }else{
        	horizontalAlignment =Std.int( alignment);     
        	repaint();
        }
    }

    
    /**
     * Returns the vertical position of the text relative to the icon.
     * @return the <code>verticalTextPosition</code> property, 
     *		one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER  (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function getVerticalTextPosition():Float{
        return verticalTextPosition;
    }
    
    /**
     * Sets the vertical position of the text relative to the icon.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function setVerticalTextPosition(textPosition:Float):Void{
        if (textPosition == verticalTextPosition){
	        return;
        }else{
        	verticalTextPosition = Std.int(textPosition);
        	repaint();
        	revalidate();
        }
    }
    
    /**
     * Returns the horizontal position of the text relative to the icon.
     * @return the <code>horizontalTextPosition</code> property, 
     * 		one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)
     * <li>AsWingConstants.LEFT
     * <li>AsWingConstants.CENTER
     * </ul>
     */
    public function getHorizontalTextPosition():Float{
        return horizontalTextPosition;
    }
    
    /**
     * Sets the horizontal position of the text relative to the icon.
     * @param textPosition one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)
     * <li>AsWingConstants.LEFT
     * <li>AsWingConstants.CENTER
     * </ul>
     */
    public function setHorizontalTextPosition(textPosition:Float):Void{
        if (textPosition == horizontalTextPosition){
        	return;
        }else{
        	horizontalTextPosition = Std.int(textPosition);
        	repaint();
        	revalidate();
        }
    }
    
    /**
     * Returns the amount of space between the text and the icon
     * displayed in this button.
     *
     * @return an int equal to the number of pixels between the text
     *         and the icon.
     * @see #setIconTextGap()
     */
    public function getIconTextGap():Float{
        return iconTextGap;
    }

    /**
     * If both the icon and text properties are set, this property
     * defines the space between them.  
     * <p>
     * The default value of this property is 4 pixels.
     * 
     * @see #getIconTextGap()
     */
    public function setIconTextGap(iconTextGap:Float):Void{
        var oldValue:Float= this.iconTextGap;
        this.iconTextGap = Std.int(iconTextGap);
        if (iconTextGap != oldValue) {
            revalidate();
            repaint();
        }
    }

	/* Bindable  getters/setters */

	private function get_text(): String {
		return getText();
	}

	private function set_text(text: String): String {
		setText(text);
		return text;
	}
	
}
