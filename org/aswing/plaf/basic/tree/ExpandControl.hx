/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.tree;


import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import org.aswing.tree.TreePath;

/**
 * The tree expand control graphics
 * @private
 */
interface ExpandControl{
	
	function paintExpandControl(c:Component, g:Graphics2D, bounds:IntRectangle, 
		totalChildIndent:Int, path:TreePath, row:Int, expanded:Bool, leaf:Bool):Void;
}