/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.dnd;


import org.aswing.Component;
import flash.display.Sprite;
import org.aswing.util.Timer;
import org.aswing.event.AWEvent;
import flash.geom.Point;
import org.aswing.geom.IntPoint;
import org.aswing.AsWingUtils;

/**
 * The motion of the drop target does not accept the dropped initiator. 
 * @author paling
 */
class RejectedMotion implements DropMotion{
		
	private var timer:Timer;
	private var initiatorPos:IntPoint;
	private var dragObject:Sprite;
	
	public function new(){
		timer = new Timer(40);
		timer.addEventListener(AWEvent.ACT, __enterFrame);
	}
	
	private function startNewMotion(dragInitiator:Component, dragObject : Sprite):Void{
		this.dragObject = dragObject;
		initiatorPos = dragInitiator.getGlobalLocation();
		if(initiatorPos == null){
			initiatorPos = new IntPoint();
		}
		timer.start();
	}
	
	public function forceStop():Void{
		finishMotion();
	}
	
	public function startMotionAndLaterRemove(dragInitiator:Component, dragObject : Sprite) : Void{
		startNewMotion(dragInitiator, dragObject);
	}
	
	private function finishMotion():Void{
		if(timer.isRunning())	{
			timer.stop();
			dragObject.alpha = 1;
			if(dragObject.parent != null){
				dragObject.parent.removeChild(dragObject);
			}
		}
	}
	
	private function __enterFrame(e:AWEvent):Void{
		//check first
		var speed:Float= 0.25;
		
		var p:Point = new Point(dragObject.x, dragObject.y);
		p =  dragObject.parent.localToGlobal(p);
		p.x += (initiatorPos.x - p.x) * speed;
		p.y += (initiatorPos.y - p.y) * speed;
		if(Point.distance(p, initiatorPos.toPoint()) < 2){
			finishMotion();
			return;
		}
		p = dragObject.parent.globalToLocal(p);
		dragObject.alpha += (0.04 - dragObject.alpha) * speed;
		dragObject.x = p.x;
		dragObject.y = p.y;
	}
	
}