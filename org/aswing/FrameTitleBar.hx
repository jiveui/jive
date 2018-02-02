package org.aswing;


interface FrameTitleBar{
	
	/**
	 * Returns the component(must be FrameTitleBar instance self, that means the implamentation 
	 * must extends Component and getPane() return itself) that represents the title bar.
	 */
	function getSelf():Component;
	
	/**
	 * Sets the owner of this title bar. null to uninstall from current frame.
	 * You can set a JFrame or a JWindow, if it is JWindow, some function will be lost.
	 */
	function setFrame(frame:JWindow):Void;
	
	function getFrame():JWindow;
		
	/**
	 * Adds extra control to title bar
	 * @param c the control
	 * @param position left or right behind the title buttons. 
	 * 			<code>AsWingConstants.LEFT</code> or <code>AsWingConstants.RIGHT</code>
	 */
	function addExtraControl(c:Component, position:Int):Void;
	
	/**
	 * Returns the extra control already added.
	 * @returns the removed control, null will be returned if the control is not in title bar.
	 */
	function removeExtraControl(c:Component):Component;
	
	/**
	 * Sets the enabled property, if enabled, the title should have ability to iconified, maximize, restore, close, move frame.
	 * If not enabled, that abilities should be disabled.
	 */
	function setTitleEnabled(b:Bool):Void;
	
	/**
	 * Returns is title enabled.
	 * @see #setTitleEnabled()
	 */
	function isTitleEnabled():Bool;
	
	/**
	 * Returns whether or not the frame is active
	 */
	function isActive():Bool;
	
	function setButtonIconGap(gap:Int):Void;
	
	function setMinimizeHeight(h:Int):Void;
	
	function getMinimizeHeight():Int;
	
	function setIcon(i:Icon):Void;
	
	function getIcon():Icon;
	
	function setText(t:String):Void;
	
	function getText():String;
	
	function getLabel():JLabel;
	
	function setIconifiedButton(b:AbstractButton):Void;
	
	function setMaximizeButton(b:AbstractButton):Void;
	
	function setRestoreButton(b:AbstractButton):Void;
	
	function setCloseButton(b:AbstractButton):Void;
	
	function getIconifiedButton():AbstractButton;
	
	function getMaximizeButton():AbstractButton;
	
	function getRestoreButton():AbstractButton;
	
	function getCloseButton():AbstractButton;
	
}