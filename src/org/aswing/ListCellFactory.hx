/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * List cell renderer factory, a ListCellFactory should not change it 
 * return value of these method <code>isAllCellHasSameHeight</code>, 
 * <code>getCellHeight</code> after created. Mean, if one of its instance 
 * method <code>isAllCellHasSameHeight</code> returned false, it should always return false.
 * @author paling
 */
interface ListCellFactory{
	
	/**
	 * Creates a new list cell.
	 */
	function createNewCell():ListCell;
	
	/**
	 * Returns is all cells has same height.
	 * <p> If all cells has same height, the List component will has more efficient on speed.
	 * <p> If this method return true, the List component will set all list cells height 
	 * what <code>getCellHeight</code> returned, 
	 * otherwise, the <code>getPreferredSize()</code> of list cell's component will be used.
	 * <p> If <code>shareCells</code>, this method must return true.
	 * @see #isShareCells()
	 * @return is all cells has same height.
	 */
	function isAllCellHasSameHeight():Bool;
	
	/**
	 * Returns is list data should share cell instances for items.
	 * <p>If this return true, the List component will just create enough cell instance 
	 * to display viewable items. 
	 * This may cause the List component have shorter time to create, but may get slow when scrolling. 
	 * <p>If this return false, the List component will create cells instances for every value 
	 * of the list. 
	 * This may cause the List component have hard time to create with huge list, but may get fast when scrolling. 
	 * <p>Ordinary, if your List component will hold a very huge list(more than 100), you many need a <code>allCellHasSameHeight</code> 
	 * and <code>shareCells</code> factory. If your list will just hold a small list(less than 50), and you want a smooth scrolling, 
	 * you may need a not <code>shareCells</code> factory, and in this case, <code>allCellHasSameHeight</code> is not matter 
	 * with speed, just matter whether you need different height items.
	 * <p><b>Note that if <code>shareCells</code>, <code>allCellHasSameHeight</code> must be true</b>
	 * @return is share cell instances.
	 * @see #createNewCell()
	 */
	function isShareCells():Bool;
	
	/**
	 * If <code>isAllCellHasSameHeight</code> or <code>isShareCells</code> returns true, 
	 * this method will be used, it returned value means each cell's same height.
	 * @return the height for every cells
	 */
	function getCellHeight():Int;
}