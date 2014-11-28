/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.geom.IntDimension;
	import org.aswing.plaf.basic.BasicSpacerUI;

/**
 * <code>JSpacer</code> provides basic functionality to create empty spaces between
 * other components.
 * 
 * @author paling
 * @author Igor Sadovskiy
 */
class JSpacer extends Component{
	
	/**
	 * JSpacer(prefSize:Dimension)<br>
	 * JSpacer()
	 */
	public function new(prefSize:IntDimension=null){
		super();
		setPreferredSize(prefSize);
		updateUI();
	}
	
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicSpacerUI;
    }
	
	override public function getUIClassID():String{
		return "SpacerUI";
	}
	
	/**
	 * Creates a Spacer that displays its components from left to right.
	 * @param width (optional)the width of the spacer, default is 4
	 * @return the spacer
	 */
	public static function createHorizontalSpacer(width:Int=4):JSpacer{
		var glue:JSpacer = new JSpacer();
		glue.setPreferredSize(new IntDimension(width , 0));
		glue.setMaximumSize(new IntDimension(width , 10000));
		return glue;
	}
	
	/**
	 * Creates a Spacer that displays its components from top to bottom.
	 * @param height (optional)the height of the spacer, default is 4
	 * @return the spacer
	 */
	public static function createVerticalSpacer(height:Int=4):JSpacer{
		var glue:JSpacer = new JSpacer();
		glue.setPreferredSize(new IntDimension(0 , height));
		glue.setMaximumSize(new IntDimension(10000 , height));
		return glue;
	}
	
	/**
	 * Creates a solid Spacer with specified preffered width and height.
	 * @param width (optional)the width of the spacer, default is 4
	 * @param height (optional)the height of the spacer, default is 4
	 * @return the spacer
	 */
	public static function createSolidSpacer(width:Int=4, height:Int=4):JSpacer{
		var glue:JSpacer = new JSpacer();
		glue.setPreferredSize(new IntDimension(width , height));
		return glue;
	}
	
}