/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.geom;
	import flash.geom.Point;
	
/**
 * A point with x and y coordinates in int.
 * @author paling
 */
class IntPoint{
	
	public var x:Int;
	public var y:Int;
	
	/**
	 * Constructor
	 */
	public function new(?x:Int=0, ?y:Int=0){
	this.x=0;
	this.y=0;
	this.x = x;
	this.y = y;
	}
	
	/**
	 * Return a Point instance with same value.
	 */
	public function toPoint():Point{
		return new Point(x, y);
	}
	
	/**
	 * Sets the location with a <code>Point</code>, the value will be transfer to int.
	 * @param p the location to be set.
	 */
	public function setWithPoint(p:Point):Void{
		x =Std.int(p.x);
		y =Std.int(p.y);
	}
	
	/**
	 * Create a int point with point.
	 */
	public static function creatWithPoint(p:Point):IntPoint{
		return new IntPoint(Std.int(p.x), Std.int(p.y));
	}
		
	/**
	 * Sets the location of this point as same as point p.
	 * @param p the location to be set.
	 */
	public function setLocation(p:IntPoint):Void{
		this.x = p.x;
		this.y = p.y;
	}
	
	/**
	 * Sets the location of this point with x and y.
	 * @param x the x coordinates.
	 * @param y the y coordinates.
	 */
	public function setLocationXY(x:Int=0, y:Int=0):Void{
		this.x = x;
		this.y = y;
	}
	
	/**
	 * Moves this point and return itself.
	 * @param dx delta of x.
	 * @param dy delta of y.
	 * @return the point itself.
	 */
	public function move(dx:Int, dy:Int):IntPoint{
		x += dx;
		y += dy;
		return this;
	}
	
	/**
	 * Moves this point with an direction in radians and distance, then return itself.
	 * @param angle the angle in radians.
	 * @param distance the distance in pixels.
	 * @return the point itself.
	 */
	public function moveRadians(direction:Int, distance:Int):IntPoint{
		x += Math.round(Math.cos(direction)*distance);
		y += Math.round(Math.sin(direction)*distance);
		return this;
	}
	
	
	
	/**
	 * Returns the point beside this point with direction and distance.
	 * @return the point beside.
	 */
	public function nextPoint(direction:Float, distance:Float):IntPoint{
		return new IntPoint(Std.int(x+Math.cos(direction)*distance), Std.int(y+Math.sin(direction)*distance));
	}
	
	/**
	 * Returns the distance square between this point and passing point.
	 * @param p the another point.
	 * @return the distance square from this to p.
	 */
	public function distanceSq(p:IntPoint):Int{
		var xx:Int= p.x;
		var yy:Int= p.y;
		
		return ((x-xx)*(x-xx)+(y-yy)*(y-yy));	
	}


	/**
	 * Returns the distance between this point and passing point.
	 * @param p the another point.
	 * @return the distance from this to p.
	 */
	public function distance(p:IntPoint):Int{
		return Std.int(Math.sqrt(distanceSq(p)));
	}
    
    /**
     * Returns whether or not this passing object is a same value point.
     * @param toCompare the object to be compared.
     * @return equals or not.
     */
	public function equals(o:Dynamic):Bool{
		var toCompare:IntPoint = AsWingUtils.as(o,IntPoint)	;
		if(toCompare == null) return false;
		return x==toCompare.x && y==toCompare.y;
	}

	/**
	 * Duplicates current instance.
	 * @return copy of the current instance.
	 */
	public function clone():IntPoint {
		return new IntPoint(x,y);
	}
    
    /**
    * 
    */
	public function toString():String{
		return "IntPoint["+x+","+y+"]";
	}	
}