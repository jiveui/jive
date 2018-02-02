/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

import org.aswing.error.Error;
import org.aswing.event.TreeModelEvent;
import org.aswing.geom.IntRectangle;
import org.aswing.tree.AbstractLayoutCache;
import org.aswing.tree.EnumerationInfo;
import org.aswing.tree.FHTreeStateNode;
import org.aswing.tree.SearchInfo;
import org.aswing.tree.TreeModel;
import org.aswing.tree.TreePath;
import org.aswing.tree.TreePathMap;
import org.aswing.util.Stack;

/**
 * @author paling
 */
class FixedHeightLayoutCache extends AbstractLayoutCache{
	/** Root node. */
	private var root:FHTreeStateNode;

	/** Number of rows currently visible. */
	private var rowCount:Int;

	/**
	 * Used in getting sizes for nodes to avoid creating a new IntRectangle
	 * every time a size is needed.
	 */
	private var boundsBuffer:IntRectangle;

	/**
	 * Maps from TreePath to a FHTreeStateNode.
	 */
	private var treePathMapping:TreePathMap;

	/**
	 * Used for getting path/row information.
	 */
	private var info:SearchInfo;

	private var tempStacks:Stack;


	public function new() {
		super();
		rowCount = 0;
		rootVisible = false;
		tempStacks = new Stack();
		boundsBuffer = new IntRectangle();
		treePathMapping = new TreePathMap();
		info = new SearchInfo(this);
		setRowHeight(16);
	}

	/**
	 * Sets the TreeModel that will provide the data.
	 *
	 * @param newModel the TreeModel that is to provide the data
	 */
	override public function setModel(newModel:TreeModel):Void{
		super.setModel(newModel);
		rebuild(false);
	}

	/**
	 * Determines whether or not the root node from
	 * the TreeModel is visible.
	 *
	 * @param rootVisible true if the root node of the tree is to be displayed
	 * @see #rootVisible
	 */
	override public function setRootVisible(rootVisible:Bool):Void{
		if(isRootVisible() != rootVisible) {
			super.setRootVisible(rootVisible);
			if(root != null) {
				if(rootVisible)	{
					rowCount++;
					root.adjustRowBy(1);
				}else {
					rowCount--;
					root.adjustRowBy(-1);
				}
				visibleNodesChanged();
			}
		}
	}

	/**
	 * Sets the height of each cell. If rowHeight is less than or equal to
	 * 0 this will throw an IllegalArgumentException.
	 *
	 * @param rowHeight the height of each cell, in pixels
	 */
	override public function setRowHeight(rowHeight:Int):Void{
		if(rowHeight <= 0){
			trace("Error : FixedHeightLayoutCache only supports row heights greater than 0");
			throw new Error("FixedHeightLayoutCache only supports row heights greater than 0");
		}
		if(getRowHeight() != rowHeight) {
			super.setRowHeight(rowHeight);
			visibleNodesChanged();
		}
	}
	
	public function setRowCount(rc:Int):Void{
		rowCount = rc;
	}
	
	/**
	 * Returns the number of visible rows.
	 */
	override public function getRowCount():Int{
		return rowCount;
	}

	/**
	 * Does nothing, FixedHeightLayoutCache doesn't cache width, and that
	 * is all that could change.
	 */
	override public function invalidatePathBounds(path:TreePath):Void{
	}


	/**
	 * Informs the TreeState that it needs to recalculate all the sizes
	 * it is referencing.
	 */
	override public function invalidateSizes():Void{
		// Nothing to do here, rowHeight still same, which is all
		// this is interested in, visible region may have changed though.
		visibleNodesChanged();
	}

	/**
	  * Returns true if the value identified by row is currently expanded.
	  */
	override public function isExpanded(path:TreePath):Bool{
		if(path != null) {
			var lastNode:FHTreeStateNode = getNodeForPath(path, true, false);
			return (lastNode != null && lastNode.isExpanded());
		}
		return false;
	}

	/**
	 * Returns a rectangle giving the bounds needed to draw path.
	 *
	 * @param path	 a TreePath specifying a node
	 * @param placeIn  a IntRectangle object giving the available space, to avoid create new instance.
	 * @return a IntRectangle object specifying the space to be used
	 */
	override public function getBounds(path:TreePath, placeIn:IntRectangle):IntRectangle {
		if(path == null)
			return null;
	
		var node:FHTreeStateNode = getNodeForPath(path, true, false);
	
		if(node != null)
			return getBounds2(node, -1, placeIn);
	
		// node hasn't been created yet.
		var parentPath:TreePath = path.getParentPath();
		node = getNodeForPath(parentPath, true, false);
		if(node != null) {
			var childIndex:Int= treeModel.getIndexOfChild(parentPath.getLastPathComponent(),
					  path.getLastPathComponent());
			//trace("childIndex = " + childIndex);
			if(childIndex != -1){
				return getBounds2(node, childIndex, placeIn);
			}
		}
		return null;
	}

	/**
	  * Returns the path for passed in row.  If row is not visible
	  * null is returned.
	  */
	override public function getPathForRow(row:Int):TreePath {
		if(row >= 0 && row < getRowCount()) {
			if(root.getPathForRow(row, getRowCount(), info)) {
				return info.getPath();
			}
		}
		return null;
	}

	/**
	  * Returns the row that the last item identified in path is visible
	  * at.  Will return -1 if any of the elements in path are not
	  * currently visible.
	  */
	override public function getRowForPath(path:TreePath):Int{
		if(path == null || root == null)
			return -1;
	
		var node:FHTreeStateNode = getNodeForPath(path, true, false);
	
		if(node != null)
			return node.getRow();
	
		var parentPath:TreePath = path.getParentPath();
	
		node = getNodeForPath(parentPath, true, false);
		if(node != null && node.isExpanded()) {
			return node.getRowToModelIndex(treeModel.getIndexOfChild(parentPath.getLastPathComponent(),
							path.getLastPathComponent()));
		}
		return -1;
	}

	/**
	  * Returns the path to the node that is closest to x,y.  If
	  * there is nothing currently visible this will return null, otherwise
	  * it'll always return a valid path.  If you need to test if the
	  * returned object is exactly at x, y you should get the bounds for
	  * the returned path and test x, y against that.
	  */
	override public function getPathClosestTo(x:Int, y:Int):TreePath {
		if(getRowCount() == 0)
			return null;
	
		var row:Int= getRowContainingYLocation(y);
	
		return getPathForRow(row);
	}

	/**
	 * Returns the number of visible children for row.
	 */
	override public function getVisibleChildCount(path:TreePath):Int{
		var node:FHTreeStateNode = getNodeForPath(path, true, false);
	
		if(node == null)
			return 0;
		return node.getTotalChildCount();
	}

	/**
	 * Returns an array that increments over the visible paths
	 * starting at the passed in location and end by totalCount of the tree end. 
	 * The ordering of the enumeration is based on how the paths are displayed.
	 * @param totalCount the total number of path to contains.
	 */
	override public function getVisiblePathsFrom(path:TreePath, totalCount:Int):Array<Dynamic>{
		if(path == null)
			return null;
				
		var node:FHTreeStateNode = getNodeForPath(path, true, false);
	
		if(node != null) {
			return getVisibleFHTreeStateNodes(node, -1, totalCount);
		}
		var parentPath:TreePath = path.getParentPath();
	
		node = getNodeForPath(parentPath, true, false);
		if(node != null && node.isExpanded()) {
			return getVisibleFHTreeStateNodes(
				node, 
				treeModel.getIndexOfChild(
					parentPath.getLastPathComponent(), 
					path.getLastPathComponent()),
				totalCount);
		}
		return null;
	}
	
	private function nextVisibleFHTreeStateNode(info:EnumerationInfo):TreePath{		
		var nextIndex:Int= Std.int(info.nextIndex);
		var parent:FHTreeStateNode = info.parent;
		var retObject:TreePath;
		if(nextIndex == -1){
			retObject = parent.getTreePath();
		}else{
			var  node:FHTreeStateNode = parent.getChildAtModelIndex(nextIndex);
			if(node == null){
				retObject = parent.getTreePath().pathByAddingChild(
								treeModel.getChild(parent.getUserObject(),
								nextIndex));
			}else{
				retObject = node.getTreePath();
			}
		}
		updateNextObject(info);
		info.enumCount--;
		return retObject;
	}
	private function hasMoreVisibleFHTreeStateNode(info:EnumerationInfo):Bool{
		return info.enumCount > 0 && info.parent != null;
	}
	
	private function updateNextObject(info:EnumerationInfo):Void{
		if(!updateNextIndex(info)) {
			findNextValidParent(info);
		}
	}
	private function updateNextIndex(info:EnumerationInfo):Bool{
		if(info.nextIndex == -1 && !info.parent.isExpanded()) {
			return false;
		}
		if(info.childCount == 0) {// Check that it can have kids
			return false;
		}
		
		info.nextIndex++;
		
		if(info.nextIndex >= info.childCount) {// Make sure next index not beyond child count.
			return false;
		}
		var child:FHTreeStateNode = info.parent.getChildAtModelIndex(Std.int(info.nextIndex));

		if(child != null && child.isExpanded()) {
			info.parent = child;
			info.nextIndex = -1;
			info.childCount = treeModel.getChildCount(child.getUserObject());
		}
		return true;
	}
	private function findNextValidParent(info:EnumerationInfo):Bool{
		if(info.parent == root) {
			// mark as invalid!
			info.parent = null;
			return false;
		}
		while(info.parent != null) {
			var newParent:FHTreeStateNode = AsWingUtils.as(info.parent.getParent(),FHTreeStateNode);
	
			if(newParent != null) {
				info.nextIndex = info.parent.getChildIndex();
				info.parent = newParent;
				info.childCount = treeModel.getChildCount(info.parent.getUserObject());
				if(updateNextIndex(info))
					return true;
			}else
				info.parent = null;
		}
		return false;
	}
	
	private function getVisibleFHTreeStateNodes(parent:FHTreeStateNode, startIndex:Int, totalCount:Int):Array<Dynamic>{
		var nodes:Array<Dynamic>= new Array<Dynamic>();
		var info:EnumerationInfo = new EnumerationInfo();
		info.parent = parent;
		info.nextIndex = startIndex;
		info.childCount = treeModel.getChildCount(parent.getUserObject());
		info.enumCount = totalCount;
		while(hasMoreVisibleFHTreeStateNode(info)){
			nodes.push(nextVisibleFHTreeStateNode(info));
		}
		return nodes;
	}

	/**
	 * Marks the path <code>path</code> expanded state to
	 * <code>isExpanded</code>.
	 */
	override public function setExpandedState(path:TreePath, isExpanded:Bool):Void{
		if(isExpanded)	{
			ensurePathIsExpanded(path, true);
		}else if(path != null) {
			var parentPath:TreePath = path.getParentPath();
	
			// YECK! Make the parent expanded.
			if(parentPath != null) {
				var parentNode:FHTreeStateNode = getNodeForPath(parentPath, false, true);
				if(parentNode != null)
					parentNode.makeVisible();
			}
			// And collapse the child.
			var childNode:FHTreeStateNode = getNodeForPath(path, true, false);
	
			if(childNode != null){
				childNode.collapse(true);
			}
		}
	}

	/**
	 * Returns true if the path is expanded, and visible.
	 */
	override public function getExpandedState(path:TreePath):Bool{
		var node:FHTreeStateNode = getNodeForPath(path, true, false);
	
		return (node != null) ? (node.isVisible() && node.isExpanded()) : false;
	}

	//
	// TreeModelListener methods
	//

	/**
	 * <p>Invoked after a node (or a set of siblings) has changed in some
	 * way. The node(s) have not changed locations in the tree or
	 * altered their children arrays, but other attributes have
	 * changed and may affect presentation. Example: the name of a
	 * file has changed, but it is in the same location in the file
	 * system.</p>
	 *
	 * <p>e.path() returns the path the parent of the changed node(s).</p>
	 *
	 * <p>e.childIndices() returns the index(es) of the changed node(s).</p>
	 */
	override public function treeNodesChanged(e:TreeModelEvent):Void{
		if(e != null) {
			var changedIndexs:Array<Dynamic>;
			var changedParent:FHTreeStateNode = getNodeForPath(e.getTreePath(), false, false);
			var maxCounter:Int;
	
			changedIndexs = e.getChildIndices();
			/* Only need to update the children if the node has been
			   expanded once. */
			// PENDING(scott): make sure childIndexs is sorted!
			if (changedParent != null) {
				if (changedIndexs != null && (maxCounter = changedIndexs.length) > 0) {
					var parentValue:Dynamic= changedParent.getUserObject();
		
					for(counter in 0...maxCounter){
						var child:FHTreeStateNode = changedParent.getChildAtModelIndex(changedIndexs[counter]);
			
						if(child != null) {
							child.setUserObject(treeModel.getChild(parentValue, changedIndexs[counter]));
						}
					}
					if(changedParent.isVisible() && changedParent.isExpanded()){
						visibleNodesChanged();
					}
				}
				// Null for root indicates it changed.
				else if (changedParent == root && changedParent.isVisible() &&
					 changedParent.isExpanded()) {
					visibleNodesChanged();
				}
			}
		}
	}

	/**
	 * <p>Invoked after nodes have been inserted into the tree.</p>
	 *
	 * <p>e.path() returns the parent of the new nodes
	 * <p>e.childIndices() returns the indices of the new nodes in
	 * ascending order.
	 */
	override public function treeNodesInserted(e:TreeModelEvent):Void{
		if(e != null) {
			var changedIndexs:Array<Dynamic>;
			var changedParent:FHTreeStateNode = getNodeForPath(e.getTreePath(), false, false);
			var maxCounter:Int;
	
			changedIndexs = e.getChildIndices();
			/* Only need to update the children if the node has been
			   expanded once. */
			// PENDING(scott): make sure childIndexs is sorted!
			if(changedParent != null && changedIndexs != null && (maxCounter = changedIndexs.length) > 0) {
				var isVisible:Bool= (changedParent.isVisible() && changedParent.isExpanded());
		
				for(counter in 0...maxCounter){
					changedParent.childInsertedAtModelIndex(changedIndexs[counter], isVisible);
				}
				if(isVisible && treeSelectionModel != null)
					treeSelectionModel.resetRowSelection();
				if(changedParent.isVisible())
					visibleNodesChanged();
			}
		}
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
	 */
	override public function treeNodesRemoved(e:TreeModelEvent):Void{
		if(e != null) {
			var changedIndexs:Array<Dynamic>;
			var maxCounter:Int;
			var parentPath:TreePath = e.getTreePath();
			var changedParentNode:FHTreeStateNode = getNodeForPath(parentPath, false, false);
	
			changedIndexs = e.getChildIndices();
			// PENDING(scott): make sure that changedIndexs are sorted in
			// ascending order.
			if(changedParentNode != null && changedIndexs != null && (maxCounter = changedIndexs.length) > 0) {

			var isVisible:Bool= (changedParentNode.isVisible() &&
				 changedParentNode.isExpanded());
	
			for(counter in 0...maxCounter  ){
				changedParentNode.removeChildAtModelIndex(changedIndexs[counter], isVisible);
			}
			if(isVisible)	{
				if(treeSelectionModel != null){
					treeSelectionModel.resetRowSelection();
				}
				if (treeModel.getChildCount(changedParentNode.getUserObject()) == 0 && changedParentNode.isLeaf()) {
					// Node has become a leaf, collapse it.
					changedParentNode.collapse(false);
				}
				visibleNodesChanged();
			}else if(changedParentNode.isVisible())
				visibleNodesChanged();
			}
		}
	}

	/**
	 * <p>Invoked after the tree has drastically changed structure from a
	 * given node down.  If the path returned by e.getPath() is of length
	 * one and the first element does not identify the current root node
	 * the first element should become the new root of the tree.<p>
	 *
	 * <p>e.path() holds the path to the node.</p>
	 * <p>e.childIndices() returns null.</p>
	 */
	override public function treeStructureChanged(e:TreeModelEvent):Void{
		if(e != null) {
			var changedPath:TreePath = e.getTreePath();
			var changedNode:FHTreeStateNode = getNodeForPath(changedPath, false, false);
	
			// Check if root has changed, either to a null root, or
				// to an entirely new root.
			if (changedNode == root ||
					(changedNode == null &&
					 ((changedPath == null && treeModel != null &&
					   treeModel.getRoot() == null) ||
					  (changedPath != null && changedPath.getPathCount() <= 1)))) {
					rebuild(true);
				}else if(changedNode != null) {
					var wasExpanded:Bool, wasVisible:Bool;
					var parent:FHTreeStateNode = AsWingUtils.as(changedNode.getParent(),FHTreeStateNode);
	
					wasExpanded = changedNode.isExpanded();
					wasVisible = changedNode.isVisible();
	
					var index:Int= parent.getIndex(changedNode);
					changedNode.collapse(false);
					parent.removeAt(index);
	
					if(wasVisible && wasExpanded) {
						var row:Int= changedNode.getRow();
						parent.resetChildrenRowsFrom(row, index, changedNode.getChildIndex());
						changedNode = getNodeForPath(changedPath, false, true);
						changedNode.expand();
					}
					if(treeSelectionModel != null && wasVisible && wasExpanded){
						treeSelectionModel.resetRowSelection();
					}
					if(wasVisible)	{
						visibleNodesChanged();
					}
			}
		}
	}


	//
	// Local methods
	//

	private function visibleNodesChanged():Void{
	}

	/**
	 * Returns the bounds for the given node. If <code>childIndex</code>
	 * is -1, the bounds of <code>parent</code> are returned, otherwise
	 * the bounds of the node at <code>childIndex</code> are returned.
	 */
	private function getBounds2(parent:FHTreeStateNode, childIndex:Int, placeIn:IntRectangle):IntRectangle {
		var expanded:Bool;
		var level:Int;
		var row:Int;
		var value:Dynamic;
	
		if(childIndex == -1) {
			// Getting bounds for parent
			row = parent.getRow();
			value = parent.getUserObject();
			expanded = parent.isExpanded();
			level = parent.getLevel();
		}else {
			row = parent.getRowToModelIndex(childIndex);
			value = treeModel.getChild(parent.getUserObject(), childIndex);
			expanded = false;
			level = parent.getLevel() + 1;
		}
	
		var bounds:IntRectangle = countNodeDimensions(value, row, level, expanded, boundsBuffer);
		// No node dimensions, bail.
		if(bounds == null){
			return null;
		}
		if(placeIn == null){
			placeIn = new IntRectangle();
		}
		placeIn.x = bounds.x;
		placeIn.height = getRowHeight();
		placeIn.y = row * placeIn.height;
		placeIn.width = bounds.width;
		return placeIn;
	}

	/**
	 * Adjust the large row count of the AbstractTreeUI the receiver was
	 * created with.
	 */
	public function adjustRowCountBy(changeAmount:Int):Void{
		rowCount += changeAmount;
	}

	/**
	 * Adds a mapping for node.
	 */
	public function addMapping(node:FHTreeStateNode):Void{
		treePathMapping.put(node.getTreePath(), node);
	}

	/**
	 * Removes the mapping for a previously added node.
	 */
	public function removeMapping(node:FHTreeStateNode):Void{
		treePathMapping.remove(node.getTreePath());
	}

	/**
	 * Returns the node previously added for <code>path</code>. This may
	 * return null, if you to create a node use getNodeForPath.
	 */
	private function getMapping(path:TreePath):FHTreeStateNode {
		return AsWingUtils.as(treePathMapping.get(path),FHTreeStateNode);
	}

	/**
	 * Sent to completely rebuild the visible tree. All nodes are collapsed.
	 */
	private function rebuild(clearSelection:Bool):Void{
		var rootUO:Dynamic= null;

		treePathMapping.clear();
		if(treeModel!=null)	rootUO = treeModel.getRoot();
		//trace("rebuild rootUO : " + rootUO);
		if(treeModel != null && rootUO != null) {
			root = createNodeForValue(rootUO, 0);
			//trace("root : " + root);
			root.setPath(new TreePath([rootUO]));
			addMapping(root);
			if(isRootVisible()) {
				rowCount = 1;
				root.setRow(0);
			}else {
				rowCount = 0;
				root.setRow(-1);
			}
			root.expand();
		}else {
			root = null;
			rowCount = 0;
		}
		if(clearSelection && treeSelectionModel != null) {
			treeSelectionModel.clearSelection();
		}
		this.visibleNodesChanged();
	}

	/**
	  * Returns the index of the row containing location.  If there
	  * are no rows, -1 is returned.  If location is beyond the last
	  * row index, the last row index is returned.
	  */
	override public function getRowContainingYLocation(location:Int):Int{
		if(getRowCount() == 0){
			return -1;
		}
		return Math.floor(Math.max(0, Math.min(getRowCount() - 1, location / getRowHeight())));
	}

	/**
	 * Ensures that all the path components in path are expanded, accept
	 * for the last component which will only be expanded if expandLast
	 * is true.
	 * Returns true if succesful in finding the path.
	 */
	private function ensurePathIsExpanded(aPath:TreePath, expandLast:Bool):Bool{
		if(aPath != null) {
			// Make sure the last entry isn't a leaf.
			if(treeModel.isLeaf(aPath.getLastPathComponent())) {
				aPath = aPath.getParentPath();
				expandLast = true;
			}
			if(aPath != null) {
				var lastNode:FHTreeStateNode = getNodeForPath(aPath, false, true);
		
				if(lastNode != null) {
					lastNode.makeVisible();
					if(expandLast)	{
						lastNode.expand();
					}
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * Creates and returns an instance of FHTreeStateNode.
	 */
	public function createNodeForValue(value:Dynamic, childIndex:Int):FHTreeStateNode {
		return new FHTreeStateNode(this, value, childIndex, -1);
	}

	/**
	 * Messages getTreeNodeForPage(path, onlyIfVisible, shouldCreate,
	 * path.length) as long as path is non-null and the length is > 0.
	 * Otherwise returns null.
	 */
	private function getNodeForPath(path:TreePath, onlyIfVisible:Bool, shouldCreate:Bool):FHTreeStateNode {
		if(path != null) {
			var node:FHTreeStateNode;
	
			node = getMapping(path);
			if(node != null) {
				if(onlyIfVisible && !node.isVisible())
					return null;
				return node;
			}
			if(onlyIfVisible)	return null;
	
			// Check all the parent paths, until a match is found.
			var paths:Stack;
	
			if(tempStacks.size() == 0) {
				paths = new Stack();
			}
			else {
				paths = AsWingUtils.as(tempStacks.pop(),Stack);
			}
	
			try {
				paths.push(path);
				path = path.getParentPath();
				node = null;
				while(path != null) {
					node = getMapping(path);
					if(node != null) {
						// Found a match, create entries for all paths in
						// paths.
						while(node != null && paths.size() > 0) {
							path = AsWingUtils.as(paths.pop(),TreePath);
							node = node.createChildFor(path.getLastPathComponent());
						}
						return node;
					}
					paths.push(path);
					path = path.getParentPath();
				}
			}catch(e:Error){
				paths.clear();
				tempStacks.push(paths);
			}
			// If we get here it means they share a different root!
			return null;
		}
		return null;
	}	
}