/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table.sorter;


/**
 * @author paling
 */
class Directive {
	public var column:Int;
	public var direction:Float;
	
	public function new(column:Int, direction:Float) {
	    this.column = column;
	    this.direction = direction;
	}
}