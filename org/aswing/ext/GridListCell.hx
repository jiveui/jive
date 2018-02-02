/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.ext;


import org.aswing.Cell;

interface GridListCell extends Cell{
	
	/**
	 * Sets the table cell status
	 * @param gridList the cell's owner, a GridList
	 * @param selected true to set the cell selected, false to set not selected.
	 * @param index the index of this cell
	 */
	function setGridListCellStatus(gridList:GridList, selected:Bool, index:Int):Void;
	
	function getAwmlIndex():Int;
}