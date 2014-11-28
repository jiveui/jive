/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.error.Error;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.basic.BasicAccordionUI;

/**
 * Accordion Container.
 * @author paling
 */
class JAccordion extends AbstractTabbedPane{
	
    /**
     * Create an accordion.
     */
	public function new() {
		super();
		setName("JAccordion");
		
		updateUI();
	}
	
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicAccordionUI;
    }
	
	override public function getUIClassID():String{
		return "AccordionUI";
	}
	
	/**
	 * Generally you should not set layout to JAccordion.
	 * @param layout layoutManager for JAccordion
	 * @throws ArgumentError when you set a non-AccordionUI layout to JAccordion.
	 */
	override public function setLayout(layout:LayoutManager):Void{
		if(Std.is(layout,ComponentUI)){
			super.setLayout(layout);
		}else{
			throw new Error("Cannot set non-AccordionUI layout to JAccordion!");  
		}
	}
}