/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


/**
 * @author paling
 */
class Resizable3Imp2 implements Resizable3{
	
	private var cm:TableColumnModel;
	private var start:Int;
	private var end:Int;
		
	public function new(cm:TableColumnModel, start:Int, end:Int){
		this.cm = cm;
		this.start = start;
		this.end = end;
	}
	
    public function getElementCount():Int{ 
    	return end-start;
    }
    
    public function getLowerBoundAt(i:Int):Int{ 
    	return cm.getColumn(i+start).getMinWidth(); 
    }
    
    public function getUpperBoundAt(i:Int):Int{ 
    	return cm.getColumn(i+start).getMaxWidth(); 
    }
    
    public function getMidPointAt(i:Int):Int{ 
    	return cm.getColumn(i+start).getWidth(); 
    }
    
    public function setSizeAt(s:Int, i:Int):Void{
    	cm.getColumn(i+start).setWidth(s); 
    }
}