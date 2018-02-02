/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.tree;


import org.aswing.Component;
	import org.aswing.plaf.UIResource;
import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntPoint;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.tree.TreePath;

/**
 * @private
 */
class BasicExpandControl implements ExpandControl implements UIResource{
	
	public function paintExpandControl(c:Component, g:Graphics2D, bounds:IntRectangle, 
		totalChildIndent:Int, path:TreePath, row:Int, expanded:Bool, leaf:Bool):Void{
		if(leaf)	{
			return;
		}
		var w:Int= totalChildIndent;
		var cx:Float= bounds.x - w/2;
		var cy:Float= bounds.y + bounds.height/2;
		var r:Float= 4;
		var trig:Array<Dynamic>;
		if(expanded!=true){
			cx -= 2;
			trig = [new IntPoint(Std.int(cx), Std.int(cy-r)), new IntPoint(Std.int(cx), Std.int(cy+r)), new IntPoint(Std.int(cx+r), Std.int(cy))];
		}else{
			cy -= 2;
			trig = [new IntPoint(Std.int(cx-r), Std.int(cy)), new IntPoint(Std.int(cx+r), Std.int(cy)), new IntPoint(Std.int(cx), Std.int(cy+r))];
		}
		g.fillPolygon(new SolidBrush(ASColor.BLACK), trig);
	}
	
}