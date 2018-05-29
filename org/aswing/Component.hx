/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

import flash.events.TouchEvent;
import motion.easing.Linear;
import motion.Actuate;
import haxe.CallStack;
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
	
/**
 * The super class for all Components.
 */
@:event("org.aswing.event.AWEvent.SHOWN", "When the component visible is set to true from false")
@:event("org.aswing.event.AWEvent.HIDDEN", "When the component visible is set to false from true")
@:event("org.aswing.event.AWEvent.PAINT", "When the component is painted")
@:event("org.aswing.event.MovedEvent.MOVED", "When the component is moved")
@:event("org.aswing.event.ResizedEvent.RESIZED", "When the component is resized")
@:event("org.aswing.event.AWEvent.FOCUS_GAINED", "When the component gained the focus from it is not the focus owner")
@:event("org.aswing.event.AWEvent.FOCUS_LOST", "When the component lost the focus from it was the focus owner")
@:event("org.aswing.event.FocusKeyEvent.FOCUS_KEY_DOWN", "When the key down and the component is the focus owner")
@:event("org.aswing.event.FocusKeyEvent.FOCUS_KEY_UP", "When the key up and the component is the focus owner")
@:event("org.aswing.event.ClickCountEvent.CLICK_COUNT", "When the component is clicked continuesly")
@:event("org.aswing.event.DragAndDropEvent.DRAG_RECOGNIZED", "When the component is recongnized that it can be drag start")
@:event("org.aswing.event.DragAndDropEvent.DRAG_ENTER", "When a drag is enter this component area")
@:event("org.aswing.event.DragAndDropEvent.DRAG_EXIT", "When a drag is exit this component area")
@:event("org.aswing.event.DragAndDropEvent.DRAG_DROP", "When a drag is drop on this component")
@:event("org.aswing.event.DragAndDropEvent.DRAG_OVERRING", "When a drag is moving on this component")
class Component extends AWSprite implements IBindable {

	//The max interval time to judge whether click was continuously.
	private static var MAX_CLICK_INTERVAL:Int= 400;

	private static var AWML_INDEX:Int= 0;

	/**
     * The look and feel delegate for this component.
     * `Component` subclasses generally override this method
     */
	public var ui(get, set):ComponentUI;
	private var _ui:ComponentUI;
	private function set_ui(v:ComponentUI) { setUI(v); return v; }
	private function get_ui():ComponentUI { return getUI();}

	@:dox(hide) public var container:Container;

	private var clientProperty:haxe.ds.StringMap<Dynamic>;
	
	private var awmlID:String;
	private var awmlIndex:Int;
	private var awmlNamespace:String;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Size and layout properties
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/**
	 * The clip bounds, a rectangle mask to make specified bounds visible.
	 *
	 * `null' to make the componet mask whole rectangle(show all).
	 *
	 * Default is null.
	 *
	 * Note: the getter clones the value.
	 */
	public var clipBounds(get, set):IntRectangle;
	private var _clipBounds:IntRectangle;
	private function set_clipBounds(v:IntRectangle) { setClipBounds(v); return v; }
	private function get_clipBounds():IntRectangle { return getClipBounds();}

    /**
	* The alignment along the X axis.
	*
	* This specifies how the component would like to be aligned relative
	* to its size when its size is maxer than its `maximumSize`.
	*
	* The value should be a number between 0 and 1 where 0
	* represents alignment start from left, 1 is aligned the furthest
	* away from the left, 0.5 is centered, etc.
	*/
	public var alignmentX(get, set):Float;
	private var _alignmentX:Float;
	private function set_alignmentX(v:Float) { setAlignmentX(v); return v; }
	private function get_alignmentX():Float { return getAlignmentX();}

	/**
	* The alignment along the Y axis.
	*
	* This specifies how the component would like to be aligned relative
	* to its size when its size is maxer than its `maximumSize`.
	*
	* The value should be a number between 0 and 1 where 0
	* represents alignment start from top, 1 is aligned the furthest
	* away from the top, 0.5 is middle, etc.
	*/
	public var alignmentY(get, set):Float;
	private var _alignmentY:Float;
	private function set_alignmentY(v:Float) { setAlignmentY(v); return v; }
	private function get_alignmentY():Float { return getAlignmentY();}

	/**
	* The minimum size of a `Component'.
	*
	* If it's `null` it'll be calculated. @see ComponentUI.getMinimumSize
	**/
	public var minimumSize(get, set):IntDimension;
	private var _minimumSize:IntDimension;
	private function set_minimumSize(v:IntDimension) { setMinimumSize(v); return v; }
	private function get_minimumSize():IntDimension { return getMinimumSize();}

	/**
	* The maximum size of a `Component'.
	*
	* If it's `null` it'll be calculated. @see ComponentUI.getMaximumSize
	**/
	public var maximumSize(get, set):IntDimension;
	private var _maximumSize:IntDimension;
	private function set_maximumSize(v:IntDimension) { setMaximumSize(v); return v; }
	private function get_maximumSize():IntDimension { return getMaximumSize();}

	/**
	* The `preferredSize`'s used during a layout process. `LayoutManager` tries to layout a component to this size.
	*/
	public var preferredSize(get, set):IntDimension;
	private var _preferredSize:IntDimension;
	private function set_preferredSize(v:IntDimension) { setPreferredSize(v); return v; }
	private function get_preferredSize():IntDimension { return getPreferredSize();}

	public var preferredWidth(get, set): Int;
	private function set_preferredWidth(v: Int) { setPreferredWidth(v); return v; }
	private function get_preferredWidth():Int { return getPreferredWidth();}

	public var preferredHeight(get, set): Int;
	private function set_preferredHeight(v: Int) { setPreferredHeight(v); return v; }
	private function get_preferredHeight():Int { return getPreferredHeight();}

	/**
	* The component's size.
	*
	* You can set a Component's size max than its maximumSize, but when it was drawed,
	* it will not max than its maximumSize.Just as its maximumSize and posited itself
	* in that size dimension you just setted. The position is relative to `alignmentX`
	*
	* See `Component.alignmentX`, `Component.alignmentY`, `Component.minimumSize`, `Component.countMaximumSize`,
	* `Component.preferredSize`
	*/
	public var currentSize(get,set): IntDimension;
	private function get_currentSize(): IntDimension { return getSize(); }
	private function set_currentSize(v: IntDimension): IntDimension { setSize(v); return v; }

	/**
	* The location of the top-left corner of a component is specified by x and y, and the size is specified by width and height.
	**/
	public var bounds(get,set): IntRectangle;
	private var _bounds:IntRectangle;
	private function get_bounds(): IntRectangle { return getComBounds(); }
	private function set_bounds(v: IntRectangle): IntRectangle { setComBounds(v); return v; }

	/**
	* The location of the top-left corner of a component is specified by x and y, and the size is specified by width and height.
	**/
	public var location(get,set): IntPoint;
	private function get_location(): IntPoint { return getLocation(); }
	private function set_location(v: IntPoint): IntPoint { setLocation(v); return v; }

	private var cachePreferSizes:Bool;
	private var cachedPreferredSize:IntDimension;
	private var cachedMinimumSize:IntDimension;
	private var cachedMaximumSize:IntDimension;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/**
	* Component constraints. It's used by layout managers to layout components in a container.
	*
	* For example, `BorderLayout.CENTER`
	**/
	public var constraints:Dynamic;

	/**
     * Indicates if this component is just a ui element component or
     * this component is a regular use created component.
     *
     * If a component is a ui element, it and its children will not be called
     * `Component.updateUI` when AsWingUtils to go thought a list of component to update the UI.
     * That is because ui element will be removed when uninstall UI, new ui elements
     * will be created when install UI. So it do not need to do update.
     *
     * @return whether or not this component is a ui element component.
     */
	public var uiElement(get,set): Bool;
	private var _uiElement:Bool;
	private function get_uiElement(): Bool { return isUIElement(); }
	private function set_uiElement(v: Bool): Bool { setUIElement(v); return v; }

	private  var drawTransparentTrigger:Bool;
	private var valid:Bool;
	private var readyToPaint:Bool;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Style properties
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/**
	 * The background color of this component.
	 *
	 * It affects each component differently. Generally it affects the background of a component,
	 * or to be the main tinge of a component.
	 *
	 * If it is `null` and it has style proxy, then this component will inherit the background color of its style proxy.
	*/
	public var background(get,set): ASColor;
	private var _background:ASColor;
	private function get_background(): ASColor { return getBackground(); }
	private function set_background(v: ASColor): ASColor { setBackground(v); return v; }

	/**
	 * The foreground color of this component.
     *
     * It affects each component differently. Generally it affects the text color of a component.
     *
     * If it is `null` and it has style proxy, then this component will inherit the foreground color of its style proxy.
	*/
	public var foreground(get,set): ASColor;
	private var _foreground:ASColor;
	private function get_foreground(): ASColor { return getForeground(); }
	private function set_foreground(v: ASColor): ASColor { setForeground(v); return v; }

	/**
     * The mideground color affects each component differently,
     * generally it affects the thumb color. Most component has no thumb will
     * not use this property.
     *
     * If it is `null` and it has style proxy, then this component will inherit the mideground color of its style proxy.
    */
	public var mideground(get,set): ASColor;
	private var _mideground: ASColor;
	private function get_mideground(): ASColor { return getMideground(); }
	private function set_mideground(v: ASColor): ASColor { setMideground(v); return v; }

	/**
	* The style tune affects each component differently based on its LAF UI implements,
	* generally it affects the border and content color gradient.
	*
	* Not every LookAndFeel UI will use style tune. BasicLookAndFeel use it mostly.
	*
	* If it is `null` then this component will use `DefaultEmptyDecoraterResource.NULL_STYLE_TUNE`
	*
	* @see StyleTune
	*/
	public var styleTune(get,set): StyleTune;
	private var _styleTune: StyleTune;
	private function get_styleTune(): StyleTune { return getStyleTune(); }
	private function set_styleTune(v: StyleTune): StyleTune { setStyleTune(v); return v; }

	/**
	 * The style proxy is used to provide the style(background, mideground, foreground and StyleTune)
	 * properties for this component if any of them are set to null or DefaultEmptyDecoraterResource.NULL_XXX.
	 *
	 * For example, if you set a button's `background` to null, then `background` of the button
	 * will return its style proxy's background.
	 *
	 * By default, the proxy is the parent of this component
	 */
	public var styleProxy(get,set): Component;
	private var _styleProxy: Component;
	private function get_styleProxy(): Component { return getStyleProxy(); }
	private function set_styleProxy(v: Component): Component { setStyleProxy(v); return v; }

	/**
	 * A decorator represents the component background with a `DisplayObject`.
	 *
	 * @see GroundDecorator
	 */
	public var backgroundDecorator(get,set): GroundDecorator;
	private var _backgroundDecorator: GroundDecorator;
	private function get_backgroundDecorator(): GroundDecorator { return getBackgroundDecorator(); }
	private function set_backgroundDecorator(v: GroundDecorator): GroundDecorator { setBackgroundDecorator(v); return v; }

	/**
	 * A decorator represents the component foreground with a `DisplayObject`.
	 *
	 * @see GroundDecorator
	 */
	public var foregroundDecorator(get,set): GroundDecorator;
	private var _foregroundDecorator: GroundDecorator;
	private function get_foregroundDecorator(): GroundDecorator { return getForegroundDecorator(); }
	private function set_foregroundDecorator(v: GroundDecorator): GroundDecorator { setForegroundDecorator(v); return v; }

	/**
	 * The text font for this component.
	 *
	 * The setting of this property will cause a repaint and revalidate method call.
	*/
	public var font(get,set): ASFont;
	private var _font:ASFont;
	private function get_font(): ASFont { return getFont(); }
	private function set_font(v: ASFont): ASFont { setFont(v); return v; }

	private var fontValidated:Bool;

	/**
     * It's true if this component is completely opaque.
     *
     * An opaque component paints every pixel within its
     * rectangular bounds. A non-opaque component paints only a subset of
     * its pixels or none at all, allowing the pixels underneath it to
     * "show through".  Therefore, a component that does not fully paint
     * its pixels provides a degree of transparency.
     *
     * The value is from LookAndFeel defaults if you have not set it.
     *
     * Subclasses that guarantee to always completely paint their contents
     * should override this method and return true.
     *
     *
     * @see Component.opaqueSet
     */
	public var opaque(get,set): Bool;
	private var _opaque:Bool;
	private function get_opaque(): Bool { return isOpaque(); }
	private function set_opaque(v: Bool): Bool { setOpaque(v); return v; }

	/**
     * The value means whether or not the opaque property is set by user.
     *
     * If it is not set, `Component.opaque` will can be replaced with the value defined
     * in LAF defaults when install a UI.
     *
     * It'll also be set to `true` when you set the value of `Component.opaque`.
     */
	public var opaqueSet(get,set): Bool;
	private var _opaqueSet:Bool;
	private function get_opaqueSet(): Bool { return isOpaqueSet(); }
	private function set_opaqueSet(v: Bool): Bool { setOpaqueSet(v); return v; }

	/**
	 * The border for the component, null to remove border.
	 * Border's display object will always on top of background decorator but under other assets.
	**/
	public var border(get, set): Border;
	private var _border:Border;
	private function get_border(): Border { return getBorder(); }
	private function set_border(v: Border): Border { setBorder(v); return v; }

	/**
	 * Makes a component hide or shown.
	 * If a component was hide, some laterly operation may not be done,
	 * they will be done when next shown, ex: repaint, doLayout ....
	 * So suggest you dont changed a component's visible frequently.
	 */
	@:bindable public var visibility(get, set): Bool;
	private function get_visibility(): Bool { return visible; }
	private function set_visibility(v: Bool): Bool { setVisible(v); return v; }

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/**
	 * Enable or disable the component.
	 *
	 * If a component is disabled, it will not fire mouse events.
	 * And some component will has different interface when enabled or disabled.
	 */
	public var enabled(get, set): Bool;
	private var _enabled:Bool;
	private function get_enabled(): Bool { return isEnabled(); }
	private function set_enabled(v: Bool): Bool { setEnabled(v); return v; }

	/**
     * The focusable state of this Component. This
     * value overrides the Component's default focusability.
     */
	public var focusable(get, set): Bool;
	private var _focusable:Bool;
	private function get_focusable(): Bool { return isFocusable(); }
	private function set_focusable(v: Bool): Bool { setFocusable(v); return v; }

	/**
     * Indicates whether or not the focusable property is set by user.
     * If it is not set, `focusable` will be replaced with the value defined
     * in LAF defaults when install a UI.
     */
	public var focusableSet(get, set): Bool;
	private var _focusableSet:Bool;
	private function get_focusableSet(): Bool { return isFocusableSet(); }
	private function set_focusableSet(v: Bool): Bool { setFocusableSet(v); return v; }


	/**
	 * The text to display in a tool tip. The text displays when the cursor lingers over the component.
	 *
	 * This tip will display with a shared tool tip with other components,
	 * so if you want to display more than one tip at same time, you may
	 * need to create your `JToolTip` or `JSharedToolTip`.
	 *
	 * if the text is null, the tool tip is turned off for this component.
	 */
	public var toolTipText(get, set): String;
	private var _toolTipText:String;
	private function get_toolTipText(): String { return getToolTipText(); }
	private function set_toolTipText(v: String): String { setToolTipText(v); return v; }

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Drag and Drop properties
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/**
	 * Means whether this component can fire `ON_DRAG_RECOGNIZED` event. (Default value is false)
	 */
	public var dragEnabled(get, set): Bool;
	private var _dragEnabled:Bool;
	private function get_dragEnabled(): Bool { return isDragEnabled(); }
	private function set_dragEnabled(v: Bool): Bool { setDragEnabled(v); return v; }

	/**
	 * Means whether this component can trigger dragging component to fire drag events
	 * when dragging over to this component.(Default value is false)
	 * See `ON_DRAG_ENTER`, `ON_DRAG_OVER`, `ON_DRAG_EXIT`, `ON_DRAG_DROP`
	 */
	public var dropTrigger(get, set): Bool;
	private var _dropTrigger:Bool;
	private function get_dropTrigger(): Bool { return isDropTrigger(); }
	private function set_dropTrigger(v: Bool): Bool { setDropTrigger(v); return v; }

	private var dragAcceptableInitiator:haxe.ds.IntMap<Bool>;
	private var dragAcceptableInitiatorAppraiser:Dynamic->Bool;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/**
	* The space between the component's border and the resizer trigger
	*/
	public var resizerMargin(get, set): Insets;
	private var _resizerMargin:Insets;
	private function get_resizerMargin(): Insets { return getResizerMargin(); }
	private function set_resizerMargin(v: Insets): Insets { setResizerMargin(v); return v; }

	public function new() {
		_bounds = new IntRectangle();
		AWML_INDEX++;
		awmlIndex = AWML_INDEX;
		drawTransparentTrigger=true;
		super();
		setName("Component");
		_ui = null;
		clientProperty = null;
		_alignmentX = 0;
		_alignmentY = 0;
		_opaque = false;
		_opaqueSet = false;
		valid = false;
		_enabled = true;
		_focusable = false;
		_focusableSet = false;
		cachePreferSizes = true;
		fontValidated = false;
		readyToPaint = false;
		_toolTipText = null;
		_uiElement = false;
		_border = DefaultEmptyDecoraterResource.INSTANCE;
		_backgroundDecorator = DefaultEmptyDecoraterResource.INSTANCE;
		_foregroundDecorator = DefaultEmptyDecoraterResource.INSTANCE;
		
		_font = DefaultEmptyDecoraterResource.DEFAULT_FONT;
		_background = DefaultEmptyDecoraterResource.DEFAULT_BACKGROUND_COLOR;
		_foreground = DefaultEmptyDecoraterResource.DEFAULT_FOREGROUND_COLOR;
		_mideground = DefaultEmptyDecoraterResource.DEFAULT_MIDEGROUND_COLOR;
		_styleTune  = DefaultEmptyDecoraterResource.DEFAULT_STYLE_TUNE;
		
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
			c._uiElement = true;
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
	@:dox(hide) public function setAwmlID(id:String):Void{
		awmlID = id;
	}

	/**
	 * Returns ID used to identify components created from AWML.
	 *
	 * @return the AWML ID
	 */
	@:dox(hide) public function getAwmlID():String{
		return awmlID;
	}

	/**
	 * Sets namespace used to identify components created from AWML.
	 * Used to obtain components through {@link org.aswing.awml.AwmlManager}.
	 * You should never modify this value.
	 *
	 * @param theNamespace the new namespace name
	 */
	@:dox(hide) public function setAwmlNamespace(theNamespace:String):Void{
		awmlNamespace = theNamespace;
	}

	/**
	 * Returns namespace name used to identify components created from AWML.
	 *
	 * @return the namespace name
	 */
	@:dox(hide) public function getAwmlNamespace():String{
		return awmlNamespace;
	}

	/**
	 * Sets ID used to identify components created from AWML. Used to obtain components through
	 * {@link org.aswing.awml.AwmlManager}. You should never modify this value.
	 *
	 * @param index the position index of the component
	 */
	@:dox(hide) public function setAwmlIndex(index:Int):Void{
		awmlIndex = index;
	}

	/**
	 * Returns position index of the component inside its AWML container.
	 *
	 * @return the component index in the AWML
	 */
	@:dox(hide) public function getAwmlIndex():Int{
		return awmlIndex;
	}
	    
	/**
     * Returns the `UIDefaults` key used to
     * look up the name of the `org.aswing.plaf.ComponentUI`
     * class that defines the look and feel
     * for this component.
     *
     * Most applications will never need to
     * call this method.  Subclasses of `Component` that support
     * pluggable look and feel should override this method to
     *
     * return a `UIDefaults` key that maps to the
     * `ComponentUI` subclass that defines their look and feel.
     *
     * @see org.aswing.UIDefaults.getUI

     * @return the `UIDefaults` key for a `ComponentUI` subclass
     **/
	public function getUIClassID():String{
		return "ComponentUI";
	}
	
	/**
	 * Sets the name of this component
	 * @see #name
	 */
	@:dox(hide) public function setName(name:String):Void{
		this.name = name;
	}
	
	/**
	 * Returns the name of the component
	 * @see #name
	 */
	@:dox(hide) public function getName():String{
		return name;
	}
	
    /**
     * Resets the UI property to a value from the current look and feel.
     * `Component` subclasses must override this method
     * like this:
     * <code>
     *   public void updateUI() {
     *      setUI(SliderUI(UIManager.getUI(this)));
     *   }
     * </code>
     *
     * See `Component.ui`, `UIManager.getLookAndFeel`, `UIManager.getUI`
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
	@:dox(hide)
    public function isUIElement():Bool{
    	return _uiElement;
    }
    
    /**
     * Sets the component is a ui element or not. (if set true, all of its children will be set to true too)
     * @param b true to set this component to be treated as a element, false not.
     * @see #isUIElement()
     */
	@:dox(hide)
    public function setUIElement(b:Bool):Void{
    	if(_uiElement != b){
    		_uiElement = b;
    		if(b){
    			makeAllTobeUIElement(this);
    		}
    	}
    }
    
    /**
     * Returns the default basic ui class for this component.
     * If there is not a ui class specified in L&F for this component, 
     * this method will be called to return a default one.
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
	@:dox(hide)
    public function setUI(newUI:ComponentUI):Void{
        /* We do not check that the UI instance is different
         * before allowing the switch in order to enable the
         * same UI instance *with different default settings*
         * to be installed.
         */
        if (_ui != null) {
            _ui.uninstallUI(this);
        }
        _ui = newUI;
        if (_ui != null) {
            _ui.installUI(this);
        }
        revalidate();
        repaint();
    }

    @:dox(hide)
    public function getUI():ComponentUI{
    	return _ui;
    }
	
	/**
	 * Sets the border for the component, null to remove border.
	 * Border's display object will always on top of background decorator but under other assets.
	 * @param border the new border to set, or null.
	 */
	@:dox(hide) public function setBorder(b:Border):Void {
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
	 */
	@:dox(hide) public function getBorder():Border{
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
	@:dox(hide) public function setResizerMargin(m:Insets):Void{
        if (_resizerMargin != m) {
        	_resizerMargin = m;
            revalidate();
        	repaint();
        }
	}
	
	@:dox(hide) public function getResizerMargin():Insets{
		var m:Insets = _resizerMargin;
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
	@:dox(hide) public function setBackgroundDecorator(bg:GroundDecorator):Void{
		if(bg != _backgroundDecorator){
			var old:GroundDecorator= _backgroundDecorator;
			_backgroundDecorator = bg;
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
	@:dox(hide) public function getBackgroundDecorator():GroundDecorator{
		return _backgroundDecorator;
	}
	
	/**
	 * Sets a decorator to be the component foreground, it will represent the component foreground 
	 * with a <code>DisplayObject</code> on top of other children of this component. 
	 * null to remove the decorator set before.
	 * 
	 * @param fg the foreground decorator.
	 */
	@:dox(hide) public function setForegroundDecorator(fg:GroundDecorator):Void{
		if(fg != _foregroundDecorator){
			var old:GroundDecorator= _foregroundDecorator;
			_foregroundDecorator = fg;
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
	@:dox(hide) public function getForegroundDecorator():GroundDecorator{
		return _foregroundDecorator;
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
	@:dox(hide)
	public function setVisible(v:Bool):Void{
		if(v != d_visible){
			var oldValue = visibility;
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
            bindx.Bind.notify(this.visibility, oldValue, visibility);
		}
	}
	@:dox(hide)
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
	@:dox(hide)public function setFont(newFont:ASFont):Void{
		if(_font != newFont){
			_font = newFont;
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
	@:dox(hide) public function getFont():ASFont{
        if (_font != null && _font != DefaultEmptyDecoraterResource.NULL_FONT) {
            return _font;
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
	@:dox(hide) public function setBackground(c:ASColor):Void{
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
	@:dox(hide) public function getBackground():ASColor{
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
	@:dox(hide) public function setForeground(c:ASColor):Void{
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
	@:dox(hide) public function getForeground():ASColor{
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
	@:dox(hide) public function setMideground(c:ASColor):Void{
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
	@:dox(hide) public function getMideground():ASColor{
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
	@:dox(hide) public function setStyleTune(c:StyleTune):Void{
		if(_styleTune != c){
			_styleTune = c;
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
	@:dox(hide) public function getStyleTune():StyleTune{
		if(_styleTune != null && _styleTune != DefaultEmptyDecoraterResource.NULL_STYLE_TUNE){
			return _styleTune;
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
	@:dox(hide) public function setStyleProxy(proxy:Component):Void{
		_styleProxy = proxy;
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
	@:dox(hide) public function getStyleProxy():Component{
		if(_styleProxy != null){
			return _styleProxy;
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
    @:dox(hide) public function setOpaque(b:Bool):Void{
    	opaqueSet = true;
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
    @:dox(hide) public function isOpaque():Bool{
    	return _opaque;
    }
    
    /**
     * Returns whether or not the opaque property is set by user. 
     * If it is not set, <code>opaque</code> will can be replaced with the value defined 
     * in LAF defaults when install a UI.
     */
	@:dox(hide)
    public function isOpaqueSet():Bool{
    	return _opaqueSet;
    }
    
    /**
     * This method will be called to set true when you set the opaque by <code>setOpaque()</code>.
     * You can also call this method to make the opaque property returned by the set or LAF defaults.
     * @see #isOpaqueSet()
     * @see #isOpaque()
     */
	@:dox(hide)
    public function setOpaqueSet(b:Bool):Void{
    	_opaqueSet = b;
    }
    
    /**
     * Indicates the alpha transparency value of the component. 
     * Valid values are 0 (fully transparent) to 1 (fully opaque).
     * @param alpha the alpha for this component, between 0 and 1. default is 1.
     */
    @:dox(hide) public function setAlpha(alpha:Float):Void{
    	this.alpha = alpha;
    }
    
    /**
     * Returns the alpha of this component.
     * @return the alpha of this component. default is 1.
     */
	@:dox(hide) public function getAlpha():Float{
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
	 *
	 * This is same to some paint method param b:Rectangle.
	 * So if you want to paint outside those method, you can get the 
	 * rectangle from here.
	 * 
	 * If this component has a little maximum size, and then current 
	 * size is larger, the bounds return from this method will be related 
	 * to `Component.alignmentX`, `Component.alignmentY` and `Component.maximumSize`.
	 *
	 * @return return the rectangle that component should paint in.
	 */
	public function getPaintBounds():IntRectangle{
		return getInsets().getInsideBounds(getPaintBoundsInRoot());
	}		
		
	/**
	 * Moves and resizes this component. The new location of the top-left corner is specified by x and y, and the new size is specified by width and height. 
	 * @param b the location and size bounds
	 */
	@:dox(hide) public function setComBounds(b:IntRectangle):Void{
		setLocationXY(b.x, b.y);
		setSizeWH(b.width, b.height);
	}
	
	/**
	 * Moves and resizes this component. The new location of the top-left corner is specified by x and y, and the new size is specified by width and height. 
	 */
	@:dox(hide) public function setComBoundsXYWH(x:Int, y:Int, w:Int, h:Int):Void{
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
	@:dox(hide) public function getComBounds(rv:IntRectangle=null):IntRectangle{
		if(rv != null){
			rv.setRect(_bounds);
			return rv;
		}else{
			return new IntRectangle(_bounds.x, _bounds.y, _bounds.width, _bounds.height);
		}
	}
	
	/**
	 * Set the component's location, if it is diffs from old location, invalidate it to wait validate.
	 *
	 * The top-left corner of the new location is specified by the x and y parameters
	  *
	 * in the coordinate space of this component's parent.
	 */
	@:dox(hide)
	public function setLocation(newPos:IntPoint):Void{
		var oldPos:IntPoint = _bounds.getLocation();

		if(!newPos.equals(oldPos)){
			_bounds.setLocation(newPos);
			locate();
			dispatchEvent(new MovedEvent(oldPos, newPos));
		}
	}
	
	/**
	 * @see #setLocation()
	 */
	@:dox(hide) public function setLocationXY(x:Int, y:Int):Void {
		setLocation(new IntPoint(x, y));
	}
	
	/**
	 * Set the component's location in global coordinate. This method should only be called when the component 
	 * is on the display list.
	 * See `Component.location`, `flash.DisplayObject.localToGlobal`, `flash.DisplayObject.globalToLocal`
	 * @param gp the global location.
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
	@:dox(hide) public function setGlobalLocationXY(x:Int, y:Int):Void{
		setGlobalLocation(new IntPoint(x, y));
	}
	
	/**
	 * Stores the location value of this component into "return value" rv and returns rv.
	 *
	 * If `rv` is `null` a `new Point` object is allocated.
	 *
	 * @param rv the return value, modified to the component's location.
	 */
	@:dox(hide)
	public function getLocation(rv:IntPoint=null):IntPoint{
		if(rv != null){
			rv.setLocationXY(_bounds.x, _bounds.y);
			return rv;
		}else{
			return new IntPoint(_bounds.x, _bounds.y);
		}
	}
	
	/**
	* Stores the global location value of this component into "return value" rv and returns rv.
	*
	* If `rv` is `null` a `new Point` object is allocated.
	* @param rv the return value, modified to the component's global location.
	*
	* See `Component.location`, `Component.setGlobalLocation`, `flash.DisplayObject.localToGlobal`, `flash.DisplayObject.globalToLocal`
	**/
	public function getGlobalLocation(rv:IntPoint=null):IntPoint{
		var gp:Point =  this.localToGlobal(new Point(0, 0));
		if(rv != null){
			rv.setLocationXY(Std.int(gp.x), Std.int(gp.y));
			return rv;
		}else{
			return new IntPoint(Std.int(gp.x), Std.int(gp.y));
		}
	}

	/**
	* Converts global coordinates to the local space (inside component space).
	*
	* @see Component.localToGlobal
	**/
	public function globalToComponent(p:IntPoint):IntPoint{
		var np:Point = new Point(p.x, p.y);
		np = globalToLocal(np);
		return new IntPoint(Std.int(np.x), Std.int(np.y));
	}

	/**
	* Converts local (inside component space) coordinates to the global space.
	*
	* @see Component.globalToLocal
	**/
	public function componentToGlobal(p:IntPoint):IntPoint{
		var np:Point = new Point(p.x, p.y);
	 
		np =   this.localToGlobal(np);
		return new IntPoint(Std.int(np.x), Std.int(np.y));
	}	
	
	/**
	 * This method will call setComBounds()
	 * @see #setComBounds()
	 */
	@:dox(hide)
	@:deprecated
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
	@:dox(hide) public function setSize(newSize:IntDimension):Void{
		newSize.width = Std.int(Math.max(0, newSize.width));
		newSize.height = Std.int(Math.max(0, newSize.height));
		var oldSize:IntDimension = new IntDimension(_bounds.width, _bounds.height);
		if(!newSize.equals(oldSize)){
			_bounds.setSize(newSize);
			size();
			dispatchEvent(new ResizedEvent(oldSize, newSize));
		}
	}
	/**
	 * @see Component.currentSize
	 */
	@:dox(hide)
	public function setSizeWH(w:Int, h:Int):Void{
		setSize(new IntDimension(w, h));
	}

	/**
	 * Stores the size value of this component into "return value" rv and returns rv. 
	 * If rv is null a new IntDimension object is allocated. 
	 * @param rv the return value, modified to the component's size.
	 */	
	@:dox(hide) public function getSize(rv:IntDimension=null):IntDimension{
		if(rv != null){
			rv.setSizeWH(_bounds.width, _bounds.height);
			return rv;
		}else{
			return new IntDimension(_bounds.width, _bounds.height);
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
	@:dox(hide) public function setWidth(width:Int):Void{
		setSizeWH(width, getHeight());
	}
	/**
	 * Sets the component's height.
	 * @param height the height of component to set
	 * @see  #setSize()
	 */
	@:dox(hide) public function setHeight(height:Int):Void{
		setSizeWH(getWidth(), height);
	}
	/**
	 * Returns the current width of this component
	 * @return the width of the component
	 */
	@:dox(hide) public function getWidth():Int{
		return _bounds.width;
	}
	/**
	 * Returns the current height of this component
	 * @return the height of the component
	 */
	@:dox(hide) public function getHeight():Int{
		return _bounds.height;
	}
	/**
	 * Sets the x coordinate of the components.
	 * @return the x coordinate
	 * @see #setLocation()
	 */
	@:dox(hide) public function setX(x:Int):Void{
		setLocationXY(x, getY());
	}
	/**
	 * Sets the y coordinate of the components.
	 * @return the y coordinate
	 * @see #setLocation()
	 */
	@:dox(hide) public function setY(y:Int):Void{
		setLocationXY(getX(), y);
	}
	/**
	 * Returns the current x coordinate of the components.
	 * @return the current x coordinate of the components
	 * @see #getLocation()
	 */
	@:dox(hide) public function getX():Int{
		return _bounds.x;
	}
	/**
	 * Returns the current y coordinate of the components.
	 * @return the current y coordinate of the components
	 * @see #getLocation()
	 */
	@:dox(hide) public function getY():Int{
		return _bounds.y;
	}
	
	/**
	 * Enable or disable the component.
	 * <p>
	 * If a component is disabled, it will not fire mouse events. 
	 * And some component will has different interface when enabled or disabled.
	 * @param b true to enable the component, false to disable it.
	 */
	@:dox(hide)
	public function setEnabled(b:Bool):Void{
		if(_enabled != b){
			_enabled = b;
			mouseEnabled = b;
			repaint();
		}
	}
	
	/**
	 * Returns whether the component is enabled.
	 * @see #setEnabled()
	 */
	@:dox(hide)
	public function isEnabled():Bool{
		return _enabled;
	}
	

	
	/**
	 * Sets the clip bounds, a rectangle mask to make specified bounds visible.
	 * Null to make the componet mask whole rectangle(show all).
	 * @param b the bounds to be the masked clip, null to make it show all. Default is null.
	 */
	@:dox(hide) public function setClipBounds(b:IntRectangle):Void{
		if(b == null && _clipBounds == null){
			return;
		}
		var changed:Bool= false;
		if(b == null && _clipBounds != null){
			_clipBounds = null;
			changed = true;
		}else{
			if(!b.equals(_clipBounds)){
				_clipBounds = b.clone();
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
	@:dox(hide) public function getClipBounds():IntRectangle{
		if(_clipBounds == null){
			return null;
		}
		return _clipBounds.clone();
	}
	
	/**
	 * Sets the size of clip bounds, a rectangle mask to make specified bounds visible.
	 *
	 * This will be only in effect after component created and before next layout time.
	 *
	 * @see Component.clipBounds
	 */	
	public function setClipSize(size:IntDimension):Void{
		var bounds:IntRectangle = new IntRectangle();
		if(_clipBounds != null){
			bounds.setLocation(_clipBounds.getLocation());
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
	@:dox(hide)
	public function isFocusable():Bool{
		return _focusable;
	}
	
    /**
     * Sets the focusable state of this Component to the specified value. This
     * value overrides the Component's default focusability.
     *
     * @param focusable indicates whether this Component is focusable
     * @see #isFocusable()
     */
	@:dox(hide)
	public function setFocusable(b:Bool):Void{
		_focusable = b;
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
	@:dox(hide)
	public function isFocusableSet():Bool{
		return _focusableSet;
	}
	
	/**
	 * Indicate that the <code>focusable</code> property is set by user or not.
	 * @param b whether set or not
	 * @see #isFocusableSet()
	 */
	@:dox(hide)
	public function setFocusableSet(b:Bool):Void{
		_focusableSet = b;
	}

	/**
	 * Sets whether this component can fire ON_DRAG_RECOGNIZED event.
	 * @see #ON_DRAG_RECOGNIZED 
	 * @see #isDragEnabled()
	 */
	@:dox(hide)
	public function setDragEnabled(b:Bool):Void{
		_dragEnabled = b;
	}
	
	/**
	 * Returns whether this component can fire ON_DRAG_RECOGNIZED event. (Default value is false)
	 * @see #ON_DRAG_RECOGNIZED
	 * @see #setDragEnabled()
	 */
	@:dox(hide)
	public function isDragEnabled():Bool{
		return _dragEnabled;
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
	@:dox(hide)
	public function setDropTrigger(b:Bool):Void{
		_dropTrigger = b;
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
	@:dox(hide)
	public function isDropTrigger():Bool{
		return _dropTrigger;
	}

	/**
	 * Adds a component to be the acceptable drag initiator to this component.
	 *
	 * It is not meanning that the DnD events will not be fired when the initiator
	 * is dragging enter/over/exit/drop on this component.
	 * It is meanning that you can have a convenient way to proccess that events from 
	 * the method `Component.isDragAcceptableInitiator` later, and the default dragging
	 * image will take advantage to present a better picture when painting.
	 *
	 * @param com the acceptable drag initiator
	 */
	public function addDragAcceptableInitiator(com:Component):Void{
		if(dragAcceptableInitiator == null){
			dragAcceptableInitiator = new haxe.ds.IntMap<Bool>();
		}
		  dragAcceptableInitiator.set(com.getAwmlIndex(), true);
	}
	
	/**
	 * Removes a component to be the acceptable drag initiator to this component.
	 *
	 * @see Component.addDragAcceptableInitiator
	 *
	 * @param com the acceptable drag initiator
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
	@:dox(hide) public function setToolTipText(t:String):Void{
		_toolTipText = t;
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
	@:dox(hide) public function getToolTipText():String{
		return _toolTipText;
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
    @:dox(hide) public function setAlignmentX(ax:Float):Void{
    	if(_alignmentX != ax){
    		_alignmentX = ax;
    		repaint();
    	}
    }
    
    /**
	 * @param ay
	 * @see #getAlignmentY()
     */
    @:dox(hide) public function setAlignmentY(ay:Float):Void{
    	if(_alignmentY != ay){
    		_alignmentY = ay;
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
    @:dox(hide) public function getAlignmentX():Float{
    	return _alignmentX;
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
    @:dox(hide) public function getAlignmentY():Float{
    	return _alignmentY;
    }
    
    /**
     * Returns the value of the property with the specified key. 
     * Only properties added with putClientProperty will return a non-null value.
     *
     * @see Component.putClientProperty
     *
     * @param key the being queried
     * @param defaultValue if the value doesn't exists, the defaultValue will be returned
     * @return the value of this property or null
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
     *
     * The `get/putClientProperty` methods provide access to
     * a small per-instance hashtable.
     *
     * Callers can use get/putClientProperty
     * to annotate components that were created by another module.
     *
     * For example, a
     * layout manager might store per child constraints this way. For example:
     * `
     * componentA.putClientProperty("to the left of", componentB);
     * `
     *
     * @see Component.getClientProperty
     *
     * @param key the new client property key
     * @param value the new client property value
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
		if(_ui != null){
			return _ui.getMinimumSize(this);
		}else{
			return getInsets().getOutsideSize(new IntDimension(0, 0));
		}
	}
	
	/**
	 * get the maximumSize from ui, if ui is null then return a big dimension;
	 * @see IntDimension#createBigDimension()
	 */
	private function countMaximumSize():IntDimension{		
		if(_ui != null){
			return _ui.getMaximumSize(this);
		}else{
			return IntDimension.createBigDimension();
		}
	}
	
	/**
	 * get the preferredSize from ui, if ui is null then just return the current size
	 */
	private function countPreferredSize():IntDimension{
		if(_ui != null){
			return _ui.getPreferredSize(this);
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
	@:dox(hide) public function getMinimumSize():IntDimension{
		if(isDirectReturnSize(_minimumSize)){
			return _minimumSize.clone();
		}else if(isCachePreferSizes() && cachedMinimumSize != null){
			return cachedMinimumSize.clone();
		}else{
			var tempSize:IntDimension = mixSetSize(countMinimumSize(), _minimumSize);
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
	@:dox(hide) public function getMaximumSize():IntDimension{
		if(isDirectReturnSize(_maximumSize)){
			return _maximumSize.clone();
		}else if(isCachePreferSizes() && cachedMaximumSize != null){
			return cachedMaximumSize.clone();
		}else{
			var tempSize:IntDimension = mixSetSize(countMaximumSize(), _maximumSize);
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
	@:dox(hide) public function getPreferredSize():IntDimension {
        if(isDirectReturnSize(_preferredSize)){
			return _preferredSize.clone();
		}else if(isCachePreferSizes() && cachedPreferredSize != null){
			return cachedPreferredSize.clone();
		}else{
			var tempSize:IntDimension = mixSetSize(countPreferredSize(), _preferredSize);
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
	@:dox(hide) public function setMinimumSize(minimumSize:IntDimension):Void{
		if(minimumSize == null){
			this._minimumSize = null;
		}else{
			this._minimumSize = minimumSize.clone();
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
	@:dox(hide) public function setMaximumSize(maximumSize:IntDimension):Void{
		if(maximumSize == null){
			this._maximumSize = null;
		}else{
			this._maximumSize = maximumSize.clone();
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
	@:dox(hide) public function setPreferredSize(preferredSize:IntDimension):Void{
		if(preferredSize == null){
			this._preferredSize = null;
		}else{
			this._preferredSize = preferredSize.clone();
		}
	}	
	
	/**
	 * Returns <code>getPreferredSize().width</code>
	 * @see #getPreferredSize()
	 */
	@:dox(hide) public function getPreferredWidth():Int{
		return getPreferredSize().width;
	}
	
	/**
	 * Sets preferred width, -1 means auto count.
	 * @see #setPreferredSize()
	 */
	@:dox(hide) public function setPreferredWidth(preferredWidth:Int):Void{
		if(_preferredSize == null){
			_preferredSize = new IntDimension(-1, -1);
		}
		_preferredSize.width = preferredWidth;
	}
	
	/**
	 * Returns <code>getPreferredSize().height</code>
	 * @see #getPreferredSize()
	 */
	@:dox(hide) public function getPreferredHeight():Int{
		return getPreferredSize().height;
	}
	
	/**
	 * Sets preferred width, -1 means auto count.
	 * @see #setPreferredSize()
	 */
	@:dox(hide) public function setPreferredHeight(preferredHeight:Int):Void{
		if(_preferredSize == null){
			_preferredSize = new IntDimension(-1, -1);
		}
		_preferredSize.height = preferredHeight;
	}
	
	/**
	 * Returns <code>getMaximumSize().width</code>
	 * @see #getMaximumSize()
	 */
	@:dox(hide) public function getMaximumWidth():Int{
		return getMaximumSize().width;
	}
	/**
	 * Sets maximum width, -1 means auto count.
	 * @see #setMaximumSize()
	 */
	@:dox(hide) public function setMaximumWidth(maximumWidth:Int):Void{
		if(_maximumSize == null){
			_maximumSize = new IntDimension(-1, -1);
		}
		_maximumSize.width = maximumWidth;
	}
	/**
	 * Returns <code>getMaximumSize().height</code>
	 * @see #getMaximumSize()
	 */
	@:dox(hide) public function getMaximumHeight():Int{
		return getMaximumSize().height;
	}
	/**
	 * Sets maximum height, -1 means auto count.
	 * @see #setMaximumSize()
	 */
	@:dox(hide) public function setMaximumHeight(maximumHeight:Int):Void{
		if(_maximumSize == null){
			_maximumSize = new IntDimension(-1, -1);
		}
		_maximumSize.height = maximumHeight;
	}
	/**
	 * Returns <code>getMinimumSize().width</code>
	 * @see #getMinimumSize()
	 */
	@:dox(hide) public function getMinimumWidth():Int{
		return getMinimumSize().width;
	}
	/**
	 * Sets minimum width, -1 means auto count.
	 * @see #setMinimumSize()
	 */
	@:dox(hide) public function setMinimumWidth(minimumWidth:Int):Void{
		if(_minimumSize == null){
			_minimumSize = new IntDimension(-1, -1);
		}
		_minimumSize.width = minimumWidth;
	}	
	/**
	 * Returns <code>getMinimumSize().height</code>
	 * @see #getMinimumSize()
	 */
	@:dox(hide) public function getMinimumHeight():Int{
		return getMinimumSize().height;
	}
	/**
	 * Sets minimum height, -1 means auto count.
	 * @see #setMinimumSize()
	 */
	@:dox(hide) public function setMinimumHeight(minimumHeight:Int):Void{
		if(_minimumSize == null){
			_minimumSize = new IntDimension(-1, -1);
		}
		_minimumSize.height = minimumHeight;
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
     *
     * Calls `Component.invalidate` and then adds this component
     * to a list of components that need to be
     * validated.  Validation will occur after all currently pending
     * events have been dispatched.  In other words after this method
     * is called, the first component (if any) found when walking
     * up the containment hierarchy of this component will be validated.
     * By default, `JPopup`, `JScrollPane`,
     * and `JTextField` return true
     * from `Component.isValidateRoot`.
     *
     * This method will or will not automatically be called on this component 
     * when a property value changes such that size, location, or 
     * internal layout of this component has been affected.But invalidate
     * will do called after thats method, so you want to get the contents of 
     * the GUI to update you should call this method.
     *
     *
     * See `Component.invalidate`, `Component.validate`, `Component.isValidateRoot`, `RepaintManager.addInvalidComponent`
     */
	public function revalidate():Void{
    	invalidate();
    	RepaintManager.getInstance().addInvalidComponent(this);
    }
        
	@:dox(hide)
    public function revalidateIfNecessary():Void{
    	RepaintManager.getInstance().addInvalidComponent(this);
    }
	
	/**
	 * Redraws the component face next `RENDER` event.
	 *
	 * This method can be called often, so it needs to execute quickly.
	 * @see org.aswing.RepaintManager
	 */
	public function repaint():Void{
		if(isVisible() && isReadyToPaint()){
			RepaintManager.getInstance().addRepaintComponent(this);
		}
	}
	/**
	* See `Component.repaint`, `Component.revalidate`
	**/
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
     * Invalidates this component.
     *
     * This component and all parents
     * above it are marked as needing to be laid out, and all `Component.clearPreferSizeCaches`.
     * This method can be called often, so it needs to execute quickly.
     * See `Component.validate`, `Component.doLayout`, `Component.invalidatePreferSizeCaches`, `org.aswing.LayoutManager`
     */	
	override public function invalidate():Void {
		super.invalidate();
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
     *
     * By default all components' prefer sizes(max, min, prefer) have caches, if you 
     * make some call that cached a invalided component's sizes but then you modify
     * the component again, so it's prefer size need to be renew,
     * `Component.invalidatePreferSizeCaches` will be helpful now.
     *
     * Generally you do not need to call this method manually unless you get above situation.
     * this method will be called inside `Component.invalidate` automatically.
     * See	`Component.invalidate`, `Component.validate`, `Component.setCachePreferSizes`, `org.aswing.LayoutManager`
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
     * primarily intended to operate on instances of `Container`.
     * See `Component.invalidate`, `Container.doLayout`, `LayoutManager`, `Container.validate`
     */	
	public function validate():Void{
    	if(!valid){
    		valid = true;
    	}
	}
	
	/**
	 * Redraw the component UI face immediately if it is visible and ready to paint.
	 * See `Component.repaint`, `Component.visibility`, `Component.isReadyToPaint`
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
		
		if(_backgroundDecorator != null){
			_backgroundDecorator.updateDecorator(this, g, b.clone());
		}
		if (_ui != null) {
			_ui.paint(this, g, b.clone());
		}
		paintFocusRect();
		//paint border at last to make it at the top depth
		if(_border != null){
			// not that border is not painted in b, is painted in component's full size bounds
			// because border are the rounds, others will painted in the border's bounds.
			_border.updateBorder(this, g, getInsets().getOutsideBounds(b.clone()));
		}
		if(_foregroundDecorator != null){
			_foregroundDecorator.updateDecorator(this, g, b.clone());
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
		if(_ui!=null && fm!=null){
			if(force || fm.isTraversing() && isFocusOwner()){
				var fr:Sprite = fm.moveFocusRectUpperTo(this);
				fr.graphics.clear();
				_ui.paintFocus(this, new Graphics2D(fr.graphics), new IntRectangle(0, 0, Std.int(getWidth()), Std.int(getHeight())));
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
		if(_clipBounds != null){
			paintBounds.x = Std.int(Math.max(paintBounds.x, _clipBounds.x));
			paintBounds.y = Std.int(Math.max(paintBounds.y, _clipBounds.y));
			paintBounds.width = Std.int(Math.min(paintBounds.width, _clipBounds.width));
			paintBounds.height = Std.int(Math.min(paintBounds.height, _clipBounds.height));
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
	 * Returns the `Container` parent,
	 * if it parent is not a `Container`, null will be returned.
	 *
	 * @return the `Container` parent
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
	 * @see Container.reAppendChildren
	 */
	public function parentReAppendChildren():Void{
		if(container!=null){
			container.reAppendChildren();
		}
	}
	
	/**
	 * Returns the first `JRootPane` ancestor of this component, or null if not found.
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
	 * Returns the keyboard manager of this component's `JRootPane` ancestor or null if no root pane ancestor.
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
	 *
	 * This method will remove this component in any case.
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
	@:dox(hide) public inline function setConstraints(constraints:Dynamic):Void{
		this.constraints = constraints;
	}
	
	/**
	 * Gets component's constraints.
	 * @return component's constraints
	 */
	@:dox(hide) public inline function getConstraints():Dynamic{
		return constraints;
	}
	
    /**
     * Transfers the focus to the next component, as though this Component were
     * the focus owner.
     * @see Component.requestFocus
     * @return true if transfered, false otherwise
     */
    public function transferFocus():Bool{
    	return transferFocusWithDirection(1);
    }
    
    /**
     * Transfers the focus to the previous component, as though this Component
     * were the focus owner.
     * @see Component.requestFocus
     * @return true if transfered, false otherwise
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
     * `org.aswing.event.AWEvent.FOCUS_GAINED` event.
     *
     * @see Component.focusable
     *
     * @return true if the request is made successful, false if the request is denied.
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
     *
     * You'd better to call `Component.requestFocus()` generally, this method is only
     * used to some internal implementation at most time.
     *
     * @see Component.requestFocus, `Component.getInternalFocusObject`
     */
    public function makeFocus():Void{
    	if(getFocusTransmit() != null){
    		getFocusTransmit().requestFocus();
    	}else{
    		var ifo:InteractiveObject = getInternalFocusObject();
			#if(flash9 || html5 || cpp)
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
     *
     * Other component may return a child object, for example `JTextComponent` will return
     * its `TextField` object.
     *
     * @see org.aswing.plaf.ComponentUI.getInternalFocusObject
     *
     * @return the object to receive the focus.
     */
	public function getInternalFocusObject():InteractiveObject{
		var ifo:InteractiveObject = null;
		if(_ui != null){
			ifo = _ui.getInternalFocusObject(this);
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
    
    @:dox(hide) public function fireFocusKeyDownEvent(e:KeyboardEvent):Void {
    	dispatchEvent(new FocusKeyEvent(FocusKeyEvent.FOCUS_KEY_DOWN, e.charCode, 
    	e.keyCode, e.keyLocation, e.ctrlKey, e.altKey, e.shiftKey));
    }
    
    @:dox(hide) public function fireFocusKeyUpEvent(e:KeyboardEvent):Void {
    	dispatchEvent(new FocusKeyEvent(FocusKeyEvent.FOCUS_KEY_UP, e.charCode, 
    	e.keyCode, e.keyLocation, e.ctrlKey, e.altKey, e.shiftKey));
    }


	@:dox(hide) private function fireDragRecognizedEvent(touchedChild:Component):Void {
		dispatchEvent(new DragAndDropEvent(DragAndDropEvent.DRAG_RECOGNIZED, this, null, new IntPoint(Std.int(stage.mouseX), Std.int(stage.mouseY))));
	}
	
	/**
	 * @private
	 * Fires ON_DRAG_ENTER event.(Note, this method is only for DragManager use)
	 */
	@:dox(hide) public function fireDragEnterEvent(dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint, relatedTarget:Component):Void{
		dispatchEvent(new DragAndDropEvent(DragAndDropEvent.DRAG_ENTER, dragInitiator, sourceData, mousePos, this, relatedTarget));
	}
	/**
	 * @private
	 * Fires DRAG_OVERRING event.(Note, this method is only for DragManager use)
	 */
	@:dox(hide) public function fireDragOverringEvent(dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):Void{
		dispatchEvent(new DragAndDropEvent(DragAndDropEvent.DRAG_OVERRING, dragInitiator, sourceData, mousePos, this));
	}
	/**
	 * @private
	 * Fires DRAG_EXIT event.(Note, this method is only for DragManager use)
	 */
	@:dox(hide) public function fireDragExitEvent(dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint, relatedTarget:Component):Void{
		dispatchEvent(new DragAndDropEvent(DragAndDropEvent.DRAG_EXIT, dragInitiator, sourceData, mousePos, this, relatedTarget));
	}
	/**
	 * @private
	 * Fires DRAG_DROP event.(Note, this method is only for DragManager use)
	 */
	@:dox(hide) public function fireDragDropEvent(dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint):Void{
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
            addEventListener(TouchEvent.TOUCH_ROLL_OUT, __rollOut);
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
//        trace(CallStack.toString(CallStack.callStack()));
//        trace(e.target);
//        trace(isFocusable());
//        trace(getInternalFocusObject());
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

	@:dox(hide) public var d_y (get, set):Float;
	@:dox(hide) public var d_x (get, set):Float;
	@:dox(hide) public var d_visible (get, set):Bool;

//	public var height (get, set):Float;
//	public var width (get, set):Float;
//	public var y (get, set):Float;
//	public var x (get, set):Float;
//	public var visible (get, set):Bool;

//	override public function toString():String {
//
//		return  Reflection.getClassName(this)+ "[asset:" +super.toString()  + "]";
//	}

    public var transitFocusFactor: Float = 0.0;
    private function doFocusTransition() {

        var targetFactor = if (isFocusOwner()) 1.0 else 0.0;

        if (transitFocusFactor != targetFactor) {
            Actuate.stop(this, "transitFocusFactor");
            Actuate.tween(this, 0.25, { transitFocusFactor: targetFactor })
            .ease(Linear.easeNone)
            .onUpdate(function() {
                repaint();
            })
            .onComplete(function() { transitFocusFactor = targetFactor; });
        }
    }


}
