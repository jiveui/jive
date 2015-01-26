/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
 

/**
 * A `JPanel` with `SoftBoxLayout`.
 * 
 * The picture below shows that when set `X_AXIS`, all of the child component share the same height no matter what value you set for the componnet.
 * It ignores the `width` and `height` property you set for the child component.<br/>
 *
 * <img src="../../SoftBoxLayoutX.jpg" ></img>
 *
 * <br/>
 *
 * The picture below shows that when set `Y_AXIS`,all of the child component share the same width no matter what value you set for the componnet.
 * It ignores the width and height property you set for the child component.<br/>
 *
 * <img src="../../SoftBoxLayoutY.jpg" ></img>
 *
 * <br/>
 *
 * Author paling, ngrebenshikov
 */
class SoftBox extends JPanel {

	/**
     * The layout axis. Must be one of:
     * <ul>
     *  <li>`X_AXIS`
     *  <li>`Y_AXIS`
     * </ul>
     *
     * Default is `X_AXIS`.
     */
	public var axis(get,set): Int;
	private function get_axis(): Int { return getAxis(); }
	private function set_axis(v: Int): Int { setAxis(v); return v;}

	/**
	* The space between children
	**/
	public var gap(get,set):Int;
	private function get_gap(): Int { return getGap(); }
	private function set_gap(v: Int): Int { setGap(v); return v; }

	/**
     * The layout align. Must be one of:
     * <ul>
     *  <li>`LEFT`
     *  <li>`RIGHT`
     *  <li>`CENTER`
     *  <li>`TOP`
     *  <li>`BOTTOM`
     * </ul>
     *
     * Default is `LEFT`.
     */
	public var align(get,set):Int;
	private function get_align(): Int { return getAlign(); }
	private function set_align(v: Int): Int { setAlign(v); return v; }

	/**
	 * `SoftBox(axis:int, gap:int, align:int)`
	 *
	 * `SoftBox(axis:int, gap:int)` default align to `SoftBoxLayout.LEFT`.
	 *
	 * `SoftBox(axis:int)` default gap to 0.
	 *
	 * `SoftBox()` default axis to `SoftBoxLayout.Y_AXIS`.
	 *
	 * Creates a panel with a `SoftBoxLayout`.
	 *
	 * @see org.aswing.SoftBoxLayout
	 *
	 * @param axis the axis of layout. `SoftBoxLayout.X_AXIS` or `SoftBoxLayout.Y_AXIS`
	 * @param gap (optional) the gap between each component, default 0
	 * @param align (optional) the alignment value, default is `LEFT`
	 */
	public function new(axis:Int=SoftBoxLayout.Y_AXIS, gap:Int=0, align:Int=AsWingConstants.LEFT){
		super();
		setName("SoftBox");
		setLayout(new SoftBoxLayout(axis, gap, align));
	}
	
	/** Sets new axis for the default SoftBoxLayout.
	 * @param axis the new axis
	 */
	@:dox(hide)
	public function setAxis(axis:Int):Void{
		AsWingUtils.as(getLayout(),SoftBoxLayout).setAxis(axis);
	}

	/**
	 * Gets current axis of the default SoftBoxLayout.
	 * @return axis 
	 */
	@:dox(hide)
	public function getAxis():Int{
		return AsWingUtils.as(getLayout(),SoftBoxLayout).getAxis();
	}

	/**
	 * Sets new gap for the default SoftBoxLayout.
	 * @param gap the new gap
	 */
	@:dox(hide)
	public function setGap(gap:Int):Void{
		AsWingUtils.as(getLayout(),SoftBoxLayout).setGap(gap);
	}

	/**
	 * Gets current gap of the default SoftBoxLayout.
	 * @return gap 
	 */
	@:dox(hide)
	public function getGap():Int{
		return AsWingUtils.as(getLayout(),SoftBoxLayout).getGap();
	}
	
	/**
	 * Sets new align for the default SoftBoxLayout.
	 * @param align the new align
	 */
	@:dox(hide)
	public function setAlign(align:Int):Void{
		AsWingUtils.as(getLayout(),SoftBoxLayout).setAlign(align);
	}

	/**
	 * Gets current align of the default SoftBoxLayout.
	 * @return align 
	 */
	@:dox(hide)
	public function getAlign():Int{
		return AsWingUtils.as(getLayout(),SoftBoxLayout).getAlign();
	}	
	
	/**
	 * Creates and return a Horizontal SoftBox.
	 *
	 * @param gap (optional)the gap between each component, default 0
	 * @param align (optional)the alignment value, default is `LEFT`
	 * @return a horizontal SoftBox.
	 */
	public static function createHorizontalBox(gap:Int=0, align:Int=AsWingConstants.LEFT):SoftBox{
		return new SoftBox(SoftBoxLayout.X_AXIS, gap, align);
	}
	
	/**
	 * Creates and return a Vertical SoftBox.
	 *
	 * @param gap the gap between each component, default 0
	 * @param align (optional)the alignment value, default is `LEFT`
	 * @return a vertical SoftBox.
	 */
	public static function createVerticalBox(gap:Int=0, align:Int=AsWingConstants.LEFT):SoftBox{
		return new SoftBox(SoftBoxLayout.Y_AXIS, gap, align);
	}
	
	/**
	 * @see org.aswing.JSpacer.createHorizontalGlue
	 */
	public static function createHorizontalGlue(width:Int=4):Component{
		return JSpacer.createHorizontalSpacer(width);
	}
	
	/**
	 * @see org.aswing.JSpacer.createVerticalGlue
	 */
	public static function createVerticalGlue(height:Int=4):Component{
		return JSpacer.createVerticalSpacer(height);
	}
}