/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

import flash.events.Event;
import org.aswing.geom.IntRectangle;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextField;
import org.aswing.geom.IntDimension;
import org.aswing.event.FocusKeyEvent;
import org.aswing.AWKeyboard;
import org.aswing.event.AWEvent;
import org.aswing.plaf.basic.BasicTextFieldUI;

/**
 * `JTextField` is a component that allows the editing of a single line of text.
 * @author Tomato
 * @author paling
 */
@:event("org.aswing.event.AWEvent.ACT", "Dispatched when the user input ENTER in the textfield")
class JTextField extends JTextComponent{

    private var hintTextField: TextField;

    /**
	* A default value of `this.maxChars`
    **/
    public static var defaultMaxChars:Int= 0;

    /**
	 * A number of columns in this JTextField, if it changed then call parent to do layout.
	 *
	 * If columns is set to zero or min than zero, the preferred width will be matched just to view all of the text.
	 *
	 * The default value is zero.
	 */
    @bindable public var columns(get, set): Int;
    private var _columns:Int;
    private function get_columns(): Int { return Math.floor(getColumns()); }
    private function set_columns(c: Int) { setColumns(c); return c; }

    /**
    * A hint that is displayed inside text field when `text` is empty.
    **/
    public var inlineHint(get, set): String;
    private function get_inlineHint(): String { return hintTextField.text; }
    private function set_inlineHint(v: String): String { hintTextField.text = v; return v; }


    public function new(text:String="", columns:Int=0) {
		super();

		setName("JTextField");
		getTextField().multiline = false;
		getTextField().text = text;
		#if (flash9)
		setMaxChars(defaultMaxChars);
		#end
		this._columns = columns;

		//addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onFocusKeyDown);

        hintTextField = new TextField();
        hintTextField.type = TextFieldType.DYNAMIC;
        hintTextField.autoSize = TextFieldAutoSize.NONE;
        hintTextField.background = false;
        addChildAt(hintTextField, 0);

        getTextField().addEventListener(Event.CHANGE, function(e) { updateHintTextField(); });
        updateHintTextField();

        updateUI();
	}
	
	@:dox(hide)
    override public function updateUI():Void {
		setUI(UIManager.getUI(this));
	}

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicTextFieldUI;
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "TextFieldUI";
	}
	
	/**
	 * Sets the maxChars property for default value when <code>JTextFeild</code> be created.
	 * By default it is 0, you can change it by this method.
	 * @param n the default maxChars to set
	 */
    @:dox(hide)
	public static function setDefaultMaxChars(n:Int):Void{
		defaultMaxChars = n;
	}
	
	/**
	 * Returns the maxChars property for default value when <code>JTextFeild</code> be created.
	 * @return the default maxChars value.
	 */
    @:dox(hide)
	public static function getDefaultMaxChars():Int{
		return defaultMaxChars;
	}	
	
	/**
	 * Sets the number of columns in this JTextField, if it changed then call parent to do layout. 
	 * @param columns the number of columns to use to calculate the preferred width;
	 * if columns is set to zero or min than zero, the preferred width will be matched just to view all of the text.
	 * default value is zero if missed this param.
	 */
    @:dox(hide)
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
    @:dox(hide)
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
	
	@:dox(hide)
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

    @:dox(hide)
    public override function paintFocusRect(force:Bool = false) {
		if (null == stage) return;
        FocusManager.getManager(stage).setTraversalEnabled(true);
        super.paintFocusRect(true);
    }

    override private function applyBoundsToText(b:IntRectangle):Void{
        super.applyBoundsToText(b);
        var t:TextField = hintTextField;
        t.x = b.x;
        t.y = b.y;
        t.width = b.width;
        t.height = b.height;
    }

    override public function setForeground(c:ASColor):Void{
        super.setForeground(c);
        if (getForeground() != null) {
            var c = getForeground().offsetHLS(0, 0.4, 0);
            hintTextField.textColor = c.getRGB();
            hintTextField.alpha = c.getAlpha();
        }
    }

    @:dox(hide)
    override public function setFont(f:ASFont):Void {
        #if (flash9 || cpp || html5)
		super.setFont(f);
        if (getFont() != null) {
            getFont().apply(hintTextField);
        }
        #end
    }

    override public function setText(text:String):Void{
        super.setText(text);
        updateHintTextField();
    }

    private function updateHintTextField() {
        hintTextField.visible = (null == text || text == "");
    }
}