package jive.gestures.core;
import openfl.Lib;
import openfl.geom.Vector3D;

/**
 * ...
 * @author Josu Igoa
 */
class Touch
{
	/**
	 * Touch point ID.
	 */
	public var id:UInt;
	/**
	 * The original event target for this touch (touch began with).
	 */
	//public var target:Object;
	
	public var sizeX:Float;
	public var sizeY:Float;
	public var pressure:Float;
	
	public var location(get, null):Vector3D;
	public var previousLocation(get, null):Vector3D;
	public var beginLocation(get, null):Vector3D;
	public var locationOffset(get, null):Vector3D;
	public var time:UInt;
	public var beginTime:UInt;
    public var speed: Vector3D; // Pixels/sec

    private var previousMouseTime:UInt;
    private var previousMouseLocation:Vector3D;


	public function new(id:UInt = 0)
	{
		this.id = id;
        speed = new Vector3D();
	}
	
	public function setLocation(x:Float, y:Float, time:UInt)
	{
		location = new Vector3D(x, y);
		beginLocation = location.clone();
		previousLocation = location.clone();
        previousMouseLocation = location.clone();

		this.time = time;
		beginTime = time;
        previousMouseTime = time;
	}
	
	public function updateLocation(x:Float, y:Float, time:UInt):Bool
	{
		if (location != null)
		{
			previousLocation.x = location.x;
			previousLocation.y = location.y;
			location.x = x;
			location.y = y;
			this.time = time;
		}
		else
		{
			setLocation(x, y, time);
		}
		
		return true;
	}

    public function updateSpeed(x:Float, y:Float, time:UInt):Bool
    {
        if (previousMouseLocation != null && time > previousMouseTime)
        {
            speed.x = (x - previousMouseLocation.x)/(time - previousMouseTime);
            speed.y = (y - previousMouseLocation.y)/(time - previousMouseTime);
            previousMouseLocation.x = x;
            previousMouseLocation.y = y;
            previousMouseTime = time;
        }
        else
        {
            setLocation(x, y, time);
        }

        return true;
    }

    public function updateLocationBetweenMouseEvents() {
        var t = Lib.getTimer();
        var l = if (null == location) previousLocation else location;
        updateLocation(
            l.x + speed.x * (t-time),
            l.y + speed.y * (t-time),
            t);
    }
	
	public function clone():Touch
	{
		var touch:Touch = new Touch(id);
		touch.location = location.clone();
		touch.beginLocation = beginLocation.clone();
		//touch.target = target;
		touch.sizeX = sizeX;
		touch.sizeY = sizeY;
		touch.pressure = pressure;
        touch.time = time;
		touch.beginTime = beginTime;
		
		return touch;
	}
	
	
	public function toString():String
	{
		return "Touch [id: " + id + ", location: " + location + ",  speed: " + speed + "...]";
	}
	
	/* GETTERS & SETTERS */
	
	public function get_location():Vector3D
	{
		return location;
	}
	
	public function get_previousLocation():Vector3D
	{
		return previousLocation;
	}
	
	public function get_beginLocation():Vector3D
	{
		return beginLocation.clone();
	}
	
	public function get_locationOffset():Vector3D
	{
		return location.subtract(beginLocation);
	}
}