/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.tabbedpane;


import org.aswing.Component;
	import org.aswing.Icon;
	import org.aswing.ASFont;
	import org.aswing.ASColor;
	import org.aswing.Insets;
	/**
 * TabbedPane Tab
 * @author paling
 * @private
 */
interface Tab{
	
	/**
	 * Inits the tab
	 * @param owner the tab owner component
	 */
	function initTab(owner:Component):Void;
	
	function setTabPlacement(tp:Int):Void;
	
	function getTabPlacement():Int;
	
	/**
	 * Sets text and icon to the header
	 */
	function setTextAndIcon(text:String, icon:Icon):Void;
	
	/**
	 * Sets the font of the tab text
	 */
	function setFont(font:ASFont):Void;
	
	/**
	 * Sets the text color of the tab
	 */
	function setForeground(color:ASColor):Void;
	
	/**
	 * Sets whether it is selected
	 */
	function setSelected(b:Bool):Void;
	
    /**
     * Sets the vertical alignment of the icon and text.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)</li>
     * <li>AsWingConstants.TOP</li>
     * <li>AsWingConstants.BOTTOM</li>
     * </ul>
     */
    function setVerticalAlignment(alignment:Int):Void;
    
    /**
     * Sets the horizontal alignment of the icon and text.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)</li>
     * <li>AsWingConstants.LEFT</li>
     * <li>AsWingConstants.CENTER</li>
     * </ul>
     */
    function setHorizontalAlignment(alignment:Int):Void;
    
    /**
     * Sets the vertical position of the text relative to the icon.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)</li>
     * <li>AsWingConstants.TOP</li>
     * <li>AsWingConstants.BOTTOM</li>
     * </ul>
     */
    function setVerticalTextPosition(textPosition:Int):Void;
    
    /**
     * Sets the horizontal position of the text relative to the icon.
     * @param textPosition one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)</li>
     * <li>AsWingConstants.LEFT</li>
     * <li>AsWingConstants.CENTER</li>
     * </ul>
     */
    function setHorizontalTextPosition(textPosition:Int):Void;
    
    /**
     * If both the icon and text properties are set, this property
     * defines the space between them.  
     * <p>
     * The default value of this property is 4 pixels.
     * 
     * @see #getIconTextGap()
     */
    function setIconTextGap(iconTextGap:Int):Void;
	
	/**
	 * Sets space for margin between the border and
     * the content.
     */
	function setMargin(m:Insets):Void;
	
	/**
	 * The component represent the header and can fire the selection event 
	 * through <code>MouseEvent.CLICK</code> event.
	 */
	function getTabComponent():Component;
	
}