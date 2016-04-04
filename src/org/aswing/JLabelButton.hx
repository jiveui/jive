/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.plaf.basic.BasicLabelButtonUI;

/**
 * A button that looks like a hypertext link.
 * @author paling
 */
class JLabelButton extends AbstractButton {

    /**
	 * A color for the text rollover state.
	 */
    @bindable public var rolloverColor(get, set): ASColor;
    private var _rolloverColor: ASColor;
    private function get_rolloverColor(): ASColor { return getRollOverColor(); }
    private function set_rolloverColor(v: ASColor): ASColor { setRollOverColor(v); return v; }

    /**
	 * A color for the text pressed/selected state.
	 */
    @bindable public var pressedColor(get, set): ASColor;
    private var _pressedColor: ASColor;
    private function get_pressedColor(): ASColor { return getPressedColor(); }
    private function set_pressedColor(v: ASColor): ASColor { setPressedColor(v); return v; }
	
    /**
     * Creates a label button.
     * @param text the text.
     * @param icon the icon.
     * @param horizontalAlignment the horizontal alignment, default is <code>AsWingConstants.CENTER</code>
     */	
	public function new(text:String="", icon:Icon=null, horizontalAlignment:Int=0){
		super(text, icon);
		setClipMasked(true);
		setName("JLabelButton");
    	setModel(new DefaultButtonModel());
    	setHorizontalAlignment(horizontalAlignment);
		
	}

    @:dox(hide)
    override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicLabelButtonUI;
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "LabelButtonUI";
	}
	
	/**
	 * Sets the color for text rollover state.
	 * @param c the color.
	 */
    @:dox(hide)
	public function setRollOverColor(c:ASColor):Void{
		if(c != _rolloverColor){
			_rolloverColor = c;
			repaint();
		}
	}
	
	/**
	 * Gets the color for text rollover state.
	 * @param c the color.
	 */
    @:dox(hide)
	public function getRollOverColor():ASColor{
		return _rolloverColor;
	}	
	
	/**
	 * Sets the color for text pressed/selected state.
	 * @param c the color.
	 */
    @:dox(hide)
	public function setPressedColor(c:ASColor):Void{
		if(c != _pressedColor){
			_pressedColor = c;
			repaint();
		}
	}
	
	/**
	 * Gets the color for text pressed/selected state.
	 * @param c the color.
	 */
    @:dox(hide)
	public function getPressedColor():ASColor{
		return _pressedColor;
	}	
}