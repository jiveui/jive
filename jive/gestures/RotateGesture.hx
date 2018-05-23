package jive.gestures;
import openfl.geom.Vector3D;
import jive.gestures.core.GestureState;
import jive.gestures.core.Touch;
import jive.gestures.core.Gesture;

/**
 * ...
 * @author Josu Igoa
 */
class RotateGesture extends Gesture
{
	public var slop:Float = Gesture.DEFAULT_SLOP;
	
	var _touch1:Touch;
	var _touch2:Touch;
	var _transformVector:Vector3D;
	var _thresholdAngle:Float;
	/** rotation: in radians */
	public var rotation:Float = 0;

	public function new(component: org.aswing.Component)
	{
		super(component);
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
			
			_transformVector = _touch2.location.subtract(_touch1.location);
			
			// @see chord length formula
			_thresholdAngle = Math.asin(slop / (2 * _transformVector.length)) * 2;
		}
	}
	
	
	override function onTouchMove(touch:Touch)
	{
		super.onTouchMove(touch);
		
		if (_touchesCount < 2)
			return;
		
		var currTransformVector:Vector3D = _touch2.location.subtract(_touch1.location);
		var cross:Float = (_transformVector.x * currTransformVector.y) - (currTransformVector.x * _transformVector.y);
		var dot:Float = (_transformVector.x * currTransformVector.x) + (_transformVector.y * currTransformVector.y);
		var rot:Float = Math.atan2(cross, dot);
		
		if (state == GestureState.POSSIBLE)
		{
			var absRotation:Float = rot >= 0 ? rot : -rot;
			if (absRotation < _thresholdAngle)
			{
				// not recognized yet
				return;
			}
			
			// adjust angle to avoid initial "jump"
			rotation = rot > 0 ? rot - _thresholdAngle : rot + _thresholdAngle;
		}
		
		//_transformVector.x = currTransformVector.x;
		//_transformVector.y = currTransformVector.y;
		rotation = rot;
		
		updateLocation();
		
		if (state == GestureState.POSSIBLE)
			setState(GestureState.BEGAN);
		else
			setState(GestureState.CHANGED);
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
			{
				_touch1 = _touch2;
			}
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
		
		rotation = 0;
	}
}