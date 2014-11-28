/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import flash.text.TextField;
import flash.events.Event;
import org.aswing.event.InteractiveEvent;

/**
 * Dispatched when the text changed, programmatic change or user change.
 * 
 * @eventType org.aswing.event.InteractiveEvent.TEXT_CHANGED
 */
// [Event(name="textChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * Dispatched when the scroll changed, programmatic change or user change, for 
 * example text scrolled by user use mouse wheel or by set the scrollH/scrollV 
 * properties of <code>TextField</code>.
 * 
 * @eventType org.aswing.event.InteractiveEvent.SCROLL_CHANGED
 */
// [Event(name="scrollChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * TextField with more events support for AsWing text component use.
 */
class AWTextField extends TextField{
	
	public function new(){
		super();
		 addEventListener(Event.SCROLL, __onAWTextFieldScroll);
		 addEventListener(Event.CHANGE, __onAWTextFieldChange);
	}
	
	private function __onAWTextFieldScroll(e:Event):Void{
		fireScrollChangeEvent(false);
	}
	
	private function __onAWTextFieldChange(e:Event):Void{
		fireTextChangeEvent(false);
	}
	
	private function fireTextChangeEvent(programmatic:Bool=true):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.TEXT_CHANGED, programmatic));		
	}
	
	private function fireScrollChangeEvent(programmatic:Bool=true):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.SCROLL_CHANGED, programmatic));		
	}
	
	#if (!iphone)

	/**
	 * Sets the <code>htmlText</code> and fire <code>InteractiveEvent.TEXT_CHANGED</code> event.
	 */
	  public function set_htmlText(value:String):String{
		htmlText = value;
		fireTextChangeEvent();
	
			return value;
		}
	
	/**
	 * Sets the <code>text</code> and fire <code>InteractiveEvent.TEXT_CHANGED</code> event.
	 */
	 public function set_text(value:String):String{
		text = value;
		fireTextChangeEvent();
	
			return value;
		}
	
	
	 public function set_scrollH(value:Int):Int{
		if(value != scrollH){
			scrollH = value;
			fireScrollChangeEvent();
		}
	
			return value;
		}
	
	 public function set_scrollV(value:Int):Int{
		if(value != scrollV){
			scrollV = value;
			fireScrollChangeEvent();		
		}
	
			return value;
		}
	#end
	
	#if (flash9)
	
	/**
	 * Appends new text and fire <code>InteractiveEvent.TEXT_CHANGED</code> event.
	 */
  
    override public function appendText(newText:String):Void{
		this.text+=newText ;
		fireTextChangeEvent();
	}
	/**
	 * Replace selected text and fire <code>InteractiveEvent.TEXT_CHANGED</code> event.
	 */	
	
    override   public function replaceSelectedText(value:String):Void {
	 
		 super.replaceSelectedText(value);
		 
		fireTextChangeEvent();
	}
	
	/**
	 * Replace text and fire <code>InteractiveEvent.TEXT_CHANGED</code> event.
	 */	
 
	override public function replaceText(beginIndex:Int, endIndex:Int, newText:String):Void{
	 
		super.replaceText(beginIndex, endIndex, newText);
		 
		fireTextChangeEvent();
	}
	#end
}