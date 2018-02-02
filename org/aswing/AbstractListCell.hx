/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.error.ImpMissError;
	
/**
 * Abstract list cell.
 * @author paling
 */
class AbstractListCell implements ListCell{
	
	private var value:Dynamic;
	private static var AWML_INDEX:Int= 0;
	 
	private var awmlIndex:Int;
	public function new(){
		AWML_INDEX++;
		awmlIndex = AWML_INDEX;
 
    }
  	public function getAwmlIndex():Int{
		return awmlIndex;	
	}
	
	public function setListCellStatus(list : JList, isSelected : Bool, index:Int) : Void{
		var com:Component = getCellComponent();
		if(isSelected)	{
			com.setBackground(list.getSelectionBackground());
			com.setForeground(list.getSelectionForeground());
		}else{
			com.setBackground(list.getBackground());
			com.setForeground(list.getForeground());
		}
		com.setFont(list.getFont());
	}

	public function setCellValue(value:Dynamic) : Void{
		this.value = value;
		
	}

	public function getCellValue():Dynamic{
		return value;
	}
	
	/**
	 * Subclass should override this method
	 */
	public function getCellComponent() : Component {
		throw new ImpMissError();
		return null;
	}
}