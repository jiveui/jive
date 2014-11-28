/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;



import org.aswing.plaf.UIResource;
	import org.aswing.JMenu;
	import org.aswing.MenuSelectionManager;
	import org.aswing.MenuElement;
	import org.aswing.Container;
	import org.aswing.JMenuBar;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.event.AWEvent;
	import org.aswing.util.Timer;
import flash.events.MouseEvent;
	import flash.events.Event;
	/**
 * @private
 * @author paling
 */
class BasicMenuUI extends BasicMenuItemUI{
	
	private var postTimer:Timer;
	
	public function new(){
		super();
	}

	override private function getPropertyPrefix():String{
		return "Menu.";
	}

	override private function installDefaults():Void{
		super.installDefaults();
		updateDefaultBackgroundColor();
	}	
	
	override private function uninstallDefaults():Void{
		menuItem.getModel().setRollOver(false);
		menuItem.setSelected(false);
		super.uninstallDefaults();
	}

	override private function installListeners():Void{
		super.installListeners();
		menuItem.addSelectionListener(__menuSelectionChanged);
	}
	
	override private function uninstallListeners():Void{
		super.uninstallListeners();
		menuItem.removeSelectionListener(__menuSelectionChanged);
	}		
	
	private function getMenu():JMenu{
		return AsWingUtils.as(menuItem,JMenu);
	}
	
	/*
	 * Set the background color depending on whether this is a toplevel menu
	 * in a menubar or a submenu of another menu.
	 */
	private function updateDefaultBackgroundColor():Void{
		if (!getBoolean("Menu.useMenuBarBackgroundForTopLevel")) {
			return;
		}
		var menu:JMenu = getMenu();
		if (Std.is(menu.getBackground() , UIResource)) {
			if (menu.isTopLevelMenu()) {
				menu.setBackground(getColor("MenuBar.background"));
			} else {
				menu.setBackground(getColor(getPropertyPrefix() + ".background"));
			}
		}
	}
	
	/**
	 * SubUI override this to do different
	 */
	override private function isMenu():Bool{
		return true;
	}
	
	/**
	 * SubUI override this to do different
	 */
	override private function isTopMenu():Bool{
		return getMenu().isTopLevelMenu();
	}
	
	/**
	 * SubUI override this to do different
	 */
	override private function shouldPaintSelected():Bool{
		return menuItem.getModel().isRollOver() || menuItem.isSelected();
	}
	
	//---------------------
	
	override public function processKeyEvent(code : Int) : Void{
		var manager:MenuSelectionManager = MenuSelectionManager.defaultManager();
		if(manager.isNextPageKey(code)){
			var path:Array<Dynamic>= manager.getSelectedPath();
			if(path[path.length-1] == menuItem){
				var popElement:MenuElement = getMenu().getPopupMenu();
				path.push(popElement);
				if(popElement.getSubElements().length > 0){
					path.push(popElement.getSubElements()[0]);
				}
				manager.setSelectedPath(menuItem.stage, path, false);
			}
		}else{
			super.processKeyEvent(code);
		}
	}	
	
	private function __menuSelectionChanged(e:InteractiveEvent):Void{
		menuItem.repaint();
	}
	
	override private function __menuItemRollOver(e:MouseEvent):Void{
		var menu:JMenu = getMenu();
		var manager:MenuSelectionManager = MenuSelectionManager.defaultManager();
		var selectedPath:Array<Dynamic>= manager.getSelectedPath();		
		if (!menu.isTopLevelMenu()) {
			if(!(selectedPath.length>0 && selectedPath[selectedPath.length-1]==menu.getPopupMenu())){
				if(menu.getDelay() <= 0) {
					appendPath(getPath(), menu.getPopupMenu());
				} else {
					manager.setSelectedPath(menuItem.stage, getPath(), false);
					setupPostTimer(menu);
				}
			}
		} else {
			if(selectedPath.length > 0 && selectedPath[0] == menu.getParent()) {
				// A top level menu's parent is by definition a JMenuBar
				manager.setSelectedPath(menuItem.stage, [menu.getParent(), menu, menu.getPopupMenu()], false);
			}
		}
		menuItem.repaint();
	}
	
	override private function __menuItemAct(e:AWEvent):Void{
		var menu:JMenu = getMenu();
		var cnt:Container = menu.getParent();
		if(cnt != null && Std.is(cnt,JMenuBar)) {
			var me:Array<Dynamic>= [cnt, menu, menu.getPopupMenu()];
			MenuSelectionManager.defaultManager().setSelectedPath(menuItem.stage, me, false);
		}
		menuItem.repaint();
	}
	
	private function __postTimerAct(e:Event):Void{
		var menu:JMenu = getMenu();
		var path:Array<Dynamic>= MenuSelectionManager.defaultManager().getSelectedPath();
		if(path.length > 0 && Std.is(path[path.length-1],JMenu) && path[path.length-1] == menu) {
			appendPath(path, menu.getPopupMenu());
		}
	}
	
	//---------------------
	private function appendPath(path:Array<Dynamic>, end:Dynamic):Void{
		path.push(end);
		MenuSelectionManager.defaultManager().setSelectedPath(menuItem.stage, path, false);
	}

	private function setupPostTimer(menu:JMenu):Void{
		if(postTimer == null){
			postTimer = new Timer(menu.getDelay(), 1);
			postTimer.addEventListener(AWEvent.ACT, __postTimerAct);
		} 
		postTimer.restart();
	}	
}