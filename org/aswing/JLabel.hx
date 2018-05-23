/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import jive.Jive;
import org.aswing.plaf.basic.BasicLabelUI;
import flash.display.DisplayObject;
import flash.filters.BitmapFilter;

/**
 * A display area for a short text string or an image, 
 * or both.
 *
 * A label does not react to input events.
 * As a result, it cannot get the keyboard focus.
 * A label can, however, display a keyboard alternative
 * as a convenience for a nearby component
 * that has a keyboard alternative but can't display it.
 *
 * A `JLabel` object can display
 * either text, an image, or both.
 * You can specify where in the label's display area
 * the label's contents are aligned
 * by setting the vertical and horizontal alignment.
 * By default, labels are vertically centered 
 * in their display area.
 * Text-only labels are leading edge aligned, by default;
 * image-only labels are horizontally centered, by default.
 *
 * You can also specify the position of the text
 * relative to the image.
 * By default, text is on the trailing edge of the image,
 * with the text and image vertically aligned.
 *
 * Finally, you can use the `this.setIconTextGap` method
 * to specify how many pixels
 * should appear between the text and the image.
 * The default is 4 pixels.
 *
 * @author paling
 */
class JLabel extends Component {
	
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
	
	
    public var icon(get, set): Icon;
    private var _icon: Icon;
    private function get_icon(): Icon { return getIcon(); }
    private function set_icon(v: Icon): Icon { setIcon(v); return v; }

	public var text(get, set): String;
    private var _text:String;
    private function get_text(): String { return getText(); }
    private function set_text(text: String): String { setText(text); return text; }

    /**
     * The icon used by the label when it's disabled.
     *
     * If no disabled icon has been set, the button constructs
     * one from the default icon if defalut icon setted otherwise returns null.
     *
     * The disabled icon really should be created
     * (if necessary) by the L&F
     *
     * @see #enabled
     */
    public var disabledIcon(get, set): Icon;
    private var _disabledIcon: Icon;
    private function get_disabledIcon(): Icon { return getDisabledIcon(); }
    private function set_disabledIcon(v: Icon): Icon { setDisabledIcon(v); return v; }
	
    /******************************************************************************************************************/
	// Icon/Label Alignment
    /******************************************************************************************************************/

    /**
     * The vertical alignment of the icon and text.
     *
     * One of the following values:
     * <ul>
     * <li>`AsWingConstants.CENTER` (the default)
     * <li>`AsWingConstants.TOP`
     * <li>`AsWingConstants.BOTTOM`
     * </ul>
     */
    public var verticalAlignment(get, set): Int;
    private var _verticalAlignment: Int;
    private function get_verticalAlignment(): Int { return Std.int(getVerticalAlignment()); }
    private function set_verticalAlignment(v: Int): Int { setVerticalAlignment(v); return v; }

    /**
     * The horizontal alignment of the icon and text.
     *
     * One of the following values:
     * <ul>
     * <li>`AsWingConstants.RIGHT` (the default)
     * <li>`AsWingConstants.LEFT`
     * <li>`AsWingConstants.CENTER`
     * </ul>
     */
    public var horizontalAlignment(get, set): Int;
    private var _horizontalAlignment: Int;
    private function get_horizontalAlignment(): Int { return Std.int(getHorizontalAlignment()); }
    private function set_horizontalAlignment(v: Int): Int { setHorizontalAlignment(v); return v; }

    /**
     * The vertical position of the text relative to the icon.
     *
     * One of the following values:
     * <ul>
     * <li>`AsWingConstants.CENTER` (the default)
     * <li>`AsWingConstants.TOP`
     * <li>`AsWingConstants.BOTTOM`
     * </ul>
     */
    public var verticalTextPosition(get, set): Int;
    private var _verticalTextPosition: Int;
    private function get_verticalTextPosition(): Int { return Std.int(getVerticalTextPosition()); }
    private function set_verticalTextPosition(v: Int): Int { setVerticalTextPosition(v); return v; }

    /**
     * The horizontal position of the text relative to the icon.
     * <ul>
     * <li>`AsWingConstants.RIGHT` (the default)
     * <li>`AsWingConstants.LEFT`
     * <li>`AsWingConstants.CENTER`
     * </ul>
     */
    public var horizontalTextPosition(get, set): Int;
    private var _horizontalTextPosition: Int;
    private function get_horizontalTextPosition(): Int { return Std.int(getHorizontalTextPosition()); }
    private function set_horizontalTextPosition(v: Int): Int { setHorizontalTextPosition(v); return v; }

    /**
     * If both the icon and text properties are set, this property
     * defines the space between them.
     *
     * The default value of this property is 4 pixels.
     */
    public var iconTextGap(get, set): Int;
    private var _iconTextGap: Int;
    private function get_iconTextGap(): Int { return Std.int(getIconTextGap()); }
    private function set_iconTextGap(v: Int): Int { setIconTextGap(v); return v; }

    public var selectable(get, set): Bool;
    private var _selectable: Bool;
    private function get_selectable(): Bool { return isSelectable(); }
    private function set_selectable(v: Bool): Bool { setSelectable(v); return v; }

    public var textFilters(get, set): Array<BitmapFilter>;
    private var _textFilters: Array<BitmapFilter>;
    private function get_textFilters(): Array<BitmapFilter> { return getTextFilters(); }
    private function set_textFilters(v: Array<BitmapFilter>): Array<BitmapFilter> { setTextFilters(v); return v; }
    
    /**
     * Creates a label.
     * @param text the text
     * @param icon the icon
     * @param horizontalAlignment the horizontal alignment, default is `AsWingConstants.CENTER`
     */
	public function new(?text:String="", ?icon:Icon=null, ?horizontalAlignment:Int=0) {
		_textFilters=null;
		super();
		setClipMasked(true);
		setName("JLabel");
		//default
    	this._verticalAlignment = CENTER;
    	this._verticalTextPosition = CENTER;
    	this._horizontalTextPosition = RIGHT;
    	
    	this.text = text;
    	this._icon = icon;
    	installIcon(icon);
    	this._horizontalAlignment = horizontalAlignment;
    	
    	_iconTextGap = Jive.toPixelSize(4);
    	_selectable = false;
        readyToPaint = true;
		
		updateUI();
	}
	
    @:dox(hide)
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

    @:dox(hide)
	public function setText(text:String):Void {
		if(this._text != text){
			this._text = text;
			repaintAndRevalidate();
		}
	}

    @:dox(hide)
	public function getText():String {
		return _text;
	}
	
	@:dox(hide)
    public function setSelectable(b:Bool):Void{
		_selectable = b;
        repaint();
	}
	
	@:dox(hide)
    public function isSelectable():Bool{
		return _selectable;
	}
	
	@:dox(hide)
    public function setTextFilters(fs:Array < BitmapFilter > ):Void {
		_textFilters = fs;
		repaint();
	}
	
	@:dox(hide)
    public function getTextFilters():Array<BitmapFilter>{
		return _textFilters;
	}
	
	@:dox(hide)
    public function setIcon(icon:Icon):Void{
		if(this._icon != icon){
			uninstallIcon(this._icon);
			this._icon = icon;
			installIcon(this._icon);
			repaintAndRevalidate();
		}
	}

	@:dox(hide)
    public function getIcon():Icon{
		return _icon;
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
    @:dox(hide)
    public function getDisabledIcon():Icon {
        if(_disabledIcon == null) {
            if(_icon != null) {
            	//TODO imp
                //disabledIcon = new GrayFilteredIcon(icon);
            }
        }
        return _disabledIcon;
    }
    
    /**
     * Sets the disabled icon for the label.
     * @param disabledIcon the icon used as the disabled image
     * @see #getDisabledIcon()
     * @see #setEnabled()
     */
    @:dox(hide)
    public function setDisabledIcon(disabledIcon:Icon):Void{
        var oldValue:Icon = this._disabledIcon;
        this._disabledIcon = disabledIcon;
        if (disabledIcon != oldValue) {
        	uninstallIcon(oldValue);
        	installIcon(disabledIcon);
            if (!isEnabled()) {
                repaintAndRevalidate();
            }
        }
    }

    /**
     * Returns the vertical alignment of the text and icon.
     *
     * @return the <code>verticalAlignment</code> property, one of the
     *		following values: 
     * <ul>
     * <li>`AsWingConstants.CENTER`</li> (the default)
     * <li>AsWingConstants.TOP</li>
     * <li>AsWingConstants.BOTTOM</li>
     * </ul>
     */
    @:dox(hide)
    public function getVerticalAlignment():Float{
        return _verticalAlignment;
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
    @:dox(hide)
    public function setVerticalAlignment(alignment:Float):Void{
        if (alignment == _verticalAlignment){
        	return;
        }else{
        	_verticalAlignment = Std.int(alignment);
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
    @:dox(hide)
    public function getHorizontalAlignment():Float{
        return _horizontalAlignment;
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
    @:dox(hide)
    public function setHorizontalAlignment(alignment:Float):Void{
        if (alignment == _horizontalAlignment){
        	return;
        }else{
        	_horizontalAlignment =Std.int( alignment);
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
    @:dox(hide)
    public function getVerticalTextPosition():Float{
        return _verticalTextPosition;
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
    @:dox(hide)
    public function setVerticalTextPosition(textPosition:Float):Void{
        if (textPosition == _verticalTextPosition){
	        return;
        }else{
        	_verticalTextPosition = Std.int(textPosition);
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
    @:dox(hide)
    public function getHorizontalTextPosition():Float{
        return _horizontalTextPosition;
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
    @:dox(hide)
    public function setHorizontalTextPosition(textPosition:Float):Void{
        if (textPosition == _horizontalTextPosition){
        	return;
        }else{
        	_horizontalTextPosition = Std.int(textPosition);
            repaintAndRevalidate();
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
        return _iconTextGap;
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
        var oldValue:Float= this._iconTextGap;
        this._iconTextGap = Std.int(iconTextGap);
        if (iconTextGap != oldValue) {
            repaintAndRevalidate();
        }
    }


}
