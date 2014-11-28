/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

import org.aswing.error.Error;
import org.aswing.event.TreeModelEvent;
import org.aswing.event.TreeModelListener;
import org.aswing.tree.MutableTreeNode;
import org.aswing.tree.TreeModel;
import org.aswing.tree.TreeNode;
import org.aswing.tree.TreePath;
import org.aswing.util.ArrayUtils;

/**
 * A simple tree data model that uses TreeNodes.
 * 
 * @see org.aswing.tree.DefaultMutableTreeNode
 * @author paling
 */
class DefaultTreeModel implements TreeModel {
    /** Root of the tree. */
    private var root:TreeNode;
    /** Listeners. */
    private var listenerList:Array<Dynamic>;
    /**
      * Determines how the <code>isLeaf</code> method figures
      * out if a node is a leaf node. If true, a node is a leaf 
      * node if it does not allow children. (If it allows 
      * children, it is not a leaf node, even if no children
      * are present.) That lets you distinguish between <i>folder</i>
      * nodes and <i>file</i> nodes in a file system, for example.
      * <p>
      * If this value is false, then any node which has no 
      * children is a leaf node, and any node may acquire 
      * children.
      *
      * @see TreeNode#getAllowsChildren()
      * @see TreeModel#isLeaf()
      * @see #setAsksAllowsChildren()
      */
    private var _asksAllowsChildren:Bool;

    /**
      * Creates a tree specifying whether any node can have children,
      * or whether only certain nodes can have children.
      *
      * @param root a TreeNode object that is the root of the tree
      * @param asc (optional)a boolean, false if any node can
      *        have children, true if each node is asked to see if
      *        it can have children. Default is false.
      * @see #asksAllowsChildren
      */
    public function new(root:TreeNode, asc:Bool=false) {
        this.root = root;
        _asksAllowsChildren = asc;
        listenerList = new Array<Dynamic>();
    }

    /**
      * Sets whether or not to test leafness by asking getAllowsChildren()
      * or isLeaf() to the TreeNodes.  If newvalue is true, getAllowsChildren()
      * is messaged, otherwise isLeaf() is messaged.
      */
    public function setAsksAllowsChildren(newValue:Bool):Void{
        _asksAllowsChildren = newValue;
    }

    /**
      * Tells how leaf nodes are determined.
      *
      * @return true if only nodes which do not allow children are
      *         leaf nodes, false if nodes which have no children
      *         (even if allowed) are leaf nodes
      * @see #asksAllowsChildren
      */
    public function asksAllowsChildren():Bool{
        return _asksAllowsChildren;
    }

    /**
     * Sets the root to <code>root</code>. A null <code>root</code> implies
     * the tree is to display nothing, and is legal.
     */
    public function setRoot(root:TreeNode):Void{
        var oldRoot:Dynamic= this.root;
		this.root = root;
        if (root == null && oldRoot != null) {
            fireTreeStructureChanged2(this, null);
        }else {
            nodeStructureChanged(root);
        }
    }

    /**
     * Returns the root of the tree.  Returns null only if the tree has
     * no nodes.
     *
     * @return  the root of the tree
     */
    public function getRoot():TreeNode{
        return root;
    }

    /**
     * Returns the index of child in parent.
     * If either the parent or child is <code>null</code>, returns -1.
     * @param parent a note in the tree, obtained from this data source
     * @param child the node we are interested in
     * @return the index of the child in the parent, or -1
     *    if either the parent or the child is <code>null</code>
     */
    public function getIndexOfChild(parent:TreeNode, child:Dynamic):Int{
        if(parent == null || child == null)
            return -1;
        return (AsWingUtils.as(parent,TreeNode)).getIndex(AsWingUtils.as(child,TreeNode));
    }

    /**
     * Returns the child of <I>parent</I> at index <I>index</I> in the parent's
     * child array.  <I>parent</I> must be a node previously obtained from
     * this data source. This should not return null if <i>index</i>
     * is a valid index for <i>parent</i> (that is <i>index</i> >= 0 &&
     * <i>index</i> < getChildCount(<i>parent</i>)).
     *
     * @param   parent  a node in the tree, obtained from this data source
     * @return  the child of <I>parent</I> at index <I>index</I>
     */
    public function getChild(parent:TreeNode, index:Int):Dynamic{
        return (AsWingUtils.as(parent,TreeNode)).getChildAt(index);
    }

    /**
     * Returns the number of children of <I>parent</I>.  Returns 0 if the node
     * is a leaf or if it has no children.  <I>parent</I> must be a node
     * previously obtained from this data source.
     *
     * @param   parent  a node in the tree, obtained from this data source
     * @return  the number of children of the node <I>parent</I>
     */
    public function getChildCount(parent:TreeNode):Int{
        return (AsWingUtils.as(parent,TreeNode)).getChildCount();
    }

    /** 
     * Returns whether the specified node is a leaf node.
     * The way the test is performed depends on the
     * <code>askAllowsChildren</code> setting.
     *
     * @param node the node to check
     * @return true if the node is a leaf node
     *
     * @see #asksAllowsChildren
     * @see TreeModel#isLeaf
     */
    public function isLeaf(node:TreeNode):Bool{
        if(asksAllowsChildren()){
            return !(AsWingUtils.as(node,TreeNode)).getAllowsChildren();
        }
        return (AsWingUtils.as(node,TreeNode)).isLeaf();
    }

    /**
      * This sets the user object of the TreeNode identified by path
      * and posts a node changed.  If you use custom user objects in
      * the TreeModel you're going to need to subclass this and
      * set the user object of the changed node to something meaningful.
      */
    public function valueForPathChanged(path:TreePath, newValue:Dynamic):Void{
		var aNode:MutableTreeNode =AsWingUtils.as(path.getLastPathComponent(), MutableTreeNode);

        aNode.setUserObject(newValue);
        nodeChanged(aNode);
    }

    /**
     * Invoked this to insert newChild at location index in parents children.
     * This will then message nodesWereInserted to create the appropriate
     * event. This is the preferred way to add children as it will create
     * the appropriate event.
     */
    public function insertNodeInto(newChild:MutableTreeNode,
                               parent:MutableTreeNode, index:Int):Void{
        parent.insert(newChild, index);

        nodesWereInserted(parent, [index]);
    }

    /**
     * Message this to remove node from its parent. This will message
     * nodesWereRemoved to create the appropriate event. This is the
     * preferred way to remove a node as it handles the event creation
     * for you.
     */
    public function removeNodeFromParent(node:MutableTreeNode):Void{
        var parent:MutableTreeNode = AsWingUtils.as(node.getParent(), MutableTreeNode);

        if(parent == null){
        	trace("Error : node does not have a parent.");
            throw new Error("node does not have a parent.");
        }

        var childIndex:Array<Dynamic>= [parent.getIndex(node)];
        parent.removeAt(childIndex[0]);
        var removedArray:Array<Dynamic>= [node];
        nodesWereRemoved(parent, childIndex, removedArray);
    }

    /**
      * Invoke this method after you've changed how node is to be
      * represented in the tree.
      */
    public function nodeChanged(node:TreeNode):Void{
        if(listenerList != null && node != null) {
            var parent:TreeNode = node.getParent();
            if(parent != null) {
                var anIndex:Int= parent.getIndex(node);
                if(anIndex != -1) {
                     nodesChanged(parent, [anIndex]);
                }
            }else if (node == getRoot()) {
				nodesChanged(node, null);
	    	}
        }
    }

    /**
     * Invoke this method if you've modified the TreeNodes upon which this
     * model depends.  The model will notify all of its listeners that the
     * model has changed below the node <code>node</code> (PENDING).
     * @param node (optional). Default is root.
     */
    public function reload(node:TreeNode=null):Void{
    	if(node == null) node = root;
        if(node != null) {
            fireTreeStructureChanged(this, getPathToRoot(node), null, null);
        }
    }

    /**
      * Invoke this method after you've inserted some TreeNodes into
      * node.  childIndices should be the index of the new elements and
      * must be sorted in ascending order.
      */
    public function nodesWereInserted(node:TreeNode, childIndices:Array<Dynamic>):Void{
        if(listenerList != null && node != null && childIndices != null && childIndices.length > 0) {
            var cCount:Int= childIndices.length;
            var newChildren:Array<Dynamic>= new Array<Dynamic>();

            for(counter in 0...cCount){
                newChildren[counter] = node.getChildAt(childIndices[counter]);
            }
            fireTreeNodesInserted(this, getPathToRoot(node), childIndices, newChildren);
        }
    }
    
    /**
      * Invoke this method after you've removed some TreeNodes from
      * node.  childIndices should be the index of the removed elements and
      * must be sorted in ascending order. And removedChildren should be
      * the array of the children objects that were removed.
      */
    public function nodesWereRemoved(node:TreeNode, childIndices:Array<Dynamic>, removedChildren:Array<Dynamic>):Void{
        if(node != null && childIndices != null) {
            fireTreeNodesRemoved(this, getPathToRoot(node), childIndices, removedChildren);
        }
    }

    /**
      * Invoke this method after you've changed how the children identified by
      * childIndicies are to be represented in the tree.
      */
    public function nodesChanged(node:TreeNode, childIndices:Array<Dynamic>):Void{
        if(node != null) {
			if (childIndices != null) {
				var cCount:Int= childIndices.length;
				if(cCount > 0) {
			    	var cChildren:Array<Dynamic>= new Array<Dynamic>();
	 				for(counter in 0...cCount){
						cChildren[counter] = node.getChildAt(childIndices[counter]);
	 				}
			    	fireTreeNodesChanged(this, getPathToRoot(node), childIndices, cChildren);
				}
			}else if (node == getRoot()) {
				fireTreeNodesChanged(this, getPathToRoot(node), null, null);
		    }
        }
    }

    /**
      * Invoke this method if you've totally changed the children of
      * node and its childrens children...  This will post a
      * treeStructureChanged event.
      */
    public function nodeStructureChanged(node:TreeNode):Void{
        if(node != null) {
           fireTreeStructureChanged(this, getPathToRoot(node), null, null);
        }
    }

    /**
     * Builds the parents of node up to and including the root node,
     * where the original node is the last element in the returned array.
     * The length of the returned array gives the node's depth in the
     * tree.
     * 
     * @param aNode  the TreeNode to get the path for
     * @param depth  (optional)an int giving the number of steps already taken towards
     *        the root (on recursive calls), used to size the returned array. Default is 0.
     * @return an array of TreeNodes giving the path from the root to the
     *         specified node 
     */
    private function getPathToRoot(aNode:TreeNode, depth:Int=0):Array<TreeNode>{
		var retNodes:Array<TreeNode>;
		// This method recurses, traversing towards the root in order
		// size the array. On the way back, it fills in the nodes,
		// starting from the root and working back to the original node.

        /* Check for null, in case someone passed in a null node, or
           they passed in an element that isn't rooted at root. */
        if(aNode == null) {
            if(depth == 0){
                return null;
            }else{
                retNodes = new Array<TreeNode>();
            }
        } else {
            depth++;
            if(aNode == root){
                retNodes = new Array<TreeNode>();
            }else{
                retNodes = getPathToRoot(aNode.getParent(), depth);
            }
            retNodes[retNodes.length - depth] = aNode;
        }
        return retNodes;
    }

    //
    //  Events
    //

    /**
     * Adds a listener for the TreeModelEvent posted after the tree changes.
     *
     * @see     #removeTreeModelListener
     * @param   l       the listener to add
     */
    public function addTreeModelListener(l:TreeModelListener):Void{
        listenerList.push(l);
    }

    /**
     * Removes a listener previously added with <B>addTreeModelListener()</B>.
     *
     * @see     #addTreeModelListener
     * @param   l       the listener to remove
     */  
    public function removeTreeModelListener(l:TreeModelListener):Void{
    	ArrayUtils.removeFromArray(listenerList, l);
    }

    /**
     * Notifies all listeners that have registered interest for
     * notification on this event type.  The event instance 
     * is lazily created using the parameters passed into 
     * the fire method.
     *
     * @param source the node being changed
     * @param path the path to the root node
     * @param childIndices the indices of the changed elements
     * @param children the changed elements
     * @see EventListenerList
     */
    private function fireTreeNodesChanged(source:Dynamic, path:Array<TreeNode>, 
                                        childIndices:Array<Dynamic>, 
                                        children:Array<Dynamic>):Void{
        var listeners:Array<Dynamic>= listenerList;
        var e:TreeModelEvent = null;
        // Process the listeners last to first, notifying
        // those that are interested in this event
        for (i in 0...listeners.length ){
            // Lazily create the event:
            if (e == null){
                e = new TreeModelEvent(source, new TreePath(path), childIndices, children);
            }
            var lis:TreeModelListener = AsWingUtils.as(listeners[i],TreeModelListener);
            lis.treeNodesChanged(e);   
        }
    }

    /**
     * Notifies all listeners that have registered interest for
     * notification on this event type.  The event instance 
     * is lazily created using the parameters passed into 
     * the fire method.
     *
     * @param source the node where new elements are being inserted
     * @param path the path to the root node
     * @param childIndices the indices of the new elements
     * @param children the new elements
     * @see EventListenerList
     */
    private function fireTreeNodesInserted(source:Dynamic, path:Array<TreeNode>, 
                                        childIndices:Array<Dynamic>, 
                                        children:Array<Dynamic>):Void{
        var listeners:Array<Dynamic>= listenerList;
        var e:TreeModelEvent = null;
        // Process the listeners last to first, notifying
        // those that are interested in this event
        for (i in 0...listeners.length ){
            // Lazily create the event:
            if (e == null){
                e = new TreeModelEvent(source, new TreePath(path), childIndices, children);
            }
            var lis:TreeModelListener = AsWingUtils.as(listeners[i],TreeModelListener);
            lis.treeNodesInserted(e);
        }
    }

    /**
     * Notifies all listeners that have registered interest for
     * notification on this event type.  The event instance 
     * is lazily created using the parameters passed into 
     * the fire method.
     *
     * @param source the node where elements are being removed
     * @param path the path to the root node
     * @param childIndices the indices of the removed elements
     * @param children the removed elements
     * @see EventListenerList
     */
    private function fireTreeNodesRemoved(source:Dynamic, path:Array<TreeNode>, 
                                        childIndices:Array<Dynamic>, 
                                        children:Array<Dynamic>):Void{
        var listeners:Array<Dynamic>= listenerList;
        var e:TreeModelEvent = null;
        // Process the listeners last to first, notifying
        // those that are interested in this event
        for (i in 0...listeners.length ){
            // Lazily create the event:
            if (e == null){
                e = new TreeModelEvent(source, new TreePath(path), childIndices, children);
            }
            var lis:TreeModelListener = AsWingUtils.as(listeners[i],TreeModelListener);
            lis.treeNodesRemoved(e);
        }
    }

    /**
     * Notifies all listeners that have registered interest for
     * notification on this event type.  The event instance 
     * is lazily created using the parameters passed into 
     * the fire method.
     *
     * @param source the node where the tree model has changed
     * @param path the path to the root node
     * @param childIndices the indices of the affected elements
     * @param children the affected elements
     * @see EventListenerList
     */
    private function fireTreeStructureChanged(source:Dynamic, path:Array<TreeNode>, 
                                        childIndices:Array<Dynamic>, 
                                        children:Array<Dynamic>):Void{
        var listeners:Array<Dynamic>= listenerList;
        var e:TreeModelEvent = null;
        // Process the listeners last to first, notifying
        // those that are interested in this event
        for (i in 0...listeners.length ){
            // Lazily create the event:
            if (e == null){
                e = new TreeModelEvent(source, new TreePath(path), childIndices, children);
            }
            var lis:TreeModelListener = AsWingUtils.as(listeners[i],TreeModelListener);
            lis.treeStructureChanged(e);
        }
    }

    /*
     * Notifies all listeners that have registered interest for
     * notification on this event type.  The event instance 
     * is lazily created using the parameters passed into 
     * the fire method.
     *
     * @param source the node where the tree model has changed
     * @param path the path to the root node
     * @see EventListenerList
     */
    private function fireTreeStructureChanged2(source:Dynamic, path:TreePath):Void{
        var listeners:Array<Dynamic>= listenerList;
        var e:TreeModelEvent = null;
        // Process the listeners last to first, notifying
        // those that are interested in this event
        for (i in 0...listeners.length ){
            // Lazily create the event:
            if (e == null){
                e = new TreeModelEvent(source, path);
            }
            var lis:TreeModelListener = AsWingUtils.as(listeners[i],TreeModelListener);
            lis.treeStructureChanged(e);
        }
    }
    
    public function toString():String{
    	return "DefaultTreeModel[root:" + root + "]";
    }
}