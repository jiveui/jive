/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

import org.aswing.event.TreeModelListener;
import org.aswing.tree.TreePath;

/**
 * The interface that defines a suitable data model for a <code>JTree</code>. 
 * For further information on tree models,
 * including an example of a custom implementation,
 * see <a
 href="http://java.sun.com/docs/books/tutorial/uiswing/components/tree.html">How to Use Trees</a>
 * in <em>The Java Tutorial.</em>
 * <p>
 * <code>JTree</code> and its related classes make extensive use of
 * <code>TreePath</code>s for indentifying nodes in the <code>TreeModel</code>.
 * If a <code>TreeModel</code> returns the same object, as compared by
 * <code>equals</code>, at two different indices under the same parent
 * than the resulting <code>TreePath</code> objects will be considered equal
 * as well. Some implementations may assume that if two
 * <code>TreePath</code>s are equal, they identify the same node. If this
 * condition is not met, painting problems and other oddities may result.
 * In other words, if <code>getChild</code> for a given parent returns
 * the same Object (as determined by <code>equals</code>) problems may
 * result, and it is recommended you avoid doing this.<br>
 * (Fully quoted from java swing's tree doc)
 * 
 * @see TreePath
 * 
 * @author paling
 */
interface TreeModel {
	
    /**
     * Returns the root of the tree.  Returns <code>null</code>
     * only if the tree has no nodes.
     *
     * @return  the root of the tree
     */
    function getRoot():TreeNode;


    /**
     * Returns the child of <code>parent</code> at index <code>index</code>
     * in the parent's
     * child array.  <code>parent</code> must be a node previously obtained
     * from this data source. This should not return <code>null</code>
     * if <code>index</code>
     * is a valid index for <code>parent</code> (that is <code>index >= 0 &&
     * index < getChildCount(parent</code>)).
     *
     * @param   parent  a node in the tree, obtained from this data source
     * @return  the child of <code>parent</code> at index <code>index</code>
     */
    function getChild(parent:TreeNode, index:Int):Dynamic;


    /**
     * Returns the number of children of <code>parent</code>.
     * Returns 0 if the node
     * is a leaf or if it has no children.  <code>parent</code> must be a node
     * previously obtained from this data source.
     *
     * @param   parent  a node in the tree, obtained from this data source
     * @return  the number of children of the node <code>parent</code>
     */
    function getChildCount(parent:TreeNode):Int;


    /**
     * Returns <code>true</code> if <code>node</code> is a leaf.
     * It is possible for this method to return <code>false</code>
     * even if <code>node</code> has no children.
     * A directory in a filesystem, for example,
     * may contain no files; the node representing
     * the directory is not a leaf, but it also has no children.
     *
     * @param   node  a node in the tree, obtained from this data source
     * @return  true if <code>node</code> is a leaf
     */
    function isLeaf(node:TreeNode):Bool;

    /**
      * Messaged when the user has altered the value for the item identified
      * by <code>path</code> to <code>newValue</code>. 
      * If <code>newValue</code> signifies a truly new value
      * the model should post a <code>treeNodesChanged</code> event.
      *
      * @param path path to the node that the user has altered
      * @param newValue the new value from the TreeCellEditor
      */
    function valueForPathChanged(path:TreePath, newValue:Dynamic):Void;

    /**
     * Returns the index of child in parent.  If either <code>parent</code>
     * or <code>child</code> is <code>null</code>, returns -1.
     * If either <code>parent</code> or <code>child</code> don't
     * belong to this tree model, returns -1.
     *
     * @param parent a note in the tree, obtained from this data source
     * @param child the node we are interested in
     * @return the index of the child in the parent, or -1 if either
     *    <code>child</code> or <code>parent</code> are <code>null</code>
     *    or don't belong to this tree model
     */
    function getIndexOfChild(parent:TreeNode, child:Dynamic):Int;

//
//  Change Events
//

    /**
     * Adds a listener for the <code>TreeModelEvent</code>
     * posted after the tree changes.
     *
     * @param   l       the listener to add
     * @see     #removeTreeModelListener()
     */
    function addTreeModelListener(l:TreeModelListener):Void;

    /**
     * Removes a listener previously added with
     * <code>addTreeModelListener</code>.
     *
     * @see     #addTreeModelListener()
     * @param   l       the listener to remove
     */  
    function removeTreeModelListener(l:TreeModelListener):Void;
	
}