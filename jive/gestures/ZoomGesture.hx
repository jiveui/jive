package jive.gestures;
import openfl.geom.Vector3D;
import jive.gestures.core.GestureState;
import jive.gestures.core.Touch;
import jive.gestures.core.Gesture;

/**
 * ...
 * @author Josu Igoa
 */
class ZoomGesture extends Gesture
{
	public var slop:Float = Gesture.DEFAULT_SLOP;
	public var lockAspectRatio:Bool = true;
	
	var _touch1:Touch;
	var _touch2:Touch;
	var _transformVector:Vector3D;
	var _initialDistance:Float;
	public var scaleX:Float = 1;
	public var scaleY:Float = 1;

	public function new(c: Component)
	{
		super(c);
		
		//scaleX = scaleY = 1;
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
		{
			_touch1 = touch;
		}
		else// == 2
		{
			_touch2 = touch;
			
			_transformVector = _touch2.location.subtract(_touch1.location);
			_initialDistance = _transformVector.length;
		}
	}
	
	override function onTouchMove(touch:Touch)
	{
		super.onTouchMove(touch);
		
		if (_touchesCount < 2)
			return;
		
		var currTransformVector:Vector3D = _touch2.location.subtract(_touch1.location);
		
		if (state == GestureState.POSSIBLE)
		{
			var d:Float = currTransformVector.length - _initialDistance;
			var absD:Float = d >= 0 ? d : -d;
			if (absD < slop)
			{
				// Not recognized yet
				return;
			}
			
			if (slop > 0)
			{
				// adjust _transformVector to avoid initial "jump"
				var slopVector:Vector3D = currTransformVector.clone();
				// TODO : check
				// slopVector.normalize(_initialDistance + (d >= 0 ? slop : -slop));
				// _transformVector = Vector.Multiply(slopVector.normalize(), _initialDistance + (d >= 0 ? slop : -slop));
			}
		}
		
		if (lockAspectRatio)
		{
			scaleX *= currTransformVector.length / _transformVector.length;
			scaleY = scaleX;
		}
		else
		{
			scaleX *= currTransformVector.x / _transformVector.x;
			scaleY *= currTransformVector.y / _transformVector.y;
		}
		
		//_transformVector.x = currTransformVector.x;
		//_transformVector.y = currTransformVector.y;
		
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
		else//== 1
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
		
		scaleX = scaleY = 1;
	}
}