/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * Cell for <code>JList</code>.
 * @see JList
 * @author paling
 */
interface ListCell extends Cell{
	/**
	 * Sets the table cell status, include the owner-JList, isSelected, the cell index.
	 * @param the cell's owner, a JList
	 * @param isSelected true to set the cell selected, false to set not selected.
	 * @param index the index of the list item
	 */
	function setListCellStatus(list:JList, isSelected:Bool, index:Int):Void;
	
	function getAwmlIndex():Int;
}