/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
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
 * Dispatched when the button's model take action, generally when user click the 
 * button or <code>doClick()</code> method is called.
 * @eventType org.aswing.event.AWEvent.ACT
 * @see org.aswing.AbstractButton#addActionListener()
 */
// [Event(name="act", type="org.aswing.event.AWEvent")]

/**
 * Dispatched when the button's state changed. the state is all about:
 * <ul>
 * <li>enabled</li>
 * <li>rollOver</li>
 * <li>pressed</li>
 * <li>released</li>
 * <li>selected</li>
 * </ul>
 * </p>
 * <p>
 * Buttons always fire <code>programmatic=false</code> InteractiveEvent.
 * </p>
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]
	
/**
 *  Dispatched when the button's selection changed.
 * <p>
 * Buttons always fire <code>programmatic=false</code> InteractiveEvent.
 * </p>
 *  @eventType org.aswing.event.InteractiveEvent.SELECTION_CHANGED
 */
// [Event(name="selectionChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * Defines common behaviors for buttons and menu items.
 * @author paling
 */
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
	

    /** The data model that determines the button's state. */
    private var model:ButtonModel;
    
    private var _text:String;
	public var text(get, set): String;
	private function get_text(): String { return getText(); }
	private function set_text(s: String): String { setText(s); return s; }

	private var displayText:String;
	private var mnemonic:Int;
	private var mnemonicIndex:Int;
	private var mnemonicEnabled:Bool;
    private var margin:Insets;
    private var defaultMargin:Insets;

    // Button icons
    private var       defaultIcon:Icon;
    private var       pressedIcon:Icon;
    private var       disabledIcon:Icon;

    private var       selectedIcon:Icon;
    private var       disabledSelectedIcon:Icon;

    private var       rolloverIcon:Icon;
    private var       rolloverSelectedIcon:Icon;
    
    // Display properties
    private var    rolloverEnabled:Bool;

    // Icon/Label Alignment
    private var        verticalAlignment:Int;
    private var        horizontalAlignment:Int;
    
    private var        verticalTextPosition:Int;
    private var        horizontalTextPosition:Int;

    private var        iconTextGap:Int;	
    private var shiftOffset:Int;
    private var shiftOffsetSet:Bool;
    
    private var        textFilters:Array<BitmapFilter>;
	
	public function new(text:String="", icon:Icon=null){
		this.shiftOffset=0;
		this.shiftOffsetSet=false;
			super();
	 	
		setName("AbstractButton");
	
    	rolloverEnabled = true;
    	
    	verticalAlignment = CENTER;
    	horizontalAlignment = CENTER;
    	verticalTextPosition = CENTER;
    	horizontalTextPosition = RIGHT;
    		
    	textFilters = new Array<BitmapFilter>();
    	
    	iconTextGap = 2;
    	mnemonicEnabled = true;
    	this._text = text;
    	this.analyzeMnemonic();
    	this.defaultIcon = icon;
    	//setText(text);
    	//setIcon(icon);
    	initSelfHandlers();
    	
    	updateUI(); 
    	installIcon(defaultIcon);
	}

    /**
     * Returns the model that this button represents.
     * @return the <code>model</code> property
     * @see #setModel()
     */
    public function getModel():ButtonModel{
        return model;
    }
    
    /**
     * Sets the model that this button represents.
     * @param m the new <code>ButtonModel</code>
     * @see #getModel()
     */
    public function setModel(newModel:ButtonModel):Void{
        
        var oldModel:ButtonModel = getModel();
        
        if (oldModel != null) {
        	oldModel.removeActionListener(__modelActionListener);
            oldModel.removeStateListener(__modelStateListener);
            oldModel.removeSelectionListener(__modelSelectionListener);
        }
        
        model = newModel;
        
        if (newModel != null) {
        	newModel.addActionListener(__modelActionListener);
            newModel.addStateListener(__modelStateListener);
            newModel.addSelectionListener(__modelSelectionListener);
        }

        if (newModel != oldModel) {
            revalidate();
            repaint();
        }
    }
         
    /**
     * Resets the UI property to a value from the current look
     * and feel.  Subtypes of <code>AbstractButton</code>
     * should override this to update the UI. For
     * example, <code>JButton</code> might do the following:
     * <pre>
     *      setUI(ButtonUI(UIManager.getUI(this)));
     * </pre>
     */
    override public function updateUI():Void{
    	throw new ImpMissError();
    }
    
    /**
     * Programmatically perform a "click".
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
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.AWEvent#ACT
     */
    public function addActionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
    	addEventListener(AWEvent.ACT, listener, false, priority, useWeakReference);
    }
	/**
	 * Removes a action listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.AWEvent#ACT
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
	 * @see org.aswing.event.InteractiveEvent#SELECTION_CHANGED
	 */	
	public function addSelectionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(InteractiveEvent.SELECTION_CHANGED, listener, false, priority);
	}

	/**
	 * Removes a selection listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.InteractiveEvent#SELECTION_CHANGED
	 */
	public function removeSelectionListener(listener:Dynamic -> Void):Void{
		removeEventListener(InteractiveEvent.SELECTION_CHANGED, listener);
	}
	
	/**
	 * Adds a listener to listen the button's state change event.
	 * <p>
	 * When the button's state changed, the state is all about:
	 * <ul>
	 * <li>enabled</li>
	 * <li>rollOver</li>
	 * <li>pressed</li>
	 * <li>released</li>
	 * <li>selected</li>
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
	override public function setEnabled(b:Bool):Void{
		if (!b && model.isRollOver()) {
	    	model.setRollOver(false);
		}
        super.setEnabled(b);
        model.setEnabled(b);
    }    

    /**
     * Returns the state of the button. True if the
     * toggle button is selected, false if it's not.
     * @return true if the toggle button is selected, otherwise false
     */
    public function isSelected():Bool{
        return model.isSelected();
    }
    
    /**
     * Sets the state of the button. Note that this method does not
     * trigger ACT Event for users(will of course trigger STATE_CHANGED event).
     * Call <code>click</code> to perform a programatic action change.
     *
     * @param b  true if the button is selected, otherwise false
     */
    public function setSelected(b:Bool):Void{
        model.setSelected(b);
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
     * @see #isRollOverEnabled()
     */
    public function setRollOverEnabled(b:Bool):Void{
    	if(rolloverEnabled != b){
    		rolloverEnabled = b;
    		repaint();
    	}
    }
    
    /**
     * Gets the <code>rolloverEnabled</code> property.
     *
     * @return the value of the <code>rolloverEnabled</code> property
     * @see #setRollOverEnabled()
     */    
    public function isRollOverEnabled():Bool{
    	return rolloverEnabled;
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

        var old:Insets = margin;
        margin = m;
        if (old == null || !m.equals(old)) {
            revalidate();
        	repaint();
        }
	}
	
	public function getMargin():Insets{
		var m:Insets = margin;
		if(margin == null){
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
	
	public function setTextFilters(fs:Array<BitmapFilter>):Void{
		textFilters = fs;
		repaint();
	}
	
	public function getTextFilters():Array<BitmapFilter>{
		return textFilters;
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
	 * @see #getDisplayText()
	 * @see #getMnemonic()
	 * @see #getMnemonicIndex()
	 */
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
	public function setMnemonicEnabled(b:Bool):Void{
		if(mnemonicEnabled != b){
			mnemonicEnabled = b;
			analyzeMnemonic();
		}
	}
	
	/**
	 * Returns whether or not enabled mnemonic.
	 */	
	public function isMnemonicEnabled():Bool{
		return mnemonicEnabled;
	}
	
	private function analyzeMnemonic():Void{
		displayText = _text;
		mnemonic = -1;
		mnemonicIndex = -1;
		if(_text == null){
			return;
		}
		if(mnemonicEnabled!=true){
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
	 * @see #getDisplayText()
	 */
	public function getText():String{
		return _text;
	}
	
	/**
	 * Returns the text to be displayed, it is a text that removed the "&"(mnemonic modifier char).
	 * @return the text to be displayed.
	 */
	public function getDisplayText():String{
		return displayText;	
	}
	
	/**
	 * Returns the mnemonic char index in the display text, -1 means no mnemonic.
	 * @return the mnemonic char index or -1.
	 * @see #getDisplayText()
	 */
	public function getMnemonicIndex():Int{
		return mnemonicIndex;
	}
	
	/**
	 * Returns the keyboard mnemonic for this button, -1 means no mnemonic.
	 * @return the keyboard mnemonic or -1.
	 */
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
	public function setIcon(defaultIcon:Icon):Void{
		if(this.defaultIcon != defaultIcon){
			uninstallIcon(this.defaultIcon);
			this.defaultIcon = defaultIcon;
			installIcon(defaultIcon);
			repaint();
			invalidate();
		}
	}

	public function getIcon():Icon{
		return defaultIcon;
	}
    
    /**
     * Returns the pressed icon for the button.
     * @return the <code>pressedIcon</code> property
     * @see #setPressedIcon()
     */
    public function getPressedIcon():Icon {
        return pressedIcon;
    }
    
    /**
     * Sets the pressed icon for the button.
     * @param pressedIcon the icon used as the "pressed" image
     * @see #getPressedIcon()
     */
    public function setPressedIcon(pressedIcon:Icon):Void{
        var oldValue:Icon = this.pressedIcon;
        this.pressedIcon = pressedIcon;
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
     * @see #setSelectedIcon()
     */
    public function getSelectedIcon():Icon {
        return selectedIcon;
    }
    
    /**
     * Sets the selected icon for the button.
     * @param selectedIcon the icon used as the "selected" image
     * @see #getSelectedIcon()
     */
    public function setSelectedIcon(selectedIcon:Icon):Void{
        var oldValue:Icon = this.selectedIcon;
        this.selectedIcon = selectedIcon;
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
     * @see #setRollOverIcon()
     */
    public function getRollOverIcon():Icon {
        return rolloverIcon;
    }
    
    /**
     * Sets the rollover icon for the button.
     * @param rolloverIcon the icon used as the "rollover" image
     * @see #getRollOverIcon()
     */
    public function setRollOverIcon(rolloverIcon:Icon):Void{
        var oldValue:Icon = this.rolloverIcon;
        this.rolloverIcon = rolloverIcon;
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
     * @see #setRollOverSelectedIcon()
     */
    public function getRollOverSelectedIcon():Icon {
        return rolloverSelectedIcon;
    }
    
    /**
     * Sets the rollover selected icon for the button.
     * @param rolloverSelectedIcon the icon used as the
     *		"selected rollover" image
     * @see #getRollOverSelectedIcon()
     */
    public function setRollOverSelectedIcon(rolloverSelectedIcon:Icon):Void{
        var oldValue:Icon = this.rolloverSelectedIcon;
        this.rolloverSelectedIcon = rolloverSelectedIcon;
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
     * @see #getPressedIcon()
     * @see #setDisabledIcon()
     */
    public function getDisabledIcon():Icon {
        if(disabledIcon == null) {
            if(defaultIcon != null) {
            	//TODO imp with UIResource??
                //return new GrayFilteredIcon(defaultIcon);
                return defaultIcon;
            }
        }
        return disabledIcon;
    }
    
    /**
     * Sets the disabled icon for the button.
     * @param disabledIcon the icon used as the disabled image
     * @see #getDisabledIcon()
     */
    public function setDisabledIcon(disabledIcon:Icon):Void{
        var oldValue:Icon = this.disabledIcon;
        this.disabledIcon = disabledIcon;
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
     * @see #getPressedIcon()
     * @see #setDisabledIcon()
     */
    public function getDisabledSelectedIcon():Icon {
        if(disabledSelectedIcon == null) {
            if(selectedIcon != null) {
            	//TODO imp with UIResource??
                //disabledSelectedIcon = new GrayFilteredIcon(selectedIcon);
            } else {
                return getDisabledIcon();
            }
        }
        return disabledSelectedIcon;
    }

    /**
     * Sets the disabled selection icon for the button.
     * @param disabledSelectedIcon the icon used as the disabled
     * 		selection image
     * @see #getDisabledSelectedIcon()
     */
    public function setDisabledSelectedIcon(disabledSelectedIcon:Icon):Void{
        var oldValue:Icon = this.disabledSelectedIcon;
        this.disabledSelectedIcon = disabledSelectedIcon;
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
    public function getVerticalAlignment():Int{
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
    public function setVerticalAlignment(alignment:Int):Void{
        if (alignment == verticalAlignment){
        	return;
        }else{
        	verticalAlignment = alignment;
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
    public function getHorizontalAlignment():Int{
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
    public function setHorizontalAlignment(alignment:Int):Void{
        if (alignment == horizontalAlignment){
        	return;
        }else{
        	horizontalAlignment = alignment;     
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
    public function getVerticalTextPosition():Int{
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
    public function setVerticalTextPosition(textPosition:Int):Void{
        if (textPosition == verticalTextPosition){
	        return;
        }else{
        	verticalTextPosition = textPosition;
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
    public function getHorizontalTextPosition():Int{
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
    public function setHorizontalTextPosition(textPosition:Int):Void{
        if (textPosition == horizontalTextPosition){
        	return;
        }else{
        	horizontalTextPosition = textPosition;
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
    public function getIconTextGap():Int{
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
    public function setIconTextGap(iconTextGap:Int):Void{
        var oldValue:Int= this.iconTextGap;
        this.iconTextGap = iconTextGap;
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
    public function getShiftOffset():Int{
        return shiftOffset;
    }

    /**
     * Set the shift offset when mouse press.
     */
    public function setShiftOffset(shiftOffset:Int):Void{
        var oldValue:Int= this.shiftOffset;
        this.shiftOffset = shiftOffset;
        setShiftOffsetSet(true);
        if (shiftOffset != oldValue) {
            revalidate();
            repaint();
        }
    }
    
    /**
     * Return whether or not the shiftOffset has set by user. The LAF will not change this value if it is true.
     */
    public function isShiftOffsetSet():Bool{
    	return shiftOffsetSet;
    }
    
   /**
    * Set whether or not the shiftOffset has set by user. The LAF will not change this value if it is true.
    */
    public function setShiftOffsetSet(b:Bool):Void{
    	shiftOffsetSet = b;
    }
    
    //--------------------------------------------------------------
    //			internal handlers
    //--------------------------------------------------------------
	
	private function initSelfHandlers():Void {
	 
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
	}
	
	private function __modelStateListener(e:AWEvent):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED));
	}
	
	private function __modelSelectionListener(e:AWEvent):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.SELECTION_CHANGED));
	}
	
}
