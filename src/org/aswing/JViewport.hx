/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

import flash.events.Event;
import jive.events.TransformGestureEvent;
import jive.events.GestureManager;
import flash.geom.Rectangle;
import org.aswing.error.Error;
import org.aswing.event.InteractiveEvent;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntPoint;
import org.aswing.geom.IntRectangle;
import org.aswing.plaf.basic.BasicViewportUI;

/**
 * JViewport is an basic viewport to view normal components. Generally JViewport works 
 * with JScrollPane together, for example:<br>
 *
 * <pre>
 *     var scrollPane:JScrollPane = new JScrollPane();
 *     var viewport:JViewport = new JViewport(yourScrollContentComponent, true, false);
 *     scrollPane.setViewport(viewport);
 * </pre>
 *
 * Then you'll get a scrollpane with scroll content and only vertical scrollbar. And 
 * the scroll content will always tracks the scroll pane width.
 *
 * Authors: paling, ngrebenshikov
 */
@:event("org.aswing.event.InteractiveEvent.STATE_CHANGED", "Dispatched when the viewport's state changed")
class JViewport extends Container  implements Viewportable {
 	
 	/**
 	 * The default unit/block increment, it means auto count a value.
 	 */
 	inline public static var AUTO_INCREMENT:Int= AsWingConstants.MIN_VALUE;
 	
	/**
	 * A fast access to `AsWingConstants` Constant
	 */
	inline public static var CENTER:Int= AsWingConstants.CENTER;

	/**
	 * A fast access to `AsWingConstants` Constant
	 */
	inline public static var TOP:Int= AsWingConstants.TOP;

	/**
	 * A fast access to `AsWingConstants` Constant
	 */
    inline public static var LEFT:Int= AsWingConstants.LEFT;

	/**
	 * A fast access to `AsWingConstants Constant
	 */
    inline public static var BOTTOM:Int= AsWingConstants.BOTTOM;

 	/**
	 * A fast access to `AsWingConstants` Constant
	 */
    inline public static var RIGHT:Int= AsWingConstants.RIGHT;

	/**
	 * The unit value for the Vertical scrolling.
	 */
	public var verticalUnitIncrement(get, set):Int;
	private var _verticalUnitIncrement:Int;
	private function get_verticalUnitIncrement():Int { return getVerticalUnitIncrement(); }
	private function set_verticalUnitIncrement(v:Int):Int { setVerticalUnitIncrement(v); return v; }

	/**
     * The block value for the Vertical scrolling.
     */
	public var verticalBlockIncrement(get, set): Int;
	private var _verticalBlockIncrement: Int;
	private function get_verticalBlockIncrement(): Int { return getVerticalBlockIncrement(); }
	private function set_verticalBlockIncrement(v: Int): Int { setVerticalBlockIncrement(v); return v; }

	/**
	 * The unit value for the Horizontal scrolling.
	 */
	public var horizontalUnitIncrement(get, set): Int;
	private var _horizontalUnitIncrement:Int;
	private function get_horizontalUnitIncrement(): Int { return getHorizontalUnitIncrement(); }
	private function set_horizontalUnitIncrement(v: Int): Int { setHorizontalUnitIncrement(v); return v; }

	/**
     * The block value for the Horizontal scrolling.
     */
	public var horizontalBlockIncrement(get, set): Int;
	private var _horizontalBlockIncrement: Int;
	private function get_horizontalBlockIncrement(): Int { return getHorizontalBlockIncrement(); }
	private function set_horizontalBlockIncrement(v: Int): Int { setHorizontalBlockIncrement(v); return v; }

	/**
	 * If true, the view will always be set to the same height as the viewport.<br>
	 * If false, the view will be set to it's preffered height.
	 */
	public var fitViewHeight(get, set):Bool;
	private var _fitViewHeight:Bool;
	private function get_fitViewHeight(): Bool { return isTracksHeight(); }
	private function set_fitViewHeight(v:Bool): Bool { setTracksHeight(v); return v; }

	/**
	 * If true, the view will always be set to the same width as the viewport.<br>
	 * If false, the view will be set to it's preffered width.
	 */
	public var fitViewWidth(get, set):Bool;
	private var _fitViewWidth:Bool;
	private function get_fitViewWidth(): Bool { return isTracksWidth(); }
	private function set_fitViewWidth(v:Bool): Bool { setTracksWidth(v); return v; }

	/**
     * The vertical alignment of the view if the view is lower than extent height.
     *
     * One of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
	public var verticalAlignment(get, set):Int;
	private var _verticalAlignment:Int;
	private function get_verticalAlignment():Int { return getVerticalAlignment(); }
	private function set_verticalAlignment(v:Int):Int { setVerticalAlignment(v); return v; }

	/**
     * The horizontal alignment of the view if the view is narrower than extent width.
     * One of the following values:
     * <ul>
     * <li>`AsWingConstants.RIGHT` (the default)
     * <li>`AsWingConstants.LEFT`
     * <li>`AsWingConstants.CENTER`
     * </ul>
     */
	public var horizontalAlignment(get, set):Int;
	private var _horizontalAlignment: Int;
	private function get_horizontalAlignment():Int { return getHorizontalAlignment(); }
	private function set_horizontalAlignment(v:Int):Int { setHorizontalAlignment(v); return v; }
	/**
	 * The view is the visible content of the `JViewport`.
	 *
	 * `JViewport` use to manage the scroll view of a component.
	 * The component will be set size to its preferred size, then scroll in the viewport.
	 */
	public var view(get, set):Component;
	private var _view:Component;
	private function get_view(): Component { return getView(); }
	private function set_view(v:Component): Component { setView(v); return v; }


	/**
	 * The view's position.
	 *
	 * It returns (0,0) if view is null.
	 *
	 * @see setViewPosition to set view position loudly (to trigger events).
	 * @see Viewportable.setViewPosition
	 */
	public var viewPosition(get, set): IntPoint;
	private var _viewPosition: IntPoint;
	private function get_viewPosition(): IntPoint { return getViewPosition(); }
	private function set_viewPosition(v: IntPoint): IntPoint { setViewPosition(v); return v; }

	/**
	 * Create a viewport with view and size tracks properties.
	 *
	 * See `JViewport.view`,`JViewport.firViewWidth`, `JViewport.fitViewHeight`
	 */
	public function new(view:Component=null, fitViewWidth:Bool=false, fitViewHeight:Bool=false){
		super();
		setName("JViewport");
		this._fitViewWidth = fitViewWidth;
		this._fitViewHeight = fitViewHeight;
		_verticalUnitIncrement = AUTO_INCREMENT;
		_verticalBlockIncrement = AUTO_INCREMENT;
		_horizontalUnitIncrement = AUTO_INCREMENT;
		_horizontalBlockIncrement = AUTO_INCREMENT;
		
    	verticalAlignment = CENTER;
    	_horizontalAlignment = CENTER;
    	
		if(view != null) setView(view);
		setLayout(new ViewportLayout());
		updateUI();

        gestureManager = new GestureManager(this, 0);
        addEventListener(TransformGestureEvent.GESTURE_PAN, onPan);
	}

	public function stopActuating() {
		gestureManager.stopActuating();
	}

	@:dox(hide)
	override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }

	@:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicViewportUI;
    }

	@:dox(hide)
	override public function getUIClassID():String{
		return "ViewportUI";
	}	

	/**
	 * @throws Error if the layout is not a ViewportLayout
	 */
	@:dox(hide)
	override public function setLayout(layout:LayoutManager):Void{
		if(Std.is(layout,ViewportLayout)){
			super.setLayout(layout);
		}else{
			throw new Error("Only on set ViewportLayout to JViewport");  
		}
	}
	
	/**
	 * Sets whether the view tracks viewport width. Default is false<br>
	 * If true, the view will always be set to the same size as the viewport.<br>
	 * If false, the view will be set to it's preffered size.
	 * @param b tracks width
	 */
	@:dox(hide)
	public function setTracksWidth(b:Bool):Void{
		if(b != _fitViewWidth){
			_fitViewWidth = b;
			revalidate();
		}
	}
	
	/**
	 * Returns whether the view tracks viewport width. Default is false<br>
	 * If true, the view will always be set to the same width as the viewport.<br>
	 * If false, the view will be set to it's preffered width.
	 * @return whether tracks width
	 */
	@:dox(hide)
	public function isTracksWidth():Bool{
		return _fitViewWidth;
	}
	
	/**
	 * Sets whether the view tracks viewport height. Default is false<br>
	 * If true, the view will always be set to the same height as the viewport.<br>
	 * If false, the view will be set to it's preffered height.
	 * @param b tracks height
	 */
	@:dox(hide)
	public function setTracksHeight(b:Bool):Void{
		if(_fitViewHeight != b){
			_fitViewHeight = b;
			revalidate();
		}
	}
	
	/**
	 * Returns whether the view tracks viewport height. Default is false<br>
	 * If true, the view will always be set to the same height as the viewport.<br>
	 * If false, the view will be set to it's preffered height.
	 * @return whether tracks height
	 */
	@:dox(hide)
	public function isTracksHeight():Bool{
		return _fitViewHeight;
	}

    /**
     * Returns the vertical alignment of the view if the view is lower than extent height.
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
     * Sets the vertical alignment of the view if the view is lower than extent height.
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
        	setViewPosition(getViewPosition());//make it to be restricted
        }
    }
    
    /**
     * Returns the horizontal alignment of the view if the view is narrower than extent width.
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
     * Sets the horizontal alignment of the view if the view is narrower than extent width.
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
        	setViewPosition(getViewPosition());//make it to be restricted
        }
    }
		
	/**
	 * Sets the view component.
	 * 
	 * <p>The view is the visible content of the JViewPort.</p>
	 * 
	 * <p>JViewport use to manage the scroll view of a component.
	 * the component will be set size to its preferred size, then scroll in the viewport.<br>
	 * </p>
	 * <p>If the component's isTracksViewportWidth method is defined and return true,
	 * when the viewport's show size is larger than the component's,
	 * the component will be widen to the show size, otherwise, not widen.
	 * Same as isTracksViewportHeight method.
	 * </p>
	 */
	@:dox(hide)
	public function setView(view:Component):Void{
		if(this._view != view){
			this._view = view;
			removeAll();
			
			if(view != null){
				insertImp(-1, _view);
			}
			fireStateChanged();
		}
	}

	@:dox(hide)
	public function getView():Component{
		return _view;
	}
		
	/**
	 * Sets the unit value for the Vertical scrolling.
	 */
	@:dox(hide)
    public function setVerticalUnitIncrement(increment:Int):Void{
    	if(_verticalUnitIncrement != increment){
    		_verticalUnitIncrement = increment;
			fireStateChanged();
    	}
    }
    
    /**
     * Sets the block value for the Vertical scrolling.
     */
	@:dox(hide)
    public function setVerticalBlockIncrement(increment:Int):Void{
    	if(_verticalBlockIncrement != increment){
    		_verticalBlockIncrement = increment;
			fireStateChanged();
    	}
    }
    
	/**
	 * Sets the unit value for the Horizontal scrolling.
	 */
	@:dox(hide)
    public function setHorizontalUnitIncrement(increment:Int):Void{
    	if(_horizontalUnitIncrement != increment){
    		_horizontalUnitIncrement = increment;
			fireStateChanged();
    	}
    }
    
    /**
     * Sets the block value for the Horizontal scrolling.
     */
	@:dox(hide)
    public function setHorizontalBlockIncrement(increment:Int):Void{
    	if(_horizontalBlockIncrement != increment){
    		_horizontalBlockIncrement = increment;
			fireStateChanged();
    	}
    }		
			
	
	/**
	 * In fact just call setView(com) in this method
	 * @see #setView()
	 */
	@:dox(hide)
	override public function append(com:Component, constraints:Dynamic=null):Void{
		setView(com);
	}
	
	/**
	 * In fact just call setView(com) in this method
	 * @see #setView()
	 */
	@:dox(hide)
	override public function insert(i:Int, com:Component, constraints:Dynamic=null):Void{
		setView(com);
	}
	
	//--------------------implementatcion of Viewportable---------------

	/**
	 * Returns the unit value for the Vertical scrolling.
	 */
	@:dox(hide)
    public function getVerticalUnitIncrement():Int{
    	if(_verticalUnitIncrement != AUTO_INCREMENT){
    		return _verticalUnitIncrement;
    	}else{
    		return Std.int( Math.max(getExtentSize().height/40, 1));
    	}
    }
    
    /**
     * Return the block value for the Vertical scrolling.
     */
	@:dox(hide)
    public function getVerticalBlockIncrement():Int{
    	if(_verticalBlockIncrement != AUTO_INCREMENT){
    		return _verticalBlockIncrement;
    	}else{
    		return getExtentSize().height-1;
    	}
    }
    
	/**
	 * Returns the unit value for the Horizontal scrolling.
	 */
	@:dox(hide)
    public function getHorizontalUnitIncrement():Int{
    	if(_horizontalUnitIncrement != AUTO_INCREMENT){
    		return _horizontalUnitIncrement;
    	}else{
    		return Std.int(Math.max(getExtentSize().width/40, 1));
    	}
    }
    
    /**
     * Return the block value for the Horizontal scrolling.
     */
	@:dox(hide)
    public function getHorizontalBlockIncrement():Int{
    	if(_horizontalBlockIncrement != AUTO_INCREMENT){
    		return _horizontalBlockIncrement;
    	}else{
    		return getExtentSize().width - 1;
    	}
    }
  
	@:dox(hide)
    public function setViewportTestSize(s:IntDimension):Void{
    	setSize(s); 
    }
	 
	public function getExtentSize() : IntDimension {
		return getInsets().getInsideSize(getSize());
	}
	
	/**
     * Usually the view's preffered size.
     * @return the view's size, (0, 0) if view is null.
	 */
	public function getViewSize() : IntDimension {
		if(_view == null){
			return new IntDimension();
		}else{
			if(isTracksWidth() && isTracksHeight()){
				return getExtentSize();
			}else{
				var viewSize:IntDimension = _view.getPreferredSize();
				var extentSize:IntDimension = getExtentSize();
				if(isTracksWidth()){
					viewSize.width = extentSize.width;
				}else if(isTracksHeight()){
					viewSize.height = extentSize.height;
				}
				return viewSize;
			}
		}
	}
	
	/**
	 * @return the view's position, (0,0) if view is null.
	 */
	@:dox(hide)
	public function getViewPosition() : IntPoint {
		if(_view != null){
			var p:IntPoint = _view.getLocation();
			var ir:IntRectangle = getInsets().getInsideBounds(getSize().getBounds());
			p.x = ir.x - p.x;
			p.y = ir.y - p.y;
			return p;
		}else{
			return new IntPoint(0, 0);
		}
	}

	/**
	 * @return the view's visible rectangle.
	 */
	public function getVisibleRect():IntRectangle {
		var p:IntPoint = getViewPosition();
		var s:IntDimension = getExtentSize();
		return new IntRectangle(p.x, p.y, s.width, s.height);
	}

	public function setViewPosition(p : IntPoint, programmatic:Bool=true) : Void{
		restrictionViewPos(p);
		if(!p.equals(getViewPosition())){
			var ir:IntRectangle = getInsets().getInsideBounds(getSize().getBounds());
			if(_view!=null)	{
				_view.setLocationXY(ir.x-p.x, ir.y-p.y);
			}
			fireStateChanged(programmatic);
		}
	}

	public function scrollRectToVisible(contentRect:IntRectangle, programmatic:Bool=true):Void{
		setViewPosition(new IntPoint(contentRect.x, contentRect.y), programmatic);
	}
	
	/**
	 * Make a scroll or not to ensure specified rect will be visible.
	 * @param contentRect the rect to be ensure visible
	 * @param programmatic whether or not a programmatic call
	 */
	public function ensureRectVisible(contentRect:IntRectangle, programmatic:Bool=true):Void{
		contentRect = contentRect.clone();
		var vp:IntPoint = getViewPosition();
		var es:IntDimension = getExtentSize();
		var vs:IntDimension = getViewSize();
		var range:IntRectangle = new IntRectangle(vp.x, vp.y, es.width, es.height);
		if(contentRect.x < 0){
			contentRect.width += contentRect.x;
			contentRect.x = 0;
		}
		if(contentRect.y < 0){
			contentRect.height += contentRect.y;
			contentRect.y = 0;
		}
		if(contentRect.x + contentRect.width > vs.width){
			contentRect.width = vs.width - contentRect.x;
		}
		if(contentRect.y + contentRect.height > vs.height){
			contentRect.height = vs.height - contentRect.y;
		}
		var newVP:IntPoint = vp.clone();
		if(contentRect.x + contentRect.width > range.x + range.width){
			newVP.x = contentRect.x + contentRect.width - es.width;
		}
		if(contentRect.y + contentRect.height > range.y + range.height){
			newVP.y = contentRect.y + contentRect.height - es.height;
		}
		if(contentRect.x < range.x){
			newVP.x = contentRect.x;
		}
		if(contentRect.y < range.y){
			newVP.y = contentRect.y;
		}
		setViewPosition(newVP, programmatic);
	}
	
	/**
	 * Scrolls view vertical with delta pixels.
	 */
	public function scrollVertical(delta:Int):Void{
		setViewPosition(getViewPosition().move(0, delta));
	}
	
	/**
	 * Scrolls view horizontal with delta pixels.
	 */
	public function scrollHorizontal(delta:Int):Void{
		setViewPosition(getViewPosition().move(delta, 0));
	}
	
	/**
	 * Scrolls to view bottom left content. 
	 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
	 * if it is located in a <code>JScrollPane</code>.
	 */
	public function scrollToBottomLeft():Void{
		setViewPosition(new IntPoint(0, AsWingConstants.MAX_VALUE));
	}
	/**
	 * Scrolls to view bottom right content. 
	 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
	 * if it is located in a <code>JScrollPane</code>.
	 */	
	public function scrollToBottomRight():Void{
		setViewPosition(new IntPoint(AsWingConstants.MAX_VALUE, AsWingConstants.MAX_VALUE));
	}
	/**
	 * Scrolls to view top left content. 
	 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
	 * if it is located in a <code>JScrollPane</code>.
	 */	
	public function scrollToTopLeft():Void{
		setViewPosition(new IntPoint(0, 0));
	}
	/**
	 * Scrolls to view to right content. 
	 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
	 * if it is located in a <code>JScrollPane</code>.
	 */	
	public function scrollToTopRight():Void{
		setViewPosition(new IntPoint(AsWingConstants.MAX_VALUE, 0));
	}
	
	/**
	 * Restrict the view pos in valid range based on the align.
	 */	
	private function restrictionViewPos(p:IntPoint):IntPoint{
		var showSize:IntDimension = getExtentSize();
		var viewSize:IntDimension = getViewSize();
		if(showSize.width < viewSize.width){
			p.x =Std.int( Math.max(0, Math.min(viewSize.width-showSize.width, p.x)));
		}else if(showSize.width > viewSize.width){
			if(_horizontalAlignment == CENTER){
				p.x = -Std.int((showSize.width - viewSize.width)/2);
			}else if(_horizontalAlignment == RIGHT){
				p.x = -(showSize.width - viewSize.width);
			}else{
				p.x = 0;
			}
		}else{//equals
			p.x = 0;
		}
		
		if(showSize.height < viewSize.height){
			p.y = Std.int(Math.max(0, Math.min(viewSize.height-showSize.height, p.y)));
		}else if(showSize.height > viewSize.height){
			if(verticalAlignment == CENTER){
				p.y = -Std.int((showSize.height - viewSize.height)/2);
			}else if(verticalAlignment == BOTTOM){
				p.y = -(showSize.height - viewSize.height);
			}else{
				p.y = 0;
			}
		}else{//equals
			p.y = 0;
		}
		return p;
	}
    	
	/**
	 * Add a listener to listen the viewpoat state change event.
	 *
	 * When the viewpoat's state changed, the state is all about:
	 * <ul>
	 * <li>`viewPosition`</li>
	 * <li>`verticalUnitIncrement`</li>
	 * <li>`verticalBlockIncrement`</li>
	 * <li>`horizontalUnitIncrement`</li>
	 * <li>`horizontalBlockIncrement`</li>
	 * </ul>
	 *
	 * @see org.aswing.event.InteractiveEvent.STATE_CHANGED
	 *
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 */
	public function addStateListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(InteractiveEvent.STATE_CHANGED, listener, false, priority);
	}	
	
	/**
	 * Removes a state listener.
	 *
	 * @see org.aswing.event.InteractiveEvent.STATE_CHANGED
	 *
	 * @param listener the listener to be removed.
	 */
	public function removeStateListener(listener:Dynamic -> Void):Void{
		removeEventListener(InteractiveEvent.STATE_CHANGED, listener);
	}
	
	private function fireStateChanged(programmatic:Bool=true):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
	}
	
	public function getViewportPane() : Component {
		return this;
	}


    public var magneticBorderSize(get, set): Int;
    private function get_magneticBorderSize(): Int { return gestureManager.magneticBorderSize; }
    private function set_magneticBorderSize(v: Int): Int {
        gestureManager.magneticBorderSize = v;
        return v;
    }


    private var gestureManager: GestureManager;
    public static var SCROLLED = "SCROLLED";

    private function onPan(e: TransformGestureEvent) {
        if (e.phase == "COMPLETED") {
            dispatchEvent(new Event(SCROLLED));
            return;
        }
        var pos = getViewPosition();
        pos.y -= Std.int(e.offsetY);
        pos.x -= Std.int(e.offsetX);
        setViewPosition(pos);
    }
}