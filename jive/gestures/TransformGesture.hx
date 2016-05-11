package jive.gestures;

import openfl.geom.Vector3D;
import jive.gestures.core.GestureState;
import jive.gestures.core.Touch;
import jive.gestures.core.Gesture;

/**
 * ...
 * @author Josu Igoa
 */
class TransformGesture extends Gesture
{
	public var slop:Float = Gesture.DEFAULT_SLOP;
	var _touch1:Touch;
	var _touch2:Touch;
	var _transformVector:Vector3D;
	
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var rotation:Float = 0;
	public var scale:Float = 1;

	public function new() 
	{
		super();
	}
	
	override public function reset()
	{
		_touch1 = null;
		_touch2 = null;
		
		super.reset();
	}
	
	// --------------------------------------------------------------------------
	//
	// methods
	//
	// --------------------------------------------------------------------------
	override function onTouchBegin(touch:Touch)
	{
		super.onTouchBegin(touch);
		
		if (_touchesCount > 2)
		{
			failOrIgnoreTouch(touch);
			return;
		}
		
		if (_touchesCount == 1)
			_touch1 = touch;
		else
		{
			_touch2 = touch;
			_transformVector = Vector.Subtract(_touch2.location, _touch1.location);
		}
		
		updateLocation();
		
		if (state == GestureState.BEGAN || state == GestureState.CHANGED)
		{
			// notify that location (and amount of touches) has changed
			setState(GestureState.CHANGED);
		}
	}
	
	override function onTouchMove(touch:Touch)
	{
		super.onTouchMove(touch);
		
		var prevLocation:Vector = location.clone();
		updateLocation();
		
		if (state == GestureState.POSSIBLE)
		{
			if (slop > 0 && touch.locationOffset.length < slop)
			{
				// Not recognized yet
				if (_touch2 != null)
				{
					// Recalculate _transformVector to avoid initial "jump" on recognize
					_transformVector = Vector.Subtract(_touch2.location, _touch1.location);
				}
				return;
			}
		}
		
		offsetX = location.x - prevLocation.x;
		offsetY = location.y - prevLocation.y;
		if (_touch2 != null)
		{
			var currTransformVector = Vector.Subtract(_touch2.location, _touch1.location);
			rotation = Math.atan2(currTransformVector.y, currTransformVector.x) - Math.atan2(_transformVector.y, _transformVector.x);
			scale = currTransformVector.length / _transformVector.length;
		}
		
		setState(state == GestureState.POSSIBLE ? GestureState.BEGAN : GestureState.CHANGED);
	}
	
	override function onTouchEnd(touch:Touch)
	{
		super.onTouchEnd(touch);
		
		if (_touchesCount == 0)
		{
			if (state == GestureState.BEGAN || state == GestureState.CHANGED)
				setState(GestureState.ENDED);
			else if (state == GestureState.POSSIBLE)
				setState(GestureState.FAILED);
		}
		else// == 1
		{
			if (touch == _touch1)
				_touch1 = _touch2;
			
			_touch2 = null;
			
			if (state == GestureState.BEGAN || state == GestureState.CHANGED)
			{
				updateLocation();
				setState(GestureState.CHANGED);
			}
		}
	}
	
	override function resetNotificationProperties()
	{
		super.resetNotificationProperties();
		
		offsetX = offsetY = 0;
		rotation = 0;
		scale = 1;
	}
}