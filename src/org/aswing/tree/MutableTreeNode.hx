/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

import org.aswing.tree.TreeNode;

/**
 * Defines the requirements for a tree node object that can change --
 * by adding or removing child nodes, or by changing the contents
 * of a user object stored in the node.
 * 
 * @author paling
 * @see org.aswing.tree.DefaultMutableTreeNode
 * @see org.aswing.JTree
 */
interface MutableTreeNode extends TreeNode{
	
    /**
     * Adds <code>child</code> to the receiver at <code>index</code>.
     * <code>child</code> will be messaged with <code>setParent</code>.
     */
    function insert(child:MutableTreeNode, index:Int):Void;

    /**
     * Removes the child at <code>index</code> from the receiver.
     */
    function removeAt(index:Int):Void;

    /**
     * Removes <code>node</code> from the receiver. <code>setParent</code>
     * will be messaged on <code>node</code>.
     */
    function remove(node:MutableTreeNode):Void;

    /**
     * Resets the user object of the receiver to <code>object</code>.
     */
    function setUserObject(object:TreeNode):Void;
	
	/**
	 * Returns the user object.
	 */
	function getUserObject():TreeNode;
	
    /**
     * Removes the receiver from its parent.
     */
    function removeFromParent():Void;

    /**
     * Sets the parent of the receiver to <code>newParent</code>.
     */
    function setParent(newParent:MutableTreeNode):Void;
}