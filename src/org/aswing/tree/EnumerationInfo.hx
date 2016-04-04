package org.aswing.tree;
 
/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import org.aswing.tree.FHTreeStateNode;

/**
 * @author paling
 */
class EnumerationInfo {
	
	/** Parent thats children are being enumerated. */
	public var parent:FHTreeStateNode;
	/** Index of next child. An index of -1 signifies parent should be
	 * visibled next. */
	public var nextIndex:Float;
	/** Number of children in parent. */
	public var childCount:Float;
	/** The number of path left to enumerat*/
	public var enumCount:Float;
	public function new():Void
	{
		
	}
}