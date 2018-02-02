/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


/**
 * @author paling
 */
interface Resizable2{
	
    function getElementCount():Int;
    
    function getLowerBoundAt(i:Int):Int;
    
    function getUpperBoundAt(i:Int):Int;
    
    function setSizeAt(newSize:Int, i:Int):Void;
    
}