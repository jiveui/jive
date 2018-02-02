/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing;


/**
 * The default list cell factory for text cells.
 * @author paling
 */
class DefaultListTextCellFactory implements ListCellFactory{
	
	private var listCellClass:Class<Dynamic>;
	private var shareCelles:Bool;
	private var cellHeight:Int;
	private var sameHeight:Bool;
	
	/**
	 * Create a list cell(with text renderer) factory with a list cell class and other properties.
	 * @param listCellClass the ListCell implementation, for example com.xlands.ui.list.UserListCell
	 * @param shareCelles (optional)is share cells for list items, default is true.
	 * @param sameHeight (optional)is all cells with same height, default is true.
	 * @param height (optional)the height for all cells if sameHeight, if not <code>sameHeight</code>, 
	 * this param can be miss, default is -1, it means will use a sample to count at the first time.
	 * @see #isShareCells()
	 */	
	public function new(listCellClass:Class<Dynamic>, shareCelles:Bool=true, sameHeight:Bool=true, height:Int=-1){
		this.listCellClass = listCellClass;
		this.shareCelles = shareCelles;
		this.sameHeight = sameHeight;
		
		cellHeight = height;
	}
	
	public function createNewCell() : ListCell {
		return AsWingUtils.as( Type.createInstance( listCellClass,[]),ListCell);
	}
	
	/**
	 * @see ListCellFactory#isAllCellHasSameHeight()
	 */
	public function isAllCellHasSameHeight() : Bool{
		return sameHeight;
	}
	
	/**
	 * @return is share cells for items.
	 * @see ListCellFactory#isShareCells()
	 */
	public function isShareCells() : Bool{
		return shareCelles;
	}
	
	/**
	 * Sets the height for all cells
	 */
	public function setCellHeight(h:Int):Void{
		cellHeight = h;
	}
	
	/**
	 * Returns the height for all cells
	 * @see ListCellFactory#getCellHeight()
	 */
	public function getCellHeight() : Int{
		if(cellHeight < 0){
			var cell:ListCell = createNewCell();
			cell.setCellValue("JjHhWpqQ1@|");
			cellHeight = cell.getCellComponent().getPreferredSize().height;
		}
		return cellHeight;
	}
	
}