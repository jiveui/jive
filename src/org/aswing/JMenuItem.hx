/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.error.Error;
import org.aswing.plaf.ComponentUI;
	import org.aswing.plaf.MenuElementUI;
	import org.aswing.plaf.basic.BasicMenuItemUI;

/**
 * An implementation of an item in a menu. A menu item is essentially a button
 * sitting in a list. When the user selects the "button", the action
 * associated with the menu item is performed. A <code>JMenuItem</code>
 * contained in a <code>JPopupMenu</code> performs exactly that function.
 * 
 * @author paling
 */
class JMenuItem extends AbstractButton  implements MenuElement{
	
	private var menuInUse:Bool;
	private var accelerator:KeyType;
	
	public function new(text:String="", icon:Icon=null){
		super(text, icon);
		setClipMasked(true);
		setName("JMenuItem");
		setModel(new DefaultButtonModel());
		initFocusability();
		menuInUse = false;
		accelerator = null;
		
	}
	
	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
	}
	
	override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicMenuItemUI;
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
    		throw new Error("JMenuItem just accept MenuElementUI instance!!!"); 
    	}
    }
    
    /**
     * Returns the ui for this frame with <code>MenuElementUI</code> instance
     * @return the menu element ui.
     */
    public function getMenuElementUI():MenuElementUI{
    	return AsWingUtils.as(getUI() , MenuElementUI);
    }
	
	override public function getUIClassID():String{
		return "MenuItemUI";
	}
	
    /**
     * Sets the key combination which invokes the menu item's
     * action listeners without navigating the menu hierarchy. It is the
     * UI's responsibility to install the correct action.  Note that 
     * when the keyboard accelerator is typed, it will work whether or
     * not the menu is currently displayed.
     *
     * @param keyStroke the <code>KeyType</code> which will
     *		serve as an accelerator 
     */
	public function setAccelerator(acc:KeyType):Void{
		if(accelerator != acc){
			accelerator = acc;
			revalidate();
			repaint();
		}
	}
	
    /**
     * Returns the <code>KeyType</code> which serves as an accelerator 
     * for the menu item.
     * @return a <code>KeyType</code> object identifying the
     *		accelerator key
     */	
	public function getAccelerator():KeyType{
		return accelerator;
	}
	
	/**
	 * Inititalizes the focusability of the the <code>JMenuItem</code>.
	 * <code>JMenuItem</code>'s are focusable, but subclasses may
	 * want to be, this provides them the opportunity to override this
	 * and invoke something else, or nothing at all.
	 */
	private function initFocusability():Void{
		setFocusable(false);
	}
	
	/**
	 * Returns the window that owned this menu.
	 * @return window that owned this menu, or null no window owned this menu yet.
	 */
	public function getRootPaneOwner():JRootPane{
		var pp:Component = this;
		do{
			pp = pp.getParent();
			if(Std.is(pp,JPopupMenu)){
				pp = AsWingUtils.as(pp,JPopupMenu).getInvoker();
			}
			if(Std.is(pp,JRootPane)){
				return AsWingUtils.as(pp,JRootPane);
			}
		}while(pp != null);
		return null;
	}
	
	private function inUseChanged():Void{
		var acc:KeyType = getAccelerator();
		if(acc != null){
			var rOwner:JRootPane = getRootPaneOwner();
			if(rOwner == null){
				throw new Error("The menu item has accelerator, " + 
						"it or it's popupMenu must be in a JRootPane(or it's subclass).");
				return;
			}
			var keyMap:KeyMap = rOwner.getKeyMap();
			if(keyMap != null){
				if(isInUse()){
					keyMap.registerKeyAction(acc, __acceleratorAction);
				}else{
					keyMap.unregisterKeyAction(acc);
				}
			}
		}
	}
	
	private function __acceleratorAction():Void{
		doClick();
	}
	
	//--------------------------------
	
    public function setInUse(b:Bool):Void{
    	if(menuInUse != b){
	    	menuInUse = b;
	    	inUseChanged();
    	}
    }
    
    public function isInUse():Bool{
    	return menuInUse;
    }
    
	public function menuSelectionChanged(isIncluded : Bool) : Void{
		getModel().setRollOver(isIncluded);
	}
	
	public function getSubElements() : Array<Dynamic>{
		return [];
	}
	
	public function getMenuComponent() : Component {
		return this;
	}
	
	public function processKeyEvent(code : Int) : Void{
		getMenuElementUI().processKeyEvent(code);
	}	
}