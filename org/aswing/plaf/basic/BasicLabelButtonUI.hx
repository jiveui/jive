package org.aswing.plaf.basic;


import org.aswing.AbstractButton;
	import org.aswing.ASColor;
	import org.aswing.JLabelButton;
	import org.aswing.StyleResult;
	import org.aswing.ButtonModel;
	import org.aswing.Component;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.plaf.UIResource;

/**
 * @private
 */
class BasicLabelButtonUI extends BasicButtonUI{
	
	public function new(){
		super();
	}
	
    override private function getPropertyPrefix():String{
        return "LabelButton.";
    }
	
	override private function installDefaults(bb:AbstractButton):Void{
		super.installDefaults(bb);
		#if(flash9)
    	bb.buttonMode = true;
		#end
	}
	
    override private function getTextPaintColor(bb:AbstractButton):ASColor{
    	var b:JLabelButton = AsWingUtils.as(bb,JLabelButton)	;
		var pp:String= getPropertyPrefix();
		var cl:ASColor = bb.getForeground();
		var colors:StyleResult = new StyleResult(cl, bb.getStyleTune());
		
		var overColor:ASColor = b.getRollOverColor();
    	if(overColor == null || Std.is(overColor,UIResource)){
    		overColor = colors.clight;
    	}
    	var downColor:ASColor = b.getPressedColor();
    	if(downColor == null || Std.is(downColor,UIResource)){
    		downColor = colors.cdark;
    	}
    	
    	if(b.isEnabled()){
    		var model:ButtonModel = b.getModel();
    		if(model.isSelected() || (model.isPressed() && model.isArmed())){
    			return downColor;
    		}else if(b.isRollOverEnabled() && model.isRollOver()){
    			return overColor;
    		}
    		return cl;
    	}else{
    		return BasicGraphicsUtils.getDisabledColor(b);
    	}
    }
    
    /**
     * paint normal bg
     */
	override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(c.isOpaque()){
			g.fillRectangle(new SolidBrush(c.getBackground()), b.x, b.y, b.width, b.height);
		}		
	}
}