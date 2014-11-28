/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
 

/**
 * A <code>JPanel</code> with <code>SoftBoxLayout</code>.
 * 
 * @author paling
 */
class SoftBox extends JPanel {
	
	/**
	 * SoftBox(axis:int, gap:int, align:int)<br>
	 * SoftBox(axis:int, gap:int)<br> default align to LEFT.
	 * SoftBox(axis:int) default gap to 0.
	 * Creates a panel with a SoftBoxLayout.
	 * @param axis the axis of layout.
	 *  {@link org.aswing.SoftBoxLayout#X_AXIS} or {@link org.aswing.SoftBoxLayout#Y_AXIS}
     * @param gap (optional)the gap between each component, default 0
     * @param align (optional)the alignment value, default is LEFT
	 * @see org.aswing.SoftBoxLayout
	 */
	public function new(axis:Int, gap:Int=0, align:Int=AsWingConstants.LEFT){
		super();
		setName("SoftBox");
		setLayout(new SoftBoxLayout(axis, gap, align));
	}
	
	/** Sets new axis for the default SoftBoxLayout.
	 * @param axis the new axis
	 */
	public function setAxis(axis:Int):Void{
		AsWingUtils.as(getLayout(),SoftBoxLayout).setAxis(axis);
	}

	/**
	 * Gets current axis of the default SoftBoxLayout.
	 * @return axis 
	 */
	public function getAxis():Int{
		return AsWingUtils.as(getLayout(),SoftBoxLayout).getAxis();
	}

	/**
	 * Sets new gap for the default SoftBoxLayout.
	 * @param gap the new gap
	 */
	public function setGap(gap:Int):Void{
		AsWingUtils.as(getLayout(),SoftBoxLayout).setGap(gap);
	}

	/**
	 * Gets current gap of the default SoftBoxLayout.
	 * @return gap 
	 */
	public function getGap():Int{
		return AsWingUtils.as(getLayout(),SoftBoxLayout).getGap();
	}
	
	/**
	 * Sets new align for the default SoftBoxLayout.
	 * @param align the new align
	 */
	public function setAlign(align:Int):Void{
		AsWingUtils.as(getLayout(),SoftBoxLayout).setAlign(align);
	}

	/**
	 * Gets current align of the default SoftBoxLayout.
	 * @return align 
	 */
	public function getAlign():Int{
		return AsWingUtils.as(getLayout(),SoftBoxLayout).getAlign();
	}	
	
	/**
	 * Creates and return a Horizontal SoftBox.
     * @param gap (optional)the gap between each component, default 0
     * @param align (optional)the alignment value, default is LEFT
     * @return a horizontal SoftBox.
	 */
	public static function createHorizontalBox(gap:Int=0, align:Int=AsWingConstants.LEFT):SoftBox{
		return new SoftBox(SoftBoxLayout.X_AXIS, gap, align);
	}
	
	/**
	 * Creates and return a Vertical SoftBox.
     * @param gap the gap between each component, default 0
     * @param align (optional)the alignment value, default is LEFT
     * @return a vertical SoftBox.
	 */
	public static function createVerticalBox(gap:Int=0, align:Int=AsWingConstants.LEFT):SoftBox{
		return new SoftBox(SoftBoxLayout.Y_AXIS, gap, align);
	}
	
	/**
	 * @see org.aswing.JSpacer#createHorizontalGlue
	 */
	public static function createHorizontalGlue(width:Int=4):Component{
		return JSpacer.createHorizontalSpacer(width);
	}
	
	/**
	 * @see org.aswing.JSpacer#createVerticalGlue
	 */
	public static function createVerticalGlue(height:Int=4):Component{
		return JSpacer.createVerticalSpacer(height);
	}
}