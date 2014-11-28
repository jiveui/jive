/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.events.Event;
import flash.events.TextEvent;
import flash.display.InteractiveObject;
import org.aswing.error.Error;
#if(flash9)
import flash.events.TextEvent;
#end
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;

import org.aswing.AWKeyboard;

import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
	/**
 * JTextComponent is the base class for text components. 
 * <p>
 * <code>JTextComponent</code> can be formated by <code>ASFont</code>, 
 * but some times you need complex format,then <code>ASFont</code> is 
 * not enough, so you can set a <code>EmptyFont</code> instance to the 
 * <code>JTextComponent</code>, it will do nothing for the format, then 
 * you can call <code>setTextFormat</code>, <code>setDefaultTextFormat</code> 
 * to format the text with <code>TextFormat</code> instances. And don't forgot 
 * to call <code>revalidate</code> if you think the component size should be 
 * change after that. Because these method will not call <code>revalidate</code>
 * automatically.
 * </p>
 * 
 * @author paling
 * @see #setTextFormat()
 * @see EmptyFont
 * @see JTextField
 * @see JTextArea
 */
class JTextComponent extends Component  implements EditableComponent{
	
	private var textField:TextField;

	private var editable:Bool;
	
	private var columnWidth:Int;
	private var rowHeight:Int;
	private var widthMargin:Int;
	private var heightMargin:Int;
	private var columnRowCounted:Bool;

	@bindable public var text(get, set): String;
	
	public function new(){
		super();
		
		textField = new TextField();
		textField.type = TextFieldType.INPUT;
		textField.autoSize = TextFieldAutoSize.NONE;
		textField.background = false;
		editable = true;
		columnRowCounted = false;
		addChild(textField);
		textField.addEventListener(Event.CHANGE, function(e) { bindx.Bind.notify(this.text);});
		#if(flash9)
		textField.addEventListener(TextEvent.TEXT_INPUT, __onTextComponentTextInput);
		#end
	}
	public function setDefaultTextFormat(dtf:TextFormat):Void{
	 	getTextField().defaultTextFormat = dtf;
	}
	
	public function getDefaultTextFormat():TextFormat{
		return getTextField().defaultTextFormat;
	}
	public function setWordWrap(b:Bool):Void{
		getTextField().wordWrap = b;
		if(isAutoSize()){
			revalidate();
		}
	}
	
	public function isWordWrap():Bool{
		return getTextField().wordWrap;
	}
	 
	/**
	 * Returns the internal <code>TextField</code> instance.
	 * @return the internal <code>TextField</code> instance.
	 */
	public function getTextField():TextField{
		return textField;
	}
	
	/**
	 * Subclass override this method to do right counting.
	 */
	private function isAutoSize():Bool{
		return false;
	}
	
	override public function setEnabled(b:Bool):Void{
		super.setEnabled(b);
		getTextField().selectable = b;
		getTextField().mouseEnabled = b;
	}
	
	public function setEditable(b:Bool):Void {
	 
		if(b != editable){
			editable = b;
			if(b)	{
				getTextField().type = TextFieldType.INPUT;
			}else{
				getTextField().type = TextFieldType.DYNAMIC;
			}
			invalidate();
			invalidateColumnRowSize();
			repaint();
		}
	}
	
	public function isEditable():Bool {
		
		return editable;
	}
		/**
	 * Sets the default textFormat to the text.
	 * <p>
	 * You should set a <code>EmptyFont</code> instance to be the component 
	 * font before this call to make sure the textFormat will be effective.
	 * </p>
	 * @param dtf the default textformat.
	 * @see #setFont()
	 */
	/**
	 * Sets the font to the text component.
	 * @param f the font.
	 * @see EmptyFont
	 */
	override public function setFont(f:ASFont):Void {
	#if (flash9 || cpp)
		super.setFont(f);
		setFontValidated(true);
		if (getFont() != null) {
			
			getFont().apply(getTextField());
			
			invalidateColumnRowSize();
		}
		#end
	}

	
	override public function setForeground(c:ASColor):Void{
		super.setForeground(c);
		if (getForeground() != null) { 
    		getTextField().textColor = getForeground().getRGB();
    		getTextField().alpha = getForeground().getAlpha();
  		}
	}
		
	public function setText(text:String):Void{
		if(getTextField().text != text){
			getTextField().text = text;
			if(isAutoSize()){
				revalidate();
			}
			bindx.Bind.notify(this.text);
		}
	}
	
	public function getText():String{
		return getTextField().text;
	}
	
	public function setHtmlText(ht:String):Void{
		getTextField().htmlText = ht;
		if(isAutoSize()){
			revalidate();
		}
	}
	
	public function getHtmlText():String{
		return getTextField().htmlText;
	}
	
	public function appendText(newText:String):Void{
		getTextField().text+=newText;
		if(isAutoSize()){
			revalidate();
		}
	}
	
	//-------------------------------------------------------------
	
	/**
	 * JTextComponent need count preferred size itself.
	 */
	override private function countPreferredSize():IntDimension{
		throw new Error("Subclass of JTextComponent need implement this method : countPreferredSize!");
		return null;
	}
	
	/**
	 * Invalidate the column and row size, make it will be recount when need it next time.
	 */
	private function invalidateColumnRowSize():Void{
		columnRowCounted = false;
	}	
	
	/**
	 * Returns the column width. The meaning of what a column is can be considered a fairly weak notion for some fonts.
	 * This method is used to define the width of a column. 
	 * By default this is defined to be the width of the character m for the font used.
	 * if the font size changed, the invalidateColumnRowSize will be called,
	 * then next call get method about this will be counted first.
	 */
	private function getColumnWidth():Int{
		if(columnRowCounted!=true) countColumnRowSize();
		return columnWidth;
	}
	
	/**
	 * Returns the row height. The meaning of what a column is can be considered a fairly weak notion for some fonts.
	 * This method is used to define the height of a row. 
	 * By default this is defined to be the height of the character m for the font used.
	 * if the font size changed, the invalidateColumnRowSize will be called,
	 * then next call get method about this will be counted first.
	 */
	private function getRowHeight():Int{
		if(columnRowCounted!=true) countColumnRowSize();
		return rowHeight;
	}
	
	/**
	 * @see #getColumnWidth()
	 */
	private function getWidthMargin():Int{
		if(columnRowCounted!=true) countColumnRowSize();
		return widthMargin;
	}
	
	/**
	 * @see #getRowHeight()
	 */	
	private function getHeightMargin():Int{
		if(columnRowCounted!=true) countColumnRowSize();
		return heightMargin;
	}
	
	private function getTextFieldAutoSizedSize(forceWidth:Int=0, forceHeight:Int=0):IntDimension{
		var tf:TextField = getTextField();
		var oldSize:IntDimension = new IntDimension(Std.int(tf.textWidth), Std.int(tf.textHeight));
		var old:TextFieldAutoSize = tf.autoSize;
		if(forceWidth != 0){
			tf.width = forceWidth;
		}
		if(forceHeight != 0){
			tf.height = forceHeight;
		}
		tf.autoSize = TextFieldAutoSize.LEFT;
		var size:IntDimension = new IntDimension(Std.int(tf.textWidth), Std.int(tf.textHeight));
		#if(flash9)
		size = new IntDimension(Std.int(tf.width), Std.int(tf.height));
		#end		
		tf.autoSize = old;
		tf.width = oldSize.width;
		tf.height = oldSize.height;
		if(forceWidth != 0){
			size.width = forceWidth;
		}
		if(forceHeight != 0){
			size.height = forceHeight;
		}
		return size;
	}
	
	private function countColumnRowSize():Void{
		var str:String= "mmmmm";
		var tf:TextFormat = getFont().getTextFormat();
		var textFieldSize:IntDimension = AsWingUtils.computeStringSizeWithFont(getFont(), str, true);
		var textSize:IntDimension = AsWingUtils.computeStringSizeWithFont(getFont(), str, false);
		if(tf.font == "NSimSun"){
			columnWidth = Math.round(textSize.width/4 + Std.int(tf.size)/6);
		}else{
			columnWidth = Std.int(textSize.width/5);
		}
		rowHeight = textSize.height;
		widthMargin = textFieldSize.width - textSize.width;
		heightMargin = textFieldSize.height - textSize.height;
		columnRowCounted = true;
	}
	
    /**
     * Returns the text field to receive the focus for this component.
     * @return the object to receive the focus.
     */
    override public function getInternalFocusObject():InteractiveObject{
    	return getTextField();
    }
	
	override private function paint(b:IntRectangle):Void{
		super.paint(b);
		applyBoundsToText(b);
	}
	
    private function applyBoundsToText(b:IntRectangle):Void{
		var t:TextField = getTextField();
		t.x = b.x;
		t.y = b.y;
		t.width = b.width;
		t.height = b.height;
    }	
	
	#if (flash9)
	
		 
	private function __onTextComponentTextInput(e:TextEvent):Void {
	
    	if(!getTextField().multiline){ //fix the bug that fp in interenet browser single line TextField Ctrl+Enter will entered a newline bug
    		var text:String= e.text;
    		var km:KeyboardManager = getKeyboardManager();
    		if(km!=null)	{
	    		if(km.isKeyDown(AWKeyboard.CONTROL) && km.isKeyDown(AWKeyboard.ENTER)){
					if(text.length == 1 && text.charCodeAt(0) == 10){
						
						e.preventDefault();
					}
	    		}
    		}
    	}

	}
	/**
	 * Append text implemented by <code>replaceText</code> to avoid the 
	 * <code>appendText()</code> method bug(the bug will make the text not be append at 
	 * the end of the text, some times it appends to a middle position).
	 * @param newText the text to be append to the end of the text field.
	 */
	public function appendByReplace(newText:String):Void{
		var n:Int = getLength();
		
		getTextField().replaceText(n, n, newText);
		 
	}
	
	public function replaceSelectedText(value:String):Void {
 
		getTextField().replaceSelectedText(value);
	 
	}
	
	public function replaceText(beginIndex:Int, endIndex:Int, newText:String):Void {
 
		getTextField().replaceText(beginIndex, endIndex, newText);
 
	}
	
	public function setSelection(beginIndex:Int, endIndex:Int):Void {
 
		getTextField().setSelection(beginIndex, endIndex);
 
	}
	
	public function selectAll():Void {
 
		getTextField().setSelection(0, getTextField().length);
 
	}
	
	public function setCondenseWhite(b:Bool):Void {
 
		if(getTextField().condenseWhite != b){
			getTextField().condenseWhite = b;
			revalidate();
		}
		
	}
	
	public function isCondenseWhite():Bool {
 
		return getTextField().condenseWhite;
	 
		return true;
	}
	 

	
	
	/**
	 * Sets the textFormat to the specified range.
	 * <p>
	 * You should set a <code>EmptyFont</code> instance to be the component 
	 * font before this call to make sure the textFormat will be effective.
	 * </p>
	 * @param tf the default textformat.
	 * @param beginIndex the begin index.
	 * @param endIndex the end index.
	 * @see #setFont()
	 */	
 
	public function setTextFormat(tf:TextFormat, beginIndex:Int= -1, endIndex:Int= -1):Void{
		
		getTextField().setTextFormat(tf, beginIndex, endIndex);
		 
	}
	
	public function getTextFormat(beginIndex:Int = -1, endIndex:Int = -1):TextFormat {
	 
	
		return getTextField().getTextFormat(beginIndex, endIndex);
	 
	}
	
	public function setDisplayAsPassword(b:Bool):Void {
 
		getTextField().displayAsPassword = b;
 
	}
	
	public function isDisplayAsPassword():Bool {
	 
		return getTextField().displayAsPassword;
	 
	}
	
	public function getLength():Int {
 	
		return getTextField().length;
 
	}
	
	public function setMaxChars(n:Int):Void {
 
		getTextField().maxChars = n;
 
	}
	
	
	public function getMaxChars():Int {
 		
		return getTextField().maxChars;
 
	}
	
	public function setRestrict(res:String):Void {
		 
		getTextField().restrict = res;
 
	} 
	
	public function getRestrict():String {
 
		return getTextField().restrict;
 
	}
	
	public function getSelectionBeginIndex():Int {
 	
		return getTextField().selectionBeginIndex;
	 
	}
	
	public function getSelectionEndIndex():Int {
 	
		return getTextField().selectionEndIndex;
 
	}
	
	public function setCSS(css:Dynamic):Void {
 	
		getTextField().styleSheet = css;
			
		if(isAutoSize()){
			revalidate();
		} 
	}
	
	public function getCSS():Dynamic {
 	
		return getTextField().styleSheet;
 
	}
	

	public function setUseRichTextClipboard(b:Bool):Void {
	 	
		getTextField().useRichTextClipboard = b;
		 
	}
	
	public function isUseRichTextClipboard():Bool {
 	
		return getTextField().useRichTextClipboard;
	 
	}
		#end
		
	private function get_text(): String {
		return getText();
	}

	private function set_text(val: String): String {
		setText(val);
		return val;
	}
}