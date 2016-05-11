package jive.gestures;
import openfl.utils.Timer;
import openfl.events.TimerEvent;
import jive.gestures.core.GestureState;
import jive.gestures.core.Touch;
import jive.gestures.core.Gesture;

/**
 * ...
 * @author Josu Igoa
 */
class LongPressGesture extends Gesture
{
	public var numTouchesRequired:UInt = 1;
	/**
	 * The minimum time interval in millisecond fingers must press on the target for the gesture to be recognized.
	 * 
	 * @default 500
	 */
	public var minPressDuration:UInt = 500;
	public var slop:Float = Gesture.DEFAULT_SLOP;
	
	var _timer:Timer;
	var _numTouchesRequiredReached:Bool;

	public function new() 
	{
		super();
		
	}
	
	// --------------------------------------------------------------------------
	//
	// Public methods
	//
	// --------------------------------------------------------------------------
	
	override public function reset()
	{
		super.reset();
		
		_numTouchesRequiredReached = false;
		_timer.reset();
	}
	
	
	// --------------------------------------------------------------------------
	//
	// Protected methods
	//
	// --------------------------------------------------------------------------
	
	override function preinit()
	{
		super.preinit();
		
		_timer = new Timer(minPressDuration, 1);
		_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
	}
	
	
	override function onTouchBegin(touch:Touch)
	{
		super.onTouchBegin(touch);

		if (_touchesCount > numTouchesRequired)
		{
			failOrIgnoreTouch(touch);
			return;
		}
		
		if (_touchesCount == numTouchesRequired)
		{
			_numTouchesRequiredReached = true;
			_timer.reset();
			_timer.start();
		}
	}
	
	override function onTouchMove(touch:Touch)
	{
		super.onTouchMove(touch);

		if (state == GestureState.POSSIBLE && slop > 0 && touch.locationOffset.length > slop)
			setState(GestureState.FAILED);
		else if (state == GestureState.BEGAN || state == GestureState.CHANGED)
		{
			updateLocation();
			setState(GestureState.CHANGED);
		}
	}
	
	
	override function onTouchEnd(touch:Touch)
	{
		super.onTouchEnd(touch);

		if (_numTouchesRequiredReached)
		{
			if (state == GestureState.BEGAN || state == GestureState.CHANGED)
			{
				updateLocation();
				setState(GestureState.ENDED);
			}
			else
				setState(GestureState.FAILED);
		}
		else
			setState(GestureState.FAILED);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//--------------------------------------------------------------------------
	
	function timerCompleteHandler(event:TimerEvent)
	{
		if (state == GestureState.POSSIBLE)
		{
			updateLocation();
			setState(GestureState.BEGAN);
		}
	}
}