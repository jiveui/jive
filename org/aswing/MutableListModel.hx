/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * MutableListMode is a MVC pattern's mode for List UI, different List UI can connected to 
 * a same mode to view the mode's data. When the mode's data changed the mode should
 * fire a event to all its ListDataListeners.
 * @author bill
 */
interface MutableListModel extends ListModel{

	/**
	 * Inserts a element at specified position.
	 */
	function insertElementAt(item:Dynamic, index:Int):Void;
	
	/**
	 * Removes a element from a specified position.
	 */
	function removeElementAt (index:Int):Void;
}