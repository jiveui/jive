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
class JAccordion extends AbstractTabbedPane {
	
    public var itemContainerClass: Dynamic;
	
	/**
     * Create an accordion.
     */
	public function new() {
		super();
		setName("JAccordion");
		updateUI();
	}
	
    @:dox(hide)
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	@:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicAccordionUI;
    }
	@:dox(hide)
	override public function getUIClassID():String{
		return "AccordionUI";
	}
	
	/**
	 * Generally you should not set layout to JAccordion.
	 * @param layout layoutManager for JAccordion
	 * @throws ArgumentError when you set a non-AccordionUI layout to JAccordion.
	 */
    @:dox(hide)
	override public function setLayout(layout:LayoutManager):Void{
		if(Std.is(layout,ComponentUI)){
			super.setLayout(layout);
		}else{
			throw new Error("Cannot set non-AccordionUI layout to JAccordion!");  
		}
	}
	
	@:dox(hide)
	override public function appendTab(com:Component, title:String = "", icon:Icon = null, tip:String = null):Void {
		var item = com;
		if (null != itemContainerClass) {
			var container: JPanel = AsWingUtils.as(Type.createInstance(itemContainerClass, []), JPanel);
			if (null != container) {
				container.append(item);
				item = container;
			}
		}
		super.appendTab(item, title, icon, tip);
	}
}