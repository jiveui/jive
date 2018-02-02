package org.aswing.tree;
 
/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import org.aswing.tree.TreePath;

/**
 * @author paling
 */
class PathPlaceHolder {
    public var isNew:Bool;
    public var path:TreePath;

    public function new(path:TreePath, isNew:Bool) {
		this.path = path;
		this.isNew = isNew;
    }	
}