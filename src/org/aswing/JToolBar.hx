/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
 

import org.aswing.plaf.InsetsUIResource;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicToolBarUI;

/**
 * `JToolBar` provides a component that is useful for
 * displaying commonly used 'Action's or controls.
 *
 *
 * JToolBar will change buttons's isOpaque() method, so if your programe's logic is related 
 * to button's opaque, take care to add buttons to JToolBar.
 *
 *
 * With most look and feels,
 * the user can drag out a tool bar into a separate window
 * (unless the `floatable` property is set to 'false').
 * For drag-out to work correctly, it is recommended that you add
 * `JToolBar` instances to one of the four "sides" of a
 * container whose layout manager is a `BorderLayout`,
 * and do not add children to any of the other four "sides".
 *
 * 
 * Authors: paling, ngrebenshikov
 */
class JToolBar extends Container  implements Orientable{
	
	inline public static var HORIZONTAL:Int= AsWingConstants.HORIZONTAL;
	inline public static var VERTICAL:Int= AsWingConstants.VERTICAL;

	/**
      * The margin between the tool bar's border and
      * its buttons.
      *
      * Setting to 'null' causes the tool bar to
      * use the default margins. The tool bar's default 'Border'
      * object uses this value to create the proper margin.
      * However, if a non-default border is set on the tool bar,
      * it is that 'Border' object's responsibility to create the
      * appropriate margin space (otherwise this property will
      * effectively be ignored).
      *
      * See `Insets`
      */
	public var margin(get, set): Insets;
	private var _margin: Insets;
	private function get_margin(): Insets { return getMargin(); }
	private function set_margin(v: Insets): Insets { setMargin(v); return v; }

	/**
	 * The gap between child components.
	 */
	public var gap(get, set): Int;
	private var _gap: Int;
	private function get_gap(): Int { return getGap(); }
	private function set_gap(v: Int): Int { setGap(v); return v; }

	/**
     * The orientation of the tool bar.
     *
     * The orientation must have
     * either the value `HORIZONTAL` or `VERTICAL`.
     */
	public var orientation(get, set): Int;
	private var _orientation: Int;
	private function get_orientation(): Int { return getOrientation(); }
	private function set_orientation(v: Int): Int { setOrientation(v); return v; }
    
    /**
     * Creates a new tool bar with specified 'orientation'.
     * title is only shown when the tool bar is undocked. 
     * @param orientation orientation  the initial orientation -- it must be
     *		either `HORIZONTAL` or `VERTICAL`
     * @param gap the gap between toolbar children
     */
	public function new(orientation:Int=AsWingConstants.HORIZONTAL, gap:Int=2) {
		super();
		this._orientation = orientation;
		this._gap = gap;
		setLayoutWidthOrientation();
		updateUI();
	}

	@:dox(hide)
    override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }

	@:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicToolBarUI;
    }

	@:dox(hide)
	override public function getUIClassID():String{
		return "ToolBarUI";
	}
	
	/**
	 * Sets the gap.
	 * @param gap the gap between toolbar children
	 */
	@:dox(hide)
	public function setGap(gap:Int):Void{
		if(this._gap != gap){
			this._gap = gap;
			setLayoutWidthOrientation();
			revalidate();
		}
	}
	
	/**
	 * Returns the gap.
	 * @return gap the gap between toolbar children
	 */
	@:dox(hide)
	public function getGap():Int{
		return _gap;
	}
	
     /**
      * Sets the margin between the tool bar's border and
      * its buttons. Setting to 'null' causes the tool bar to
      * use the default margins. The tool bar's default 'Border'
      * object uses this value to create the proper margin.
      * However, if a non-default border is set on the tool bar,
      * it is that 'Border' object's responsibility to create the
      * appropriate margin space (otherwise this property will
      * effectively be ignored).
      *
      * See `Insets`
      *
      * @param m an 'Insets' object that defines the space
      * 	between the border and the buttons
      */
	@:dox(hide)
	public function setMargin(m:Insets):Void{
		if(_margin != m){
			_margin = m;
			revalidate();
			repaint();
		}
	}
	
     /**
      * Returns the margin between the tool bar's border and
      * its buttons.
      *
      * @return an 'Insets' object containing the margin values
      * See `Insets`
      */
	@:dox(hide)
	public function getMargin():Insets{
		if(_margin == null){
			return new InsetsUIResource(0, 0, 0, 0);
		}else if(Std.is(_margin,UIResource)){
			return (new InsetsUIResource()).addInsets(_margin);//return a copy
		}else{
			return _margin.clone();
		}
	}
	
	@:dox(hide)
	override public function getInsets():Insets{
		var insets:Insets = super.getInsets();
		insets.addInsets(getMargin());
		return insets;
	}
	
    /**
     * Returns the current orientation of the tool bar.  The value is either
     * `HORIZONTAL` or `VERTICAL`.
     *
     * @return an integer representing the current orientation -- either
     *		'HORIZONTAL' or 'VERTICAL'
     * See `setOrientation()`
     */
	@:dox(hide)
    public function getOrientation():Int{
        return _orientation;
    }

    /**
     * Sets the orientation of the tool bar.  The orientation must have
     * either the value 'HORIZONTAL' or 'VERTICAL'.
     *
     * @param o  the new orientation -- either 'HORIZONTAL' or
     *			'VERTICAL'
     * See `#getOrientation()`
     */
	@:dox(hide)
    public function setOrientation(o:Int):Void{
		if (_orientation != o){
		    _orientation = o;
		    setLayoutWidthOrientation();
		    revalidate();
		    repaint();
	    }
    }
    
    private function setLayoutWidthOrientation():Void{
	    if(_orientation == VERTICAL){
	    	setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, _gap));
	    }else{
	    	setLayout(new SoftBoxLayout(SoftBoxLayout.X_AXIS, _gap));
	    }
    }
	
}