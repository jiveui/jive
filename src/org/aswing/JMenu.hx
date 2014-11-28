/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.plaf.basic.BasicMenuUI;
import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import flash.events.Event;

/**
 * An implementation of a menu -- a popup window containing
 * <code>JMenuItem</code>s that
 * is displayed when the user selects an item on the <code>JMenuBar</code>.
 * In addition to <code>JMenuItem</code>s, a <code>JMenu</code> can
 * also contain <code>JSeparator</code>s. 
 * <p>
 * In essence, a menu is a button with an associated <code>JPopupMenu</code>.
 * When the "button" is pressed, the <code>JPopupMenu</code> appears. If the
 * "button" is on the <code>JMenuBar</code>, the menu is a top-level window.
 * If the "button" is another menu item, then the <code>JPopupMenu</code> is
 * "pull-right" menu.
 * </p>
 * @author paling
 */
class JMenu extends JMenuItem  implements MenuElement{
	
	/*
	 * The popup menu portion of the menu.
	 */
	private var popupMenu:JPopupMenu;
	
	private var delay:Int;
		
	public function new(text:String="", icon:Icon=null){
		super(text, icon);
		setName("JMenu");
		delay = 200;
		menuInUse = false;
		addEventListener(Event.REMOVED_FROM_STAGE, __menuDestroied);
	}

	override public function updateUI():Void{
		setUI(UIManager.getUI(this));
		if(popupMenu != null){
			popupMenu.updateUI();
		}
	}
	
	override public function getUIClassID():String{
		return "MenuUI";
	}
	
	override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicMenuUI;
    }
	
    /**
     * Returns true if the menu is a 'top-level menu', that is, if it is
     * the direct child of a menubar.
     *
     * @return true if the menu is activated from the menu bar;
     *         false if the menu is activated from a menu item
     *         on another menu
     */	
	public function isTopLevelMenu():Bool{
        if (!(Std.is(getParent() , JPopupMenu))){
            return true;
        }
        return false;
	}
	

    /**
     * Returns true if the specified component exists in the 
     * submenu hierarchy.
     *
     * @param c the <code>Component</code> to be tested
     * @return true if the <code>Component</code> exists, false otherwise
     */
    public function isMenuComponent(c:Component):Bool{
    	if(c == null){
    		return false;
    	}
        if (c == this){
            return true;
        }
        if (c == popupMenu) {
        	return true;
        }
        var ncomponents:Int= getComponentCount();
        for (i in 0 ...ncomponents ){
            var comp:Component = getComponent(i);
            if (comp == c){
                return true;
            }
            // Recursive call for the Menu case
            if (Std.is(comp,JMenu)) {
                var subMenu:JMenu = AsWingUtils.as(comp,JMenu);
                if (subMenu.isMenuComponent(c)){
                    return true;
                }
            }
        }
        return false;
    }	
	
	/**
	 * Returns the popupMenu for the Menu
	 */
	public function getPopupMenu():JPopupMenu{
		ensurePopupMenuCreated();
		return popupMenu;
	}
	
	/**
	 * Creates a new menu item with the specified text and appends
	 * it to the end of this menu.
	 *  
	 * @param s the string for the menu item to be added
	 */
	public function addMenuItem(s:String):JMenuItem {
		var mi:JMenuItem = new JMenuItem(s);
		append(mi);
		return mi;
	}
	
	/**
	 * Adds a component(generally JMenuItem or JSeparator) to this menu.
	 */
	public function append(c:Component):Void{
		getPopupMenu().append(c);
	}
	
	/**
	 * Inserts a component(generally JMenuItem or JSeparator) to this menu.
	 */
	public function insert(i:Int, c:Component):Void{
		getPopupMenu().insert(i, c);
	}
	
    /**
     * Returns the number of components on the menu.
     *
     * @return an integer containing the number of components on the menu
     */
    public function getComponentCount():Int{
        if (popupMenu != null){
            return popupMenu.getComponentCount();
        }else{
			return 0;
        }
    }
    
    /**
     * Returns the component at position <code>index</code>.
     *
     * @param n the position of the component to be returned
     * @return the component requested, or <code>null</code>
     *			if there is no popup menu or no component at the position.
     *
     */
    public function getComponent(index:Int):Component{
        if (popupMenu != null){
            return popupMenu.getComponent(index);
        }else{
			return null;
        }
    }
    
    /**
	 * Remove the specified component.
	 * @return the component just removed, null if the component is not in this menu.
	 */
    public function remove(c:Component):Component{
		if (popupMenu != null){
			return popupMenu.remove(c);
		}
		return null;
    }
    
	/**
	 * Remove the specified index component.
	 * @param i the index of component.
	 * @return the component just removed. or null there is not component at this position.
	 */	
    public function removeAt(i:Int):Component{
		if (popupMenu != null){
			return popupMenu.removeAt(i);
		}
		return null;
    }
    
    /**
	 * Remove all components in the menu.
	 */
    public function removeAll():Void{
		if (popupMenu != null){
			popupMenu.removeAll();
		}
    }
    
	/**
	 * Returns the suggested delay, in milliseconds, before submenus
	 * are popped up or down.  
	 * Each look and feel (L&F) may determine its own policy for
	 * observing the <code>delay</code> property.
	 * In most cases, the delay is not observed for top level menus
	 * or while dragging.  The default for <code>delay</code> is 0.
	 * This method is a property of the look and feel code and is used
	 * to manage the idiosyncracies of the various UI implementations.
	 * 
	 * @return the <code>delay</code> property
	 */
	public function getDelay():Int{
		return delay;
	}
	
	/**
	 * Sets the suggested delay before the menu's <code>PopupMenu</code>
	 * is popped up or down.  Each look and feel (L&F) may determine
	 * it's own policy for observing the delay property.  In most cases,
	 * the delay is not observed for top level menus or while dragging.
	 * This method is a property of the look and feel code and is used
	 * to manage the idiosyncracies of the various UI implementations.
	 *
	 * @param d the number of milliseconds to delay
	 */
	public function setDelay(d:Int):Void{
		if (d < 0){
			trace("/e/Delay must be a positive integer, ignored.");
			return;
		}
		delay = d;
	}
			
	/**
	 * Returns true if the menu's popup window is visible.
	 *
	 * @return true if the menu is visible, else false
	 */
	public function isPopupMenuVisible():Bool{
		return popupMenu != null && popupMenu.isVisible();
	}

	/**
	 * Sets the visibility of the menu's popup.  If the menu is
	 * not enabled, this method will have no effect.
	 *
	 * @param b  a boolean value -- true to make the menu visible,
	 *		   false to hide it
	 */
	public function setPopupMenuVisible(b:Bool):Void{
		var isVisible:Bool= isPopupMenuVisible();
		if (b != isVisible && (isEnabled() || !b)) {
			ensurePopupMenuCreated();
			if ((b==true) && isShowing()) {
				// Set location of popupMenu (pulldown or pullright)
		 		var p:IntPoint = getPopupMenuOrigin();
				getPopupMenu().show(this, p.x, p.y);
			} else {
				getPopupMenu().setVisible(false);
			}
		}
	}
	private function ensurePopupMenuCreated() : Void{
        if (popupMenu == null) {
            popupMenu = new JPopupMenu();
            popupMenu.setInvoker(this);
        }
	}

	private function getPopupMenuOrigin() : IntPoint {
		var p:IntPoint;
		if(Std.is(getParent() , JPopupMenu)){
			p = new IntPoint(getWidth(), 0);
			var ofx:Int= getUIPropertyNumber("Menu.submenuPopupOffsetX");
			var ofy:Int= getUIPropertyNumber("Menu.submenuPopupOffsetY");
			p.x += ofx;
			p.y += ofy;
			if(stage!=null)	{
				var rect:IntRectangle = AsWingUtils.getVisibleMaximizedBounds(this);
				var popupSize:IntDimension = getPopupMenu().getPreferredSize();
				if(p.x + popupSize.width > rect.x + rect.width){
					p.x = -ofx - popupSize.width;
				}
				if(p.y + popupSize.height > rect.y + rect.height){
					p.y = -ofy - popupSize.height + getHeight();
				}
			}
		}else{
			p = new IntPoint(0, getHeight());
			p.x += getUIPropertyNumber("Menu.menuPopupOffsetX");
			p.y += getUIPropertyNumber("Menu.menuPopupOffsetY");
		}
		return p;
	}
	
	private function getUIPropertyNumber(name:String):Int{
		var n:Int= getUI().getInt(name);
		return n;
	}
	
	private function __menuDestroied(e:Event):Void{
		if(popupMenu != null && popupMenu.isVisible()){
			popupMenu.dispose();
		}
	}
	
	//--------------------------------
	
    override public function setInUse(b:Bool):Void{
    	if(menuInUse != b){
	    	menuInUse = b;
	    	if(b)	{
	    		ensurePopupMenuCreated();
	    	}
	    	var subs:Array<Dynamic>= getSubElements();
	    	for(i in 0...subs.length){
	    		var ele:MenuElement = AsWingUtils.as(subs[i],MenuElement);
	    		ele.setInUse(b);
	    	}
	    	inUseChanged();
    	}
    }
    	
	override public function menuSelectionChanged(isIncluded : Bool) : Void{
		setSelected(isIncluded);
	}

	override public function getSubElements() : Array<Dynamic>{
        if(popupMenu == null){
            return [];
        }else{
            return [popupMenu];
        }
	}

	override public function getMenuComponent() : Component {
		return this;
	}	
}