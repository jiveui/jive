/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.util;
   
import flash.utils.ByteArray;


class ObjectUtils
{
	
	/**
	 * Deep clone object using thiswind@gmail.com 's solution
	 */
	public static function baseClone(source:Dynamic):Dynamic{
		 
        
        return Reflect.copy(source);
	}
	
	/**
	 * Checks wherever passed-in value is <code>String</code>.
	 */
	public static function isString(value:Dynamic):Bool{
		return (   Std.is(value , String));
	}
	
	/**
	 * Checks wherever passed-in value is <code>Number</code>.
	 */
	public static function isNumber(value:Dynamic):Bool{
		return (  Std.is(value , Float));
	}

	/**
	 * Checks wherever passed-in value is <code>Boolean</code>.
	 */
	public static function isBoolean(value:Dynamic):Bool{
		return (   Std.is( value , Bool	));
	}

	/**
	 * Checks wherever passed-in value is <code>Function</code>.
	 */
	public static function isFunction(value:Dynamic):Bool{
		return ( Reflect.isFunction(value));
	}

	
}