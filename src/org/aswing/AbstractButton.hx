/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
import flash.events.TouchEvent;
import jive.Command;
import haxe.CallStack;
import motion.easing.Linear;
import motion.easing.Back;
import motion.Actuate;
import flash.filters.BitmapFilter;
import flash.display.DisplayObjectContainer;
import flash.display.DisplayObject; 
import flash.events.Event;
import flash.events.MouseEvent;
import org.aswing.util.StringUtils;
import org.aswing.error.ImpMissError;
import org.aswing.event.ReleaseEvent;
import org.aswing.event.AWEvent;
import org.aswing.event.InteractiveEvent;
import org.aswing.plaf.ArrayUIResource;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.InsetsUIResource;

/**
 * Defines common behaviors for buttons and menu items.
 * 
 * @author paling
 * @author ngrebenshikov
 */
@:event("org.aswing.event.InteractiveEvent.SELECTION_CHANGED", "Dispatched when the button's selection changed. Buttons always fire `programmatic=false` InteractiveEvent")
@:event("org.aswing.event.InteractiveEvent.STATE_CHANGED", "Dispatched when the button's state changed. The state is all about:`enabled`, `rollOver`, `pressed`, `released`, `selected`")
@:event("org.aswing.event.AWEvent.ACT", "Dispatched when the button's model take action, generally when user click the button or `>doClick()` method is called.")
class AbstractButton extends Component{
	
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


	/**
     * The model that this button represents.
     */
	public var model(get, set): ButtonModel;
	private var _model: ButtonModel;
	private function get_model(): ButtonModel { return getModel(); }
	private function set_model(v: ButtonModel): ButtonModel { setModel(v); return v; }

    /**
	 * The text include the "&"(mnemonic modifier char). For example,
	 * if you set "&File" to be the text, then "File" will be displayed, and "F"
	 * will be the mnemonic.
	 *
	 * The set operation will make button repaint, but will not make button relayout,
	 * so if you sets a different size text, you may need to call `this.revalidate()`
	 * to make this button to be relayouted by his container.
	 *
	 * @see #displayText
	 * @see #mnemonic
	 * @see #mnemonicIndex
	 */
    private var _text:String;
	public var text(get, set): String;
	private function get_text(): String { return getText(); }
	private function set_text(s: String): String { setText(s); return s; }

    /**
	 * The text to be displayed, it is a text that removed the "&"(mnemonic modifier char).
	 */
    public var displayText(default, null):String;

    /**
	 * The keyboard mnemonic for this button, -1 means no mnemonic.
	 * @see #text
	 * @see #displayText
	 * @see #mnemonicIndex
	 */
    public var mnemonic(default, null):Int;

    /**
	 * The mnemonic char index in the display text, -1 means no mnemonic.
	 * @see #text
	 * @see #displayText
	 * @see #mnemonic
	 */
    public var mnemonicIndex(default, null):Int;

    /**
	 * Whether or not enabled mnemonic.
	 */
    public var mnemonicEnabled(get, set): Bool;
    private var _mnemonicEnabled: Bool;
    private function get_mnemonicEnabled(): Bool { return isMnemonicEnabled(); }
    private function set_mnemonicEnabled(v: Bool): Bool { setMnemonicEnabled(v); return v; }

    /**
	 * The space for margin between the button's border and
     * the label.
     *
     * Setting to `null` will cause the button to
     * use the default margin.  The button's default `Border`
     * object will use this value to create the proper margin.
     *
     * However, if a non-default border is set on the button,
     * it is that `Border` object's responsibility to create the
     * appropriate margin space (else this property will
     * effectively be ignored).
	 */
    public var margin(get, set): Insets;
    private var _margin: Insets;
    private function get_margin(): Insets { return getMargin(); }
    private function set_margin(v: Insets): Insets { setMargin(v); return v; }

    private var defaultMargin:Insets;

    /*************************************************************************************************************/
    // Button icons
    /*************************************************************************************************************/

    /**
	 * The default icon for the button.
	 *
	 * A setting will make button repaint, but will not make button relayout,
	 * so if you sets a different size icon, you may need to call `this.revalidate()`
	 * to make this button to be relayouted by his container.
	 */
    public var icon(get, set): Icon;
    private var _defaultIcon:Icon;
    private function get_icon(): Icon { return getIcon(); }
    private function set_icon(v: Icon): Icon { setIcon(v); return v; }

    /**
     * The pressed icon for the button.
     */
    public var pressedIcon(get, set): Icon;
    private var _pressedIcon: Icon;
    private function get_pressedIcon(): Icon { return getPressedIcon(); }
    private function set_pressedIcon(v: Icon): Icon { setPressedIcon(v); return v; }

    /**
     * The disabled icon for the button.
     */
    public var disabledIcon(get, set): Icon;
    private var _disabledIcon: Icon;
    private function get_disabledIcon(): Icon { return getDisabledIcon(); }
    private function set_disabledIcon(v: Icon): Icon { setDisabledIcon(v); return v; }

    /**
     * The selected icon for the button.
     */
    public var selectedIcon(get, set): Icon;
    private var _selectedIcon: Icon;
    private function get_selectedIcon(): Icon { return getSelectedIcon(); }
    private function set_selectedIcon(v: Icon): Icon { setSelectedIcon(v); return v; }


    /**
     * The disabled selection icon for the button.
     */
    public var disabledSelectedIcon(get, set): Icon;
    private var _disabledSelectedIcon: Icon;
    private function get_disabledSelectedIcon(): Icon { return getDisabledSelectedIcon(); }
    private function set_disabledSelectedIcon(v: Icon): Icon { setDisabledSelectedIcon(v); return v; }

    /**
     * The rollover icon for the button.
     */
    public var rolloverIcon(get, set): Icon;
    private var _rolloverIcon: Icon;
    private function get_rolloverIcon(): Icon { return getRollOverIcon(); }
    private function set_rolloverIcon(v: Icon): Icon { setRollOverIcon(v); return v; }

    /**
     * The rollover selected icon for the button.
     */
    public var rolloverSelectedIcon(get, set): Icon;
    private var _rolloverSelectedIcon: Icon;
    private function get_rolloverSelectedIcon(): Icon { return getRollOverSelectedIcon(); }
    private function set_rolloverSelectedIcon(v: Icon): Icon { setRollOverSelectedIcon(v); return v; }
    
    /*************************************************************************************************************/
    // Display properties
    /*************************************************************************************************************/

    /**
     * Must be `true` for rollover effects to occur.
     *
     * The default value is `false`.
     *
     * Some look and feels might not implement rollover effects;
     * they will ignore this property.
     */
    public var rolloverEnabled(get, set): Bool;
    private var _rolloverEnabled: Bool;
    private function get_rolloverEnabled(): Bool { return isRollOverEnabled(); }
    private function set_rolloverEnabled(v: Bool): Bool { setRollOverEnabled(v); return v; }

    /*************************************************************************************************************/
    // Icon/Label Alignment
    /*************************************************************************************************************/

    /**
     * The vertical alignment of the icon and text.
     *
     * One of the following values:
     * <ul>
     * <li>`org.aswing.AsWingConstants.CENTER` (the default)
     * <li>`org.aswing.AsWingConstants.TOP`
     * <li>`org.aswing.AsWingConstants.BOTTOM`
     * </ul>
     */
    public var verticalAlignment(get, set): Int;
    private var _verticalAlignment: Int;
    private function get_verticalAlignment(): Int { return getVerticalAlignment(); }
    private function set_verticalAlignment(v: Int): Int { setVerticalAlignment(v); return v; }

    /**
     * The horizontal alignment of the icon and text.
     *
     * One of the following values:
     * <ul>
     * <li>`org.aswing.AsWingConstants.RIGHT` (the default)
     * <li>`org.aswing.AsWingConstants.LEFT`
     * <li>`org.aswing.AsWingConstants.CENTER`
     * </ul>
     */
    public var horizontalAlignment(get, set): Int;
    private var _horizontalAlignment: Int;
    private function get_horizontalAlignment(): Int { return getHorizontalAlignment(); }
    private function set_horizontalAlignment(v: Int): Int { setHorizontalAlignment(v); return v; }

    /**
     * The vertical position of the text relative to the icon.
     * One of the following values:
     * <ul>
     * <li>`org.aswing.AsWingConstants.CENTER` (the default)
     * <li>`org.aswing.AsWingConstants.TOP`
     * <li>`org.aswing.AsWingConstants.BOTTOM`
     * </ul>
     */
    public var verticalTextPosition(get, set): Int;
    private var _verticalTextPosition: Int;
    private function get_verticalTextPosition(): Int { return getVerticalTextPosition(); }
    private function set_verticalTextPosition(v: Int): Int { setVerticalTextPosition(v); return v; }

    /**
     * The horizontal position of the text relative to the icon.
     *
     * One of the following values:
     * <ul>
     * <li>`org.aswing.AsWingConstants.RIGHT` (the default)
     * <li>`org.aswing.AsWingConstants.LEFT`
     * <li>`org.aswing.AsWingConstants.CENTER`
     * </ul>
     */
    public var horizontalTextPosition(get, set): Int;
    private var _horizontalTextPosition: Int;
    private function get_horizontalTextPosition(): Int { return getHorizontalTextPosition(); }
    private function set_horizontalTextPosition(v: Int): Int { setHorizontalTextPosition(v); return v; }

    /**
     * If both the icon and text properties are set, this property
     * defines the space between them.
     *
     * The default value of this property is 4 pixels.
     */
    public var iconTextGap(get, set): Int;
    private var _iconTextGap: Int;
    private function get_iconTextGap(): Int { return getIconTextGap(); }
    private function set_iconTextGap(v: Int): Int { setIconTextGap(v); return v; }

    /**
    * True if iconTextGap is set by user.
    **/
    public var iconTextGapSet: Bool = false;

    /**
     * The shift offset of the content when mouse press.
     */
    public var shiftOffset(get, set): Int;
    private var _shiftOffset: Int;
    private function get_shiftOffset(): Int { return getShiftOffset(); }
    private function set_shiftOffset(v: Int): Int { setShiftOffset(v); return v; }

    /**
    * Whether or not the shiftOffset has set by user. The LAF will not change this value if it is true.
    **/
    public var shiftOffsetSet:Bool;
    
    public var textFilters(get, set): Array<BitmapFilter>;
    private var _textFilters: Array<BitmapFilter>;
    private function get_textFilters(): Array<BitmapFilter> { return getTextFilters(); }
    private function set_textFilters(v: Array<BitmapFilter>): Array<BitmapFilter> { setTextFilters(v); return v; }


    /**
     * The state of the button.
     *
     * Note that setting does not trigger `ACT` Event for users (will of course trigger `STATE_CHANGED` event).
     * Call `this.doClick()` to perform a programatic action change.
     */
    @bindable public var selected(get, set): Bool;
    private var _selected: Bool;
    private function get_selected(): Bool { return isSelected(); }
    private function set_selected(v: Bool): Bool { setSelected(v); return v; }
	
    public var iconAsBackground: Bool;

    public var command: Command;

	public function new(text:String="", icon:Icon=null){
		this._shiftOffset=0;
		this.shiftOffsetSet=false;
			super();
	 	
		setName("AbstractButton");
	
        #if !mobile
    	_rolloverEnabled = true;
        #end
    	
    	_verticalAlignment = CENTER;
    	_horizontalAlignment = CENTER;
    	_verticalTextPosition = CENTER;
    	_horizontalTextPosition = RIGHT;
    		
    	_textFilters = new Array<BitmapFilter>();
    	
    	_iconTextGap = 2;
    	_mnemonicEnabled = true;
    	this._text = text;
    	this.analyzeMnemonic();
    	this._defaultIcon = icon;
    	//setText(text);
    	//setIcon(icon);
    	initSelfHandlers();
    	
    	updateUI(); 
    	installIcon(_defaultIcon);

        addActionListener(function(e) {
            if (null != command) command.action();
        });

    }

    /**
     * Returns the model that this button represents.
     * @return the <code>model</code> property
     * @see `#setModel()`
     */
	@:dox(hide)
    public function getModel():ButtonModel{
        return _model;
    }
    
    /**
     * Sets the model that this button represents.
     * @param m the new <code>ButtonModel</code>
     * See `#getModel()`
     */
	@:dox(hide)
    public function setModel(newModel:ButtonModel):Void{
        
        var oldModel:ButtonModel = getModel();
        
        if (oldModel != null) {
        	oldModel.removeActionListener(__modelActionListener);
            oldModel.removeStateListener(__modelStateListener);
            oldModel.removeSelectionListener(__modelSelectionListener);
        }
        
        _model = newModel;
        
        if (newModel != null) {
        	newModel.addActionListener(__modelActionListener);
            newModel.addStateListener(__modelStateListener);
            newModel.addSelectionListener(__modelSelectionListener);
        }

        if (newModel != oldModel) {
            revalidate();
            repaint();
        }
        doBackgroundTransition(true);
    }
         
    /**
     * Resets the UI property to a value from the current look
     * and feel.
     *
     * Subtypes of `AbstractButton`
     * should override this to update the UI. For
     * example, `JButton` might do the following:
     * <pre>
     *      setUI(ButtonUI(UIManager.getUI(this)));
     * </pre>
     */
    override public function updateUI():Void{
    	throw new ImpMissError();
    }
    
    /**
     * Programmatically perform a click.
     */
    public function doClick():Void{
    	dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER, true, false, 0, 0));
    	dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, true, false, 0, 0));
    	if(isOnStage()){
    		dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true, false, 0, 0));
    	}else { 
    		dispatchEvent(new ReleaseEvent(ReleaseEvent.RELEASE, this, false, new MouseEvent(MouseEvent.MOUSE_UP)));
    	}
    	dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 0, 0));
    	dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT, true, false, 0, 0));
    }
    
    /**
     * Adds a action listener to this button. Buttons fire a action event when
     * user clicked on it.
     *
     * See `org.aswing.event.AWEvent#ACT`
     *
     * @param listener the listener
     * @param priority the priority
     * @param useWeakReference Determines whether the reference to the listener is strong or weak.
     */
    public function addActionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
    	addEventListener(AWEvent.ACT, listener, false, priority, useWeakReference);
    }

	/**
	 * Removes a action listener.
	 * @param listener the listener to be removed.
	 */
	public function removeActionListener(listener:Dynamic -> Void):Void{
		removeEventListener(AWEvent.ACT, listener);
	}    
    	
	/**
	 * Add a listener to listen the button's selection change event.
	 * When the button's selection changed, fired when diselected or selected.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * See `org.aswing.event.InteractiveEvent#SELECTION_CHANGED`
	 */	
	public function addSelectionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(InteractiveEvent.SELECTION_CHANGED, listener, false, priority);
	}

	/**
	 * Removes a selection listener.
	 * @param listener the listener to be removed.
	 * See `org.aswing.event.InteractiveEvent#SELECTION_CHANGED`
	 */
	public function removeSelectionListener(listener:Dynamic -> Void):Void{
		removeEventListener(InteractiveEvent.SELECTION_CHANGED, listener);
	}
	
	/**
	 * Adds a listener to listen the button's state change event.
	 * <p>
	 * When the button's state changed, the state is all about:
	 * <ul>
	 * <li>`this.enabled`</li>
	 * <li>`this.rollOver`</li>
	 * <li>`this.pressed`</li>
	 * <li>`this.released`</li>
	 * <li>`this.selected`</li>
	 * </ul>
	 * </p>
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */	
	public function addStateListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(InteractiveEvent.STATE_CHANGED, listener, false, priority);
	}	
	
	/**
	 * Removes a state listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */	
	public function removeStateListener(listener:Dynamic -> Void):Void{
		removeEventListener(InteractiveEvent.STATE_CHANGED, listener);
	}
	
    /**
     * Enabled (or disabled) the button.
     * @param b  true to enable the button, otherwise false
     */
    @:dox(hide)
	override public function setEnabled(b:Bool):Void{
		if (!b && _model.isRollOver()) {
	    	_model.setRollOver(false);
		}
        super.setEnabled(b);
        _model.setEnabled(b);
    }    

    /**
     * Returns the state of the button. True if the
     * toggle button is selected, false if it's not.
     * @return true if the toggle button is selected, otherwise false
     */
    @:dox(hide)
    public function isSelected():Bool{
        return _model.isSelected();
    }
    
    /**
     * Sets the state of the button. Note that this method does not
     * trigger ACT Event for users(will of course trigger STATE_CHANGED event).
     * Call <code>click</code> to perform a programatic action change.
     *
     * @param b  true if the button is selected, otherwise false
     */
    @:dox(hide)
    public function setSelected(b:Bool):Void{
        _model.setSelected(b);
    }
    
    /**
     * Sets the <code>rolloverEnabled</code> property, which
     * must be <code>true</code> for rollover effects to occur.
     * The default value for the <code>rolloverEnabled</code>
     * property is <code>false</code>.
     * Some look and feels might not implement rollover effects;
     * they will ignore this property.
     * 
     * @param b if <code>true</code>, rollover effects should be painted
     * See `#isRollOverEnabled()`
     */
    @:dox(hide)
    public function setRollOverEnabled(b:Bool):Void{
    	if(_rolloverEnabled != b){
    		_rolloverEnabled = b;
    		repaint();
    	}
    }
    
    /**
     * Gets the <code>rolloverEnabled</code> property.
     *
     * @return the value of the <code>rolloverEnabled</code> property
     * See `#setRollOverEnabled()`
     */
    @:dox(hide)
    public function isRollOverEnabled():Bool{
    	return _rolloverEnabled;
    }

	/**
	 * Sets space for margin between the button's border and
     * the label. Setting to <code>null</code> will cause the button to
     * use the default margin.  The button's default <code>Border</code>
     * object will use this value to create the proper margin.
     * However, if a non-default border is set on the button, 
     * it is that <code>Border</code> object's responsibility to create the
     * appropriate margin space (else this property will
     * effectively be ignored).
     *
     * @param m the space between the border and the label
	 */
    @:dox(hide)
	public function setMargin(m:Insets):Void{
        // Cache the old margin if it comes from the UI
        if(Std.is(m,UIResource)) {
            defaultMargin = m;
        }
        
        // If the client passes in a null insets, restore the margin
        // from the UI if possible
        if(m == null && defaultMargin != null) {
            m = defaultMargin;
        }

        var old:Insets = _margin;
        _margin = m;
        if (old == null || !m.equals(old)) {
            revalidate();
        	repaint();
        }
	}

    @:dox(hide)
	public function getMargin():Insets{
		var m:Insets = _margin;
		if(_margin == null){
			m = defaultMargin;
		}
		if(m == null){
			return new InsetsUIResource();
		}else if(Std.is(m,UIResource)){//make it can be replaced by LAF
			return new InsetsUIResource(m.top, m.left, m.bottom, m.right);
		}else{
			return new Insets(m.top, m.left, m.bottom, m.right);
		}
	}
	
	@:dox(hide)
    public function setTextFilters(fs:Array<BitmapFilter>):Void{
		_textFilters = fs;
		repaint();
	}

    @:dox(hide)
	public function getTextFilters():Array<BitmapFilter>{
		return _textFilters;
	}
	
	/**
	 * Wrap a SimpleButton to be this button's representation.
	 * @param btn the SimpleButton to be wrap.
	 * @return the button self
	 */
	public function wrapSimpleButton(btn:SimpleButton):AbstractButton{
		setShiftOffset(0);
		setIcon(new SimpleButtonIconToggle(btn));
		setBorder(null);
		setMargin(new Insets());
		setBackgroundDecorator(null);
		setOpaque(false);
		return this;
	}
		
	/**
	 * Sets the text include the "&"(mnemonic modifier char). For example, 
	 * if you set "&File" to be the text, then "File" will be displayed, and "F" 
	 * will be the mnemonic.
	 * <p>
	 * This method will make button repaint, but will not make button relayout, 
	 * so if you sets a different size text, you may need to call <code>revalidate()</code> 
	 * to make this button to be relayouted by his container.
	 * </p>
	 * @param text the text.
	 * See `#getDisplayText()`
	 * See `#getMnemonic()`
	 * See `#getMnemonicIndex()`
	 */
    @:dox(hide)
	public function setText(text:String):Void{
		if(this._text != text){
			this._text = text;
			analyzeMnemonic();
			repaint();
			invalidate();
		}
	}
	
	/**
	 * Sets whether or not enabled mnemonic.
	 */
    @:dox(hide)
	public function setMnemonicEnabled(b:Bool):Void{
		if(_mnemonicEnabled != b){
			_mnemonicEnabled = b;
			analyzeMnemonic();
		}
	}
	
	/**
	 * Returns whether or not enabled mnemonic.
	 */
    @:dox(hide)
	public function isMnemonicEnabled():Bool{
		return _mnemonicEnabled;
	}
	
	private function analyzeMnemonic():Void{
		displayText = _text;
		mnemonic = -1;
		mnemonicIndex = -1;
		if(_text == null){
			return;
		}
		if(_mnemonicEnabled!=true){
			return;
		}
		var mi:Int= _text.indexOf("&");
		var mc:String= "";
		var found:Bool= false;
		while(mi >= 0){
			if(mi+1 < _text.length){
				mc = _text.charAt(mi+1);
				if (StringUtils.isLetter(mc)) {
				
					found = true;
					break;
				}
			}else{
				break;
			}
			mi = _text.indexOf("&", mi+1);
		}
		if(found)	{
			displayText = _text.substr(0, mi) + _text.substr(mi+1);
			mnemonic = mc.toUpperCase().charCodeAt(0);
			mnemonicIndex = mi;
		}
	}
	
	/**
	 * Returns the text include the "&"(mnemonic modifier char).
	 * @return the text.
	 * See `#getDisplayText()`
	 */
    @:dox(hide)
	public function getText():String{
		return _text;
	}
	
	/**
	 * Returns the text to be displayed, it is a text that removed the "&"(mnemonic modifier char).
	 * @return the text to be displayed.
	 */
    @:dox(hide)
	public function getDisplayText():String{
		return displayText;	
	}
	
	/**
	 * Returns the mnemonic char index in the display text, -1 means no mnemonic.
	 * @return the mnemonic char index or -1.
	 * See `#getDisplayText()`
	 */
    @:dox(hide)
	public function getMnemonicIndex():Int{
		return mnemonicIndex;
	}
	
	/**
	 * Returns the keyboard mnemonic for this button, -1 means no mnemonic.
	 * @return the keyboard mnemonic or -1.
	 */
    @:dox(hide)
	public function getMnemonic():Int{
		return mnemonic;
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
		 }
	}
	
	/**
	 * Sets the default icon for the button.
	 * <p>
	 * This method will make button repaint, but will not make button relayout, 
	 * so if you sets a different size icon, you may need to call <code>revalidate()</code> 
	 * to make this button to be relayouted by his container.
	 * </p>
	 * @param defaultIcon the default icon for the button.
	 */
    @:dox(hide)
	public function setIcon(defaultIcon:Icon):Void{
		if(this._defaultIcon != defaultIcon){
			uninstallIcon(this._defaultIcon);
			this._defaultIcon = defaultIcon;
			installIcon(defaultIcon);
			repaint();
			invalidate();
		}
	}

    @:dox(hide)
	public function getIcon():Icon{
		return _defaultIcon;
	}
    
    /**
     * Returns the pressed icon for the button.
     * @return the <code>pressedIcon</code> property
     * See `#setPressedIcon()`
     */
    @:dox(hide)
    public function getPressedIcon():Icon {
        return _pressedIcon;
    }
    
    /**
     * Sets the pressed icon for the button.
     * @param pressedIcon the icon used as the "pressed" image
     * See `#getPressedIcon()`
     */
    @:dox(hide)
    public function setPressedIcon(pressedIcon:Icon):Void{
        var oldValue:Icon = this._pressedIcon;
        this._pressedIcon = pressedIcon;
        if (pressedIcon != oldValue) {
        	uninstallIcon(oldValue);
        	installIcon(pressedIcon);
			//if (getModel().isPressed()) {
                repaint();
            //}
        }
    }

    /**
     * Returns the selected icon for the button.
     * @return the <code>selectedIcon</code> property
     * See `#setSelectedIcon()`
     */
    @:dox(hide)
    public function getSelectedIcon():Icon {
        return _selectedIcon;
    }
    
    /**
     * Sets the selected icon for the button.
     * @param selectedIcon the icon used as the "selected" image
     * See `#getSelectedIcon()`
     */
    @:dox(hide)
    public function setSelectedIcon(selectedIcon:Icon):Void{
        var oldValue:Icon = this._selectedIcon;
        this._selectedIcon = selectedIcon;
        if (selectedIcon != oldValue) {
        	uninstallIcon(oldValue);
        	installIcon(selectedIcon);
            //if (isSelected()) {
                repaint();
            //}
        }
    }

    /**
     * Returns the rollover icon for the button.
     * @return the <code>rolloverIcon</code> property
     * See `#setRollOverIcon()`
     */
    @:dox(hide)
    public function getRollOverIcon():Icon {
        return _rolloverIcon;
    }
    
    /**
     * Sets the rollover icon for the button.
     * @param rolloverIcon the icon used as the "rollover" image
     * See `#getRollOverIcon()`
     */
    @:dox(hide)
    public function setRollOverIcon(rolloverIcon:Icon):Void{
        var oldValue:Icon = this._rolloverIcon;
        this._rolloverIcon = rolloverIcon;
        setRollOverEnabled(true);
        if (rolloverIcon != oldValue) {
        	uninstallIcon(oldValue);
        	installIcon(rolloverIcon);
			//if(getModel().isRollOver()){
            	repaint();
            //}
        }
      
    }
    
    /**
     * Returns the rollover selection icon for the button.
     * @return the <code>rolloverSelectedIcon</code> property
     * See `#setRollOverSelectedIcon()`
     */
    @:dox(hide)
    public function getRollOverSelectedIcon():Icon {
        return _rolloverSelectedIcon;
    }
    
    /**
     * Sets the rollover selected icon for the button.
     * @param rolloverSelectedIcon the icon used as the
     *		"selected rollover" image
     * See `#getRollOverSelectedIcon()`
     */
    @:dox(hide)
    public function setRollOverSelectedIcon(rolloverSelectedIcon:Icon):Void{
        var oldValue:Icon = this._rolloverSelectedIcon;
        this._rolloverSelectedIcon = rolloverSelectedIcon;
        setRollOverEnabled(true);
        if (rolloverSelectedIcon != oldValue) {
        	uninstallIcon(oldValue);
        	installIcon(rolloverSelectedIcon);
            //if (isSelected()) {
                repaint();
            //}
        }
    }
    
    /**
     * Returns the icon used by the button when it's disabled.
     * If no disabled icon has been set, the button constructs
     * one from the default icon. 
     * <p>
     * The disabled icon really should be created 
     * (if necessary) by the L&F.-->
     *
     * @return the <code>disabledIcon</code> property
     * See `#getPressedIcon()`
     * See `#setDisabledIcon()`
     */
    @:dox(hide)
    public function getDisabledIcon():Icon {
        if(_disabledIcon == null) {
            if(_defaultIcon != null) {
            	//TODO imp with UIResource??
                //return new GrayFilteredIcon(defaultIcon);
                return _defaultIcon;
            }
        }
        return _disabledIcon;
    }
    
    /**
     * Sets the disabled icon for the button.
     * @param disabledIcon the icon used as the disabled image
     * See `#getDisabledIcon()`
     */
    @:dox(hide)
    public function setDisabledIcon(disabledIcon:Icon):Void{
        var oldValue:Icon = this._disabledIcon;
        this._disabledIcon = disabledIcon;
        if (disabledIcon != oldValue) {
        	uninstallIcon(oldValue);
        	installIcon(disabledIcon);
            //if (!isEnabled()) {
                repaint();
            //}
        }
    }
    
    /**
     * Returns the icon used by the button when it's disabled and selected.
     * If not no disabled selection icon has been set, the button constructs
     * one from the selection icon. 
     * <p>
     * The disabled selection icon really should be 
     * created (if necessary) by the L&F. -->
     *
     * @return the <code>disabledSelectedIcon</code> property
     * See `#getPressedIcon()`
     * See `#setDisabledIcon()`
     */
    @:dox(hide)
    public function getDisabledSelectedIcon():Icon {
        if(_disabledSelectedIcon == null) {
            if(_selectedIcon != null) {
            	//TODO imp with UIResource??
                //disabledSelectedIcon = new GrayFilteredIcon(selectedIcon);
            } else {
                return getDisabledIcon();
            }
        }
        return _disabledSelectedIcon;
    }

    /**
     * Sets the disabled selection icon for the button.
     * @param disabledSelectedIcon the icon used as the disabled
     * 		selection image
     * See `#getDisabledSelectedIcon()`
     */
    @:dox(hide)
    public function setDisabledSelectedIcon(disabledSelectedIcon:Icon):Void{
        var oldValue:Icon = this._disabledSelectedIcon;
        this._disabledSelectedIcon = disabledSelectedIcon;
        if (disabledSelectedIcon != oldValue) {
        	uninstallIcon(oldValue);
        	installIcon(disabledSelectedIcon);
            //if (!isEnabled() && isSelected()) {
                repaint();
                revalidate();
            //}
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
    @:dox(hide)
    public function getVerticalAlignment():Int{
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
    public function setVerticalAlignment(alignment:Int):Void{
        if (alignment == _verticalAlignment){
        	return;
        }else{
        	_verticalAlignment = alignment;
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
    public function getHorizontalAlignment():Int{
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
    public function setHorizontalAlignment(alignment:Int):Void{
        if (alignment == _horizontalAlignment){
        	return;
        }else{
        	_horizontalAlignment = alignment;
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
    public function getVerticalTextPosition():Int{
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
    public function setVerticalTextPosition(textPosition:Int):Void{
        if (textPosition == _verticalTextPosition){
	        return;
        }else{
        	_verticalTextPosition = textPosition;
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
    public function getHorizontalTextPosition():Int{
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
    public function setHorizontalTextPosition(textPosition:Int):Void{
        if (textPosition == _horizontalTextPosition){
        	return;
        }else{
        	_horizontalTextPosition = textPosition;
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
     * See `#setIconTextGap()`
     */
    @:dox(hide)
    public function getIconTextGap():Int{
        return _iconTextGap;
    }

    /**
     * If both the icon and text properties are set, this property
     * defines the space between them.  
     * <p>
     * The default value of this property is 4 pixels.
     * 
     * See `#getIconTextGap()`
     */
    @:dox(hide)
    public function setIconTextGap(iconTextGap:Int):Void{
        var oldValue:Int= this._iconTextGap;
        this._iconTextGap = iconTextGap;
        if (iconTextGap != oldValue) {
            revalidate();
            repaint();
        }
    }
    
    /**
     * Returns the shift offset when mouse press.
     *
     * @return the shift offset when mouse press.
     */
    @:dox(hide)
    public function getShiftOffset():Int{
        return _shiftOffset;
    }

    /**
     * Set the shift offset when mouse press.
     */
    @:dox(hide)
    public function setShiftOffset(shiftOffset:Int):Void{
        var oldValue:Int= this._shiftOffset;
        this._shiftOffset = shiftOffset;
        setShiftOffsetSet(true);
        if (shiftOffset != oldValue) {
            revalidate();
            repaint();
        }
    }
    
    /**
     * Return whether or not the shiftOffset has set by user. The LAF will not change this value if it is true.
     */
    @:dox(hide)
    public function isShiftOffsetSet():Bool{
    	return shiftOffsetSet;
    }
    
   /**
    * Set whether or not the shiftOffset has set by user. The LAF will not change this value if it is true.
    */
    @:dox(hide)
    public function setShiftOffsetSet(b:Bool):Void{
    	shiftOffsetSet = b;
    }
    
    //--------------------------------------------------------------
    //			internal handlers
    //--------------------------------------------------------------
	
	private function initSelfHandlers():Void {

        addEventListener(TouchEvent.TOUCH_ROLL_OUT, __rollOutListener);
		addEventListener(MouseEvent.ROLL_OUT, __rollOutListener);
		addEventListener(MouseEvent.ROLL_OVER, __rollOverListener);
		addEventListener(MouseEvent.MOUSE_DOWN, __mouseDownListener);
		addEventListener(MouseEvent.MOUSE_UP, __mouseUpListener);
		addEventListener(ReleaseEvent.RELEASE, __mouseReleaseListener);
		addEventListener(Event.ADDED_TO_STAGE, __addedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, __removedFromStage);
	}
	
	private var rootPane:JRootPane;
	private function __addedToStage(e:Event):Void{
		rootPane = getRootPaneAncestor();
		if(rootPane != null){
			rootPane.registerMnemonic(this);
		}
	}

	private function __removedFromStage(e:Event):Void{
		if(rootPane != null){
			rootPane.unregisterMnemonic(this);
			rootPane = null;
		}
	}
	
	private function __rollOverListener(e:MouseEvent):Void{
		var m:ButtonModel = getModel();
		if(isRollOverEnabled()) {
			if(m.isPressed() || !e.buttonDown){
				m.setRollOver(true);
			}
		}
		if(m.isPressed()){
			m.setArmed(true);
		}
	}

	private function __rollOutListener(e:MouseEvent):Void{
        var m:ButtonModel = getModel();
		if(isRollOverEnabled()) {
			if(!m.isPressed()){
				m.setRollOver(false);
			}
		}
		m.setArmed(false);
	}

	private function __mouseDownListener(e:Event):Void {
		getModel().setArmed(true);
		getModel().setPressed(true);

	}

	private function __mouseUpListener(e:Event):Void{
		if(isRollOverEnabled()) {
			getModel().setRollOver(true);
		}

    }

	private function __mouseReleaseListener(e:Event):Void {
 
		getModel().setPressed(false);
		getModel().setArmed(false);
		if(isRollOverEnabled() && !hitTestMouse()){
			getModel().setRollOver(false);
		}
	}
	
	private function __modelActionListener(e:AWEvent):Void{
		dispatchEvent(new AWEvent(AWEvent.ACT));
        doBackgroundTransition();
    }
	
	private function __modelStateListener(e:AWEvent):Void{
        bindx.Bind.notify(this.selected);
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED));
        doBackgroundTransition();
	}
	
	private function __modelSelectionListener(e:AWEvent):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.SELECTION_CHANGED));
        doBackgroundTransition();
	}

    public var transitBackgroundFactor: Float = 0.0;

    private function calculateTargetBackgroundTransitionFactor(): Float {
        return
            if (model.isPressed()) -1.0
            else if (model.isRollOver()) 1.0
            else 0.0;
    }

    private function doBackgroundTransition(immediately:Bool = false) {

        var targetFactor: Float = calculateTargetBackgroundTransitionFactor();
        if (transitBackgroundFactor != targetFactor) {
            if (immediately) {
                transitBackgroundFactor = targetFactor;
                return;
            }
            Actuate.stop(this, "transitBackgroundFactor");
            Actuate.tween(this, 0.25, { transitBackgroundFactor: targetFactor })
                .ease(Linear.easeNone)
                .onUpdate(function() {
                    repaint();
                })
                .onComplete(function() { transitBackgroundFactor = targetFactor; });
        }
    }
}
