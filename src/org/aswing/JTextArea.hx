/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

import flash.geom.Rectangle;
import flash.events.Event;
import flash.text.TextField;
import org.aswing.event.InteractiveEvent;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntPoint;
import org.aswing.geom.IntRectangle;
import org.aswing.plaf.basic.BasicTextAreaUI;

/**
 * A `JTextArea` is a multi-line area that displays text.
 *
 * With JScrollPane, it's easy to be a scrollable text area, for example:
 * <pre>
 * var ta:JTextArea = new JTextArea();
 * var sp:JScrollPane = new JScrollPane(ta);
 * </pre>
 * @author paling
 * @see org.aswing.JScrollPane
 */
@:event("org.aswing.event.InteractiveEvent.STATE_CHANGED", "Dispatched when the viewport's state changed")
class JTextArea extends JTextComponent  implements Viewportable{
	 	
 	/**
 	 * The default unit/block increment, it means auto count a value.
 	 */
 	inline public static var AUTO_INCREMENT:Int= AsWingConstants.MIN_VALUE;

    /**
	 * A default value for `this.maxChars` property.
	 *
	 * By default it is 0.
	 */
	private static var defaultMaxChars:Int= 0;


    /**
	 * A number of columns in this `JTextArea`, if it changed then call parent to do layout.
	 *
	 * If columns is set to zero or min than zero, the preferred width will be matched just to view all of the text.
	 */
    public var columns(get, set): Int;
    private var _columns:Int;
    private function get_columns(): Int { return Math.floor(getColumns()); }
    private function set_columns(columns: Int) { setColumns(columns); return columns; }

    /**
	 * A number of rows in this `JTextArea`, if it changed then call parent to do layout.
	 *
	 * If rows is set to zero or min than zero, the preferred height will be matched just to view all of the text.
	 */
    public var rows(get, set): Int;
    private var _rows:Int;
    private function get_rows(): Int { return Math.floor(getRows());  }
    private function set_rows(rows: Int) { setRows(rows); return rows; }

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

    private var viewportSizeTesting:Bool;
	private var lastMaxScrollV:Int;
	private var lastMaxScrollH:Int;

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
	 * Returns the unit value for the Horizontal scrolling.
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

	public function new(text:String="", rows:Int=0, columns:Int=0){
		super();
		setName("JTextField");
		getTextField().multiline = true;
		getTextField().text = text;
			#if (flash9)
		setMaxChars(defaultMaxChars);
		#end
		this._rows = rows;
		this._columns = columns;
		_viewPosition = new IntPoint();
		viewportSizeTesting = false;			
		lastMaxScrollV = getTextField().maxScrollV;
		lastMaxScrollH = getTextField().maxScrollH;
		
		_verticalUnitIncrement = AUTO_INCREMENT;
		_verticalBlockIncrement = AUTO_INCREMENT;
		_horizontalUnitIncrement = AUTO_INCREMENT;
		_horizontalBlockIncrement = AUTO_INCREMENT;
		
		getTextField().addEventListener(Event.CHANGE, __onTextAreaTextChange);
		getTextField().addEventListener(Event.SCROLL, __onTextAreaTextScroll);
		
		updateUI();
	}
	
	@:dox(hide)
    override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicTextAreaUI;
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "TextAreaUI";
	}
	
	/**
	 * Sets the maxChars property for default value when <code>JTextArea</code> be created.
	 * By default it is 0, you can change it by this method.
	 * @param n the default maxChars to set
	 */
    @:dox(hide)
	public static function setDefaultMaxChars(n:Int):Void{
		defaultMaxChars = n;
	}
	
	/**
	 * Returns the maxChars property for default value when <code>JTextArea</code> be created.
	 * @return the default maxChars value.
	 */
    @:dox(hide)
	public static function getDefaultMaxChars():Int{
		return defaultMaxChars;
	}	
	
	/**
	 * Sets the number of columns in this JTextArea, if it changed then call parent to do layout. 
	 * 
	 * @param columns the number of columns to use to calculate the preferred width;
	 * 			if columns is set to zero or min than zero, the preferred width will be matched just to view all of the text.
	 */
    @:dox(hide)
	public inline function setColumns(columns:Int):Void{
		if(columns < 0) columns = 0;
		if(this._columns != columns){
			this._columns = columns;
			if(isWordWrap()){
				//invalidateTextFieldAutoSizeToCountPrefferedSize();
			}
			revalidate();
		}
	}
	
	/**
	 * @see #setColumns
	 */
    @:dox(hide)
	public inline function getColumns():Int{
		return _columns;
	}
	
	/**
	 * Sets the number of rows in this JTextArea, if it changed then call parent to do layout. 
	 * 
	 * @param rows the number of rows to use to calculate the preferred height;
	 * 			if rows is set to zero or min than zero, the preferred height will be matched just to view all of the text.
	 */
    @:dox(hide)
	public inline function setRows(rows:Int):Void{
		if(rows < 0) rows = 0;
		if(this._rows != rows){
			this._rows = rows;
			if(isWordWrap()){
				//invalidateTextFieldAutoSizeToCountPrefferedSize();
			}
			revalidate();
		}
	}
	
	/**
	 * @see #setRows
	 */
    @:dox(hide)
	public inline function getRows():Int{
		return _rows;
	}

    @:dox(hide)
	override private function isAutoSize():Bool{
		return _columns == 0 || _rows == 0;
	}

    @:dox(hide)
	override private function countPreferredSize():IntDimension{
		var size:IntDimension;
		if(_columns > 0 && _rows > 0){
			var width:Int= getColumnWidth() * _columns + getWidthMargin();
			var height:Int= getRowHeight() * _rows + getHeightMargin();
			size = new IntDimension(width, height);
		}else if(_rows <=0 && _columns <=0 ){
			size = getTextFieldAutoSizedSize();
		}else if(_rows > 0){ // columns must <= 0
			var forceHeight:Int= getRowHeight() * _rows + getHeightMargin();
			size = getTextFieldAutoSizedSize(0, forceHeight);
		}else{ //must be columns > 0 and rows <= 0
			var forceWidth:Int= getColumnWidth() * _columns + getWidthMargin();
			size = getTextFieldAutoSizedSize(forceWidth, 0);
		}
		return getInsets().getOutsideSize(size);
	}	
	
	private function fireStateChanged(programmatic:Bool=true):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
	}

    @:dox(hide)
	override private function size():Void{
		super.size();
		applyBoundsToText(getPaintBounds());
	}

	
	private function __onTextAreaTextChange(e:Event):Void{
    	if(viewportSizeTesting)	{
    		return;
    	}
		//do not need call revalidate here in fact
		//because if the scroll changed with text change, the 
		//scroll event will be fired see below handler
	}
	
	private function __onTextAreaTextScroll(e:Event):Void{
    	if(viewportSizeTesting)	{
    		return;
    	}
    	var t:TextField = getTextField();
    	if(focusScrolling)	{//avoid scroll change when make focus
    		var vp:IntPoint = getViewPosition();
    		t.scrollH = vp.x;
    		t.scrollV = vp.y + 1;
    		return;
    	}
		var newViewPos:IntPoint = new IntPoint(t.scrollH, t.scrollV-1);
		if(!getViewPosition().equals(newViewPos)){
			_viewPosition.setLocation(newViewPos);
			//notify scroll bar to syn
			fireStateChanged(true);
		}
		if(lastMaxScrollV != t.maxScrollV || lastMaxScrollH != t.maxScrollH){
			lastMaxScrollV = t.maxScrollV;
			lastMaxScrollH = t.maxScrollH;
			revalidate();
		}
	}
	
	private var focusScrolling:Bool;
    @:dox(hide)
	override public function makeFocus():Void{
		if(getFocusTransmit() == null){
			focusScrolling = true;
			super.makeFocus();
			focusScrolling = false;
		}
	}
	
	//------------------------------------------------------------
	//                    Viewportable Imp
	//------------------------------------------------------------
	
	/**
	 * Add a listener to listen the viewpoat state change event.
	 * <p>
	 * When the viewpoat's state changed, the state is all about:
	 * <ul>
	 * <li>viewPosition</li>
	 * <li>verticalUnitIncrement</li>
	 * <li>verticalBlockIncrement</li>
	 * <li>horizontalUnitIncrement</li>
	 * <li>horizontalBlockIncrement</li>
	 * </ul>
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
	 * @see org.aswing.event.AWEvent#STATE_CHANGED
	 */	
	public function removeStateListener(listener:Dynamic -> Void):Void{
		removeEventListener(InteractiveEvent.STATE_CHANGED, listener);
	}
	
	/**
	 * Returns the unit value for the Vertical scrolling.
	 */
    @:dox(hide)
    public function getVerticalUnitIncrement():Int{
    	if(_verticalUnitIncrement == AUTO_INCREMENT){
    		return 1;
    	}else{
    		return _verticalUnitIncrement;
    	}
    }
    
    /**
     * Return the block value for the Vertical scrolling.
     */
    @:dox(hide)
    public function getVerticalBlockIncrement():Int{
    	if(_verticalBlockIncrement == AUTO_INCREMENT){
    		return 10;
    	}else{
    		return _verticalBlockIncrement;
    	}
    }
    
	/**
	 * Returns the unit value for the Horizontal scrolling.
	 */
    @:dox(hide)
    public function getHorizontalUnitIncrement():Int{
    	if(_horizontalUnitIncrement == AUTO_INCREMENT){
    		return getColumnWidth();
    	}else{
    		return _horizontalUnitIncrement;
    	}
    }
    
    /**
     * Return the block value for the Horizontal scrolling.
     */
    @:dox(hide)
    public function getHorizontalBlockIncrement():Int{
    	if(_horizontalBlockIncrement == AUTO_INCREMENT){
    		return getColumnWidth()*10;
    	}else{
    		return _horizontalBlockIncrement;
    	}
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
	* @see Viewportable.scrollRectToVisible
    **/
    public function scrollRectToVisible(contentRect:IntRectangle, programmatic:Bool=true):Void{
		setViewPosition(new IntPoint(contentRect.x, contentRect.y), programmatic);
	}

    /**
	* @see Viewportable.setViewPosition
    **/
    public function setViewPosition(p:IntPoint, programmatic:Bool=true):Void{
		if(!_viewPosition.equals(p)){
			restrictionViewPos(p);
			if(_viewPosition.equals(p)){
				return;
			}
			_viewPosition.setLocation(p);
			validateScroll();
			fireStateChanged(programmatic);
		}
	}

    /**
	* @see Viewportable.setViewportTestSize
    **/
	public function setViewportTestSize(s:IntDimension):Void{
    	viewportSizeTesting = true;
    	setSize(s);
    	validateScroll();
    	viewportSizeTesting = false;
	}

    /**
	* @see Viewportable.getViewSize
    **/
	public function getViewSize():IntDimension{
    	var t:TextField = getTextField();
    	var wRange:Int, hRange:Int;
    	if(isWordWrap()){
    		wRange = Std.int(t.textWidth);
    		t.scrollH = 0;
    	}else{
	    	if(t.maxScrollH > 0){
    			wRange = Std.int(t.textWidth + t.maxScrollH);
	    	}else{
    			wRange = Std.int(t.textWidth);
    			t.scrollH = 0;
	    	}
    	}
		var extent:Int= t.bottomScrollV - t.scrollV + 1;
		var maxValue:Int= t.maxScrollV + extent;
		var minValue:Int= 1;
    	hRange = maxValue - minValue;
    	return new IntDimension(wRange, hRange);
	}

    /**
	* @see Viewportable.getExtentSize
    **/
	public function getExtentSize():IntDimension{
    	var t:TextField = getTextField();
		var extentVer:Int= t.bottomScrollV - t.scrollV + 1;
		var extentHor:Int= Std.int(t.textWidth);
    	return new IntDimension(extentHor, extentVer);
	}

    /**
	* @see Viewportable.getViewportPane
    **/
	public function getViewportPane():Component{
		return this;
	}

    @:dox(hide)
	public function getViewPosition():IntPoint{
		return _viewPosition.clone();
	}
	
	/**
	 * Scroll the text with viewPosition
	 */
    private function validateScroll():Void{
		var xS:Int= _viewPosition.x;
		var yS:Int= _viewPosition.y + 1;
    	var t:TextField = getTextField();
		if(t.scrollH != xS){
			t.scrollH = xS;
		}
		if(t.scrollV != yS){
			t.scrollV = yS;
		}
		//t.background = false; //avoid TextField background lose effect bug
    }
	
	private function restrictionViewPos(p:IntPoint):IntPoint{
		var maxPos:IntPoint = getViewMaxPos();
		p.x = Std.int(Math.max(0, Math.min(maxPos.x, p.x)));
		p.y = Std.int(Math.max(0, Math.min(maxPos.y, p.y)));
		return p;
	}
	
	private function getViewMaxPos():IntPoint{
		var showSize:IntDimension = getExtentSize();
		var viewSize:IntDimension = getViewSize();
		var p:IntPoint = new IntPoint(viewSize.width-showSize.width, viewSize.height-showSize.height);
		if(p.x < 0) p.x = 0;
		if(p.y < 0) p.y = 0;
		return p;
	}
}