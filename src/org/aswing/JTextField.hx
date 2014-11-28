/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.geom.IntDimension;
	import org.aswing.event.FocusKeyEvent;
import org.aswing.AWKeyboard;
import org.aswing.event.AWEvent;
import org.aswing.plaf.basic.BasicTextFieldUI;

/**
 * Dispatched when the user input ENTER in the textfield.
 * @eventType org.aswing.event.AWEvent.ACT
 * @see org.aswing.JTextField#addActionListener()
 */
// [Event(name="act", type="org.aswing.event.AWEvent")]

/**
 * JTextField is a component that allows the editing of a single line of text. 
 * @author Tomato, paling
 */
class JTextField extends JTextComponent{
	
	private static var defaultMaxChars:Int= 0;
	
	private var _columns:Int;
	@bindable public var columns(get, set): Int;
	
	public function new(text:String="", columns:Int=0){
		super(); 
		setName("JTextField");
		getTextField().multiline = false;
		getTextField().text = text;
		#if (flash9)
		setMaxChars(defaultMaxChars);
		#end
		this._columns = columns;
		//addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onFocusKeyDown);
		updateUI();
	}
	
	override public function updateUI():Void {
 
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicTextFieldUI;
    }
	
	override public function getUIClassID():String{
		return "TextFieldUI";
	}
	
	/**
	 * Sets the maxChars property for default value when <code>JTextFeild</code> be created.
	 * By default it is 0, you can change it by this method.
	 * @param n the default maxChars to set
	 */
	public static function setDefaultMaxChars(n:Int):Void{
		defaultMaxChars = n;
	}
	
	/**
	 * Returns the maxChars property for default value when <code>JTextFeild</code> be created.
	 * @return the default maxChars value.
	 */
	public static function getDefaultMaxChars():Int{
		return defaultMaxChars;
	}	
	
	/**
	 * Sets the number of columns in this JTextField, if it changed then call parent to do layout. 
	 * @param columns the number of columns to use to calculate the preferred width;
	 * if columns is set to zero or min than zero, the preferred width will be matched just to view all of the text.
	 * default value is zero if missed this param.
	 */
	public inline function setColumns(columns:Int=0):Void{
		if(columns < 0) columns = 0;
		if(this._columns != columns){
			this._columns = columns;
			revalidate();
		}
	}
	
	/**
	 * @see #setColumns
	 */
	public inline function getColumns():Float{
		return _columns;
	}	
	
    /**
     * Adds a action listener to this text field. JTextField fire a action event when 
     * user press Enter Key when input to text field.
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
	
	override private function isAutoSize():Bool{
		return _columns == 0;
	}
	
	/**
	 * JTextComponent need count preferred size itself.
	 */
	
	override private function countPreferredSize():IntDimension{
		if(_columns > 0){
			var columnWidth:Int = getColumnWidth();
			//why
			//var width:Int = Std.int( getTextField().textWidth+30);
			var width:Int = columnWidth * _columns + getWidthMargin();
			 var height:Int = getRowHeight() + getHeightMargin();
			var size:IntDimension = new IntDimension(width, height);
			return getInsets().getOutsideSize(size);
		}else{
			return getInsets().getOutsideSize(getTextFieldAutoSizedSize());
		}
	}
	
	//-------------------------------------------------------------------------
	
	private function __onFocusKeyDown(e:FocusKeyEvent):Void{
		if(Std.int(e.keyCode) == AWKeyboard.ENTER){
			dispatchEvent(new AWEvent(AWEvent.ACT));
		}
	}

    public override function paintFocusRect(force:Bool=false) {
        FocusManager.getManager(stage).setTraversalEnabled(true);
        super.paintFocusRect(true);
    }

	private function get_columns(): Int {
		return Math.floor(getColumns());
	}

	private function set_columns(c: Int) {
		setColumns(c);
		return c;
	}
}