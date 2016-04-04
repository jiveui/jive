/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

import flash.filters.BitmapFilter;
import org.aswing.JToolTip;
import org.aswing.JLabel;
import org.aswing.Component;
import org.aswing.BorderLayout;
import org.aswing.event.ToolTipEvent;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.BaseComponentUI;

/**
 * @private
 */
class BasicToolTipUI extends BaseComponentUI{
	
	private var tooltip:JToolTip;
	private var label:JLabel;
	
	public function new() {
		super();
	}
	
    override public function installUI(c:Component):Void{
    	tooltip = AsWingUtils.as(c,JToolTip);
        installDefaults();
        initallComponents();
        installListeners();
    }

    private function getPropertyPrefix():String{
        return "ToolTip.";
    }

	private function installDefaults():Void{
        var pp:String= getPropertyPrefix();
        LookAndFeel.installColorsAndFont(tooltip, pp);
        LookAndFeel.installBorderAndBFDecorators(tooltip, pp);
        LookAndFeel.installBasicProperties(tooltip, pp);
		 
        var filters:Array<BitmapFilter>= getInstance(getPropertyPrefix()+"filters")   ;
        tooltip.filters = filters;
		 
	}
	
	private function initallComponents():Void{
		var b:JToolTip = tooltip;
		b.setLayout(new BorderLayout());
		label = new JLabel(b.getTipText());
		label.setOpaque(false);
		label.setFont(null); //make it to use parent(JToolTip) font
		label.setForeground(null); //make it to user parent(JToolTip) foreground
		label.setUIElement(true);
		b.append(label, BorderLayout.CENTER);
	}
	
	private function installListeners():Void{
		tooltip.addEventListener(ToolTipEvent.TIP_TEXT_CHANGED, __tipTextChanged);
	}
	
	override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		//do nothing, let background decorator to do things
	}
	
	private function __tipTextChanged(e:ToolTipEvent):Void{
		label.setText(tooltip.getTipText());
	}
	
    override public function uninstallUI(c:Component):Void{
        uninstallDefaults();
        uninstallListeners();
        uninstallComponents();
    }
    
    private function uninstallDefaults():Void{
    	LookAndFeel.uninstallBorderAndBFDecorators(tooltip);
        tooltip.filters = [];
    }
    
    private function uninstallComponents():Void{
    	tooltip.remove(label);
    	label = null;
    }    
    
    private function uninstallListeners():Void{
    	tooltip.removeEventListener(ToolTipEvent.TIP_TEXT_CHANGED, __tipTextChanged);
    }

	
}