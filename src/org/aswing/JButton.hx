/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.display.DisplayObjectContainer;

import org.aswing.plaf.basic.BasicButtonUI;

/**
 * An implementation of a "push" button.
 * @author paling
 */
class JButton extends AbstractButton
{
	public function new(text:String="", icon:Icon=null){
		super(text, icon);
		setClipMasked(true);
		setName("JButton" + text);
		
    	setModel(new DefaultButtonModel());
	}
	
	/**
	 * Returns whether this button is the default button of its root pane or not.
	 * @return true if this button is the default button of its root pane, false otherwise.
	 */
	public function isDefaultButton():Bool{
		var rootPane:JRootPane = getRootPaneAncestor();
		if(rootPane != null){
			return rootPane.getDefaultButton() == this;
		}
		return false;
	}
	
	/**
	 * Wrap a SimpleButton to be this button's representation.
	 * @param btn the SimpleButton to be wrap.
	 * @return the button self
	 */
	override public function wrapSimpleButton(btn:SimpleButton):AbstractButton{
		mouseChildren = true;
		drawTransparentTrigger = false;
		setShiftOffset(0);
		setIcon(new SimpleButtonIcon(btn));
		setBorder(null);
		setMargin(new Insets());
		setBackgroundDecorator(null);
		setOpaque(false);
		setHorizontalTextPosition(AsWingConstants.CENTER);
		setVerticalTextPosition(AsWingConstants.CENTER);
		return this;
	}
	
    override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicButtonUI;
    }
    
	override public function getUIClassID():String{
		return "ButtonUI";
	}
	
}
