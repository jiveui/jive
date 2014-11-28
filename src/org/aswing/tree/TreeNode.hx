/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

/**
 * Defines the requirements for an object that can be used as a
 * tree node in a JTree.
 * 
 * @author paling
 * @see org.aswing.tree.MutableTreeNode
 * @see org.aswing.tree.DefaultMutableTreeNode
 * @see org.aswing.JTree
 */
interface TreeNode {
	function getAwmlIndex():Int;
    /**
     * Returns the child <code>TreeNode</code> at index 
     * <code>childIndex</code>.
     */
    function getChildAt(childIndex:Int):TreeNode;

    /**
     * Returns the number of children <code>TreeNode</code>s the receiver
     * contains.
     */
    function getChildCount():Int;

    /**
     * Returns the parent <code>TreeNode</code> of the receiver.
     */
    function getParent():TreeNode;

    /**
     * Returns the index of <code>node</code> in the receivers children.
     * If the receiver does not contain <code>node</code>, -1 will be
     * returned.
     */
    function getIndex(node:TreeNode):Int;

    /**
     * Returns true if the receiver allows children.
     */
    function getAllowsChildren():Bool;

    /**
     * Returns true if the receiver is a leaf.
     */
    function isLeaf():Bool;

    /**
     * Returns the children of the receiver as an <code>Enumeration</code>.
     */
    function children():Array<Dynamic>;
}