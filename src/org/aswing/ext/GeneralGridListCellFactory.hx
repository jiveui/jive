/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.ext;


/**
 * General factory to generate instance by a class
 */
class GeneralGridListCellFactory implements GridListCellFactory{
	
	private var cellClass:Class<Dynamic>;
	
	public function new(cellClass:Class<Dynamic>){
		this.cellClass = cellClass;
	}

	public function createNewGridListCell():GridListCell{
		return AsWingUtils.as(Type.createInstance( cellClass,[]) , GridListCell);
	}
	
}