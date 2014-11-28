/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.plaf.basic.BasicPanelUI;
	
/**
 * The general container - panel.
 * @author paling
 */
class JPanel extends Container{
	
	public function new(?layout:LayoutManager=null){
		super();
		setName("JPanel");
		if(layout == null) layout = new FlowLayout();
		this._layout = layout;
		updateUI();
	}
	
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicPanelUI;
    }
	
	override public function getUIClassID():String{
		return "PanelUI";
	}
}