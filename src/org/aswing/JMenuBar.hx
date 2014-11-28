/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.error.Error;
import org.aswing.plaf.EmptyLayoutUIResourse;
	import org.aswing.plaf.ComponentUI;
	import org.aswing.plaf.MenuElementUI;
	import org.aswing.plaf.basic.BasicMenuBarUI;
import flash.events.Event;
import org.aswing.event.ContainerEvent;

/**
 * An implementation of a menu bar. You add <code>JMenu</code> objects to the
 * menu bar to construct a menu. When the user selects a <code>JMenu</code>
 * object, its associated <code>JPopupMenu</code> is displayed, allowing the
 * user to select one of the <code>JMenuItems</code> on it.
 * @author paling
 */
class JMenuBar extends Container  implements MenuElement{
	
	private var selectionModel:SingleSelectionModel;
	private var menuInUse:Bool;
	
	public function new() {
		super();
		setSelectionModel(new DefaultSingleSelectionModel());
		_layout = new EmptyLayoutUIResourse();
		menuInUse = false;
		
		addEventListener(Event.REMOVED_FROM_STAGE, __menuBarDestroied);
		addEventListener(Event.ADDED_TO_STAGE, __menuBarCreated);
		addEventListener(ContainerEvent.COM_ADDED, __menuBarChildAdd);
		addEventListener(ContainerEvent.COM_REMOVED, __menuBarChildRemove);
		
		updateUI();
	}

	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
	/**
	 * Sets the ui.
	 * <p>
	 * The ui should implemented <code>MenuElementUI</code> interface!
	 * </p>
	 * @param newUI the newUI
	 * @throws ArgumentError when the newUI is not an <code>MenuElementUI</code> instance.
	 */
    override public function setUI(newUI:ComponentUI):Void{
    	if(Std.is(newUI,MenuElementUI)){
    		super.setUI(newUI);
    	}else{
    		throw new Error("JMenuBar just accept MenuElementUI instance!!!");  
    	}
    }
    
    /**
     * Returns the ui for this frame with <code>MenuElementUI</code> instance
     * @return the menu element ui.
     */
    public function getMenuElementUI():MenuElementUI{
    	return AsWingUtils.as( getUI() , MenuElementUI);
    }
	
	override public function getUIClassID():String{
		return "MenuBarUI";
	}
	
	override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicMenuBarUI;
    }
	
	/**
	 * Adds a menu to the menu bar.
	 * @param menu the menu to be added
	 * @return the menu be added
	 */
	public function addMenu(menu:JMenu):JMenu{
		append(menu);
		return menu;
	}
	
	/**
	 * Returns the menu component at index, if it is not a menu component at that index, null will be returned.
	 * @return a menu instance or null
	 */
	public function getMenu(index:Int):JMenu{
		var com:Component = getComponent(index);
		if(Std.is(com,JMenu)){
			return AsWingUtils.as(com,JMenu);
		}else{
			return null;
		}
	}
	
	/**
	 * Returns the model object that handles single selections.
	 *
	 * @return the <code>SingleSelectionModel</code> property
	 * @see SingleSelectionModel
	 */
	public function getSelectionModel():SingleSelectionModel {
		return selectionModel;
	}

	/**
	 * Sets the model object to handle single selections.
	 *
	 * @param model the <code>SingleSelectionModel</code> to use
	 * @see SingleSelectionModel
	 */
	public function setSelectionModel(model:SingleSelectionModel):Void{
		selectionModel = model;
	}	

	/**
	 * Sets the currently selected component, producing a
	 * a change to the selection model.
	 *
	 * @param sel the <code>Component</code> to select
	 */
	public function setSelected(sel:Component):Void{	
		var model:SingleSelectionModel = getSelectionModel();
		var index:Int= getIndex(sel);
		model.setSelectedIndex(index);
	}

	/**
	 * Returns true if the menu bar currently has a component selected.
	 *
	 * @return true if a selection has been made, else false
	 */
	public function isSelected():Bool{	   
		return selectionModel.isSelected();
	}	
		
	//--------------------------------------------------------------
	//					MenuElement imp
	//--------------------------------------------------------------
		
	public function menuSelectionChanged(isIncluded : Bool) : Void{
	}

	private function __menuBarDestroied(e:Event):Void{
		setInUse(false);
	}
	
	private function __menuBarCreated(e:Event):Void{
		setInUse(true);
	}
	
	private function __menuBarChildAdd(e:ContainerEvent) : Void{
		if(Std.is(e.getChild() , MenuElement)){
			AsWingUtils.as(e.getChild(),MenuElement).setInUse(isInUse());
		}
	}

	private function __menuBarChildRemove(e:ContainerEvent) : Void{
		if(Std.is(e.getChild() , MenuElement)){
			AsWingUtils.as(e.getChild(),MenuElement).setInUse(false);
		}
	}
	
	public function getSubElements() : Array<Dynamic>{
		var arr:Array<Dynamic>= new Array<Dynamic>();
		for(i in 0...getComponentCount()){
			var com:Component = getComponent(i);
			if(Std.is(com,MenuElement)){
				arr.push(com);
			}
		}
		return arr;
	}
		
	public function getMenuComponent():Component{
		return this;
	}
	
	public function processKeyEvent(code : Int) : Void{
		getMenuElementUI().processKeyEvent(code);
	}
	
    public function setInUse(b:Bool):Void{
    	if(menuInUse != b){
	    	menuInUse = b;
	    	var subs:Array<Dynamic>= getSubElements();
	    	for(i in 0...subs.length){
	    		var ele:MenuElement = AsWingUtils.as(subs[i],MenuElement);
	    		ele.setInUse(b);
	    	}
    	}
    }
    
    public function isInUse():Bool{
    	return menuInUse;
    }	
}