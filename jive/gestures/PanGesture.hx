package jive.gestures;

import org.aswing.Component;
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
	public static inline var MAX_DURATION:Int = 400;

	public var slop:Float = Gesture.DEFAULT_SLOP;
	/**
	 * Used for initial slop overcome calculations only.
	 */
	public var direction:UInt = NO_DIRECTION;
	public var maxNumTouchesRequired(default, set):UInt;
	public var minNumTouchesRequired(default, set):UInt;
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
    public var maxDuration: Int = MAX_DURATION;

    public var velX:Float = 0;
    public var velY:Float = 0;

    private var sumOffsetX:Float = 0;
    private var timeX:Int = 0;
    private var sumOffsetY:Float = 0;
    private var timeY:Int = 0;

	public function new(component: Component)
	{
		super(component);
		
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
		
		if (_touchesCount >= minNumTouchesRequired) {
			updateLocation();
            updateALocation();
            sumOffsetX = 0;
            sumOffsetY = 0;
            velX = 0;
            velY = 0;
            timeX = touch.time;
            timeY = touch.time;
        }
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
            updateALocation();
			
			// Check if finger moved enough for gesture to be recognized
			var locationOffset = touch.locationOffset;
			if (direction == VERTICAL)
				locationOffset.x = 0;
			else if (direction == HORIZONTAL)
				locationOffset.y = 0;
			
			if (locationOffset.length > slop || slop != slop)//faster isNaN(slop)
			{
				// NB! += instead of = for the case when this gesture recognition is delayed via requireGestureToFail
                
                var dx = location.x - prevLocationX;
                var dy = location.y - prevLocationY;

                updateOffsetSum(dx, dy, touch);

				offsetX += dx;
				offsetY += dy;
				
				setState(GestureState.BEGAN);
			}
		}
		else if (state == GestureState.BEGAN || state == GestureState.CHANGED)
		{
			prevLocationX = location.x;
			prevLocationY = location.y;
			updateLocation();

            var dx = location.x - prevLocationX;
            var dy = location.y - prevLocationY;

            updateOffsetSum(dx, dy, touch);

			//offsetX = dx;
			//offsetY = dy;
			
			// setState(GestureState.CHANGED);
		}
	}

    override function onTouchAnimated(touch:Touch) {
        super.onTouchAnimated(touch);

        var prevLocationX:Float;
        var prevLocationY:Float;

        if (state == GestureState.BEGAN || state == GestureState.CHANGED)
        {
            prevLocationX = alocation.x;
            prevLocationY = alocation.y;
            updateALocation();

            offsetX = alocation.x - prevLocationX;
            offsetY = alocation.y - prevLocationY;

            setState(GestureState.CHANGED);
        }
    }

	
    private function updateOffsetSum(dx: Float, dy: Float, touch:Touch) {
        if (dx * sumOffsetX >= 0 && dx != 0) {
            sumOffsetX += dx ;
        } else {
            sumOffsetX = dx ;
            timeX = touch.time;
        }

        if (dy * sumOffsetY >= 0 && dy != 0) {
            sumOffsetY += dy ;
        } else {
            sumOffsetY = dy ;
            timeY = touch.time;
        }
    }

	override function onTouchEnd(touch:Touch)
	{
		super.onTouchEnd(touch);
		
		if (_touchesCount < minNumTouchesRequired)
		{
			if (state == GestureState.POSSIBLE)
				setState(GestureState.FAILED);
			else {
                var dtx = touch.time - timeX;
                var dty = touch.time - timeY;

                //trace('(dtx: $dtx, dty: $dty) offset ($sumOffsetX, $sumOffsetY)');

                velX = dtx == 0 || dtx > maxDuration ? 0 : sumOffsetX / dtx; 
                velY = dty == 0 || dty > maxDuration ? 0 : sumOffsetY / dty; 
                
                setState(GestureState.ENDED);
            }
		}
		else {
			updateLocation();
            updateALocation();
        }
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