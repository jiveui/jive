/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.ext;


import org.aswing.Container;

class GridCellHolder extends Container{
	
	private var list:GridList;
	
	public function new(list:GridList){
		super();
		this.list = list;
	}
	
	public function getList():GridList{
		return list;
	}
}