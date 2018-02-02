/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border;


import org.aswing.Border;
import org.aswing.ASColor;
import org.aswing.border.BevelBorder;
import org.aswing.plaf.UIResource;
import org.aswing.Component;
import org.aswing.EditableComponent;
import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;

/**
 * Discard in aswing 2.0(Background raped his job)
 * @private
 */
class ComboBoxBorder extends BevelBorder  implements UIResource{
	
	private var colorInited:Bool;
	
	public function new(){
		super(null, BevelBorder.LOWERED);
		colorInited = false;
	}

	override public function updateBorderImp(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(colorInited!=true){
			setHighlightOuterColor(c.getUI().getColor("ComboBox.light"));
			setHighlightInnerColor(c.getUI().getColor("ComboBox.highlight"));
			setShadowOuterColor(c.getUI().getColor("ComboBox.darkShadow"));
			setShadowInnerColor(c.getUI().getColor("ComboBox.shadow"));
		}
        
    	var box:EditableComponent = AsWingUtils.as(c,EditableComponent)	;
    	if(box != null){
	    	if(box.isEditable()){
	    		setBevelType(BevelBorder.LOWERED);
	    	}else{
	    		setBevelType(BevelBorder.RAISED);
	    	}
    	}
    	super.updateBorderImp(c, g, b);
    }	
	
}