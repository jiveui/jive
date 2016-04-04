/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.plaf.basic.BasicPanelUI;
	
/**
 * The general container - a panel.
 *
 * The default layout is `FlowLayout`.
 *
 * @author paling
 */
class JPanel extends Container {
	
	public function new(?layout:LayoutManager=null){
		super();
		setName("JPanel");
		if(layout == null) layout = new FlowLayout();
		this._layout = layout;
		updateUI();
	}
	
	@:dox(hide)
    override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicPanelUI;
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "PanelUI";
	}
}