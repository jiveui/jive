/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


/**
 * @author paling
 */
class Resizable3Imp1 implements Resizable3{
	
	private var cm:TableColumnModel;
	private var inverse:Bool;
		
	public function new(cm:TableColumnModel, inverse:Bool){
		this.cm = cm;
		this.inverse = inverse;
	}
	
    public function getElementCount():Int{ 
    	return cm.getColumnCount(); 
    }
    
    public function getLowerBoundAt(i:Int):Int{ 
    	return cm.getColumn(i).getMinWidth(); 
    }
    
    public function getUpperBoundAt(i:Int):Int{ 
    	return cm.getColumn(i).getMaxWidth(); 
    }
    
    public function getMidPointAt(i:Int):Int{
        if(inverse!=true) {
	    	return cm.getColumn(i).getPreferredWidth();
        }else {
	    	return cm.getColumn(i).getWidth();
        }
    }
    
    public function setSizeAt(s:Int, i:Int):Void{
        if(inverse!=true) {
			cm.getColumn(i).setWidth(s);
        }else {
			cm.getColumn(i).setPreferredWidth(s);
        }
    }
}