/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.MenuElementUI;
	import org.aswing.plaf.UIResource;
	import org.aswing.JMenuBar;
	import org.aswing.Component;
	import org.aswing.LayoutManager;
	import org.aswing.JMenu;
	import org.aswing.MenuSelectionManager;
	import org.aswing.MenuElement;
	import org.aswing.event.ContainerEvent;
import org.aswing.event.AWEvent;
import org.aswing.event.FocusKeyEvent;
import org.aswing.event.InteractiveEvent;

/**
 * @private
 */
class BasicMenuBarUI extends BaseComponentUI  implements MenuElementUI{
	
	private var menuBar:JMenuBar;
	
	public function new() {
		super();
	}

	override public function installUI(c:Component):Void{
		menuBar =  AsWingUtils.as(c,JMenuBar);
		installDefaults();
		installListeners();
	}

	override public function uninstallUI(c:Component):Void{
		menuBar =AsWingUtils.as(c,JMenuBar);
		uninstallDefaults();
		uninstallListeners();
	}
	
	private function getPropertyPrefix():String{
		return "MenuBar.";
	}

	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
		LookAndFeel.installColorsAndFont(menuBar, pp);
		LookAndFeel.installBorderAndBFDecorators(menuBar, pp);
		LookAndFeel.installBasicProperties(menuBar, pp);
		var layout:LayoutManager = menuBar.getLayout();
		if(layout == null || Std.is(layout,UIResource)){
			menuBar.setLayout(new DefaultMenuLayout(DefaultMenuLayout.X_AXIS));
		}
	}
	
	private function installListeners():Void{
		for(i in 0...menuBar.getComponentCount()){
			var menu:JMenu = menuBar.getMenu(i);
			if(menu != null){
				menu.addSelectionListener(__menuSelectionChanged);
			}
		}
		
		menuBar.addEventListener(ContainerEvent.COM_ADDED, __childAdded);
		menuBar.addEventListener(ContainerEvent.COM_REMOVED, __childRemoved);
		menuBar.addEventListener(AWEvent.FOCUS_GAINED, __barFocusGained);
		menuBar.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __barKeyDown);
	}

	private function uninstallDefaults():Void{
		LookAndFeel.uninstallBorderAndBFDecorators(menuBar);
	}
	
	private function uninstallListeners():Void{
		for(i in 0...menuBar.getComponentCount()){
			var menu:JMenu = menuBar.getMenu(i);
			if(menu != null){
				menu.removeSelectionListener(__menuSelectionChanged);
			}
		}
		
		menuBar.removeEventListener(ContainerEvent.COM_ADDED, __childAdded);
		menuBar.removeEventListener(ContainerEvent.COM_REMOVED, __childRemoved);
		menuBar.removeEventListener(AWEvent.FOCUS_GAINED, __barFocusGained);
		menuBar.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __barKeyDown);
	}
	
	//-----------------

	/**
	 * Subclass override this to process key event.
	 */
	public function processKeyEvent(code : Int) : Void{
		var manager:MenuSelectionManager = MenuSelectionManager.defaultManager();
		if(manager.isNavigatingKey(code)){
			var subs:Array<Dynamic>= menuBar.getSubElements();
			var path:Array<Dynamic>= [menuBar];
			if(subs.length > 0){
				if(manager.isNextItemKey(code) || manager.isNextPageKey(code)){
					path.push(subs[0]);
				}else{//left
					path.push(subs[subs.length-1]);
				}
				var smu:MenuElement = AsWingUtils.as(path[1],MenuElement);
				if(smu.getSubElements().length > 0){
					path.push(smu.getSubElements()[0]);
				}
				manager.setSelectedPath(menuBar.stage, path, false);
			}
		}
	}
	
	private function __barKeyDown(e:FocusKeyEvent):Void{
		if(MenuSelectionManager.defaultManager().getSelectedPath().length == 0){
			processKeyEvent(e.keyCode);
		}
	}
	
	private function __menuSelectionChanged(e:InteractiveEvent):Void{
		for(i in 0...menuBar.getComponentCount()){
			var menu:JMenu = menuBar.getMenu(i);
			if(menu != null && menu.isSelected()){
				menuBar.getSelectionModel().setSelectedIndex(i, e.isProgrammatic());
				break;
			}
		}
	}
	
	private function __barFocusGained(e:AWEvent):Void{
		MenuSelectionManager.defaultManager().setSelectedPath(menuBar.stage, [menuBar], false);
	}
	
	private function __childAdded(e:ContainerEvent):Void{
		if (Std.is(e.getChild() , JMenu)) {
			AsWingUtils.as(e.getChild(),JMenu).addSelectionListener(__menuSelectionChanged);
		}
	}
	
	private function __childRemoved(e:ContainerEvent):Void{
		if(Std.is(e.getChild() , JMenu)){
			AsWingUtils.as(e.getChild(),JMenu).removeSelectionListener(__menuSelectionChanged);
		}
	}
}