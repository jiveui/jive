/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.error.Error;
import org.aswing.plaf.ComponentUI;
	import org.aswing.plaf.basic.BasicTabbedPaneUI;
	
/**
 * A component that lets the user switch between a group of components by
 * clicking on a tab with a given title and/or icon.
 * <p>
 * Tabs/components are added to a <code>TabbedPane</code> object by using the
 * <code>addTab</code> and <code>insertTab</code> methods.
 * A tab is represented by an index corresponding
 * to the position it was added in, where the first tab has an index equal to 0
 * and the last tab has an index equal to the tab count minus 1.
 * @author paling
 */	
	
class JTabbedPane extends AbstractTabbedPane{

	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	inline public static var TOP:Int= AsWingConstants.TOP;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var LEFT:Int= AsWingConstants.LEFT;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var BOTTOM:Int= AsWingConstants.BOTTOM;
 	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var RIGHT:Int= AsWingConstants.RIGHT;	
	
	private var tabPlacement:Int;
	private var leadingOffset:Int;
	
    /**
     * JTabbedPane()
     * <p>
     */
	public function new() {
		super();
		setName("JTabbedPane");
		tabPlacement = TOP;
		leadingOffset = 0;
		
		updateUI();
	}

	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicTabbedPaneUI;
    }
		
	override public function getUIClassID():String{
		return "TabbedPaneUI";
	}
	
    /**
     * Sets the tab placement for this tabbedpane.
     * Possible values are:<ul>
     * <li><code>JTabbedPane.TOP</code>
     * <li><code>JTabbedPane.BOTTOM</code>
     * <li><code>JTabbedPane.LEFT</code>
     * <li><code>JTabbedPane.RIGHT</code>
     * </ul>
     * The default value, if not set, is <code>SwingConstants.TOP</code>.
     *
     * @param tabPlacement the placement for the tabs relative to the content
     */
    public function setTabPlacement(tabPlacement:Int):Void{
    	if(this.tabPlacement != tabPlacement){
    		this.tabPlacement = tabPlacement;
    		revalidate();
    		repaint();
    	}
    }
    
    /**
     * Returns the placement of the tabs for this tabbedpane.
     * @see #setTabPlacement()
     */
    public function getTabPlacement():Int{
    	return tabPlacement;
    }
	
    /**
     * Sets the offset of the first tab.
     *
     * @param offset the offset of the first tab.
     */
    public function setLeadingOffset(offset:Int):Void{
    	if(leadingOffset != offset){
    		leadingOffset = offset;
    		revalidate();
    		repaint();
    	}
    }
    
    /**
     * Returns the offset of the first tab.
     * @see #setLeadingOffset()
     */
    public function getLeadingOffset():Int{
    	return leadingOffset;
    }
    
	/**
	 * Generally you should not set layout to JTabbedPane.
	 * @param layout layoutManager for JTabbedPane
	 * @throws ArgumentError when you set a non-TabbedPaneUI layout to JTabbedPane.
	 */
	override public function setLayout(layout:LayoutManager):Void{
		if(Std.is(layout,ComponentUI)){
			super.setLayout(layout);
		}else{
			throw new Error("Cannot set non-AccordionUI layout to JAccordion!");  
		}
	}
    
    /**
     * Not support this function.
     * @throws Error("Not supported setVisibleAt!")
     */
    override public function setVisibleAt(index:Int, visible:Bool):Void{
    	throw new Error("Not supported setVisibleAt!");  
    }	
	
}