package jive.gestures.core;
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
	
	

	public function new(id:UInt = 0)
	{
		this.id = id;
	}
	
	public function setLocation(x:Float, y:Float, time:UInt)
	{
		location = new Vector3D(x, y);
		beginLocation = location.clone();
		previousLocation = location.clone();
		
		this.time = time;
		beginTime = time;
	}
	
	public function updateLocation(x:Float, y:Float, time:UInt):Bool
	{
		if (location != null)
		{
			if (location.x == x && location.y == y)
				return false;
			
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
		return "Touch [id: " + id + ", location: " + location + ", ...]";
	}
	
	/* GETTERS & SETTERS */
	
	public function get_location():Vector3D
	{
		//return location.clone();
		return location;
	}
	
	public function get_previousLocation():Vector3D
	{
		return previousLocation.clone();
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