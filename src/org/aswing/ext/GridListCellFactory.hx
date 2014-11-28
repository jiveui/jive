/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.ext;


/**
 * The factory to generate grid list cell instances.
 */
interface GridListCellFactory{
	
	/**
	 * Creates a new list cell.
	 */ 
	function createNewGridListCell():GridListCell;
	
}