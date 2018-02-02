/**
 * ...
 * @author paling
 */

package org.aswing;
import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.MouseEvent; 
class SimpleButton  extends Sprite
{
	
	private var _over:Bool;
	private var _down:Bool;
	public var downState : DisplayObject;
	public var enabled : Bool ;
	public var hitTestState : DisplayObject;
	public var overState : DisplayObject ; 
	public var trackAsMenu : Bool ;
	public var upState : DisplayObject; 
	public function new( ?upState : DisplayObject, ?overState : DisplayObject, ?downState : DisplayObject, ?hitTestState : DisplayObject ) : Void
	{
		super();
		this.upState = upState;
		this.overState = overState;
		this.downState = downState;
		this.hitTestState = hitTestState;
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
		addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
	}
	public function show():Void
	{
		clear();
		addChild(upState);
	}
	private function clear():Void
	{
		while (this.numChildren > 0) this.removeChildAt(0);
	}
	public function onMouseOver(event:MouseEvent):Void
	{
		_over = true;
		clear();
		addChild(overState);
		addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
	}

	/**
	* Internal mouseOut handler.
	* @param event The MouseEvent passed by the system.
	*/
	public function onMouseOut(event:MouseEvent):Void
	{
		_over = false;
	
		if(!_down)
		{ 
			clear();
			addChild(upState);
		} 
		removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
	}

	/**
	* Internal mouseOut handler.
	* @param event The MouseEvent passed by the system.
	*/
	public function onMouseGoDown(event:MouseEvent):Void
	{
		_down = true;
		  clear();
		addChild(downState);
		AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
	}

	/**
	* Internal mouseUp handler.
	* @param event The MouseEvent passed by the system.
	*/
	public function onMouseGoUp(event:MouseEvent):Void
	{
	    clear();
		addChild(upState);
		AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
	}

}