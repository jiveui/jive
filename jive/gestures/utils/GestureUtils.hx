package jive.gestures.utils;

import openfl.geom.Vector3D;
/**
 * ...
 * @author Josu Igoa
 */
class GestureUtils
{
	/**
	 * Precalculated coefficient used to convert 'inches per second' value to 'pixels per millisecond' value.
	 */
	//public static inline var IPS_TO_PPMS:Float = Capabilities.screenDPI * 0.001;
	public static inline var IPS_TO_PPMS:Float = .254;
	/**
	 * Precalculated coefficient used to convert radians to degress.
	 */
	public static inline var RADIANS_TO_DEGREES:Float = 180 / 3.14159;
	/**
	 * Precalculated coefficient used to convert degress to radians.
	 */
	public static inline var DEGREES_TO_RADIANS:Float = 3.14159 / 180;
	/**
	 * Precalculated coefficient Math.PI * 2
	 */
	public static inline var PI_DOUBLE:Float = 6.28318;
	//public static inline var GLOBAL_ZERO:Vector = new Vector();
	
	static public inline function distance(v2:Vector3D, v1:Vector3D):Float
	{
		return Math.sqrt((v2.x - v1.x) * (v2.x - v1.x) + (v2.y - v1.y) * (v2.y - v1.y));
	}
	
	static public function clearArray(arr:Array<Dynamic>)
	{
        #if (cpp||php)
           arr.splice(0,arr.length);
        #else
           untyped arr.length = 0;
        #end
    }
}