/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

import org.aswing.tree.TreeCell;
import org.aswing.tree.TreeCellFactory;

/**
 * @author paling
 */
class GeneralTreeCellFactory implements TreeCellFactory {
		
	private var cellClass:Class<Dynamic>;
	
	/**
	 * Creates a GeneralTreeCellFactory with specified cell class.
	 * @param cellClass the cell class
	 */
	public function new(cellClass:Class<Dynamic>){
		this.cellClass = cellClass;
	}
	
	/**
	 * Creates and returns a new tree cell.
	 * @return the tree cell
	 */
	public function createNewCell():TreeCell{
		return AsWingUtils.as(Type.createInstance( cellClass,[]) , TreeCell);  
	}
	
	public function toString():String{
		return "GeneralTreeCellFactory[cellClass:" + cellClass + "]";
	}
}