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

    static public var gesturesManager(default, null):GesturesManager;
    static private var touchesManager:TouchesManager;


    static public function init()
    {
        if (gesturesManager == null) {
            GestureState.initStates();
            
            gesturesManager = new GesturesManager();
            touchesManager = new TouchesManager(gesturesManager);
            Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, onmousedown);
            // Lib.current.stage.addEventListener(TouchEvent.TOUCH_DOWN, ontouchdown);
        }
    }

    static public function ontouchdown(event:TouchEvent)
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
        touchesManager.onTouchBegin(event.touchPointID, event.stageX, event.stageY); //, event.target as InteractiveObject);
    }

    static private function ontouchmove(event:TouchEvent)
    {
        touchesManager.onTouchMove(event.touchPointID, event.stageX, event.stageY);
    }

    static private function ontouchup(event:TouchEvent)
    {
        touchesManager.onTouchEnd(event.touchPointID, event.stageX, event.stageY);
    }

    static public function onmousedown(event:MouseEvent)
    {
        var touchAccepted:Bool = touchesManager.onTouchBegin(MOUSE_TOUCH_POINT_ID, event.stageX, event.stageY);

        if (touchAccepted)
            addmouselisteners();
    }

    static private function onmousemove(event:MouseEvent)
    {
        touchesManager.onTouchMove(MOUSE_TOUCH_POINT_ID, event.stageX, event.stageY);
    }

    static private function onmouseup(event:MouseEvent)
    {
        touchesManager.onTouchEnd(MOUSE_TOUCH_POINT_ID, event.stageX, event.stageY);

        if (touchesManager.activeTouchesCount == 0)
            removemouselisteners();
    }

    static private function addmouselisteners()
    {
        //Luxe.core.emitter.on(luxe.Ev.mousemove, onmousemove);
        //Luxe.core.emitter.on(luxe.Ev.mouseup, onmouseup);
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onmousemove);
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onmouseup);
        //_component.addEventListener(MouseEvent.MOUSE_OUT, onmouseup);
    }

    static private function removemouselisteners()
    {
        //Luxe.core.emitter.off(luxe.Ev.mousemove, onmousemove);
        //Luxe.core.emitter.off(luxe.Ev.mouseup, onmouseup);
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onmousemove);
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, onmouseup);
        //_component.removeEventListener(MouseEvent.MOUSE_OUT, onmouseup);
    }

    static public function dispose()
    {
        gesturesManager.removeAllGestures();
        gesturesManager = null;
        touchesManager = null;

        // _component.removeEventListener(TouchEvent.TOUCH_BEGIN, ontouchdown);
        // _component.removeEventListener(TouchEvent.TOUCH_END, ontouchup);
        // _component.removeEventListener(TouchEvent.TOUCH_MOVE, ontouchmove);
        // _component.removeEventListener(TouchEvent.TOUCH_OUT, ontouchup);
        // _component.removeEventListener(MouseEvent.MOUSE_OUT, onmouseup);
        
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onmouseup);

        removemouselisteners();
    }
}
