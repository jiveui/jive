/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
/**
 * A collection of constants generally used for positioning and orienting
 * components on the screen.
 * 
 * @author paling
 */
class AsWingConstants{
		
		
	inline public static var MAX_VALUE:Int= 2147483647;

	inline public static var MIN_VALUE:Int=  -2147483648;

		inline public static var NONE:Int= -1;

        /** 
         * The central position in an area. Used for
         * both compass-direction constants (NORTH, etc.)
         * and box-orientation constants (TOP, etc.).
         */
        inline public static var CENTER:Int= 0;

        // 
        // Box-orientation constant used to specify locations in a box.
        //
        /** 
         * Box-orientation constant used to specify the top of a box.
         */
        inline public static var TOP:Int= 1;
        /** 
         * Box-orientation constant used to specify the left side of a box.
         */
        inline public static var LEFT:Int= 2;
        /** 
         * Box-orientation constant used to specify the bottom of a box.
         */
        inline public static var BOTTOM:Int= 3;
        /** 
         * Box-orientation constant used to specify the right side of a box.
         */
        inline public static var RIGHT:Int= 4;

        // 
        // Compass-direction constants used to specify a position.
        //
        /** 
         * Compass-direction North (up).
         */
        inline public static var NORTH:Int= 1;
        /** 
         * Compass-direction north-east (upper right).
         */
        inline public static var NORTH_EAST:Int= 2;
        /** 
         * Compass-direction east (right).
         */
        inline public static var EAST:Int= 3;
        /** 
         * Compass-direction south-east (lower right).
         */
        inline public static var SOUTH_EAST:Int= 4;
        /** 
         * Compass-direction south (down).
         */
        inline public static var SOUTH:Int= 5;
        /** 
         * Compass-direction south-west (lower left).
         */
        inline public static var SOUTH_WEST:Int= 6;
        /** 
         * Compass-direction west (left).
         */
        inline public static var WEST:Int= 7;
        /** 
         * Compass-direction north west (upper left).
         */
        inline public static var NORTH_WEST:Int= 8;

        //
        // These constants specify a horizontal or 
        // vertical orientation. For example, they are
        // used by scrollbars and sliders.
        //
        /** 
         * Horizontal orientation. Used for scrollbars and sliders.
         */
        inline public static var HORIZONTAL:Int= 0;
        /** 
         * Vertical orientation. Used for scrollbars and sliders.
         */
        inline public static var VERTICAL:Int= 1;
}