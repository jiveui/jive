/*
 Copyright aswing.org, see the LICENCE.txt.
*/


package org.aswing;


import bindx.IBindable;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.FocusEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.Lib; 

import org.aswing.dnd.SourceData;
	import org.aswing.event.PropertyChangeEvent;
	import org.aswing.event.AWEvent;
	import org.aswing.event.MovedEvent;
	import org.aswing.event.ResizedEvent;
	import org.aswing.event.FocusKeyEvent;
	import org.aswing.event.DragAndDropEvent;
	import org.aswing.event.ClickCountEvent;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.plaf.ComponentUI;
	import org.aswing.plaf.InsetsUIResource;
	import org.aswing.plaf.UIResource;
	import org.aswing.plaf.DefaultEmptyDecoraterResource;
 
	import org.aswing.util.Reflection;
	
//--------------------------------------
//  Events
//--------------------------------------

/**
 *  Dispatched when the component visible is set to true from false.
 *
 *  @eventType org.aswing.event.AWEvent.SHOWN
 */
// [Event(name="shown", type="org.aswing.event.AWEvent")]

/**
 *  Dispatched when the component visible is set to false from true.
 *
 *  @eventType org.aswing.event.AWEvent.HIDDEN
 */
// [Event(name="hidden", type="org.aswing.event.AWEvent")]

/**
 *  Dispatched when the component is painted.
 *
 *  @eventType org.aswing.event.AWEvent.PAINT
 */
// [Event(name="paint", type="org.aswing.event.AWEvent")]

/**
 *  Dispatched when the component is moved.
 *
 *  @eventType org.aswing.event.MovedEvent.MOVED
 */
// [Event(name="moved", type="org.aswing.event.MovedEvent")]
	
/**
 *  Dispatched when the component is resized.
 *
 *  @eventType org.aswing.event.ResizedEvent.RESIZED
 */
// [Event(name="resized", type="org.aswing.event.ResizedEvent")]

/**
 * Dispatched when the component gained the focus from it is not the focus owner
 * 
 * @eventType org.aswing.event.AWEvent.FOCUS_GAINED
 */
// [Event(name="focusGained", type="org.aswing.event.AWEvent")]
	
/**
 * Dispatched when the component lost the focus from it was the focus owner.
 * 
 * @eventType org.aswing.event.AWEvent.FOCUS_LOST
 */
// [Event(name="focusLost", type="org.aswing.event.AWEvent")]

/**
 * Dispatched when the key down and the component is the focus owner.
 * 
 * @eventType org.aswing.event.FocusKeyEvent.FOCUS_KEY_DOWN
 */
// [Event(name="focusKeyDown", type="org.aswing.event.FocusKeyEvent")]
	
/**
 * Dispatched when the key up and the component is the focus owner.
 * 
 * @eventType org.aswing.event.FocusKeyEvent.FOCUS_KEY_UP
 */
// [Event(name="focusKeyUp", type="org.aswing.event.FocusKeyEvent")]

/**
 *  Dispatched when the component is clicked continuesly.
 *
 *  @eventType org.aswing.event.ClickCountEvent.CLICK_COUNT
 */
// [Event(name="clickCount", type="org.aswing.event.ClickCountEvent")]


/**
 * Dispatched when the component is recongnized that it can be drag start.
 * @see #isDragEnabled()
 * 
 * @eventType org.aswing.event.DragAndDropEvent.DRAG_RECOGNIZED
 */
// [Event(name="dragRecognized", type="org.aswing.event.DragAndDropEvent")]

/**
 * Dispatched when a drag is enter this component area.
 * @see #isDropTrigger()
 * 
 * @eventType org.aswing.event.DragAndDropEvent.DRAG_ENTER
 */
// [Event(name="dragEnter", type="org.aswing.event.DragAndDropEvent")]

/**
 * Dispatched when a drag is exit this component area.
 * @see #isDropTrigger()
 * 
 * @eventType org.aswing.event.DragAndDropEvent.DRAG_EXIT
 */
// [Event(name="dragExit", type="org.aswing.event.DragAndDropEvent")]

/**
 * Dispatched when a drag is drop on this component.
 * @see #isDropTrigger()
 * 
 * @eventType org.aswing.event.DragAndDropEvent.DRAG_DROP
 */
// [Event(name="dragDrop", type="org.aswing.event.DragAndDropEvent")]

/**
 * Dispatched when a drag is moving on this component.
 * @see #isDropTrigger()
 * 
 * @eventType org.aswing.event.DragAndDropEvent.DRAG_OVERRING
 */
// [Event(name="dragOverring", type="org.aswing.event.DragAndDropEvent")]

/**
 * The super class for all Components.
 * 
 * <p>The maximumSize and minimumSize are the component's represent max or min size.</p>
 * 
 * <p>You can set a Component's size max than its maximumSize, but when it was drawed,
 * it will not max than its maximumSize.Just as its maximumSize and posited itself
 * in that size dimension you just setted. The position is relative to <code>getAlignmentX</code> 
 * and <code>getAlignmentY<code>.
 * </p>
 * @see #setSize()
 * @see #setPrefferedSize()
 * @see #getAlignmentX()
 * 
 * @author paling
 */	
class Component extends AWSprite implements IBindable {
	/**
	 * The max interval time to judge whether click was continuously.
	 */
	private static var MAX_CLICK_INTERVAL:Int= 400;
	private static var AWML_INDEX:Int= 0;
	private var ui:ComponentUI;
	public var container:Container;
	private var clientProperty:haxe.ds.StringMap<Dynamic>;
	
	private var awmlID:String;
	private var awmlIndex:Int;
	private var awmlNamespace:String;
	
	private var clipBounds:IntRectangle;
	private var alignmentX:Float;
	private var alignmentY:Float;
	private var minimumSize:IntDimension;
	private var maximumSize:IntDimension;
	private var preferredSize:IntDimension;
	
	private var cachePreferSizes:Bool;
	private var cachedPreferredSize:IntDimension;
	private var cachedMinimumSize:IntDimension;
	private var cachedMaximumSize:IntDimension;
	private var constraints:Dynamic;
	private var uiElement:Bool;
	
	private  var drawTransparentTrigger:Bool;
	private var valid:Bool;
	private var bounds:IntRectangle;
	private var readyToPaint:Bool;
	
	private var _background:ASColor;
	public var background(get,set): ASColor;
	private function get_background(): ASColor { return getBackground(); }
	private function set_background(v: ASColor): ASColor { setBackground(v); return v; }

	private var _foreground:ASColor;
	public var foreground(get,set): ASColor;
	private function get_foreground(): ASColor { return getForeground(); }
	private function set_foreground(v: ASColor): ASColor { setForeground(v); return v; }

	private var _mideground:ASColor;
	public var mideground(get,set): ASColor;
	private function get_mideground(): ASColor { return getMideground(); }
	private function set_mideground(v: ASColor): ASColor { setMideground(v); return v; }

	private var styleTune:StyleTune;
	private var styleProxy:Component;
	private var backgroundDecorator:GroundDecorator;
	private var foregroundDecorator:GroundDecorator;
	private var font:ASFont;
	private var fontValidated:Bool;

	private var _opaque:Bool;
	public var opaque(get,set): Bool;
	private function get_opaque(): Bool { return isOpaque(); }
	private function set_opaque(v: Bool): Bool { setOpaque(v); return v; }

	private var opaqueSet:Bool;

	private var _border:Border;
	public var border(get, set): Border;
	private function get_border(): Border { return getBorder(); }
	private function set_border(v: Border): Border { setBorder(v); return v; }

	private var enabled:Bool;
	private var focusable:Bool;
	private var focusableSet:Bool;
	private var toolTipText:String;
	private var dragEnabled:Bool;
	private var dropTrigger:Bool;
	private var dragAcceptableInitiator:haxe.ds.IntMap<Bool>;
	private var dragAcceptableInitiatorAppraiser:Dynamic->Bool;
	private var resizerMargin:Insets;
	
	public function new()
	{
		bounds = new IntRectangle();
		AWML_INDEX++;
		awmlIndex = AWML_INDEX;
		drawTransparentTrigger=true;
		super();
		setName("Component");
		ui = null;
		clientProperty = null;
		alignmentX = 0;
		alignmentY = 0;
		_opaque = false;
		opaqueSet = false;
		valid = false;
		enabled = true;
		focusable = false;
		focusableSet = false;
		cachePreferSizes = true;
		fontValidated = false;
		readyToPaint = false;
		toolTipText = null;
		uiElement = false;
		_border = DefaultEmptyDecoraterResource.INSTANCE;
		backgroundDecorator = DefaultEmptyDecoraterResource.INSTANCE;
		foregroundDecorator = DefaultEmptyDecoraterResource.INSTANCE;
		
		font = DefaultEmptyDecoraterResource.DEFAULT_FONT;
		_background = DefaultEmptyDecoraterResource.DEFAULT_BACKGROUND_COLOR;
		_foreground = DefaultEmptyDecoraterResource.DEFAULT_FOREGROUND_COLOR;
		_mideground = DefaultEmptyDecoraterResource.DEFAULT_MIDEGROUND_COLOR;
		styleTune  = DefaultEmptyDecoraterResource.DEFAULT_STYLE_TUNE;
		
		addEventListener(FocusEvent.FOCUS_IN, __focusIn);
		addEventListener(FocusEvent.FOCUS_OUT, __focusOut);
		addEventListener(MouseEvent.MOUSE_DOWN, __mouseDown);
		addEventListener(MouseEvent.CLICK, __mouseClick);
		addEventListener(Event.ADDED, __componentAdded);
		 
	}
	
	private function __componentAdded(e:Event):Void{
		if(isUIElement()){
			var dis:DisplayObject = AsWingUtils.as(e.target,DisplayObject)	;
			if(dis != null){
				if(dis != this){
					if(AsWingUtils.getOwnerComponent(dis.parent) == this){
						makeAllTobeUIElement(AsWingUtils.as(e.target,DisplayObject)	);
					}
				}
			}
		}
	}
	
	private function makeAllTobeUIElement(dis:DisplayObject):Void{
		if(dis == null){
			return;
		}
		if(Std.is(dis,Component)){
			var c:Component = AsWingUtils.as(dis,Component)	;
			c.uiElement = true;
		}
		if(Std.is(dis,DisplayObjectContainer)){
			var con:DisplayObjectContainer = AsWingUtils.as(dis,DisplayObjectContainer)	;
			for(i in 0...con.numChildren ){
				makeAllTobeUIElement(con.getChildAt(i));
			}
		}
	}
		    
	/**
	 * Sets ID used to identify components created from AWML. Used to obtain components through 
	 * {@link org.aswing.awml.AwmlManager}. You should never modify this value.
	 * 
	 * @param id the component's AWML ID
	 */
	public function setAwmlID(id:String):Void{
		awmlID = id;	
	}

	/**
	 * Returns ID used to identify components created from AWML.
	 * 
	 * @return the AWML ID
	 */
	public function getAwmlID():String{
		return awmlID;
	}

	/**
	 * Sets namespace used to identify components created from AWML. 
	 * Used to obtain components through {@link org.aswing.awml.AwmlManager}. 
	 * You should never modify this value.
	 * 
	 * @param theNamespace the new namespace name
	 */
	public function setAwmlNamespace(theNamespace:String):Void{
		awmlNamespace = theNamespace;	
	}

	/**
	 * Returns namespace name used to identify components created from AWML.
	 * 
	 * @return the namespace name
	 */
	public function getAwmlNamespace():String{
		return awmlNamespace;	
	}

	/**
	 * Sets ID used to identify components created from AWML. Used to obtain components through 
	 * {@link org.aswing.awml.AwmlManager}. You should never modify this value.
	 * 
	 * @param index the position index of the component
	 */
	public function setAwmlIndex(index:Int):Void{
		awmlIndex = index;	
	}

	/**
	 * Returns position index of the component inside its AWML container.
	 * 
	 * @return the component index in the AWML
	 */
	public function getAwmlIndex():Int{
		return awmlIndex;	
	}
	    
	/**
     * Returns the <code>UIDefaults</code> key used to
     * look up the name of the <code>org.aswing.plaf.ComponentUI</code>
     * class that defines the look and feel
     * for this component.  Most applications will never need to
     * call this method.  Subclasses of <code>Component</code> that support
     * pluggable look and feel should override this method to
     * return a <code>UIDefaults</code> key that maps to the
     * <code>ComponentUI</code> subclass that defines their look and feel.
     *
     * @return the <code>UIDefaults</code> key for a
     *		<code>ComponentUI</code> subclass
     * @see org.aswing.UIDefaults#getUI()
     */
	public function getUIClassID():String{
		return "ComponentUI";
	}
	
	/**
	 * Sets the name of this component
	 * @see #name
	 */
	public function setName(name:String):Void{
		this.name = name;
	}
	
	/**
	 * Returns the name of the component
	 * @see #name
	 */
	public function getName():String{
		return name;
	}
	
    /**
     * Resets the UI property to a value from the current look and feel.
     * <code>Component</code> subclasses must override this method
     * like this:
     * <pre>
     *   public void updateUI() {
     *      setUI(SliderUI(UIManager.getUI(this)));
     *   }
     *  </pre>
     *
     * @see #setUI()
     * @see org.aswing.UIManager#getLookAndFeel()
     * @see org.aswing.UIManager#getUI()
     */
    public function updateUI():Void{
    	//throw new ImpMissError();
    }
    
    /**
     * Returns true if this component is just a ui element component, 
     * false means this component is a regular use created component.
     * <p>
     * If a component is a ui element, it and its children will not be called 
     * <code>updateUI()</code> when AsWingUtils to go thought a list of component to update the UI.
     * That is because ui element will be removed when uninstall UI, new ui elements 
     * will be created when install UI. So it do not need to do update.
     * </p>
     * @return whether or not this component is a ui element component.
     * @see #AsWingUtils#updateChildrenUI()
     * @see #setUIElement()
     */
    public function isUIElement():Bool{
    	return uiElement;
    }
    
    /**
     * Sets the component is a ui element or not. (if set true, all of its children will be set to true too)
     * @param b true to set this component to be treated as a element, false not.
     * @see #isUIElement()
     */
    public function setUIElement(b:Bool):Void{
    	if(uiElement != b){
    		uiElement = b;
    		if(b){
    			makeAllTobeUIElement(this);
    		}
    	}
    }
    
    /**
     * Returns the default basic ui class for this component.
     * If there is not a ui class specified in L&F for this component, 
     * this method will be called to return a default one.
     * @return the default basic ui class. 
     */
    public function getDefaultBasicUIClass():Class<Dynamic>{
    	//throw new ImpMissError();
    	return null;
    }

    /**
     * Sets the look and feel delegate for this component.
     * <code>Component</code> subclasses generally override this method
     * to narrow the argument type. For example, in <code>JSlider</code>:
     * <pre>
     * public void setUI(SliderUI newUI) {
     *     setUI(newUI);
     * }
     *  </pre>
     * <p>
     * Additionally <code>Component</code> subclasses must provide a
     * <code>getUI</code> method that returns the correct type.  For example:
     * <pre>
     * public SliderUI getUI() {
     *     return (SliderUI)ui;
     * }
     * </pre>
     *
     * @param newUI the new UI delegate
     * @see #updateUI()
     * @see UIManager#getLookAndFeel()
     * @see UIManager#getUI()
     */
    public function setUI(newUI:ComponentUI):Void{
        /* We do not check that the UI instance is different
         * before allowing the switch in order to enable the
         * same UI instance *with different default settings*
         * to be installed.
         */
        if (ui != null) {
            ui.uninstallUI(this);
        }
        ui = newUI;
        if (ui != null) {
            ui.installUI(this);
        }
        revalidate();
        repaint();
    }
    
    public function getUI():ComponentUI{
    	return ui;
    }
	
	/**
	 * Sets the border for the component, null to remove border.
	 * Border's display object will always on top of background decorator but under other assets.
	 * @param border the new border to set, or null.
	 */
	public function setBorder(b:Border):Void { 
		if(b != _border){
			if(_border != null && _border.getDisplay(this) != null){
				removeChild(_border.getDisplay(this));
			}
			_border = b;
			
			if(_border != null && _border.getDisplay(this) != null){
				addChildAt(_border.getDisplay(this), getLowestIndexAboveBackground());
			}
			
			repaint();
			revalidate();
		}
	}
	
	/**
	 * Returns the border.
	 * @return the border.
	 */
	public function getBorder():Border{
		return _border;
	}
	
	/**
	 * If a border has been set on this component, returns the border's insets; 
	 * otherwise returns an empty insets.
	 */
	public function getInsets():Insets{
		if(_border == null){
			return new Insets();
		}else{
			return _border.getBorderInsets(this, getSize().getBounds());
		}
	}
	


	/**
	 * Sets space for margin between the component's border and
     * the resizer trigger.
     *
     * @param m the space between the component's border and the resizer trigger
	 */
	public function setResizerMargin(m:Insets):Void{
        if (resizerMargin != m) {
        	resizerMargin = m;
            revalidate();
        	repaint();
        }
	}
	
	public function getResizerMargin():Insets{
		var m:Insets = resizerMargin;
		if(m == null){
			return new InsetsUIResource();
		}else if(Std.is(m,UIResource)){//make it can be replaced by LAF
			return new InsetsUIResource(m.top, m.left, m.bottom, m.right);
		}else{
			return new Insets(m.top, m.left, m.bottom, m.right);
		}
	}	
	
	/**
	 * Sets a decorator to be the component background, it will represent the component background 
	 * with a <code>DisplayObject</code>. null to remove the decorator set before.
	 * 
	 * @param bg the background decorator.
	 */
	public function setBackgroundDecorator(bg:GroundDecorator):Void{
		if(bg != backgroundDecorator){
			var old:GroundDecorator= backgroundDecorator;
			backgroundDecorator = bg;
			if(bg != null){
				setBackgroundChild(bg.getDisplay(this));
			}else{
				setBackgroundChild(null);
			}
			dispatchEvent(new PropertyChangeEvent("backgroundDecorator", old, bg));
		}
	}
	
	/**
	 * Returns the background decorator of this component.
	 * @return the background decorator of this component.
	 */
	public function getBackgroundDecorator():GroundDecorator{
		return backgroundDecorator;
	}
	
	/**
	 * Sets a decorator to be the component foreground, it will represent the component foreground 
	 * with a <code>DisplayObject</code> on top of other children of this component. 
	 * null to remove the decorator set before.
	 * 
	 * @param fg the foreground decorator.
	 */
	public function setForegroundDecorator(fg:GroundDecorator):Void{
		if(fg != foregroundDecorator){
			var old:Dynamic= backgroundDecorator;
			foregroundDecorator = fg;
			if(fg != null){
				setForegroundChild(fg.getDisplay(this));
			}else{
				setForegroundChild(null);
			}
			dispatchEvent(new PropertyChangeEvent("foregroundDecorator", old, fg));
		}
	}
	
	/**
	 * Returns the foreground decorator of this component.
	 * @return the foreground decorator of this component.
	 */
	public function getForegroundDecorator():GroundDecorator{
		return foregroundDecorator;
	}
	
	/**
	 * Sets the <code>DisplayObject.visible</code> directly.
	 * @param value the visible
	 */	
	private function set_d_visible(value:Bool):Bool{
        #if (cpp)
		super.visible = value;
        #else
		visible = value;
        #end
    	return value;
	}
	
	/**
	 * Returns the <code>DisplayObject.visible</code> directly.
	 * @return the <code>DisplayObject.visible</code>
	 */
	private function get_d_visible():Bool{
        #if (cpp)
		return super.visible;
        #else
		return visible;
        #end
	}	
	
	#if(cpp)
    override private function set_visible(value:Bool):Bool {
		setVisible(value);
			return value;
		}
	
	override private function get_visible():Bool {
		return super.visible;
	}
    #end

	/**
	 * Set a component to be hide or shown.
	 * If a component was hide, some laterly operation may not be done,
	 * they will be done when next shown, ex: repaint, doLayout ....
	 * So suggest you dont changed a component's visible frequently.
	 */
	public function setVisible(v:Bool):Void{
		if(v != d_visible){
			d_visible = v;
			if(v){
				dispatchEvent(new AWEvent(AWEvent.SHOWN, false, false));
			}else{
				dispatchEvent(new AWEvent(AWEvent.HIDDEN, false, false));
			}
			//because the repaint and some other operating only do when visible
			//so when change to visible, must call repaint to do the operatings they had not done when invisible
			if(v){
				repaint();
			}
			revalidate();
		}
	}
	
	public function isVisible():Bool{
		return visible;
	}
		
	/**
	 * Determines whether or not this component is on stage(on the display list).
	 * @return turn of this component is on display list, false not.
	 */
	public function isOnStage():Bool{
		return stage != null;
	}
	
    /**
     * Determines whether this component is showing on screen. This means
     * that the component must be visible, and it must be in a container
     * that is visible and showing.
     * @return <code>true</code> if the component is showing,
     *          <code>false</code> otherwise
     * @see #setVisible()
     */    
    public function isShowing():Bool{
    	if(isOnStage() && isVisible()){
    		//here, parent is stage means this is the top component(ex root)
    		if(parent == stage){
    			return true;
    		}else{
    			if(getParent() != null){
    				return getParent().isShowing();
    			}else{
    				return AsWingUtils.isDisplayObjectShowing(parent);
    			}
    		}
    	}
    	return false;
    }
    
	/**
	 * Sets the text font for this component.<br>
	 * this method will cause a repaint and revalidate method call.<br>
	 * @param newFont the font to set for this component.
	 */
	public function setFont(newFont:ASFont):Void{
		if(font != newFont){
			font = newFont;
			setFontValidated(false);
			repaint();
			revalidate();
		}
	}
	
	/**
	 * Returns whether the new font are applied and taked effect.
	 * <p>
	 * Some UI can just apply font to text when this method returned false 
	 * to avoid wasteful time for font applying.
	 * @return true if currently font are applied to texts, otherwish false.
	 * @see #setFontValidated()
	 */
	public function isFontValidated():Bool{
		return fontValidated;
	}
	
	/**
	 * Sets whether the new font are applied and taked effect.
	 * <p>
	 * Once the UI applied the font, it can call this method to set the value 
	 * to be true, to avoid next wasteful applying.
	 * @return true set font are applied, otherwish false.
	 * @see #isFontValidated()
	 */
	public function setFontValidated(b:Bool):Void{
		fontValidated = b;
	}
	
	/**
     * Gets the font of this component.
     * @return this component's font; if a font has not been set
     * for this component and it has parent, the font of its style proxy is returned
     * @see #setFont()
     */
	public function getFont():ASFont{
        if (font != null && font != DefaultEmptyDecoraterResource.NULL_FONT) {
            return font;
        }else if(getStyleProxy() != null){
        	return getStyleProxy().getFont();
        }else{
        	return DefaultEmptyDecoraterResource.NULL_FONT;
        }
	}
	
	/**
     * Sets the background color of this component.
     * <p>
     * The background color affects each component differently.
     * Generally it affects the background of a component, or to be the main 
     * tinge of a component.
     *
     * @param c the color to become this component's color;
     *          if this parameter is <code>null</code> and it has style proxy, then this
     *          component will inherit the background color of its style proxy.
     * @see #getBackground()
	 */
	public function setBackground(c:ASColor):Void{
		if(_background != c){
			_background = c;
			repaint();
		}
	}
	
	/**
     * Gets the background color of this component.
     * @return this component's background color; if this component does
     *          not have a background color and it has style proxy,
     *          the background color of its style proxy is returned
     * @see #setBackground()
	 */
	public function getBackground():ASColor{
		if(_background != null && _background != DefaultEmptyDecoraterResource.NULL_COLOR){
			return _background;
		}else if(getStyleProxy() != null){
        	return getStyleProxy().getBackground();
        }else{
        	return DefaultEmptyDecoraterResource.NULL_COLOR;
        }
	}
	
	/**
     * Sets the foreground color of this component.
     * <p>
     * The foreground color affects each component differently. 
     * Generally it affects the text color of a component.
     *
     * @param c the color to become this component's color;
     *          if this parameter is <code>null</code> and it has style proxy, then this
     *          component will inherit the foreground color of its style proxy.
     * @see #getForeground()
	 */
	public function setForeground(c:ASColor):Void{
		if(_foreground != c){
			_foreground = c;
			repaint();
		}
	}
	
	/**
     * Gets the foreground color of this component.
     * @return this component's foreground color; if this component does
     *          not have a foreground color and it has parent,
     *          the foreground color of its parent is returned
     * @see #setForeground()
	 */
	public function getForeground():ASColor{
		if(_foreground != null && _foreground != DefaultEmptyDecoraterResource.NULL_COLOR){
			return _foreground;
		}else if(getStyleProxy() != null){
        	return getStyleProxy().getForeground();
        }else{
        	return DefaultEmptyDecoraterResource.NULL_COLOR;
        }
	}
	
	/**
     * Sets the mideground color of this component.
     * <p>
     * The mideground color affects each component differently, 
     * generally it affects the thumb color. Most component has no thumb will 
     * not use this property.
     *
     * @param c the color to become this component's color;
     *          if this parameter is <code>null</code> and it has style proxy, then this
     *          component will inherit the mideground color of its style proxy.
     * @see #getMideground()
	 */
	public function setMideground(c:ASColor):Void{
		if(_mideground != c){
			_mideground = c;
			repaint();
		}
	}
	
	/**
     * Gets the mideground color of this component.
     * @return this component's mideground color; if this component does
     *          not have a mideground color and it has parent,
     *          the mideground color of its parent is returned
     * @see #setMideground()
	 */
	public function getMideground():ASColor{
		if(_mideground != null && _mideground != DefaultEmptyDecoraterResource.NULL_COLOR){
			return _mideground;
		}else if(getStyleProxy() != null){
        	return getStyleProxy().getMideground();
        }else{
        	return DefaultEmptyDecoraterResource.NULL_COLOR;
        }
	}	
	

	/**
     * Sets the style tune of this component.
     * <p>
     * The style tune affects each component differently based on its LAF UI implements, 
     * generally it affects the border and content color gradient.
     * </p>
     * <p>
     * Not every LAF UI will use style tune. BasicLookAndFeel use it mostly.
     * </p>
     * @param c the style tune to become this component's param;
     *          if this parameter is <code>null</code>, then this
     *          component will use <code>DefaultEmptyDecoraterResource.NULL_COLOR_ADJUSTER</code>
     * @see #getColorAdjuster()
	 */
	public function setStyleTune(c:StyleTune):Void{
		if(styleTune != c){
			styleTune = c;
			repaint();
		}
	}
	
	/**
     * Gets the style tune of this component.
     * @return this component's style tune; if this component does
     *          not have a mideground color then <code>DefaultEmptyDecoraterResource.NULL_STYLE_TUNE</code> 
     * 			will be returned.
     * @see #setColorAdjuster()
	 */
	public function getStyleTune():StyleTune{
		if(styleTune != null && styleTune != DefaultEmptyDecoraterResource.NULL_STYLE_TUNE){
			return styleTune;
		}else if(getStyleProxy() != null){
        	return getStyleProxy().getStyleTune();
        }else{
        	return DefaultEmptyDecoraterResource.NULL_STYLE_TUNE;
        }
	}
	
	/**
	 * Sets the style proxy of the component.
	 * <p>
	 * Style proxy is used to provide the style(background, mideground, foreground and StyleTune) 
	 * properties for this component if any of them are set to null or DefaultEmptyDecoraterResource.NULL_XXX.
	 * </p>
	 * <p>
	 * For example, if you set a button's background to null, then getBackground of the button 
	 * will return its style proxy's background.
	 * </p>
	 * By default(nr set to null) the proxy is the parent of this component
	 * @param proxy the style proxy for this component
	 */
	public function setStyleProxy(proxy:Component):Void{
		styleProxy = proxy;
	}
	
	/**
	 * The style(background, mideground, foreground and StyleTune) proxy for this component, 
	 * if any style property for this component are null or DefaultEmptyDecoraterResource.NULL_XXX 
	 * then the proxy's related property will be used.
	 * <p>
	 * If the style proxy is not set(or set to null), then the component's parent component will be returned.
	 * </p>
	 * @return the style proxy of this component
	 */
	public function getStyleProxy():Component{
		if(styleProxy != null){
			return styleProxy;
		}else if(getParent() != null){
        	return getParent();
        }else if(Std.is(parent,Component)){
        	return  AsWingUtils.as(parent,Component);
        }else{
        	return null;
        }	
	}	
	
    /**
     * If true the component paints every pixel within its bounds. 
     * Otherwise, the component may not paint some or all of its
     * pixels, allowing the underlying pixels to show through.
     * <p>
     * The default value of this property is false for <code>JComponent</code>.
     * However, the default value for this property on most standard
     * <code>Component</code> subclasses (such as <code>JButton</code> and
     * <code>JTree</code>) is look-and-feel dependent.
     *
     * @param b  true if this component should be opaque
     * @see #isOpaque()
     */
    public function setOpaque(b:Bool):Void{
    	setOpaqueSet(true);
    	if(_opaque != b){
    		_opaque = b;
    		repaint();
    	}
    }
    
    /**
     * Returns true if this component is completely opaque.
     * <p>
     * An opaque component paints every pixel within its
     * rectangular bounds. A non-opaque component paints only a subset of
     * its pixels or none at all, allowing the pixels underneath it to
     * "show through".  Therefore, a component that does not fully paint
     * its pixels provides a degree of transparency.
     * </p>
     * <p>
     * The value is from LAF defaults if you have not set it.
     * </p>
     * <p>
     * Subclasses that guarantee to always completely paint their contents
     * should override this method and return true.
     * <p>
     * @return true if this component is completely opaque
     * @see #setOpaque()
     * @see #isOpaqueSet()
     */
    public function isOpaque():Bool{
    	return _opaque;
    }
    
    /**
     * Returns whether or not the opaque property is set by user. 
     * If it is not set, <code>opaque</code> will can be replaced with the value defined 
     * in LAF defaults when install a UI.
     */
    public function isOpaqueSet():Bool{
    	return opaqueSet;
    }
    
    /**
     * This method will be called to set true when you set the opaque by <code>setOpaque()</code>.
     * You can also call this method to make the opaque property returned by the set or LAF defaults.
     * @see #isOpaqueSet()
     * @see #isOpaque()
     */
    public function setOpaqueSet(b:Bool):Void{
    	opaqueSet = b;
    }
    
    /**
     * Indicates the alpha transparency value of the component. 
     * Valid values are 0 (fully transparent) to 1 (fully opaque).
     * @param alpha the alpha for this component, between 0 and 1. default is 1.
     */
    public function setAlpha(alpha:Float):Void{
    	this.alpha = alpha;
    }
    
    /**
     * Returns the alpha of this component.
     * @return the alpha of this component. default is 1.
     */
    public function getAlpha():Float{
    	return alpha;
    }
    
    /**
     * Returns the coordinate of the mouse position, in pixels, in the component scope.
     * @return the coordinate of the mouse position.
     */
    public function getMousePosition():IntPoint{
    	return new IntPoint(Std.int(mouseX), Std.int(mouseY));
    }
		
	/**
	 * Returns the bounds that component should paint in.
	 * <p>
	 * This is same to some paint method param b:Rectangle.
	 * So if you want to paint outside those method, you can get the 
	 * rectangle from here.
	 * 
	 * If this component has a little maximum size, and then current 
	 * size is larger, the bounds return from this method will be related 
	 * to <code>getAlignmentX<code>, <code>getAlignmentY<code> and <code>getMaximumSize<code>.
	 * @return return the rectangle that component should paint in.
	 * @see #getAlignmentX()
	 * @see #getAlignmentY()
	 * @see #getMaximumSize()
	 */
	public function getPaintBounds():IntRectangle{
		return getInsets().getInsideBounds(getPaintBoundsInRoot());
	}		
		
	/**
	 * Moves and resizes this component. The new location of the top-left corner is specified by x and y, and the new size is specified by width and height. 
	 * @param b the location and size bounds
	 */
	public function setComBounds(b:IntRectangle):Void{
		setLocationXY(b.x, b.y);
		setSizeWH(b.width, b.height);
	}
	
	/**
	 * Moves and resizes this component. The new location of the top-left corner is specified by x and y, and the new size is specified by width and height. 
	 */	
	public function setComBoundsXYWH(x:Int, y:Int, w:Int, h:Int):Void{
		setLocationXY(x, y);
		setSizeWH(w, h);
	}
	
	 
	
	/**
	 * <p>Stores the bounds value of this component into "return value" rv and returns rv. 
	 * If rv is null a new IntRectangle object is allocated. 
	 * 
	 * @param rv the return value, modified to the component's bounds.
	 * 
	 * @see #setSize()
	 * @see #setLocation()
	 */
	public function getComBounds(rv:IntRectangle=null):IntRectangle{
		if(rv != null){
			rv.setRect(bounds);
			return rv;
		}else{
			return new IntRectangle(bounds.x, bounds.y, bounds.width, bounds.height);
		}
	}
	
	/**
	 * Set the component's location, if it is diffs from old location, invalidate it to wait validate.
	 * The top-left corner of the new location is specified by the x and y parameters 
	 * in the coordinate space of this component's parent.
	 */
	public function setLocation(newPos:IntPoint):Void{
		var oldPos:IntPoint = bounds.getLocation();
		 
		 
		if(!newPos.equals(oldPos)){
			bounds.setLocation(newPos);
			locate();
			dispatchEvent(new MovedEvent(oldPos, newPos));
		}
	}
	
	/**
	 * @see #setLocation()
	 */
	public function setLocationXY(x:Int, y:Int):Void {
	 	
		setLocation(new IntPoint(x, y));
	}
	
	/**
	 * Set the component's location in global coordinate. This method should only be called when the component 
	 * is on the display list.
	 * @param gp the global location.
	 * @see #setLocation()
	 * @see #localToGlobal()
	 * @see #MovieClip.globalToLocal()
	 */
	public function setGlobalLocation(gp:IntPoint):Void{
		var newPos:Point = parent.globalToLocal(new Point(gp.x, gp.y));
		setLocationXY(Std.int(newPos.x), Std.int(newPos.y));
	}
	
	/**
	 * Set the component's location in global coordinate. This method should only be called when the component 
	 * is on the display list.
	 * @param x the global x location.
	 * @param y the global y location.
	 * @see #setLocation()
	 * @see #localToGlobal()
	 * @see #globalToLocal()
	 */
	public function setGlobalLocationXY(x:Int, y:Int):Void{
		setGlobalLocation(new IntPoint(x, y));
	}
	
	/**
	 * Stores the location value of this component into "return value" rv and returns rv. 
	 * If p is null a new Point object is allocated. 
	 * @param rv the return value, modified to the component's location.
	 */
	public function getLocation(rv:IntPoint=null):IntPoint{
		if(rv != null){
			rv.setLocationXY(bounds.x, bounds.y);
			return rv;
		}else{
			return new IntPoint(bounds.x, bounds.y);
		}
	}
	
	/**
	 * Stores the global location value of this component into "return value" p and returns p. 
	 * If p is null a new Point object is allocated. 
	 * @param p the return value, modified to the component's global location.
	 * @see #getLocation()
	 * @see #setGlobalLocation()
	 * @see MovieClip.localToGlobal()
	 * @see MovieClip.globalToLocal()
	 */
	public function getGlobalLocation(rv:IntPoint=null):IntPoint{
		var gp:Point =  this.localToGlobal(new Point(0, 0));
		if(rv != null){
			rv.setLocationXY(Std.int(gp.x), Std.int(gp.y));
			return rv;
		}else{
			return new IntPoint(Std.int(gp.x), Std.int(gp.y));
		}
	}
	
	public function globalToComponent(p:IntPoint):IntPoint{
		var np:Point = new Point(p.x, p.y);
		np = globalToLocal(np);
		return new IntPoint(Std.int(np.x), Std.int(np.y));
	}
	
	public function componentToGlobal(p:IntPoint):IntPoint{
		var np:Point = new Point(p.x, p.y);
	 
		np =   this.localToGlobal(np);
		return new IntPoint(Std.int(np.x), Std.int(np.y));
	}	
	
	/**
	 * This method will call setComBounds()
	 * @see #setComBounds()
	 */
	public function setBounds(b:IntRectangle):Void{
		setComBounds(b);
	}
		
	/**
	 * Set the component's size, the width and height all will be setted to not less than zero, 
	 * then set the size.
	 * You can set a Component's size max than its maximumSize, but when it was drawed,
 	 * it will not max than its maximumSize.Just as its maximumSize and posited itself
 	 * in that size dimension you just setted. The position is relative to <code>getAlignmentX</code> 
	 * @see #getAlignmentX()
	 * @see #getAlignmentY()
	 * @see #getMinimumSize()
	 * @see #countMaximumSize()
	 * @see #getPreferredSize()
	 */
	public function setSize(newSize:IntDimension):Void{
		newSize.width = Std.int(Math.max(0, newSize.width));
		newSize.height = Std.int(Math.max(0, newSize.height));
		var oldSize:IntDimension = new IntDimension(bounds.width, bounds.height);
		if(!newSize.equals(oldSize)){
			bounds.setSize(newSize);
			size();
			dispatchEvent(new ResizedEvent(oldSize, newSize));
		}
	}
	/**
	 * @see #setSize()
	 */
	public function setSizeWH(w:Int, h:Int):Void{
		setSize(new IntDimension(w, h));
	}

	public var currentSize(get,set): IntDimension;
	private function get_currentSize(): IntDimension { return getSize(); }
	private function set_currentSize(v: IntDimension): IntDimension { setSize(v); return v; }

	/**
	 * Stores the size value of this component into "return value" rv and returns rv. 
	 * If rv is null a new IntDimension object is allocated. 
	 * @param rv the return value, modified to the component's size.
	 */	
	public function getSize(rv:IntDimension=null):IntDimension{
		if(rv != null){
			rv.setSizeWH(bounds.width, bounds.height);
			return rv;
		}else{
			return new IntDimension(bounds.width, bounds.height);
		}
	}
	
	/**
	 * Causes this component to be sized to fit the preferred size.
	 */
	public function pack():Void{
		setSize(getPreferredSize());
	}	
	
	/**
	 * Sets the component's width.
	 * @param width the width of component to set
	 * @see  #setSize()
	 */
	public function setWidth(width:Int):Void{
		setSizeWH(width, getHeight());
	}
	/**
	 * Sets the component's height.
	 * @param height the height of component to set
	 * @see  #setSize()
	 */	
	public function setHeight(height:Int):Void{
		setSizeWH(getWidth(), height);
	}
	/**
	 * Returns the current width of this component
	 * @return the width of the component
	 */
	public function getWidth():Int{
		return bounds.width;
	}
	/**
	 * Returns the current height of this component
	 * @return the height of the component
	 */	
	public function getHeight():Int{
		return bounds.height;
	}
	/**
	 * Sets the x coordinate of the components.
	 * @return the x coordinate
	 * @see #setLocation()
	 */
	public function setX(x:Int):Void{
		setLocationXY(x, getY());
	}
	/**
	 * Sets the y coordinate of the components.
	 * @return the y coordinate
	 * @see #setLocation()
	 */
	public function setY(y:Int):Void{
		setLocationXY(getX(), y);
	}
	/**
	 * Returns the current x coordinate of the components.
	 * @return the current x coordinate of the components
	 * @see #getLocation()
	 */
	public function getX():Int{
		return bounds.x;
	}
	/**
	 * Returns the current y coordinate of the components.
	 * @return the current y coordinate of the components
	 * @see #getLocation()
	 */
	public function getY():Int{
		return bounds.y;
	}
	
	/**
	 * Enable or disable the component.
	 * <p>
	 * If a component is disabled, it will not fire mouse events. 
	 * And some component will has different interface when enabled or disabled.
	 * @param b true to enable the component, false to disable it.
	 */
	public function setEnabled(b:Bool):Void{
		if(enabled != b){
			enabled = b;
			mouseEnabled = b;
			repaint();
		}
	}
	
	/**
	 * Returns whether the component is enabled.
	 * @see #setEnabled()
	 */
	public function isEnabled():Bool{
		return enabled;
	}
	

	
	/**
	 * Sets the clip bounds, a rectangle mask to make specified bounds visible.
	 * Null to make the componet mask whole rectangle(show all).
	 * @param b the bounds to be the masked clip, null to make it show all. Default is null.
	 */
	public function setClipBounds(b:IntRectangle):Void{
		if(b == null && clipBounds == null){
			return;
		}
		var changed:Bool= false;
		if(b == null && clipBounds != null){
			clipBounds = null;
			changed = true;
		}else{
			if(!b.equals(clipBounds)){
				clipBounds = b.clone();
				changed = true;
			}
		}
		if(changed){
			layoutClipAndTrigger(null);
		}
	}
	
	/**
	 * Returns the clip bounds.
	 * @see #setClipBounds()
	 */
	public function getClipBounds():IntRectangle{
		if(clipBounds == null){
			return null;
		}
		return clipBounds.clone();
	}
	
	/**
	 * Sets the clip size, a rectangle mask to make specified bounds visible.
	 * This will be only in effect after component created and before next layout time.
	 * @see #setClipBounds()
	 */	
	public function setClipSize(size:IntDimension):Void{
		var bounds:IntRectangle = new IntRectangle();
		if(clipBounds != null){
			bounds.setLocation(clipBounds.getLocation());
		}
		bounds.setSize(size);
		setClipBounds(bounds);
	}		
	
    /**
     * Returns whether this Component can be focused.
     *
     * @return <code>true</code> if this Component is focusable;
     *         <code>false</code> otherwise.
     * @see #setFocusable()
     */	
	public function isFocusable():Bool{
		return focusable;
	}
	
    /**
     * Sets the focusable state of this Component to the specified value. This
     * value overrides the Component's default focusability.
     *
     * @param focusable indicates whether this Component is focusable
     * @see #isFocusable()
     */	
	public function setFocusable(b:Bool):Void{
		focusable = b;
		#if(flash9)
		getInternalFocusObject().tabEnabled = b;
		#end
		setFocusableSet(true);
	}
	
    /**
     * Returns whether or not the opaque property is set by user. 
     * If it is not set, <code>focusable</code> will can be replaced with the value defined 
     * in LAF defaults when install a UI.
     */	
	public function isFocusableSet():Bool{
		return focusableSet;
	}
	
	/**
	 * Indicate that the <code>focusable</code> property is set by user or not.
	 * @param b whether set or not
	 * @see #isFocusableSet()
	 */
	public function setFocusableSet(b:Bool):Void{
		focusableSet = b;
	}

	/**
	 * Sets whether this component can fire ON_DRAG_RECOGNIZED event.
	 * @see #ON_DRAG_RECOGNIZED 
	 * @see #isDragEnabled()
	 */
	public function setDragEnabled(b:Bool):Void{
		dragEnabled = b;
	}
	
	/**
	 * Returns whether this component can fire ON_DRAG_RECOGNIZED event. (Default value is false)
	 * @see #ON_DRAG_RECOGNIZED
	 * @see #setDragEnabled()
	 */
	public function isDragEnabled():Bool{
		return dragEnabled;
	}
	
	/**
	 * Sets whether this component can trigger dragging component to fire drag events 
	 * when dragging over to this component.
	 * @param b true to make this component to be a trigger that trigger drag and drop 
	 * action to fire events, false not to do that things.
	 * @see #ON_DRAG_ENTER
	 * @see #ON_DRAG_OVER
	 * @see #ON_DRAG_EXIT
	 * @see #ON_DRAG_DROP
	 * @see #isDropTrigger()
	 */
	public function setDropTrigger(b:Bool):Void{
		dropTrigger = b;
	}
	
	/**
	 * Returns whether this component can trigger dragging component to fire drag events 
	 * when dragging over to this component.(Default value is false)
	 * @return true if this component is a trigger that can trigger drag and drop action to 
	 * fire events, false it is not.
	 * @see #ON_DRAG_ENTER
	 * @see #ON_DRAG_OVER
	 * @see #ON_DRAG_EXIT
	 * @see #ON_DRAG_DROP
	 * @see #setDropTrigger()
	 */
	public function isDropTrigger():Bool{
		return dropTrigger;
	}

	/**
	 * Adds a component to be the acceptable drag initiator to this component.
	 * <p>
	 * It is not meanning that the DnD events will not be fired when the initiator 
	 * is dragging enter/over/exit/drop on this component.
	 * It is meanning that you can have a convenient way to proccess that events from 
	 * the method <code>isDragAcceptableInitiator</code> later, and the default dragging 
	 * image will take advantage to present a better picture when painting.
	 * </p>
	 * @param com the acceptable drag initiator
	 * @see #isDragAcceptableInitiator()
	 */
	public function addDragAcceptableInitiator(com:Component):Void{
		if(dragAcceptableInitiator == null){
			dragAcceptableInitiator = new haxe.ds.IntMap<Bool>();
		}
		  dragAcceptableInitiator.set(com.getAwmlIndex(), true);
	}
	
	/**
	 * Removes a component to be the acceptable drag initiator to this component.
	 * @param com the acceptable drag initiator
	 * @see #addDragAcceptableInitiator()
	 */
	public function removeDragAcceptableInitiator(com:Component):Void{
		if(dragAcceptableInitiator != null){
			//dragAcceptableInitiator[com] = undefined;
			//delete dragAcceptableInitiator[com];
			 dragAcceptableInitiator.remove(com.getAwmlIndex()); 
		}
	}
	
	/**
	 * Sets a function to judge whether a component is acceptable drag initiator.
	 * This function will be called to judge when <code>dragAcceptableInitiator</code> set 
	 * does not contains the component.
	 * @param the judge function func(initiator:Component):Boolean
	 */
	public function setDragAcceptableInitiatorAppraiser(func:Dynamic->Bool):Void{
		dragAcceptableInitiatorAppraiser = func;
	}
	
	/**
	 * Returns whether the component is acceptable drag initiator for this component.
	 * @param com the maybe acceptable drag initiator
	 * @return true if it is acceptable drag initiator, false not
	 */
	public function isDragAcceptableInitiator(com:Component):Bool{
		if(dragAcceptableInitiator != null){
			return   dragAcceptableInitiator.get(com.getAwmlIndex()) == true;
		}else{
			if(dragAcceptableInitiatorAppraiser != null){
				return dragAcceptableInitiatorAppraiser(com);
			}else{
				return false;
			}
		}
	}		

	/**
	 * Registers the text to display in a tool tip. 
	 * The text displays when the cursor lingers over the component. 
	 * <p>
	 * This tip will display with a shared tool tip with other components, 
	 * so if you want to display more than one tip at same time, you may 
	 * need to create your <code>JToolTip</code> or <code>JSharedToolTip</code>.
	 * </p>
	 * @param t the string to display; if the text is null, 
	 * the tool tip is turned off for this component
	 * @see JToolTip
	 * @see JSharedToolTip
	 */
	public function setToolTipText(t:String):Void{
		toolTipText = t;
		if(t == null){
			JSharedToolTip.getSharedInstance().unregisterComponent(this);
		}else{
			JSharedToolTip.getSharedInstance().registerComponent(this);
		}
	}
	
	/**
	 * Returns the tooltip string that has been set with setToolTipText. 
	 * @return the text of the tool tip
	 * @see #setToolTipText()
	 */
	public function getToolTipText():String{
		return toolTipText;
	}	
	
	/**
	 * Locate the component to the current location.
	 */
	private function locate():Void{
		var _x:Float= getX();
		var _y:Float = getY();
		 
		d_x = _x;
		d_y = _y;
	}
	
	/**
	 * Sets <code>DisplayObject.x</code> directly.
	 * @param value the x coordinats
	 */
	private function set_d_x(value:Float):Float{
		super.x = value;
		return value;
    }
	
	/**
	 * Sets <code>DisplayObject.y</code> directly.
	 * @param value the y coordinats
	 */	
	private function set_d_y(value:Float):Float{
		super.y = value;
 
		return value;
	}
	
	/**
	 * Returns <code>DisplayObject.x</code> directly.
	 * @return the x coordinats
	 */
	private function get_d_x():Float {
			
		return super.x;
	}
	
	/**
	 * Returns <code>DisplayObject.y</code> directly.
	 * @return the y coordinats
	 */	
	private function get_d_y():Float{
		return super.y;
	}	
	
    #if (!flash)
	/**
	 * @see #setX()
	 */
	override public function set_x(value:Float):Float{
		setX(Std.int(value));
	 
			return value;
		}
	
	/**
	 * @see #getX()
	 */
	 
	override public function get_x():Float{
		return getX();
	}

	/**
	 * @see #setY()
	 */
	override public function set_y(value:Float):Float{
		setY(Std.int(value));
	
			return value;
		}
	
	/**
	 * @see #getY()
	 */
	 
	override public function get_y():Float{
		return getY();
	}
		
	/**
	 * @see setWidth()
	 */
	override public function set_width(value:Float):Float{
		setWidth(Std.int(value));
	
			return value;
		}
	
	/**
	 * @see getWidth()
	 */
	 
	override public function get_width():Float{
		return getWidth();
	}
	
	/**
	 * @see setHeight()
	 */	
	override public function set_height(value:Float):Float{
		setHeight(Std.int(value));
	
			return value;
		}
	
	/**
	 * @see getHeight()
	 */	
	 
	override public function get_height():Float{
		return getHeight();
	}
    #end

	/**
	 * @param ax
	 * @see #getAlignmentX()
	 */
    public function setAlignmentX(ax:Float):Void{
    	if(alignmentX != ax){
    		alignmentX = ax;
    		repaint();
    	}
    }
    
    /**
	 * @param ay
	 * @see #getAlignmentY()
     */
    public function setAlignmentY(ay:Float):Void{
    	if(alignmentY != ay){
    		alignmentY = ay;
    		repaint();
    	}
    }		
	
	/**
	 * Returns the alignment along the x axis. 
	 * This specifies how the component would like to be aligned relative 
	 * to its size when its size is maxer than its maximumSize. 
	 * The value should be a number between 0 and 1 where 0 
	 * represents alignment start from left, 1 is aligned the furthest 
	 * away from the left, 0.5 is centered, etc. 
	 * @return the alignment along the x axis, 0 by default
	 */
    public function getAlignmentX():Float{
    	return alignmentX;
    }

	/**
	 * Returns the alignment along the y axis. 
	 * This specifies how the component would like to be aligned relative 
	 * to its size when its size is maxer than its maximumSize. 
	 * The value should be a number between 0 and 1 where 0 
	 * represents alignment start from top, 1 is aligned the furthest 
	 * away from the top, 0.5 is centered, etc. 
	 * @return the alignment along the y axis, 0 by default
	 */
    public function getAlignmentY():Float{
    	return alignmentY;
    }
    
    /**
     * Returns the value of the property with the specified key. 
     * Only properties added with putClientProperty will return a non-null value.
     * @param key the being queried
     * @param defaultValue if the value doesn't exists, the defaultValue will be returned
     * @return the value of this property or null
     * @see #putClientProperty()
     */
    public function getClientProperty(key:String, ?defaultValue:Dynamic):Dynamic{
    	if(clientProperty == null){
    		return defaultValue;
    	}
    	if(clientProperty.exists(key)){
    		return clientProperty.get(key);
    	}else{
    		return defaultValue;
    	}
    }
    
    /**
     * Adds an arbitrary key/value "client property" to this component.
     * <p>
     * The <code>get/putClientProperty</code> methods provide access to 
     * a small per-instance hashtable. Callers can use get/putClientProperty
     * to annotate components that were created by another module.
     * For example, a
     * layout manager might store per child constraints this way. For example:
     * <pre>
     * componentA.putClientProperty("to the left of", componentB);
     * </pre>
     * @param key the new client property key
     * @param value the new client property value
     * @see #getClientProperty()
     */    
    public function putClientProperty(key:String, value:Dynamic):Void{
    	//Lazy initialization
    	if(clientProperty == null){
    		clientProperty = new haxe.ds.StringMap<Dynamic>();
    	}
    	clientProperty.set(key, value);
    }
	
	/**
	 * get the minimumSize from ui, if ui is null then Returns getInsets().roundsSize(new IntDimension(0, 0)).
	 */
	private function countMinimumSize():IntDimension{		
		if(ui != null){
			return ui.getMinimumSize(this);
		}else{
			return getInsets().getOutsideSize(new IntDimension(0, 0));
		}
	}
	
	/**
	 * get the maximumSize from ui, if ui is null then return a big dimension;
	 * @see IntDimension#createBigDimension()
	 */
	private function countMaximumSize():IntDimension{		
		if(ui != null){
			return ui.getMaximumSize(this);
		}else{
			return IntDimension.createBigDimension();
		}
	}
	
	/**
	 * get the preferredSize from ui, if ui is null then just return the current size
	 */
	private function countPreferredSize():IntDimension{
		if(ui != null){
			return ui.getPreferredSize(this);
		}else{
			return getSize();
		}
	}
	
	/**
	 * Sets whether or not turn on the preferred size, minimum size and 
	 * max size cache. By default, this is true(means turned on).
	 * <p>
	 * If this is turned on, the size count will be very fast as most time. 
	 * So suggest you that do not turn off it unless you have your personal reason.
	 * </p>
	 * @param b true to turn on it, false trun off it.
	 */
	public function setCachePreferSizes(b:Bool):Void{
		cachePreferSizes = b;
		if(!b){
	    	cachedMaximumSize = null;
	    	cachedMinimumSize = null;
	    	cachedPreferredSize = null;			
		}
	}
	
	/**
	 * Returns whether or not the preferred size, minimum size and 
	 * max size cache is turned on.
	 * @return whether or not the preferred size, minimum size and 
	 * max size cache is turned on.
	 */
	public function isCachePreferSizes():Bool{
		return cachePreferSizes;
	}
	
	/**
	 * @see #setMinimumSize()
	 */
	public function getMinimumSize():IntDimension{
		if(isDirectReturnSize(minimumSize)){
			return minimumSize.clone();
		}else if(isCachePreferSizes() && cachedMinimumSize != null){
			return cachedMinimumSize.clone();
		}else{
			var tempSize:IntDimension = mixSetSize(countMinimumSize(), minimumSize);			
			if(isCachePreferSizes()){
				cachedMinimumSize = tempSize;
				return cachedMinimumSize.clone();
			}else{
				return tempSize;
			}
		}
	}
	
	/**
	 * @see #setMaximumSize()
	 */	
	public function getMaximumSize():IntDimension{
		if(isDirectReturnSize(maximumSize)){
			return maximumSize.clone();
		}else if(isCachePreferSizes() && cachedMaximumSize != null){
			return cachedMaximumSize.clone();
		}else{
			var tempSize:IntDimension = mixSetSize(countMaximumSize(), maximumSize);
			if(isCachePreferSizes()){
				cachedMaximumSize = tempSize;
				return cachedMaximumSize.clone();
			}else{
				return tempSize;
			}
		}
	}
	
	/**
	 * @see #setPreferredSize()
	 */	
	public function getPreferredSize():IntDimension {
		
		if(isDirectReturnSize(preferredSize)){
			return preferredSize.clone();
		}else if(isCachePreferSizes() && cachedPreferredSize != null){
			return cachedPreferredSize.clone();
		}else{
			var tempSize:IntDimension = mixSetSize(countPreferredSize(), preferredSize);
			if(isCachePreferSizes()){
				cachedPreferredSize = tempSize;
				return cachedPreferredSize.clone();
			}else{
				return tempSize;
			}
		}
	}
	
	private function isDirectReturnSize(s:IntDimension):Bool{
		return s != null && (s.width != -1 && s.height != -1);
	}
	
	private function mixSetSize(counted:IntDimension, setted:IntDimension):IntDimension{
		if(setted != null){
			if(setted.width != -1){
				counted.width = setted.width;
			}else if(setted.height != -1){
				counted.height = setted.height;
			}
		}
		return counted;
	}
	
	/**
	 * setMinimumSize(d:IntDimension)<br>
	 * setMinimumSize(width:Number, height:Number)
	 * <p>
	 * Set the minimumSize, then the component's minimumSize is
	 * specified. otherwish getMinimumSize will can the count method.
	 * @param arguments null to set minimumSize null then getMinimumSize will can the layout.
	 * others set the minimumSize to be a specified size.
	 * @see #getMinimumSize()
	 */
	public function setMinimumSize(minimumSize:IntDimension):Void{
		if(minimumSize == null){
			this.minimumSize = null;
		}else{
			this.minimumSize = minimumSize.clone();
		}
	}
	
	/**
	 * setMaximumSize(d:IntDimension)<br>
	 * setMaximumSize(width:Number, height:Number)<br>
	 * <p>
	 * Set the maximumSize, then the component's maximumSize is
	 * specified. otherwish getMaximumSize will can count method.
	 * 
	 * @param arguments null to set maximumSize null to make getMaximumSize will can the layout.
	 * others set the maximumSize to be a specified size.
	 * @see #getMaximumSize()
	 * @see #MaximumSize()
	 */	
	public function setMaximumSize(maximumSize:IntDimension):Void{
		if(maximumSize == null){
			this.maximumSize = null;
		}else{
			this.maximumSize = maximumSize.clone();
		}
	}
	
	/**
	 * setPreferredSize(d:IntDimension)<br>
	 * setPreferredSize(width:Number, height:Number)<br>
	 * <p>
	 * Set the preferredSize, then the component's preferredSize is
	 * specified. otherwish getPreferredSize will count method.
	 * 
	 * @param arguments null to set preferredSize null to make getPreferredSize will call the layout,
	 * others set the preferredSize to be a specified size.
	 * @see #getPreferredSize()
	 */	
	public function setPreferredSize(preferredSize:IntDimension):Void{
		if(preferredSize == null){
			this.preferredSize = null;
		}else{
			this.preferredSize = preferredSize.clone();
		}
	}	
	
	/**
	 * Returns <code>getPreferredSize().width</code>
	 * @see #getPreferredSize()
	 */
	public function getPreferredWidth():Int{
		return getPreferredSize().width;
	}
	
	/**
	 * Sets preferred width, -1 means auto count.
	 * @see #setPreferredSize()
	 */
	public function setPreferredWidth(preferredWidth:Int):Void{
		if(preferredSize == null){
			preferredSize = new IntDimension(-1, -1);
		}
		preferredSize.width = preferredWidth;
	}
	
	/**
	 * Returns <code>getPreferredSize().height</code>
	 * @see #getPreferredSize()
	 */
	public function getPreferredHeight():Int{
		return getPreferredSize().height;
	}
	
	/**
	 * Sets preferred width, -1 means auto count.
	 * @see #setPreferredSize()
	 */
	public function setPreferredHeight(preferredHeight:Int):Void{
		if(preferredSize == null){
			preferredSize = new IntDimension(-1, -1);
		}
		preferredSize.height = preferredHeight;
	}
	
	/**
	 * Returns <code>getMaximumSize().width</code>
	 * @see #getMaximumSize()
	 */
	public function getMaximumWidth():Int{
		return getMaximumSize().width;
	}
	/**
	 * Sets maximum width, -1 means auto count.
	 * @see #setMaximumSize()
	 */
	public function setMaximumWidth(maximumWidth:Int):Void{
		if(maximumSize == null){
			maximumSize = new IntDimension(-1, -1);
		}
		maximumSize.width = maximumWidth;
	}
	/**
	 * Returns <code>getMaximumSize().height</code>
	 * @see #getMaximumSize()
	 */
	public function getMaximumHeight():Int{
		return getMaximumSize().height;
	}
	/**
	 * Sets maximum height, -1 means auto count.
	 * @see #setMaximumSize()
	 */
	public function setMaximumHeight(maximumHeight:Int):Void{
		if(maximumSize == null){
			maximumSize = new IntDimension(-1, -1);
		}
		maximumSize.height = maximumHeight;
	}
	/**
	 * Returns <code>getMinimumSize().width</code>
	 * @see #getMinimumSize()
	 */
	public function getMinimumWidth():Int{
		return getMinimumSize().width;
	}
	/**
	 * Sets minimum width, -1 means auto count.
	 * @see #setMinimumSize()
	 */
	public function setMinimumWidth(minimumWidth:Int):Void{
		if(minimumSize == null){
			minimumSize = new IntDimension(-1, -1);
		}
		minimumSize.width = minimumWidth;
	}	
	/**
	 * Returns <code>getMinimumSize().height</code>
	 * @see #getMinimumSize()
	 */
	public function getMinimumHeight():Int{
		return getMinimumSize().height;
	}
	/**
	 * Sets minimum height, -1 means auto count.
	 * @see #setMinimumSize()
	 */
	public function setMinimumHeight(minimumHeight:Int):Void{
		if(minimumSize == null){
			minimumSize = new IntDimension(-1, -1);
		}
		minimumSize.height = minimumHeight;
	}
	
	/**
	 * Returns whether the component hit the mouse.
	 */
	public function hitTestMouse():Bool{
		if(isOnStage()){
			return hitTestPoint(stage.mouseX, stage.mouseY, false);
		}else{
			return false;
		}
	}
	
    /**
     * Supports deferred automatic layout.  
     * <p> 
     * Calls <code>invalidateLayout</code> and then adds this component's
     * <code>validateRoot</code> to a list of components that need to be
     * validated.  Validation will occur after all currently pending
     * events have been dispatched.  In other words after this method
     * is called,  the first validateRoot (if any) found when walking
     * up the containment hierarchy of this component will be validated.
     * By default, <code>JPopup</code>, <code>JScrollPane</code>,
     * and <code>JTextField</code> return true 
     * from <code>isValidateRoot</code>.
     * <p>
     * This method will or will not automatically be called on this component 
     * when a property value changes such that size, location, or 
     * internal layout of this component has been affected.But invalidate
     * will do called after thats method, so you want to get the contents of 
     * the GUI to update you should call this method.
     * <p>
     *
     * @see #invalidate()
     * @see #validate()
     * @see #isValidateRoot()
     * @see RepaintManager#addInvalidComponent()
     */
	public function revalidate():Void{
    	invalidate();
    	RepaintManager.getInstance().addInvalidComponent(this);
    }
        
    public function revalidateIfNecessary():Void{
    	RepaintManager.getInstance().addInvalidComponent(this);
    }
	
	/**
	 * Redraws the component face next RENDER event.This method can
     * be called often, so it needs to execute quickly.
	 * @see org.aswing.RepaintManager
	 */
	public function repaint():Void{
		if(isVisible() && isReadyToPaint()){
			RepaintManager.getInstance().addRepaintComponent(this);
		}
	}
	
	public function repaintAndRevalidate():Void{
		repaint();
		revalidate();
	}
		
	/**
	 * Do the process when size changed.
	 */
	private function size():Void{
		readyToPaint = true;
		repaint();
		invalidate();
	}
	
    /**
     * Invalidates this component.  This component and all parents
     * above it are marked as needing to be laid out, and all <code>clearPreferSizeCaches</code>.
     * This method can be called often, so it needs to execute quickly.
     * @see       #validate()
     * @see       #doLayout()
     * @see       #invalidatePreferSizeCaches()
     * @see       org.aswing.LayoutManager
     */	
	public function invalidate():Void{
    	invalidateTree();
    	invalidatePreferSizeCaches();
	}
	
	/**
     * Makes this component and all parents
     * above it are marked as needing to be laid out.
	 */
	private function invalidateTree():Void{
    	valid = false;
    	var par:Component = getParent();
    	if(par != null && par.isValid()){
    		par.invalidateTree();
    	}
	}
	
    /**
     * Clears this component and all parents above it's preferred size caches.
     * <p>
     * By default all components' prefer sizes(max, min, prefer) have caches, if you 
     * make some call that cached a invalided component's sizes but then you modifid 
     * the component again, so it's prefer size need to be renew, 
     * <code>invalidatePreferSizeCaches</code> will be helpful now.
     * </p>
     * <p>
     * Generally you do not need to call this method manually unless you get above situation.
     * this method will be called inside <code>invalidate()</code> automatically.
     * </p>
     * @see       #invalidate()
     * @see       #validate()
     * @see       #setCachePreferSizes()
     * @see       org.aswing.LayoutManager
     */		
	public function invalidatePreferSizeCaches():Void{
    	clearPreferSizeCaches();
    	var par:Container = getParent();
    	if(par != null){
    		par.invalidatePreferSizeCaches();
    	}
	}
	
	private function clearPreferSizeCaches():Void{
    	cachedMaximumSize = null;
    	cachedMinimumSize = null;
    	cachedPreferredSize = null;
	}
	
    /**
     * Ensures that this component has a valid layout.  This method is
     * primarily intended to operate on instances of <code>Container</code>.
     * @see       #invalidate()
     * @see       #doLayout()
     * @see       org.aswing.LayoutManager
     * @see       org.aswing.Container#validate()
     */	
	public function validate():Void{
    	if(!valid){
    		valid = true;
    	}
	}
	
	/**
	 * Redraw the component UI face immediately if it is visible and ready to paint.
	 * @see #repaint()
	 * @see #isVisible()
	 * @see #isReadyToPaint()
	 */	
	public function paintImmediately():Void{
		if(isVisible() && isReadyToPaint()){
			var paintBounds:IntRectangle = getPaintBoundsInRoot();
			layoutClipAndTrigger(null);
			paint(getInsets().getInsideBounds(paintBounds));
		}
	}	
	/////////
	
	/**
	 * Returns if this component is ready to do paint.
	 * By default, if a component is resized once, then it is ready.
	 * @return if this component is ready to do paint.
	 * @see #setSize()
	 * @see #size()
	 */
	private function isReadyToPaint():Bool{
		return readyToPaint;
	}
	
	/**
	 * draw the component interface in specified bounds.
	 * Sub class should override this method if you want to draw your component's face.
	 * @param b this paiting bounds, it is opposite on the component corrdinarry.
	 */
	private function paint(b:IntRectangle):Void{
		graphics.clear();
		var g:Graphics2D = new Graphics2D(graphics);
		
		//fill a transparent rectangle to be the mouse trigger
		if(isEnabled() && drawTransparentTrigger){
			g.fillRectangle(bg_trigger_brush, b.x, b.y, b.width, b.height);
		}
		
		if(backgroundDecorator != null){
			backgroundDecorator.updateDecorator(this, g, b.clone());
		}
		if (ui != null) { 
			ui.paint(this, g, b.clone());
		}
		//paintFocusRect();
		//paint border at last to make it at the top depth
		if(_border != null){
			// not that border is not painted in b, is painted in component's full size bounds
			// because border are the rounds, others will painted in the border's bounds.
			_border.updateBorder(this, g, getInsets().getOutsideBounds(b.clone()));
		}
		if(foregroundDecorator != null){
			foregroundDecorator.updateDecorator(this, g, b.clone());
		}
				
		dispatchEvent(new AWEvent(AWEvent.PAINT, false, false));
	}
	private static var bg_trigger_brush:SolidBrush = new SolidBrush(new ASColor(0, 0));
	
	/**
	 * Paints the focus rect if need.
	 * The focus will be paint by the component ui if this component is focusOwner and 
	 * <code>FocusManager.getCurrentManager().isTraversing()</code>.
	 * @param force force to paint the focus rect nomatter if it is focused.
	 */
	public function paintFocusRect(force:Bool=false):Void{
		var fm:FocusManager = FocusManager.getManager(stage);
		if(ui!=null && fm!=null){
			if(force || fm.isTraversing() && isFocusOwner()){
				var fr:Sprite = fm.moveFocusRectUpperTo(this);
				fr.graphics.clear();
				ui.paintFocus(this, new Graphics2D(fr.graphics), new IntRectangle(0, 0, Std.int(getWidth()), Std.int(getHeight())));
			}
		}
	}
	
	private function layoutClipAndTrigger(paintBounds:IntRectangle):Void{
		if(paintBounds == null){
			var b:IntRectangle = new IntRectangle(0, 0, Std.int(getWidth()), Std.int(getHeight()));
			var r:IntRectangle = getPaintBoundsInRoot();
			var x1:Int= Std.int(Math.max(b.x, r.x));
			var x2:Int= Std.int(Math.min(b.x + b.width, r.x + r.width));
			var y1:Int= Std.int(Math.max(b.y, r.y));
			var y2:Int= Std.int(Math.min(b.y + b.height, r.y + r.height));
			paintBounds = new IntRectangle(x1, y1, x2 - x1, y2 - y1);
		}else{
			paintBounds = paintBounds.clone();
		}
		if(clipBounds != null){
			paintBounds.x = Std.int(Math.max(paintBounds.x, clipBounds.x));
			paintBounds.y = Std.int(Math.max(paintBounds.y, clipBounds.y));
			paintBounds.width = Std.int(Math.min(paintBounds.width, clipBounds.width));
			paintBounds.height = Std.int(Math.min(paintBounds.height, clipBounds.height));
		}
		setClipMaskRect(paintBounds);
	}

	/**
	 * get the simon-pure component paint bounds.
	 * This is include insets range.
	 * @see #getPaintBounds()
	 */
	private function getPaintBoundsInRoot():IntRectangle{
		var minSize:IntDimension = getMinimumSize();
		var maxSize:IntDimension = getMaximumSize();
		var size:IntDimension = getSize();
		var paintBounds:IntRectangle = new IntRectangle(0, 0, size.width, size.height);
		//if it size max than maxsize, draw it as maxsize and then locate it in it size(the size max than maxsize)
		if(size.width > maxSize.width){
			paintBounds.width = maxSize.width;
			paintBounds.x =Std.int( (size.width-paintBounds.width)*getAlignmentX());
		}
		if(size.height > maxSize.height){
			paintBounds.height = maxSize.height;
			paintBounds.y = Std.int((size.height-paintBounds.height)*getAlignmentY());
		}
		//cannot paint its min than minsize
		if(paintBounds.width < minSize.width) paintBounds.width = minSize.width;
		if(paintBounds.height < minSize.height) paintBounds.height = minSize.height;
		
		return paintBounds;
	}	
		
    /**
     * Determines whether this component is valid. A component is valid
     * when it is correctly sized within its parent
     * container and all its children are also valid. components are invalidated
     * before they are first shown on the screen. By the time the parent container 
     * is fully realized, all its components will be valid.
     * @return <code>true</code> if the component is valid, <code>false</code>
     * otherwise
     * @see #validate()
     * @see #invalidate()
     */
    public function isValid():Bool{
    	return valid;
    }
	
	/**
	 * If this method returns true, revalidate calls by descendants of this 
	 * component will cause the entire tree beginning with this root to be validated. 
	 * Returns false by default. 
	 * JScrollPane overrides this method and returns true. 
	 * @return return true if this component is located in a non-component container, 
	 *         otherwise returns false
	 */
	public function isValidateRoot():Bool{
		if(stage != null && getParent() == null){
			//TODO check this
			return true;
		}
		return false;
	}	
	
	/**
	 * Returns the <code>Container</code> parent, 
	 * if it parent is not a <code>Container</code>, null will be returned.
	 * @return the <code>Container</code> parent
	 */
	public function getParent():Container{
		return container;
	}
	
	/**
	 * Removes this component from its parent and then append it with specified constraints.
	 * If this component is not in a container yet, no effect will take.
	 * @param constraints the new constraints, null means get from getConstraints method.
	 * @see #getConstraints
	 */
	public function reAppendToParent(constraints:Dynamic=null):Void{
		if(container!=null){
			var index:Int= container.getIndex(this);
			var con:Container = container;
			con.remove(this);
			con.insert(index, this, constraints);
		}
	}
	
	/**
	 * Calls parent reAppendChildren if parent is a container.
	 * @see Container#reAppendChildren()
	 */
	public function parentReAppendChildren():Void{
		if(container!=null){
			container.reAppendChildren();
		}
	}
	
	/**
	 * Returns the first <code>JRootPane</code> ancestor of this component.
	 * @return the <code>JRootPane</code> ancestor, or null if not found.
	 */
	public function getRootPaneAncestor():JRootPane{
		var pa:DisplayObject = parent;
		while(pa != null){
			if(Std.is(pa,JRootPane)){
				return AsWingUtils.as(pa,JRootPane)	;
			}
			pa = pa.parent;
		}
		return null;
	}
	
	/**
	 * Returns the keyboard manager of this component's <code>JRootPane</code> ancestor.
	 * @return the keyboard manager, or null if no root pane ancestor.
	 */
	public function getKeyboardManager():KeyboardManager{
		var rootPane:JRootPane = getRootPaneAncestor();
		if(rootPane!=null){
			return rootPane.getKeyboardManager();
		}
		return null;
	}
	
	/**
	 * Removes this component from its parent, 
	 * whatever it is as a component child or only a display object child, 
	 * or it's parent is just a display object container.
	 * <p>
	 * This method will remove this component in any case.
	 * </p>
	 */
	public function removeFromContainer():Void{
		if(getParent() != null){
			getParent().remove(this);
		}
		if(parent != null){
			parent.removeChild(this);
		}
	}
	
	/**
	 * Sets component's constraints.
	 * @param constraints the constraints to set
	 */
	public function setConstraints(constraints:Dynamic):Void{
		this.constraints = constraints;	
	}
	
	/**
	 * Gets cpmponent's constraints.
	 * @return component's constraints
	 */
	public function getConstraints():Dynamic{
		return constraints;
	}
	
    /**
     * Transfers the focus to the next component, as though this Component were
     * the focus owner.
     * 
     * @return true if transfered, false otherwise
     * @see       #requestFocus()
     */
    public function transferFocus():Bool{
    	return transferFocusWithDirection(1);
    }
    
    /**
     * Transfers the focus to the previous component, as though this Component
     * were the focus owner.
     * 
     * @return true if transfered, false otherwise
     * @see       #requestFocus()
     */
    public function transferFocusBackward():Bool{
    	return transferFocusWithDirection(-1);
    }
    
    /**
     * dir > 0 transferFocus, dir <= 0 transferFocusBackward
     */
    private function transferFocusWithDirection(dir:Float):Bool{
        var pa:Container = getParent();
        if(pa == null){
        	pa = AsWingUtils.as(this , Container);
        }
        if(pa != null){
        	var nextFocus:Component = null;
        	if(dir > 0){
        		nextFocus = pa.getFocusTraversalPolicy().getComponentAfter(this);
        	}else{
        		nextFocus = pa.getFocusTraversalPolicy().getComponentBefore(this);
        	}
        	if(nextFocus != null){
        		return nextFocus.requestFocus();
        	}
        }
        return false;
    }
    
    /**
     * Returns <code>true</code> if this <code>Component</code> is the 
     *    focus owner.
     *
     * @return <code>true</code> if this <code>Component</code> is the 
     *     focus owner; <code>false</code> otherwise
     */
    public function isFocusOwner():Bool{
    	var fm:FocusManager = FocusManager.getManager(stage);
        return (fm != null && fm.getFocusOwner() == this);
    }
    
    /**
     * Requests that this Component get the input focus, and that this
     * Component's top-level ancestor become the focused Window. This component
     * must be displayable, visible, and focusable for the request to be
     * granted. Every effort will be made to honor the request; however, in
     * some cases it may be impossible to do so. Developers must never assume
     * that this Component is the focus owner until this Component receives a
     * ON_FOCUS_GAINED event.
     *
     * @return true if the request is made successful, false if the request is denied.
     * @see #isFocusable()
     * @see #isDisplayable()
     * @see #ON_FOCUS_GAINED
     */
    public function requestFocus():Bool{
    	//TODO imp check
    	if((isFocusable() || getFocusTransmit() != null) && isEnabled() && isShowing()){
    		makeFocus();
    		return true;
    	}
        return false;
    }
    
    /**
     * Makes this component's internal focus object to be the stage focus directly, 
     * without any judgement.
     * <p>
     * You'd better to call <code>requestFocus()</code> generally, this method is only 
     * used to some internal implementation at most time.
     * </p>
     * @see #requestFocus()
     * @see #getInternalFocusObject()
     */
    public function makeFocus():Void{
    	if(getFocusTransmit() != null){
    		getFocusTransmit().requestFocus();
    	}else{
    		var ifo:InteractiveObject = getInternalFocusObject();
			#if(flash9)
				if(ifo != stage.focus){
					stage.focus = ifo;
				}
			#end
    	}
    }
    
    /**
     * Returns the object to receive the focus for this component. 
     * It will call the ui to return the ui specified object, if ui is null 
     * or ui returned null, then it just return the component self. 
     * <p>
     * Other component may return a child object, for example <code>JTextComponent<code> will return 
     * its <code>TextField</code> object.
     * </p>
     * @return the object to receive the focus.
     * @see org.aswing.plaf.ComponentUI#getInternalFocusObject()
     */
	public function getInternalFocusObject():InteractiveObject{
		var ifo:InteractiveObject = null;
		if(ui != null){
			ifo = ui.getInternalFocusObject(this);
		}
		if(ifo != null){
			return ifo;
		}else{
			return this;
		}
	}
	
	/**
	 * Returns the focus manager for this component's stage, 
	 * or null if this component is not on stage.
	 */
	public function getFocusManager():FocusManager{
		return FocusManager.getManager(stage);
	}
    
    public function fireFocusKeyDownEvent(e:KeyboardEvent):Void{
    	dispatchEvent(new FocusKeyEvent(FocusKeyEvent.FOCUS_KEY_DOWN, e.charCode, 
    	e.keyCode, e.keyLocation, e.ctrlKey, e.altKey, e.shiftKey));
    }
    
    public function fireFocusKeyUpEvent(e:KeyboardEvent):Void{
    	dispatchEvent(new FocusKeyEvent(FocusKeyEvent.FOCUS_KEY_UP, e.charCode, 
    	e.keyCode, e.keyLocation, e.ctrlKey, e.altKey, e.shiftKey));
    }
    

	private function fireDragRecognizedEvent(touchedChild:Component):Void {
	 	
		dispatchEvent(new DragAndDropEvent(DragAndDropEvent.DRAG_RECOGNIZED, this, null, new IntPoint(Std.int(stage.mouseX), Std.int(stage.mouseY))));
	}
	
	/**
	 * @private
	 * Fires ON_DRAG_ENTER event.(Note, this method is only for DragManager use)
	 */
	public function fireDragEnterEvent(dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint, relatedTarget:Component):Void{
		dispatchEvent(new DragAndDropEvent(DragAndDropEvent.DRAG_ENTER, dragInitiator, sourceData, mousePos, this, relatedTarget));
	}
	/**
	 * @private
	 * Fires DRAG_OVERRING event.(Note, this method is only for DragManager use)
	 */
	public function fireDragOverringEvent(dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):Void{
		dispatchEvent(new DragAndDropEvent(DragAndDropEvent.DRAG_OVERRING, dragInitiator, sourceData, mousePos, this));
	}
	/**
	 * @private
	 * Fires DRAG_EXIT event.(Note, this method is only for DragManager use)
	 */
	public function fireDragExitEvent(dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint, relatedTarget:Component):Void{
		dispatchEvent(new DragAndDropEvent(DragAndDropEvent.DRAG_EXIT, dragInitiator, sourceData, mousePos, this, relatedTarget));
	}
	/**
	 * @private
	 * Fires DRAG_DROP event.(Note, this method is only for DragManager use)
	 */
	public function fireDragDropEvent(dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):Void{
		dispatchEvent(new DragAndDropEvent(DragAndDropEvent.DRAG_DROP, dragInitiator, sourceData, mousePos, this));
	}    
	
	//----------------------------------------------------------------
	//               Event Handlers
	//----------------------------------------------------------------
	private var lastClickTime:Int;
	private var _lastClickPoint:IntPoint;
	private var clickCount:Int;
	private function __mouseClick(e:MouseEvent):Void{
		var time:Int= Lib.getTimer();
		var mousePoint:IntPoint = getMousePosition();
		if(mousePoint.equals(_lastClickPoint) && time - lastClickTime < MAX_CLICK_INTERVAL){
			clickCount++;
		}else{
			clickCount = 1;
		}
		lastClickTime = time;
		dispatchEvent(new ClickCountEvent(ClickCountEvent.CLICK_COUNT, clickCount));
		_lastClickPoint = mousePoint;
	}
	
	//retrive the focus when mouse down if not focused child or self
	//this will works because focusIn will be fired before mouseDown
	private function __mouseDown(e:MouseEvent):Void{
		checkRequestFocusWhenMouseDown(e);
		
		if(isDragEnabled()){
			addEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
			addEventListener(MouseEvent.ROLL_OUT, __rollOut);
			stage.addEventListener(MouseEvent.MOUSE_UP, __mouseUp, false, 0, false);
			pressingPoint = getMousePosition();
		}
	}
	
	/**
	 * Override this to return another component that the focus should be transmit to. 
	 * return null if do not need to transmit(means self handle the focus). By default imp, this return null.
	 * @return the component where the focus need transmit to.
	 */
	private function getFocusTransmit():Component{
		return null;
	}
	
	private function checkRequestFocusWhenMouseDown(e:MouseEvent):Void{
		if(!((isFocusable() || getFocusTransmit() != null) && isEnabled())){
			return;
		}
		var fm:FocusManager = FocusManager.getManager(stage);
		if(fm == null){
			return;
		}
		var focusOwner:Component = fm.getFocusOwner();
		var target:DisplayObject = AsWingUtils.as(e.target,DisplayObject)	;
		if(focusOwner == null){
			var focusObj:InteractiveObject = null;
			#if (flash9)
			if(stage != null){
			 	focusObj = stage.focus;
			}
			#end
			if(focusObj == null){
				requestFocus();
			}else if(!contains(focusObj)){
				requestFocus();
			}
		}else if(focusOwner == this){
			//do nothing, it is already self
		}else if(!AsWingUtils.isAncestor(this, focusOwner)){
			requestFocus();//request, if the current owner is not a child
		}else if(focusOwner.contains(target)){
			//do nothing because child is already focused, and focused child are pressed
		}else{
			var tarCom:Component = AsWingUtils.getOwnerComponent(target);
			if(tarCom == this){
				requestFocus(); //self asset pressed, so request
			}else if(!AsWingUtils.isAncestorComponent(this, tarCom)){
				requestFocus();//request, if the current pressed obj is not a regular child of this
			}
			//do nothing because child is already focused, and another not focusable child is pressed
		}		
	}
	
	private var pressingPoint:IntPoint;
	private function __mouseUp(e:MouseEvent):Void { 
		stopListernDragRec();
	}
	private function __mouseMove(e:MouseEvent):Void{
		var mp:IntPoint = getMousePosition();
		if(mp.distanceSq(pressingPoint) > 1){
			fireDragRecognizedEvent(null);
			stopListernDragRec();
		}
	}
	private function __rollOut(e:MouseEvent):Void{
		stopListernDragRec();
	}
	private function stopListernDragRec():Void{
		//removeEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
		//removeEventListener(MouseEvent.ROLL_OUT, __rollOut);
		//stage.removeEventListener(MouseEvent.MOUSE_UP, __mouseUp);
	}
	
	private function __focusIn(e:FocusEvent):Void{
		if(e.target == getInternalFocusObject() && isFocusable()){
			var fm:FocusManager = FocusManager.getManager(stage);
			if(fm == null){
				return;
			}
			var focusOwner:Component = fm.getFocusOwner();
			if(this != focusOwner){
	    		fm.setFocusOwner(this);
                if (null != focusOwner) focusOwner.paintFocusRect();
	    		paintFocusRect();
	    		dispatchEvent(new AWEvent(AWEvent.FOCUS_GAINED));
   			}
		}
	}
	
	private function __focusOut(e:FocusEvent):Void{
		 if(e.relatedObject == null){
		 	return;
		 }
		if(e.target == getInternalFocusObject() && isFocusable()){
			var fm:FocusManager = FocusManager.getManager(stage);
			if(fm == null){
				return;
			}
			var focusOwner:Component = fm.getFocusOwner();
			if(this == focusOwner){
	    		fm.setFocusOwner(null);
                paintFocusRect();
	    		dispatchEvent(new AWEvent(AWEvent.FOCUS_LOST));
   			}
		}
	}
	/*
	override public function toString():String {
	  	
		return  Reflection.getClassName(this)+ "[asset:" +super.toString()  + "]";
	}
*/
	public var d_y (get, set):Float;

	public var d_x (get, set):Float;
	public var d_visible (get, set):Bool;

//	public var height (get, set):Float;
//
//	public var width (get, set):Float;
//
//	public var y (get, set):Float;
//
//	public var x (get, set):Float;
//
//	public var visible (get, set):Bool;
}
