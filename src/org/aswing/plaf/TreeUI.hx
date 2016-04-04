/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf;
 

import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.JTree;
import org.aswing.plaf.ComponentUI;
import org.aswing.tree.TreePath;

/**
 * Pluggable look and feel interface for JTree.
 * @author paling
 * @private
 */
interface TreeUI extends ComponentUI {
	
    /**
      * Returns the IntRectangle enclosing the label portion that the
      * last item in path will be drawn into.  Will return null if
      * any component in path is currently valid.
      */
    function getPathBounds(tree:JTree, path:TreePath):IntRectangle;

    /**
      * Returns the path for passed in row.  If row is not visible
      * null is returned.
      */
    function getPathForRow(tree:JTree, row:Int):TreePath;

    /**
      * Returns the row that the last item identified in path is visible
      * at.  Will return -1 if any of the elements in path are not
      * currently visible.
      */
    function getRowForPath(tree:JTree, path:TreePath):Int;

    /**
      * Returns the number of rows that are being displayed.
      */
    function getRowCount(tree:JTree):Int;

    /**
      * Returns the path to the node that is closest to x,y.  If
      * there is nothing currently visible this will return null, otherwise
      * it'll always return a valid path.  If you need to test if the
      * returned object is exactly at x, y you should get the bounds for
      * the returned path and test x, y against that.
      */
    function getClosestPathForLocation(tree:JTree, x:Int, y:Int):TreePath;

    /**
      * Returns true if the tree is being edited.  The item that is being
      * edited can be returned by getEditingPath().
      */
    function isEditing(tree:JTree):Bool;

    /**
      * Stops the current editing session.  This has no effect if the
      * tree isn't being edited.  Returns true if the editor allows the
      * editing session to stop.
      */
    function stopEditing(tree:JTree):Bool;

    /**
      * Cancels the current editing session. This has no effect if the
      * tree isn't being edited.  Returns true if the editor allows the
      * editing session to stop.
      */
    function cancelEditing(tree:JTree):Void;

    /**
      * Selects the last item in path and tries to edit it.  Editing will
      * fail if the CellEditor won't allow it for the selected item.
      * 
      * @return true is started sucessful, editing fail
      */
    function startEditingAtPath(tree:JTree, path:TreePath):Bool;

    /**
     * Returns the path to the element that is being edited.
     */
    function getEditingPath(tree:JTree):TreePath;
    
    /**
     * Returns the view size.
     */    
	function getViewSize(tree:JTree):IntDimension;

    /**
     * Returns the treePath that the user mouse pointed, null if no path was pointed.
     */	
	function getMousePointedPath():TreePath;
}