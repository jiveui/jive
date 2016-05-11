package jive.gestures;
// import luxe.Timer;
import openfl.geom.Vector3D;
import openfl.utils.Timer;
import openfl.events.TimerEvent;
import jive.gestures.core.GestureState;
import jive.gestures.core.Touch;
import jive.gestures.utils.GestureUtils;
import jive.gestures.core.Gesture;
import openfl.system.Capabilities;
import haxe.CallStack;

/**
 * ...
 * @author Josu Igoa
 */
class SwipeGesture extends Gesture
{
	// DIRECTIONS
	public static inline var RIGHT:UInt = 1 << 0;
	public static inline var LEFT:UInt = 1 << 1;
	public static inline var UP:UInt = 1 << 2;
	public static inline var DOWN:UInt = 1 << 3;
	
	public static inline var NO_DIRECTION:UInt = 0;
	public static var HORIZONTAL:UInt = RIGHT | LEFT;
	public static var VERTICAL:UInt = UP | DOWN;
	public static var ORTHOGONAL:UInt = RIGHT | LEFT | UP | DOWN;
	//
	
	private static inline var ANGLE:Float = 40 * GestureUtils.DEGREES_TO_RADIANS;
	private static inline var MAX_DURATION:UInt = 100;
	private static var MIN_OFFSET:Float =  Capabilities.screenDPI > 0 ? Capabilities.screenDPI / 6 : 96.0 / 6; // 42.6; //  / 6;
	private static var MIN_VELOCITY:Float = 2 * MIN_OFFSET / MAX_DURATION;
	
	/**
	 * "Dirty" region around touch begin location which is not taken into account for
	 * recognition/failing algorithms.
	 * 
	 * @default Gesture.DEFAULT_SLOP
	 */
	public var slop:Float = Gesture.DEFAULT_SLOP;
	public var numTouchesRequired:UInt = 1;
	public var direction:UInt = ORTHOGONAL;
	
	/**
	 * The duration of period (in milliseconds) in which SwipeGesture must be recognized.
	 * If gesture is not recognized during this period it fails. Default value is 500 (half a
	 * second) and generally should not be changed. You can change it though for some special
	 * cases, most likely together with <code>minVelocity</code> and <code>minOffset</code>
	 * to achieve really custom behavior. 
	 * 
	 * @default 500
	 * 
	 * @see #minVelocity
	 * @see #minOffset
	 */
	public var maxDuration:UInt = MAX_DURATION;
	
	/**
	 * Minimum offset (in pixels) for gesture to be recognized.
	 * Default value is <code>Capabilities.screenDPI / 6</code> and generally should not
	 * be changed.
	 */
	public var minOffset:Vector3D = new Vector3D(MIN_OFFSET, MIN_OFFSET);
	
	/**
	 * Minimum velocity (in pixels per millisecond) for gesture to be recognized.
	 * Default value is <code>2 * minOffset / maxDuration</code> and generally should not
	 * be changed.
	 * 
	 * @see #minOffset
	 * @see #minDuration
	 */
	public var minVelocity:Vector3D = new Vector3D(MIN_VELOCITY, MIN_VELOCITY);
	
	public var offsetX(get, null):Float;
	public var offsetY(get, null):Float;
	var _offset:Vector3D;
	var _startTime:Int;
	var _noDirection:Bool;
	var _avrgVel:Vector3D;
	var _timer:Timer;
	var isRecognized: Bool;
	
	public function new() 
	{
		super();
		// trace('screenDpi=' + Capabilities.screenDPI);
		// trace('MIN_OFFSET=$MIN_OFFSET');
		// trace('MIN_OFFSET=$MIN_OFFSET');
		// trace('slop=$slop');

		_offset = new Vector3D();
		_avrgVel = new Vector3D();
	}
	
	override public function reset()
	{
		_startTime = 0;
		_offset.x = 0;
		_offset.y = 0;
		_timer.reset();
		
		super.reset();
	}
	
	// --------------------------------------------------------------------------
	//
	// methods
	//
	// --------------------------------------------------------------------------
	override function preinit()
	{
		super.preinit();
		
		_timer = new Timer(maxDuration, 1);
		_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
	}
	
	override function onTouchBegin(touch:Touch)
	{
		super.onTouchBegin(touch);
		
		isRecognized = false;

		if (_touchesCount > numTouchesRequired)
		{
			failOrIgnoreTouch(touch);
			return;
		}
		
		if (_touchesCount == 1)
		{
			// Because we want to fail as quick as possible
			_startTime = touch.time;
			
			// trace('start time = $_startTime');

			_timer.reset();
			_timer.delay = maxDuration;
			_timer.repeatCount = 1;
			_timer.start();
		}
		if (_touchesCount == numTouchesRequired)
		{
			updateLocation();
			_avrgVel.x = _avrgVel.y = 0;
			
			// cache direction condition for performance
			_noDirection = (ORTHOGONAL & direction) == 0;
		}
	}
	
	override function onTouchMove(touch:Touch)
	{
		super.onTouchMove(touch);
		
		if (_touchesCount < numTouchesRequired)
			return;
		
		var totalTime:Int = touch.time - _startTime;

		// trace('total time = $totalTime');
		

		if (totalTime == 0)
			return;//It was somehow THAT MUCH performant on one Android tablet
		
		var prevCentralPointX:Float = _centralPoint.x;
		var prevCentralPointY:Float = _centralPoint.y;
		updateCentralPoint();
		
		_offset.x = _centralPoint.x - location.x;
		_offset.y = _centralPoint.y - location.y;
		var offsetLength:Float = _offset.length;
		
		// average velocity (total offset to total duration)
		_avrgVel.x = _offset.x / totalTime;
		_avrgVel.y = _offset.y / totalTime;

		var avrgVel:Float = _avrgVel.length;
		
		if (_noDirection)
		{
			if ((offsetLength > slop || slop != slop) &&
				((avrgVel >= minVelocity.x || avrgVel >= minVelocity.y) && (offsetLength >= minOffset.x || offsetLength >= minOffset.y)))
			{
				// setState(GestureState.RECOGNIZED);
				isRecognized = true;
			}
		}
		else
		{
			var recentOffsetX:Float = _centralPoint.x - prevCentralPointX;
			var recentOffsetY:Float = _centralPoint.y - prevCentralPointY;
			//faster Math.abs()
			var absVelX:Float = Math.abs(_avrgVel.x);
			var absVelY:Float = Math.abs(_avrgVel.y);
			
			// trace('absVel = ($absVelX, $absVelY), $_offset, $minVelocity');

			if (absVelX > absVelY) // horizontal swipe detected
			{
				var absOffsetX:Float = Math.abs(_offset.x);
				// trace(absOffsetX);
				if (absOffsetX > slop || slop != slop)//faster isNaN()
				{
					if ((recentOffsetX < 0 && (direction & LEFT) == 0) ||
						(recentOffsetX > 0 && (direction & RIGHT) == 0) ||
						Math.abs(Math.atan(_offset.y/_offset.x)) > ANGLE)
					{
						// movement in opposite direction
						// or too much diagonally
						// trace('failed');
						setState(GestureState.FAILED);
					}
					else if (absVelX >= minVelocity.x && absOffsetX >= minOffset.x)
					{
						_offset.y = 0;
						isRecognized = true;
						// setState(GestureState.RECOGNIZED);
					}
				}
			}
			else if (absVelY > absVelX) // vertical swipe detected
			{
				var absOffsetY:Float = Math.abs(_offset.y);

				if (absOffsetY > slop || slop != slop)//faster isNaN()
				{
					if ((recentOffsetY < 0 && (direction & UP) == 0) ||
						(recentOffsetY > 0 && (direction & DOWN) == 0) ||
						Math.abs(Math.atan(_offset.x/_offset.y)) > ANGLE)
					{
						// movement in opposite direction
						// or too much diagonally
						// trace('failed');
						
						setState(GestureState.FAILED);
					}
					else if (absVelY >= minVelocity.y && absOffsetY >= minOffset.y)
					{
						_offset.x = 0;
						isRecognized = true;
						// setState(GestureState.RECOGNIZED);
					}
				}
			}
			// Give some tolerance for accidental offset on finger press (slop)
			else if (offsetLength > slop || slop != slop) {//faster isNaN()
				// trace('failed');
				setState(GestureState.FAILED);
			}
		}
	}
	
	override function onTouchEnd(touch:Touch)
	{
		super.onTouchEnd(touch);
		
		if (_touchesCount < numTouchesRequired){
			if (isRecognized)
				setState(GestureState.RECOGNIZED);
			else
				setState(GestureState.FAILED);
		}
	}
	
	override function resetNotificationProperties()
	{
		super.resetNotificationProperties();
		
		_offset.x = _offset.y = 0;
	}
	
	
	//--------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//--------------------------------------------------------------------------
	
	function timerCompleteHandler(event:TimerEvent)
	{
		// trace('timer complete handler $state');
		if (state == GestureState.POSSIBLE)
			setState(GestureState.FAILED);
	}
	
	/* GETTER & SETTER */
	public function get_offsetX():Float
	{
		return _offset.x;
	}
	public function get_offsetY():Float
	{
		return _offset.y;
	}
}