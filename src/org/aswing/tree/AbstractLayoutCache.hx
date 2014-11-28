/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

import org.aswing.event.TreeModelEvent;
import org.aswing.geom.IntRectangle;
import org.aswing.tree.NodeDimensions;
import org.aswing.tree.RowMapper;
import org.aswing.tree.TreeModel;
import org.aswing.tree.TreePath;
import org.aswing.tree.TreeSelectionModel;
import org.aswing.error.ImpMissError;

/**
 * @author paling
 */
class AbstractLayoutCache implements RowMapper{
    /** Object responsible for getting the size of a node. */
    private var nodeDimensions:NodeDimensions;

    /** Model providing information. */
    private var treeModel:TreeModel;

    /** Selection model. */
    private var treeSelectionModel:TreeSelectionModel;

    /**
     * True if the root node is displayed, false if its children are
     * the highest visible nodes.
     */
    private var rootVisible:Bool;

    /**
      * Height to use for each row.  If this is <= 0 the renderer will be
      * used to determine the height for each row.
      */
    private var rowHeight:Int;

	 public function new():Void{
    }
    /**
     * Sets the renderer that is responsible for drawing nodes in the tree
     * and which is threfore responsible for calculating the dimensions of
     * individual nodes.
     *
     * @param nd a <code>NodeDimensions</code> object
     */
    public function setNodeDimensions(nd:NodeDimensions):Void{
		nodeDimensions = nd;
    }

    /**
     * Returns the object that renders nodes in the tree, and which is 
     * responsible for calculating the dimensions of individual nodes.
     *
     * @return the <code>NodeDimensions</code> object
     */
    public function getNodeDimensions():NodeDimensions {
		return nodeDimensions;
    }

    /**
     * Sets the <code>TreeModel</code> that will provide the data.
     *
     * @param newModel the <code>TreeModel</code> that is to
     *		provide the data
     */
    public function setModel(newModel:TreeModel):Void{
        treeModel = newModel;
    }

    /**
     * Returns the <code>TreeModel</code> that is providing the data.
     *
     * @return the <code>TreeModel</code> that is providing the data
     */
    public function getModel():TreeModel {
        return treeModel;
    }

    /**
     * Determines whether or not the root node from
     * the <code>TreeModel</code> is visible.
     *
     * @param rootVisible true if the root node of the tree is to be displayed
     */
    public function setRootVisible(rootVisible:Bool):Void{
        this.rootVisible = rootVisible;
    }

    /**
     * Returns true if the root node of the tree is displayed.
     *
     * @return true if the root node of the tree is displayed
     */
    public function isRootVisible():Bool{
        return rootVisible;
    }

    /**
     * Sets the height of each cell.  If the specified value
     * is less than or equal to zero the current cell renderer is
     * queried for each row's height.
     *
     * @param rowHeight the height of each cell, in pixels
     */
    public function setRowHeight(rowHeight:Int):Void{
        this.rowHeight = rowHeight;
    }

    /**
     * Returns the height of each row.  If the returned value is less than
     * or equal to 0 the height for each row is determined by the
     * renderer.
     */
    public function getRowHeight():Int{
        return rowHeight;
    }

    /**
     * Sets the <code>TreeSelectionModel</code> used to manage the
     * selection to new LSM.
     *
     * @param newLSM  the new <code>TreeSelectionModel</code>
     */
    public function setSelectionModel(newLSM:TreeSelectionModel):Void{
		if(treeSelectionModel != null)
		    treeSelectionModel.setRowMapper(null);
		treeSelectionModel = newLSM;
		if(treeSelectionModel != null)
		    treeSelectionModel.setRowMapper(this);
    }

    /**
     * Returns the model used to maintain the selection.
     *
     * @return the <code>treeSelectionModel</code>
     */
    public function getSelectionModel():TreeSelectionModel {
		return treeSelectionModel;
    }

    /**
     * Returns the preferred height.
     *
     * @return the preferred height
     */
    public function getPreferredHeight():Int{
		// Get the height
		var rowCount:Int= getRowCount();
	
		if(rowCount > 0) {
		    var bounds:IntRectangle = getBounds(getPathForRow(rowCount - 1), null);
	
		    if(bounds != null){
				return bounds.y + bounds.height;
		    }
		}
		return 0;
    }

    /**
     * Returns the preferred width for the passed in region.
     * The region is defined by the path closest to
     * <code>(bounds.x, bounds.y)</code> and
     * ends at <code>bounds.height + bounds.y</code>.
     * If <code>bounds</code> is <code>null</code>,
     * the preferred width for all the nodes
     * will be returned (and this may be a VERY expensive
     * computation).
     *
     * @param bounds the region being queried
     * @return the preferred width for the passed in region
     */
    public function getPreferredWidth(bounds:IntRectangle):Int{
		var rowCount:Int= getRowCount();
		if(rowCount > 0) {
		    // Get the width
		    var firstPath:TreePath;
		    var endY:Int;
	
		    if(bounds == null) {
				firstPath = getPathForRow(0);
				endY = AsWingConstants.MAX_VALUE;
		    }else {
				firstPath = getPathClosestTo(bounds.x, bounds.y);
				endY = bounds.height + bounds.y;
		    }
	
		    var paths:Array<Dynamic>= getVisiblePathsFrom(firstPath, AsWingConstants.MAX_VALUE);
			var pn:Int= paths.length;
		    if(paths != null && pn>0){
				var pBounds:IntRectangle = getBounds(AsWingUtils.as(paths[0],TreePath), null);
				var width:Int;
		
				if(pBounds != null) {
				    width = pBounds.x + pBounds.width;
				    if (pBounds.y >= endY) {
						return width;
				    }
				}else{
				    width = 0;
				}
				var i:Int= 1;
				while (pBounds != null && i<pn) {
				    pBounds = getBounds(AsWingUtils.as(paths[i],TreePath), pBounds);
				    if (pBounds != null && pBounds.y < endY) {
						width = Std.int(Math.max(width, pBounds.x + pBounds.width));
				    } else {
						pBounds = null;
				    }
				    i++;
				}
				return width;
		    }
		}
		return 0;
    }

    //
    // Abstract methods that must be implemented to be concrete.
    //

    /**
      * Returns true if the value identified by row is currently expanded.
      */
    public function isExpanded(path:TreePath):Bool{
    	throw new ImpMissError();
    	return false;
    }

    /**
     * Returns a rectangle giving the bounds needed to draw path.
     *
     * @param path     a <code>TreePath</code> specifying a node
     * @param placeIn  a <code>IntRectangle</code> object giving the
     *		available space
     * @return a <code>IntRectangle</code> object specifying the space to be used
     */
    public function getBounds(path:TreePath, placeIn:IntRectangle):IntRectangle{
    	throw new ImpMissError();
    	return null;
    }

    /**
      * Returns the path for passed in row.  If row is not visible
      * <code>null</code> is returned.
      *
      * @param row  the row being queried
      * @return the <code>TreePath</code> for the given row
      */
    public function getPathForRow(row:Int):TreePath{
    	throw new ImpMissError();
    	return null;
    }

    /**
      * Returns the row that the last item identified in path is visible
      * at.  Will return -1 if any of the elements in path are not
      * currently visible.
      *
      * @param path the <code>TreePath</code> being queried
      * @return the row where the last item in path is visible or -1
      *		if any elements in path aren't currently visible
      */
    public function getRowForPath(path:TreePath):Int{
    	throw new ImpMissError();
    	return 0;
    }
    
    
    /**
      * Returns the index of the row containing location.  If there
      * are no rows, -1 is returned.  If location is beyond the last
      * row index, the last row index is returned.
      */
    public function getRowContainingYLocation(location:Int):Int{
    	throw new ImpMissError();
    	return 0;
    }

    /**
      * Returns the path to the node that is closest to x,y.  If
      * there is nothing currently visible this will return <code>null</code>,
      * otherwise it'll always return a valid path.
      * If you need to test if the
      * returned object is exactly at x, y you should get the bounds for
      * the returned path and test x, y against that.
      *
      * @param x the horizontal component of the desired location
      * @param y the vertical component of the desired location
      * @return the <code>TreePath</code> closest to the specified point
      */
    public function getPathClosestTo(x:Int, y:Int):TreePath{
    	throw new ImpMissError();
    	return null;
    }

    /**
     * Returns an <code>Enumerator</code> that increments over the visible 
     * paths starting at the passed in location. The ordering of the 
     * enumeration is based on how the paths are displayed.
     * The first element of the returned enumeration will be path,
     * unless it isn't visible,
     * in which case <code>null</code> will be returned.
     *
     * @param path the starting location for the enumeration
     * @param totalCount the total number of path to contains.
     * @return the <code>Enumerator</code> starting at the desired location
     */
    public function getVisiblePathsFrom(path:TreePath, totalCount:Int):Array<Dynamic>{
    	throw new ImpMissError();
    	return null;
    }

    /**
     * Returns the number of visible children for row.
     * 
     * @param path  the path being queried
     * @return the number of visible children for the specified path
     */
    public function getVisibleChildCount(path:TreePath):Int{
    	throw new ImpMissError();
    	return 0;
    }

    /**
     * Marks the path <code>path</code> expanded state to
     * <code>isExpanded</code>.
     *
     * @param path  the path being expanded or collapsed
     * @param isExpanded true if the path should be expanded, false otherwise 
     */
    public function setExpandedState(path:TreePath, isExpanded:Bool):Void{
    	throw new ImpMissError();
    }

    /**
     * Returns true if the path is expanded, and visible.
     *
     * @param path  the path being queried
     * @return true if the path is expanded and visible, false otherwise
     */
    public function getExpandedState(path:TreePath):Bool{
    	throw new ImpMissError();
    	return false;
    }

    /**
     * Number of rows being displayed.
     * 
     * @return the number of rows being displayed
     */
    public function getRowCount():Int{
    	throw new ImpMissError();
    	return 0;
    }

    /**
     * Informs the <code>TreeState</code> that it needs to recalculate
     * all the sizes it is referencing.
     */
    public function invalidateSizes():Void{
    	throw new ImpMissError();
    }

    /**
     * Instructs the <code>LayoutCache</code> that the bounds for
     * <code>path</code> are invalid, and need to be updated.
     *
     * @param path the path being updated
     */
    public function invalidatePathBounds(path:TreePath):Void{
    	throw new ImpMissError();
    }

    //
    // TreeModelListener methods
    // AbstractTreeState does not directly become a TreeModelListener on
    // the model, it is up to some other object to forward these methods.
    //

    /**
     * <p>
     * Invoked after a node (or a set of siblings) has changed in some
     * way. The node(s) have not changed locations in the tree or
     * altered their children arrays, but other attributes have
     * changed and may affect presentation. Example: the name of a
     * file has changed, but it is in the same location in the file
     * system.</p>
     *
     * <p>e.path() returns the path the parent of the changed node(s).</p>
     *
     * <p>e.childIndices() returns the index(es) of the changed node(s).</p>
     *
     * @param e  the <code>TreeModelEvent</code>
     */
    public function treeNodesChanged(e:TreeModelEvent):Void{
    	throw new ImpMissError();
    }

    /**
     * <p>Invoked after nodes have been inserted into the tree.</p>
     *
     * <p>e.path() returns the parent of the new nodes</p>
     * <p>e.childIndices() returns the indices of the new nodes in
     * ascending order.</p>
     *
     * @param e the <code>TreeModelEvent</code>
     */
    public function treeNodesInserted(e:TreeModelEvent):Void{
    	throw new ImpMissError();
    }

    /**
     * <p>Invoked after nodes have been removed from the tree.  Note that
     * if a subtree is removed from the tree, this method may only be
     * invoked once for the root of the removed subtree, not once for
     * each individual set of siblings removed.</p>
     *
     * <p>e.path() returns the former parent of the deleted nodes.</p>
     *
     * <p>e.childIndices() returns the indices the nodes had before they were deleted in ascending order.</p>
     *
     * @param e the <code>TreeModelEvent</code>
     */
    public function treeNodesRemoved(e:TreeModelEvent):Void{
    	throw new ImpMissError();
    }

    /**
     * <p>Invoked after the tree has drastically changed structure from a
     * given node down.  If the path returned by <code>e.getPath()</code>
     * is of length one and the first element does not identify the
     * current root node the first element should become the new root
     * of the tree.</p>
     *
     * <p>e.path() holds the path to the node.</p>
     * <p>e.childIndices() returns null.</p>
     *
     * @param e the <code>TreeModelEvent</code>
     */
    public function treeStructureChanged(e:TreeModelEvent):Void{
    	throw new ImpMissError();
    }

    //
    // RowMapper
    //

    /**
     * Returns the rows that the <code>TreePath</code> instances in
     * <code>path</code> are being displayed at.
     * This method should return an array of the same length as that passed
     * in, and if one of the <code>TreePaths</code>
     * in <code>path</code> is not valid its entry in the array should
     * be set to -1.
     *
     * @param paths the array of <code>TreePath</code>s being queried
     * @return an array of the same length that is passed in containing
     *		the rows that each corresponding where each
     *		<code>TreePath</code> is displayed; if <code>paths</code>
     *		is <code>null</code>, <code>null</code> is returned
     */
    public function getRowsForPaths(paths:Array<Dynamic>):Array<Dynamic>{
		if(paths == null)
		    return null;
	
		var numPaths:Int= paths.length;
		var rows:Array<Dynamic>= new Array<Dynamic>();
	
		for(counter in 0...numPaths)rows[counter] = getRowForPath(paths[counter]);
		return rows;
    }

    //
    // Local methods that subclassers may wish to use that are primarly
    // convenience methods.
    //

    /**
     * Returns, by reference in <code>placeIn</code>,
     * the size needed to represent <code>value</code>.
     * If <code>inPlace</code> is <code>null</code>, a newly created
     * <code>IntRectangle</code> should be returned, otherwise the value
     * should be placed in <code>inPlace</code> and returned. This will
     * return <code>null</code> if there is no renderer.
     *
     * @param value the <code>value</code> to be represented
     * @param row  row being queried
     * @param depth the depth of the row
     * @param expanded true if row is expanded, false otherwise 
     * @param placeIn  a <code>IntRectangle</code> containing the size needed
     *		to represent <code>value</code>
     * @return a <code>IntRectangle</code> containing the node dimensions,
     *		or <code>null</code> if node has no dimension
     */
    private function countNodeDimensions(value:Dynamic, row:Int, depth:Int,
					  expanded:Bool, placeIn:IntRectangle):IntRectangle {
		var nd:NodeDimensions = getNodeDimensions();
	
		if(nd != null) {
		    return nd.countNodeDimensions(value, row, depth, expanded, placeIn);
		}
		return null;
    }
}