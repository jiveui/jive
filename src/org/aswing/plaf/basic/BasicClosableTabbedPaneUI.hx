package org.aswing.plaf.basic;


import org.aswing.event.FocusKeyEvent;
import flash.events.MouseEvent;
import flash.events.Event;
import org.aswing.plaf.basic.tabbedpane.ClosableTab;
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.DisplayObjectContainer;
import org.aswing.plaf.basic.tabbedpane.BasicClosableTabbedPaneTab;
import org.aswing.event.TabCloseEvent;
import org.aswing.plaf.basic.tabbedpane.Tab;
import org.aswing.JClosableTabbedPane;
import org.aswing.Component;	

/**
 * Basic imp for JClosableTabbedPane UI.
 * @author paling
 */
class BasicClosableTabbedPaneUI extends BasicTabbedPaneUI{
	
	public function new(){
		super();
	}	
	
    override private function getPropertyPrefix():String{
        return "ClosableTabbedPane.";
    }
	
	private function getClosableTab(i:Int):ClosableTab{
    	return AsWingUtils.as(tabs[i],ClosableTab);
	}
	
    override private function setTabProperties(header:Tab, i:Int):Void{
    	super.setTabProperties(header, i);
    	AsWingUtils.as(header,ClosableTab).getCloseButton().setEnabled( (AsWingUtils.as(tabbedPane,JClosableTabbedPane)).isCloseEnabledAt(i) && tabbedPane.isEnabledAt(i));
    }
	
	override private function installListeners():Void{
		super.installListeners();
		tabbedPane.addEventListener(MouseEvent.CLICK, __onTabPaneClicked);
	}
	
	override private function uninstallListeners():Void{
		super.uninstallListeners();
		tabbedPane.removeEventListener(MouseEvent.CLICK, __onTabPaneClicked);
	}
	
	override private function __onTabPanePressed(e:Event):Void{
		if((prevButton.hitTestMouse() || nextButton.hitTestMouse())
			&& (prevButton.isShowing() && nextButton.isShowing())){
			return;
		}
		var index:Int= getMousedOnTabIndex();
		if(index >= 0 && tabbedPane.isEnabledAt(index) && !isButtonEvent(e, index)){
			tabbedPane.setSelectedIndex(index);
		}
	}
	
    /**
     * Just override this method if you want other LAF headers.
     */
    override private function createNewTab():Tab{    	
    	var tab:Tab = AsWingUtils.as(getInstance(getPropertyPrefix() + "tab") , Tab);
    	if(tab == null){
    		tab = new BasicClosableTabbedPaneTab();
    	}
    	tab.initTab(tabbedPane);
    	tab.getTabComponent().setFocusable(false);
    	return tab;
    }
    
	private function isButtonEvent(e:Event, index:Int):Bool{
		var eventTarget:DisplayObject = AsWingUtils.as(e.target,DisplayObject)	;
		if(eventTarget!=null)	{
			var button:Component = getClosableTab(index).getCloseButton();
			if(button == eventTarget || button.contains(eventTarget)){
				return true;
			}
		}
		return false;
	}
	
	private function __onTabPaneClicked(e:Event):Void{
		var index:Int= getMousedOnTabIndex();
		if(index >= 0 && tabbedPane.isEnabledAt(index) && isButtonEvent(e, index)){
			tabbedPane.dispatchEvent(new TabCloseEvent(index));
		}
	}	
}