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
 * Dispatched when the viewport's state changed. the state is all about:
 * <ul>
 * <li>view position</li>
 * <li>verticalUnitIncrement</li>
 * <li>verticalBlockIncrement</li>
 * <li>horizontalUnitIncrement</li>
 * <li>horizontalBlockIncrement</li>
 * </ul>
 * </p>
 * 
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * A JTextArea is a multi-line area that displays text.
 * <p>
 * With JScrollPane, it's easy to be a scrollable text area, for example:
 * <pre>
 * var ta:JTextArea = new JTextArea();
 * 
 * var sp:JScrollPane = new JScrollPane(ta); 
 * //or 
 * //var sp:JScrollPane = new JScrollPane(); 
 * //sp.setView(ta);
 * </pre>
 * @author paling
 * @see org.aswing.JScrollPane
 */
class JTextArea extends JTextComponent  implements Viewportable{
	 	
 	/**
 	 * The default unit/block increment, it means auto count a value.
 	 */
 	inline public static var AUTO_INCREMENT:Int= AsWingConstants.MIN_VALUE;
 	
	private static var defaultMaxChars:Int= 0;
 	
	private var _columns:Int;
	private var _rows:Int;

	public var columns(get, set): Int;
	public var rows(get, set): Int;

	private var viewPos:IntPoint;
	private var viewportSizeTesting:Bool;
	private var lastMaxScrollV:Int;
	private var lastMaxScrollH:Int;
		
	private var verticalUnitIncrement:Int;
	private var verticalBlockIncrement:Int;
	private var horizontalUnitIncrement:Int;
	private var horizontalBlockIncrement:Int;
	
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
		viewPos = new IntPoint();
		viewportSizeTesting = false;			
		lastMaxScrollV = getTextField().maxScrollV;
		lastMaxScrollH = getTextField().maxScrollH;
		
		verticalUnitIncrement = AUTO_INCREMENT;
		verticalBlockIncrement = AUTO_INCREMENT;
		horizontalUnitIncrement = AUTO_INCREMENT;
		horizontalBlockIncrement = AUTO_INCREMENT;
		
		getTextField().addEventListener(Event.CHANGE, __onTextAreaTextChange);
		getTextField().addEventListener(Event.SCROLL, __onTextAreaTextScroll);
		
		updateUI();
	}
	
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicTextAreaUI;
    }
	
	override public function getUIClassID():String{
		return "TextAreaUI";
	}
	
	/**
	 * Sets the maxChars property for default value when <code>JTextArea</code> be created.
	 * By default it is 0, you can change it by this method.
	 * @param n the default maxChars to set
	 */
	public static function setDefaultMaxChars(n:Int):Void{
		defaultMaxChars = n;
	}
	
	/**
	 * Returns the maxChars property for default value when <code>JTextArea</code> be created.
	 * @return the default maxChars value.
	 */
	public static function getDefaultMaxChars():Int{
		return defaultMaxChars;
	}	
	
	/**
	 * Sets the number of columns in this JTextArea, if it changed then call parent to do layout. 
	 * 
	 * @param columns the number of columns to use to calculate the preferred width;
	 * 			if columns is set to zero or min than zero, the preferred width will be matched just to view all of the text.
	 */
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
	public inline function getColumns():Int{
		return _columns;
	}
	
	/**
	 * Sets the number of rows in this JTextArea, if it changed then call parent to do layout. 
	 * 
	 * @param rows the number of rows to use to calculate the preferred height;
	 * 			if rows is set to zero or min than zero, the preferred height will be matched just to view all of the text.
	 */
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
	public inline function getRows():Int{
		return _rows;
	}
	
	override private function isAutoSize():Bool{
		return _columns == 0 || _rows == 0;
	}
	
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
			viewPos.setLocation(newViewPos);
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
    public function getVerticalUnitIncrement():Int{
    	if(verticalUnitIncrement == AUTO_INCREMENT){
    		return 1;
    	}else{
    		return verticalUnitIncrement;
    	}
    }
    
    /**
     * Return the block value for the Vertical scrolling.
     */
    public function getVerticalBlockIncrement():Int{
    	if(verticalBlockIncrement == AUTO_INCREMENT){
    		return 10;
    	}else{
    		return verticalBlockIncrement;
    	}
    }
    
	/**
	 * Returns the unit value for the Horizontal scrolling.
	 */
    public function getHorizontalUnitIncrement():Int{
    	if(horizontalUnitIncrement == AUTO_INCREMENT){
    		return getColumnWidth();
    	}else{
    		return horizontalUnitIncrement;
    	}
    }
    
    /**
     * Return the block value for the Horizontal scrolling.
     */
    public function getHorizontalBlockIncrement():Int{
    	if(horizontalBlockIncrement == AUTO_INCREMENT){
    		return getColumnWidth()*10;
    	}else{
    		return horizontalBlockIncrement;
    	}
    }
    
	/**
	 * Sets the unit value for the Vertical scrolling.
	 */
    public function setVerticalUnitIncrement(increment:Int):Void{
    	if(verticalUnitIncrement != increment){
    		verticalUnitIncrement = increment;
			fireStateChanged();
    	}
    }
    
    /**
     * Sets the block value for the Vertical scrolling.
     */
    public function setVerticalBlockIncrement(increment:Int):Void{
    	if(verticalBlockIncrement != increment){
    		verticalBlockIncrement = increment;
			fireStateChanged();
    	}
    }
    
	/**
	 * Sets the unit value for the Horizontal scrolling.
	 */
    public function setHorizontalUnitIncrement(increment:Int):Void{
    	if(horizontalUnitIncrement != increment){
    		horizontalUnitIncrement = increment;
			fireStateChanged();
    	}
    }
    
    /**
     * Sets the block value for the Horizontal scrolling.
     */
    public function setHorizontalBlockIncrement(increment:Int):Void{
    	if(horizontalBlockIncrement != increment){
    		horizontalBlockIncrement = increment;
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
	
	public function scrollRectToVisible(contentRect:IntRectangle, programmatic:Bool=true):Void{
		setViewPosition(new IntPoint(contentRect.x, contentRect.y), programmatic);
	}
	
	public function setViewPosition(p:IntPoint, programmatic:Bool=true):Void{
		if(!viewPos.equals(p)){
			restrictionViewPos(p);
			if(viewPos.equals(p)){
				return;
			}
			viewPos.setLocation(p);
			validateScroll();
			fireStateChanged(programmatic);
		}
	}
 
	public function setViewportTestSize(s:IntDimension):Void{
    	viewportSizeTesting = true;
    	setSize(s);
    	validateScroll();
    	viewportSizeTesting = false;
	}
	
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
	
	public function getExtentSize():IntDimension{
    	var t:TextField = getTextField();
		var extentVer:Int= t.bottomScrollV - t.scrollV + 1;
		var extentHor:Int= Std.int(t.textWidth);
    	return new IntDimension(extentHor, extentVer);
	}
	
	public function getViewportPane():Component{
		return this;
	}
	
	public function getViewPosition():IntPoint{
		return viewPos.clone();
	}
	
	/**
	 * Scroll the text with viewpos
	 */
    private function validateScroll():Void{
		var xS:Int= viewPos.x;
		var yS:Int= viewPos.y + 1;
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

	private function get_columns(): Int {
		return Math.floor(getColumns());
	}

	private function set_columns(columns: Int) {
		setColumns(columns);
		return columns;
	}

	private function get_rows(): Int {
		return Math.floor(getRows());
	}

	private function set_rows(rows: Int) {
		setRows(rows);
		return rows;
	}
}