package jive.gestures;

import jive.gestures.core.GestureState;
import jive.gestures.core.Touch;
import jive.gestures.core.Gesture;

/**
 * ...
 * @author Josu Igoa
 */
class PanGesture extends Gesture
{
	public static inline var NO_DIRECTION:UInt = 0;
	public static inline var VERTICAL:UInt = 1 << 0;
	public static inline var HORIZONTAL:UInt = 1 << 1;
	
	public var slop:Float = Gesture.DEFAULT_SLOP;
	/**
	 * Used for initial slop overcome calculations only.
	 */
	public var direction:UInt = NO_DIRECTION;
	public var maxNumTouchesRequired(default, set):UInt;
	public var minNumTouchesRequired(default, set):UInt;
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;

	public function new() 
	{
		super();
		
		maxNumTouchesRequired = Std.int(Math.pow(2, 31));
		minNumTouchesRequired = 1;
	}
	
	// --------------------------------------------------------------------------
	//
	// Protected methods
	//
	// --------------------------------------------------------------------------
	override function onTouchBegin(touch:Touch)
	{
		super.onTouchBegin(touch);
		
		if (_touchesCount > maxNumTouchesRequired)
		{
			failOrIgnoreTouch(touch);
			return;
		}
		
		if (_touchesCount >= minNumTouchesRequired)
			updateLocation();
	}
	
	override function onTouchMove(touch:Touch)
	{
		super.onTouchMove(touch);
		
		if (_touchesCount < minNumTouchesRequired)
			return;
		
		var prevLocationX:Float;
		var prevLocationY:Float;
		
		if (state == GestureState.POSSIBLE)
		{
			prevLocationX = location.x;
			prevLocationY = location.y;
			updateLocation();
			
			// Check if finger moved enough for gesture to be recognized
			var locationOffset = touch.locationOffset;
			if (direction == VERTICAL)
				locationOffset.x = 0;
			else if (direction == HORIZONTAL)
				locationOffset.y = 0;
			
			if (locationOffset.length > slop || slop != slop)//faster isNaN(slop)
			{
				// NB! += instead of = for the case when this gesture recognition is delayed via requireGestureToFail
				offsetX += location.x - prevLocationX;
				offsetY += location.y - prevLocationY;
				
				setState(GestureState.BEGAN);
			}
		}
		else if (state == GestureState.BEGAN || state == GestureState.CHANGED)
		{
			prevLocationX = location.x;
			prevLocationY = location.y;
			updateLocation();
			offsetX = location.x - prevLocationX;
			offsetY = location.y - prevLocationY;
			
			setState(GestureState.CHANGED);
		}
	}
	
	override function onTouchEnd(touch:Touch)
	{
		super.onTouchEnd(touch);
		
		if (_touchesCount < minNumTouchesRequired)
		{
			if (state == GestureState.POSSIBLE)
				setState(GestureState.FAILED);
			else
				setState(GestureState.ENDED);
		}
		else
			updateLocation();
	}
	
	override function resetNotificationProperties()
	{
		super.resetNotificationProperties();
		
		offsetX = offsetY = 0;
	}
	
	/* GETTERS & SETTERS */
	public function set_maxNumTouchesRequired(value:UInt):UInt 
	{
		if (maxNumTouchesRequired == value)
				return value;
			
		if (value < minNumTouchesRequired)
			throw "maxNumTouchesRequired must be not less then minNumTouchesRequired";
		
		maxNumTouchesRequired = value;
		
		return value;
	}
	
	public function set_minNumTouchesRequired(value:UInt):UInt 
	{
		if (minNumTouchesRequired == value)
				return value;
		
		if (value > maxNumTouchesRequired)
			throw "minNumTouchesRequired must be not greater then maxNumTouchesRequired";
		
		minNumTouchesRequired = value;
		
		return value;
	}
}