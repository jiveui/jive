package org.aswing.tree;
 
/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import org.aswing.tree.AbstractLayoutCache;
import org.aswing.tree.FHTreeStateNode;
import org.aswing.tree.TreePath;

/**
 * @author paling
 */
class SearchInfo {
	public var node:FHTreeStateNode;
	public var isNodeParentNode:Bool;
	public var childIndex:Float;
	private var layoutCatch:AbstractLayoutCache;
	
	public function new(layoutCatch:AbstractLayoutCache){
		this.layoutCatch = layoutCatch;
	}

	public function getPath():TreePath {
	    if(node == null){
			return null;
	    }

	    if(isNodeParentNode)	{
			return node.getTreePath().pathByAddingChild(layoutCatch.getModel().getChild(node.getUserObject(),
						     Std.int(childIndex)));
	    }
	    return node.getTreePath();
	}	
}