/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.plaf.basic.BasicSeparatorUI;
	
/**
 * `JSeparator` provides a general purpose component for
 * implementing divider lines - most commonly used as a divider
 * between menu items that breaks them up into logical groupings.
 *
 * Instead of using `JSeparator`  directly,
 * you can use the `JMenu` or `JPopupMenu`.
 *
 * `JSeparator`s may also be used elsewhere in a GUI
 * wherever a visual divider is useful.
 *
 */
class JSeparator extends Component  implements Orientable{
	
	/**
	* Horizontal orientation.
	*
	* A fast access to `AsWingConstants` Constant
	*/
    inline public static var HORIZONTAL:Int= AsWingConstants.HORIZONTAL;

    /**
     * Vertical orientation.
     *
	 * A fast access to `AsWingConstants` Constant
     */
    inline public static var VERTICAL:Int= AsWingConstants.VERTICAL;
	
	private var _orientation:Int;
	public var orientation(get, set): Int;
	private function get_orientation(): Int { return getOrientation(); }
	private function set_orientation(v: Int): Int { setOrientation(v); return v; }
	
	/**
	 * `JSeparator(orientation:Number`)
	 *
	 * `JSeparator()` default orientation to `AsWingConstants.HORIZONTAL`;
	 */

	public function new(orientation:Int=AsWingConstants.HORIZONTAL){
		super();
		setName("JSeparator");
		this._orientation = orientation;
		setFocusable(false);
		updateUI();
	}

	@:dox(hide)
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
	override public function getUIClassID():String{
		return "SeparatorUI";
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicSeparatorUI;
    }
	
	@:dox(hide)
	@:deprecated
	public function getOrientation():Int{
		return _orientation;
	}
	
	@:dox(hide)
	@:deprecated
	public function setOrientation(orientation:Int):Void{
		if (this._orientation != orientation){
			this._orientation = orientation;
			revalidate();
			repaint();
		}
	}
}