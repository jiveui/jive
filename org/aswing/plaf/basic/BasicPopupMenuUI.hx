package org.aswing.plaf.basic;


import org.aswing.JPopupMenu;
	import org.aswing.Component;
	import org.aswing.LayoutManager;
	import org.aswing.MenuSelectionManager;
	import org.aswing.MenuElement;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.MenuElementUI;
	import org.aswing.plaf.UIResource;
	/**
 * @private
 * @author paling
 */
class BasicPopupMenuUI extends BaseComponentUI  implements MenuElementUI{

	private var popupMenu:JPopupMenu;
	
	public function new() {
		super();
	}
	
	override public function installUI(c:Component):Void{
		popupMenu = AsWingUtils.as(c,JPopupMenu);
		installDefaults();
		installListeners();
	}

	override public function uninstallUI(c:Component):Void{
		popupMenu = AsWingUtils.as(c,JPopupMenu);
		uninstallDefaults();
		uninstallListeners();
	}
	
	private function getPropertyPrefix():String{
		return "PopupMenu.";
	}

	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
        LookAndFeel.installColorsAndFont(popupMenu, pp);
        LookAndFeel.installBorderAndBFDecorators(popupMenu, pp);
        LookAndFeel.installBasicProperties(popupMenu, pp);
		var layout:LayoutManager = popupMenu.getLayout();
		if(layout == null || Std.is(layout,UIResource)){
			popupMenu.setLayout(new DefaultMenuLayout(DefaultMenuLayout.Y_AXIS));
		}
	}
	
	private function installListeners():Void{
	}

	private function uninstallDefaults():Void{
		LookAndFeel.uninstallBorderAndBFDecorators(popupMenu);
	}
	
	private function uninstallListeners():Void{
	}
	
	override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		//do nothing, border will do this job
	}
	
	//-----------------
	
	/**
	 * Subclass override this to process key event.
	 */
	public function processKeyEvent(code : Int) : Void{
		var manager:MenuSelectionManager = MenuSelectionManager.defaultManager();
		var path:Array<Dynamic>= manager.getSelectedPath();
		if(path[path.length-1] != popupMenu){
			return;
		}
		var root:MenuElement;
		var prev:MenuElement;
		var subs:Array<Dynamic>;
		if(manager.isPrevPageKey(code)){
			if(path.length > 2){
				path.pop();
			}
			if(path.length == 2 && !(	Std.is(path[0] , JPopupMenu))){ //generally means jmenubar here
				root = AsWingUtils.as(path[0],MenuElement);
				prev = manager.prevSubElement(root, AsWingUtils.as(path[1],MenuElement));
				path.pop();
				path.push(prev);
				if(prev.getSubElements().length > 0){
					var prevPop:MenuElement = AsWingUtils.as(prev.getSubElements()[0],MenuElement);
					path.push(prevPop);
					if(prevPop.getSubElements().length > 0){
						path.push(prevPop.getSubElements()[0]);
					}
				}
			}else{
				subs = popupMenu.getSubElements();
				if(subs.length > 0){
					path.push(subs[subs.length-1]);
				}
			}
			manager.setSelectedPath(popupMenu.stage, path, false);
		}else if(manager.isNextPageKey(code)){
			root = AsWingUtils.as(path[0],MenuElement);
			if(root.getSubElements().length > 1 && !(Std.is(root,JPopupMenu))){
				var next:MenuElement = manager.nextSubElement(root, AsWingUtils.as(path[1],MenuElement));
				path = [root];
				path.push(next);
				if(next.getSubElements().length > 0){
					var nextPop:MenuElement = AsWingUtils.as(next.getSubElements()[0],MenuElement);
					path.push(nextPop);
					if(nextPop.getSubElements().length > 0){
						path.push(nextPop.getSubElements()[0]);
					}
				}
			}else{
				subs = popupMenu.getSubElements();
				if(subs.length > 0){
					path.push(subs[0]);
				}
			}
			manager.setSelectedPath(popupMenu.stage, path, false);
		}else if(manager.isNextItemKey(code)){
			subs = popupMenu.getSubElements();
			if(subs.length > 0){
				if(manager.isPrevItemKey(code)){
					path.push(subs[subs.length-1]);
				}else{
					path.push(subs[0]);
				}
			}
			manager.setSelectedPath(popupMenu.stage, path, false);
		}
	}	   
	
	//-----------------
		
	public static function getFirstPopup():MenuElement {
		var msm:MenuSelectionManager = MenuSelectionManager.defaultManager();
		var p:Array<Dynamic>= msm.getSelectedPath();
		var me:MenuElement = null;		
	//	for(var i:Number = 0 ; me == null && i < p.length ; i++) {
		for(i in 0...p.length ){
			if (	Std.is(p[i] ,JPopupMenu)){
				me = p[i];
			}
		}
	
		return me;
	}
	
	public static function getLastPopup():MenuElement {
		var msm:MenuSelectionManager = MenuSelectionManager.defaultManager();
		var p:Array<Dynamic>= msm.getSelectedPath();
		var me:MenuElement = null;		
	//for(var i:Number = p.length-1 ; me == null && i >= 0 ; i--) {
		var i:Int = p.length - 1 ;  
		while(i >= 0  ){
			if (	Std.is(p[i] , JPopupMenu)){
				me = p[i];
			}
			i--;
		}
	
		return me;
	}
	
}