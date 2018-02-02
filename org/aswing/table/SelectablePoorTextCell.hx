/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


/**
 * Texts in this cell is selectable.
 */
class SelectablePoorTextCell extends PoorTextCell{
	
	public function new(){
		super();
		textField.mouseEnabled = true;
		textField.selectable = true;
	}
	
}