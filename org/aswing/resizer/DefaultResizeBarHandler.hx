/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.resizer;

	
import flash.events.Event;
import flash.events.MouseEvent;
import org.aswing.event.ReleaseEvent;
import org.aswing.AWSprite;
/**
 * The Handler for Resizer's mc bars.
 * @author paling
 */
class DefaultResizeBarHandler{
	
	private var resizer:DefaultResizer;
	private var mc:AWSprite;
	private var arrowRotation:Float;
	private var strategy:ResizeStrategy;
	
	public function new(resizer:DefaultResizer, barMC:AWSprite, arrowRotation:Float, strategy:ResizeStrategy){
		this.resizer = resizer;
		mc = barMC;
		this.arrowRotation = arrowRotation;
		this.strategy = strategy;
		handle();
	}
	
	public static function createHandler(resizer:DefaultResizer, barMC:AWSprite, arrowRotation:Float, strategy:ResizeStrategy):DefaultResizeBarHandler{
		return new DefaultResizeBarHandler(resizer, barMC, arrowRotation, strategy);
	}
	
	private function handle():Void{
		mc.addEventListener(MouseEvent.ROLL_OVER, __onRollOver);
		mc.addEventListener(MouseEvent.ROLL_OUT, __onRollOut);
		mc.addEventListener(MouseEvent.MOUSE_DOWN, __onPress);
		mc.addEventListener(MouseEvent.MOUSE_UP, __onUp);
		mc.addEventListener(MouseEvent.CLICK, __onRelease);
		mc.addEventListener(ReleaseEvent.RELEASE_OUT_SIDE, __onReleaseOutside);
		mc.addEventListener(Event.REMOVED_FROM_STAGE, __onDestroy);
		
	}
	
	private function __onRollOver(e:MouseEvent):Void{
		if(!resizer.isResizing() && (e ==null || !e.buttonDown)){
			resizer.startArrowCursor();
			__rotateArrow();
			if(AsWingManager.getStage()!=null)	{
				AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_MOVE, __rotateArrow, false, 0, true);
			}
		}
	}
	
	private function __onRollOut(e:MouseEvent):Void{
		if(!resizer.isResizing() && !e.buttonDown){
			if(AsWingManager.getStage()!=null)	{
				AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __rotateArrow);
			}
			resizer.stopArrowCursor();
		}
	}
	
	private function __onPress(e:MouseEvent):Void{
		resizer.setResizing(true);
		startResize(e);
		if(AsWingManager.getStage()!=null)	{
			AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __rotateArrow);
			AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_MOVE, resizing, false, 0, true);
		}
	}
	
	private function __onUp(e:MouseEvent):Void{
		__onRollOver(null);
	}
	
	private function __onRelease(e:Event):Void{
		resizer.setResizing(false);
		resizer.stopArrowCursor();
		if(AsWingManager.getStage()!=null)	{
			AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, resizing);
		}
		finishResize();
	}
	
	private function __onReleaseOutside(e:Event):Void{
		__onRelease(e);
	}
	
	private function __onDestroy(e:Event):Void {
		//why
		if(AsWingManager.getStage()!=null)	{	
			AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, resizing);
			AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __rotateArrow);
		}
	}
	
	private function __rotateArrow(e:Event=null):Void{
		resizer.setArrowRotation(arrowRotation);
	}
	
	private function startResize(e:MouseEvent):Void{
		resizer.startResize(strategy, e);
	}
	
	private function resizing(e:MouseEvent):Void{
		resizer.resizing(strategy, e);
	}
	
	private function finishResize():Void{
		resizer.finishResize(strategy);
	}
}