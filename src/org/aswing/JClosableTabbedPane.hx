package org.aswing;


import org.aswing.plaf.basic.BasicClosableTabbedPaneUI;	

/**
 * Dispatched when a tab clos button is clicked. 
 * @eventType org.aswing.event.TabCloseEvent.TAB_CLOSING
 */
// [Event(name="tabClosing", type="org.aswing.event.TabCloseEvent")]

/**
 * A TabbedPane with each tab a close button, you must listen the TabCloseEvent 
 * and then remove the related tab component if you want. 
 * By default, any thing will happen for close button click.
 * @author paling
 */
class JClosableTabbedPane extends JTabbedPane{
	
    private var closeEnables:Array<Dynamic>;
    
	public function new(){
		super();
		closeEnables = new Array<Dynamic>();
		setName("JClosableTabbedPane");
	}
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicClosableTabbedPaneUI;
    }
	
	override public function getUIClassID():String{
		return "ClosableTabbedPaneUI";
	}
	
	/**
	 * Sets whether or not the tab close button at index is enabled. 
	 * Nothing will happen if there is no tab at that index.
	 * @param index the tab index which should be enabled/disabled
	 * @param enabled whether or not the tab close button should be enabled 
	 */
	public function setCloseEnabledAt(index:Int, enabled:Bool):Void{
		if(closeEnables[index] != enabled){
			closeEnables[index] = enabled;
			revalidate();
			repaint();
		}
	}
	
	/**
	 * Returns whether or not the tab close button at index is currently enabled. 
	 * false will be returned if there is no tab at that index.
	 * @param index  the index of the item being queried 
	 * @return if the tab close button at index is enabled; false otherwise.
	 */
	public function isCloseEnabledAt(index:Int):Bool{
		return closeEnables[index] == true;
	}
	
	override private function insertProperties(i:Int, title:String="", icon:Icon=null, tip:String=null):Void{
		super.insertProperties(i, title, icon, tip);
		insertToArray(closeEnables, i, true);
	}
	
	override private function removeProperties(i:Int):Void{
		super.removeProperties(i);
		removeFromArray(closeEnables, i);
	}
}