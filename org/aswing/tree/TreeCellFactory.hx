package org.aswing.tree;
 
/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import org.aswing.tree.TreeCell;

/**
 * TreeCellFactory for create cells for tree
 * @author paling
 */
interface TreeCellFactory {
	/**
	 * Creates a new tree cell.
	 * @return the tree cell
	 */
	function createNewCell():TreeCell;
}