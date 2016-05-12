package jive.gestures;

import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import openfl.Lib;
import jive.Component;
import jive.gestures.core.GesturesManager;
import jive.gestures.core.GestureState;
import jive.gestures.core.TouchesManager;
import jive.gestures.core.Gesture;
/**
 * ...
 * @author Josu Igoa
 */

class Gestures
{
	static inline var MOUSE_TOUCH_POINT_ID:UInt = 0;

	public var gesturesManager(default, null):GesturesManager;
	private var touchesManager:TouchesManager;
	private var _component: Component;

	public function new(component: Component, gs: Array<Gesture> = null)
	{	
		gesturesManager = new GesturesManager(component);
		touchesManager = new TouchesManager(gesturesManager);

		if (gs != null) {
			for(g in gs) {
				gesturesManager.addGesture(g);
			}
		}

		_component = component;

		// _component.addEventListener(TouchEvent.TOUCH_BEGIN, ontouchdown);
		// _component.addEventListener(TouchEvent.TOUCH_MOVE, ontouchmove);
		// _component.addEventListener(TouchEvent.TOUCH_END, ontouchup);
		// _component.addEventListener(TouchEvent.TOUCH_OUT, ontouchup);
		_component.addEventListener(MouseEvent.MOUSE_DOWN, onmousedown);
	}

	static public function init()
	{
		GestureState.initStates();
		
		//#if web
		// desktop web browsers
		//Luxe.on(luxe.Ev.mousedown, onmousedown);
		// mobile web browsers
		//Luxe.on(luxe.Ev.touchdown, ontouchdown);
		//Luxe.on(luxe.Ev.touchmove, ontouchmove);
		//Luxe.on(luxe.Ev.touchup, ontouchup);
		//#elseif mobile
		//Luxe.on(luxe.Ev.touchdown, ontouchdown);
		//Luxe.on(luxe.Ev.touchmove, ontouchmove);
		//Luxe.on(luxe.Ev.touchup, ontouchup);
		//#else
		//Luxe.on(luxe.Ev.mousedown, onmousedown);
		//#end
	}

	private function ontouchdown(event:TouchEvent)
	{
		/*
		 * state : InteractState.down,
			timestamp : timestamp,
			touch_id : touch_id,
			x : x,
			y : y,
			dx : x,
			dy : y,
			pos : _touch_pos*/
		// Original: _touchesManager.onTouchBegin(event.touchPointID, event.pos.x * Luxe.screen.w, event.pos.y * Luxe.screen.h); //, event.target as InteractiveObject);
		touchesManager.onTouchBegin(event.touchPointID, event.localX, event.localY); //, event.target as InteractiveObject);
	}

	private function ontouchmove(event:TouchEvent)
	{
		touchesManager.onTouchMove(event.touchPointID, event.localX, event.localY);
	}

	private function ontouchup(event:TouchEvent)
	{
		touchesManager.onTouchEnd(event.touchPointID, event.localX, event.localY);
	}

	private function onmousedown(event:MouseEvent)
	{
		var touchAccepted:Bool = touchesManager.onTouchBegin(MOUSE_TOUCH_POINT_ID, event.localX, event.localY);

		if (touchAccepted)
			addmouselisteners();
	}

	private function onmousemove(event:MouseEvent)
	{
		touchesManager.onTouchMove(MOUSE_TOUCH_POINT_ID, event.localX, event.localY);
	}

	private function onmouseup(event:MouseEvent)
	{
		touchesManager.onTouchEnd(MOUSE_TOUCH_POINT_ID, event.localX, event.localY);

		if (touchesManager.activeTouchesCount == 0)
			removemouselisteners();
	}

	private function addmouselisteners()
	{
		//Luxe.core.emitter.on(luxe.Ev.mousemove, onmousemove);
		//Luxe.core.emitter.on(luxe.Ev.mouseup, onmouseup);
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onmousemove);
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onmouseup);
		//_component.addEventListener(MouseEvent.MOUSE_OUT, onmouseup);
	}

	private function removemouselisteners()
	{
		//Luxe.core.emitter.off(luxe.Ev.mousemove, onmousemove);
		//Luxe.core.emitter.off(luxe.Ev.mouseup, onmouseup);
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onmousemove);
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, onmouseup);
		//_component.removeEventListener(MouseEvent.MOUSE_OUT, onmouseup);
	}

	public function dispose()
	{
		gesturesManager.removeAllGestures();
		gesturesManager = null;
		touchesManager = null;

		// _component.removeEventListener(TouchEvent.TOUCH_BEGIN, ontouchdown);
		// _component.removeEventListener(TouchEvent.TOUCH_END, ontouchup);
		// _component.removeEventListener(TouchEvent.TOUCH_MOVE, ontouchmove);
		// _component.removeEventListener(TouchEvent.TOUCH_OUT, ontouchup);
		_component.removeEventListener(MouseEvent.MOUSE_DOWN, onmouseup);
		// _component.removeEventListener(MouseEvent.MOUSE_OUT, onmouseup);

		//Luxe.core.emitter.off(luxe.Ev.touchdown, ontouchdown);
		//Luxe.core.emitter.off(luxe.Ev.touchmove, ontouchmove);
		//Luxe.core.emitter.off(luxe.Ev.touchup, ontouchup);

		//Luxe.core.emitter.off(luxe.Ev.mousedown, onmousedown);
		removemouselisteners();
	}
}
