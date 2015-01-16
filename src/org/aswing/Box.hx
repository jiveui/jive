/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
 
import org.aswing.BoxLayout;
import org.aswing.Component;
import org.aswing.JPanel;
import org.aswing.JSpacer;

/**
 * A `JPanel` with `BoxLayout`.
 *
 * The following picture illustrates `Box` with `X_AXIS`:
 *
 * <img src="../../BoxLayoutX.jpg" ></img>
 *
 * <br/>
 *
 * The picure for `Y_AXIS`:
 *
 * <img src="../../BoxLayoutY.jpg" ></img>
 *
 * <br/>
 *
 * See `SoftBox`.
 * 
 * Authors paling, ngrebenshikov
 */
class Box extends JPanel {

	/**
	* An axis for `BoxLayout`
	**/
	public var axis(get, set): Int;
	private function get_axis(): Int { return getAxis(); }
	private function set_axis(v: Int): Int { setAxis(v); return v; }

	/**
	* A gap between children in pixels
	*
	* See `BoxLayout`
	**/
	public var gap(get, set): Int;
	private function get_gap(): Int { return getGap(); }
	private function set_gap(v: Int): Int { setGap(v); return v; }

	/**
	 * `Box(axis:int, gap:int)`
	 *
	 * `Box(axis:int)` default gap to 0.
	 *
	 * Creates a panel with a `BoxLayout`.
	 *
	 * @param axis (optional) the axis of layout, default is `X_AXIS`. Values: `org.aswing.BoxLayout.X_AXIS` or `org.aswing.BoxLayout.Y_AXIS`
     * @param gap (optional) the gap between each component, default 0
	 *
	 * See `org.aswing.SoftBox`
	 */
	public function new(axis:Int=0, gap:Int=0){
		super();
		setName("Box");
		setLayout(new BoxLayout(axis, gap));
	}
	
	/**
	 * Sets new axis for the default BoxLayout.
	 * @param axis the new axis
	 */
	@:dox(hide)
	public function setAxis(axis:Int):Void{
		AsWingUtils.as(getLayout(),BoxLayout).setAxis(axis);
	}

	/**
	 * Gets current axis of the default BoxLayout.
	 * @return axis 
	 */
	@:dox(hide)
	public function getAxis():Int{
		return AsWingUtils.as(getLayout(),BoxLayout).getAxis();
	}

	/**
	 * Sets new gap for the default BoxLayout.
	 * @param gap the new gap
	 */
	@:dox(hide)
	public function setGap(gap:Int):Void{
		AsWingUtils.as(getLayout(),BoxLayout).setGap(gap);
	}

	/**
	 * Gets current gap of the default BoxLayout.
	 * @return gap 
	 */
	@:dox(hide)
	public function getGap():Int{
		return AsWingUtils.as(getLayout(),BoxLayout).getGap();
	}
	
	/**
	 * Creates and return a Horizontal Box.
     * @param gap (optional)the gap between each component, default 0
     * @return a horizontal Box.
	 */	
	public static function createHorizontalBox(gap:Int=0):Box{
		return new Box(BoxLayout.X_AXIS, gap);
	}
	
	/**
	 * Creates and return a Vertical Box.
     * @param gap (optional)the gap between each component, default 0
     * @return a vertical Box.
	 */
	public static function createVerticalBox(gap:Int=0):Box{
		return new Box(BoxLayout.Y_AXIS, gap);
	}
	

	/**
	 * Creates a glue that displays its components from left to right.
	 *
	 * See `org.aswing.JSpacer.createVerticalGlue`
	 */
	public static function createHorizontalGlue():Component{
		return JSpacer.createHorizontalSpacer(0);
	}
	
	/**
	 * Creates a glue that displays its components from top to bottom.
	 *
	 * See `org.aswing.JSpacer.createVerticalGlue`
	 */
	public static function createVerticalGlue():Component{
		return JSpacer.createVerticalSpacer(0);
	}
}