/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import org.aswing.SoftBoxLayout;
import org.aswing.plaf.UIResource;
import org.aswing.AsWingConstants;

/**
 * @private
 */
class DefaultMenuLayout extends SoftBoxLayout  implements UIResource{
	/**
     * Specifies that components should be laid out left to right.
     */
    inline public static var X_AXIS:Int= 0;
    
    /**
     * Specifies that components should be laid out top to bottom.
     */
    inline public static var Y_AXIS:Int= 1;
    
	public function new(axis:Int, gap:Int=0, align:Int=AsWingConstants.LEFT){
		super(axis, gap, align);
	}
	
}