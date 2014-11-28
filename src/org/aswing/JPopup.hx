/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import haxe.CallStack;
import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import org.aswing.error.Error;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.aswing.util.DepthManager;
	import org.aswing.event.PopupEvent;
	import org.aswing.event.MovedEvent;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.util.ArrayList;
	/**
 * Dispatched when the popup opened.
 * @eventType org.aswing.event.PopupEvent.POPUP_OPENED
 */
// [Event(name="popupOpened", type="org.aswing.event.PopupEvent")]
	
/**
 *  Dispatched when the popup closed(hidden or disposed).
 *  @eventType org.aswing.event.PopupEvent.POPUP_CLOSED
 */
// [Event(name="popupClosed", type="org.aswing.event.PopupEvent")]

/**
 * JPopup is a component that generally be a base container of a window panel.
 * <p>
 * <b>Note:</b>
 * You should call <code>dispose()</code> to remove a JPopup from stage.<br>
 * You'd better call <code>AsWingManager.setRoot(theRoot)</code> to set a root 
 * for all popup as default root when application initialization.
 * </p>
 * @see org.aswing.JWindow
 * @author paling
 */
class JPopup extends JRootPane{
		
	private var ground_mc:Sprite;
	private var modalMC:Sprite;
	private var owner:Dynamic;
	private var modal:Bool;
	
	private var ownedEquipedPopups:Array<JPopup>;
	private var lastLAF:Dynamic;	
	
	/**
	 * Create a JPopup
	 * @param owner the owner of this popup, it can be a DisplayObjectContainer or a JPopup, default it is default 
	 * is <code>AsWingManager.getRoot()</code>
	 * @param modal true for a modal dialog, false for one that allows other windows to be active at the same time,
	 *  default is false.
	 * @see org.aswing.AsWingManager#getRoot()
	 * @throw AsWingManagerNotInited if not specified the owner, and aswing default root is not specified either.
	 * @throw TypeError if the owner is not a JPopup nor DisplayObjectContainer
	 */
	public function new(owner:Dynamic=null, modal:Bool=false){
		super();
		if(owner == null){
			owner = AsWingManager.getRoot(false);
		}
		if(Std.is(owner,JPopup)|| Std.is(owner,DisplayObjectContainer)){
			this.owner = owner;
		}else if(owner != null){
			throw new Error(this + " JPopup's owner is not a DisplayObjectContainer or JPopup, owner is : " + owner);
		}
		this.modal = modal;
		setName("JPopup");
		
		ground_mc = new Sprite();
		 
		ground_mc.name = "ground_mc";
		ground_mc.visible = false;
		
		lastLAF = UIManager.getLookAndFeel();
		
		modalMC = new Sprite();
		initModalMC();
		d_visible = false;
		ground_mc.addChild(modalMC);
		 
		
		ground_mc.addChild(this);
		
		
		
		ownedEquipedPopups = new Array<JPopup>();
		  addEventListener(Event.ADDED_TO_STAGE, __popupOpennedAddToList);
		   addEventListener(Event.REMOVED_FROM_STAGE, __popupOfffromDisplayList);
		 
	}
	
	private function __popupOpennedAddToList(e:Event):Void {  
		var fm:FocusManager = FocusManager.getManager(AsWingManager.getStage());
 
		if(!fm.getPopupsVector().contains(this)){
			 fm.getPopupsVector().append(this);
		}
		AsWingManager.getStage().addEventListener(Event.RESIZE, __resetModelMCWhenStageResized, false, 0, false);
	}
	private function __popupOfffromDisplayList(e:Event):Void{
		 
		var fm:FocusManager = FocusManager.getManager(AsWingManager.getStage());
		//why 
		if (fm != null)
		{
			fm.getPopupsVector().remove(this);
			fm.uninit(); 
		
		} 
		//why
	    AsWingManager.getStage().removeEventListener(Event.RESIZE, __resetModelMCWhenStageResized);
	}
		
	/**
	 * @return true always here.
	 */
	override public function isValidateRoot():Bool{
		return true;
	}
	
	/**
	 * Sets the mouse enabled of the popup.
	 * @param b true enabled, false, disabled.
	 */
	override public function setEnabled(b:Bool):Void{
		super.setEnabled(b);
		ground_mc.mouseEnabled = isEnabled();
	}
	
	/**
	 * This will return the owner of this JPopup, it maybe a DisplayObjectContainer maybe a JPopup.
	 */
	public function getOwner():Dynamic{
		return owner;
	}
	
	/**
	 * This will return the owner of this JPopup, it return a JPopup if
	 * this window's owner is a JPopup, else return null;
	 * @return the owner.
	 */
	public function getPopupOwner():JPopup{
		return AsWingUtils.as(owner,JPopup)	;
	}
	
	/**
	 * Returns the owner as <code>DisplayObjectContainer</code>, null if it is not <code>DisplayObjectContainer</code>.
	 * @return the owner.
	 */
	public function getDisplayOwner():DisplayObjectContainer{
		return AsWingUtils.as(owner,DisplayObjectContainer)	;
	}
	
	/**
	 * changeOwner(owner:JPopup)<br>
	 * changeOwner(owner:MovieClip)
	 * <p>
	 * Changes the owner. While the popup is displayable, you can't change the owner of it.
	 * @param owner the new owner to apply, if null passed, it will be <code>AsWingManager.getRoot()</code>
	 * @return true if changed successfully, false otherwise
	 */
	public function changeOwner(owner:Dynamic):Void{
		if(owner == null){
			owner = AsWingManager.getRoot(false);
		}
		if(this.owner != owner){
			this.owner = owner;
			if(isAddedToList()){
				if(owner == null){
					throw new Error("This popup is alreay on display list, can't be owned to null, please dispose it first.");
				}else{
					equipPopupContents();
				}
			}
		}
	}
	
	/**
	 * Specifies whether this dialog should be modal.
	 */
	public function setModal(m:Bool):Void{
		if(modal != m){
			modal = m;
			modalMC.visible = modal;
			resetModalMC();
		}
	}
	
	/**
	 * Returns is this dialog modal.
	 */
	public function isModal():Bool{
		return modal;
	}	
	
			
	/**
	 * Shortcut of <code>setVisible(true)</code>
	 */
	public function show():Void{
		setVisible(true);
	}
	
	public function getGroundContainer():DisplayObjectContainer{
		return ground_mc;
	}
	
	/**
	 * Shows or hides the Popup. 
	 * <p>Shows the window when set visible true, If the Popup and/or its owner are not yet displayable(and if Owner is a JPopup),
	 * both are made displayable. The Popup will be made visible and bring to top;
	 * <p>Hides the window when set visible false, just hide the Popup's MCs.
	 * @param v true to show the window, false to hide the window.
	 * @throws Error if the window has not a {@link JPopup} or <code>MovieClip</code> owner currently, 
	 * generally this should be never occur since the default owner is <code>_root</code>.
	 * @see #show()
	 * @see #hide()
	 */	
	override public function setVisible(v:Bool):Void{
		if(v != visible || (v && !isAddedToList())){
			super.setVisible(v);
			
			if(v)	{
				if(!isAddedToList()){
					equipPopupContents();
				}
				resetModalMC();
				dispatchEvent(new PopupEvent(PopupEvent.POPUP_OPENED));
			}else{
				dispatchEvent(new PopupEvent(PopupEvent.POPUP_CLOSED));
			}
		}
		ground_mc.visible = shouldGroundVisible();
		if(v)	{
			toFront();
		}
	}
	
	/**
	 * JPopup pack will revalidate if necessary. 
	 * So JPopup pack call will always make effect if preferred size has changed.
	 */
	override public function pack():Void{
		super.pack();
		revalidateIfNecessary();
	}
	
	private function isAddedToList():Bool{
		return ground_mc.parent != null;
	}
	
	/**
	 * Shortcut of <code>setVisible(false)</code>
	 */
	public function hide():Void{
		setVisible(false);
	}
	
	/**
	 * Remove all of this window's source movieclips.(also the components in this window will be removed too)
	 */
    public function dispose():Void {
		
		if(isAddedToList()){
			var st:Stage = AsWingManager.getStage();
			d_visible = false;
			//TODO check this
			//getPopupOwner().removeEventListener(listenerToOwner);
			disposeProcess(st);
			if (ground_mc.parent != null)
			{
				ground_mc.parent.removeChild(ground_mc);
			}
			 
			if (getPopupOwner() != null) { 
				getPopupOwner().removeOwnedEquipedPopup(this);
			}
		    
			dispatchEvent(new PopupEvent(PopupEvent.POPUP_CLOSED));
			 
		}
		
	}
	
	/**
	 * override this method to do process when disposing
	 */
	private function disposeProcess(st:Stage):Void{
		 
			 
		 
			removeEventListener(Event.REMOVED_FROM_STAGE, __popupOfffromDisplayList);
	 
			removeEventListener(Event.ADDED_TO_STAGE, __popupOpennedAddToList);
			 
		 
	}
	/**
	 * Returns should ground be visible through.
	 * This method will call <code>owner.shouldOwnedPopupGroundVisible()</code>.
	 */
	public function shouldGroundVisible():Bool{
		var pOwner:JPopup = getPopupOwner();
		if(pOwner != null){
			return pOwner.shouldOwnedPopupGroundVisible(this);
		}
		return isVisible();
	}	
	
	/**
	 * Returns should owned popup ground be visible.
	 */
	public function shouldOwnedPopupGroundVisible(popup:JPopup):Bool{
		return popup.isVisible();
	}
	
	/**
	 * If this Popup is visible, sends this Popup to the back and may cause it to lose 
	 * focus or activation if it is the focused or active Popup.
	 * <p>Infact this sends this JPopup to the back of all the MCs in its owner's MC
	 *  except it's owner's root_mc, it's owner is always below it.<br>
	 * @see #toFront()
	 */
	public function toBack():Void{
		if(isAddedToList() && isVisible()){
			var po:JPopup = getPopupOwner();
			if(po == null){
				if(!DepthManager.isBottom(ground_mc)){
					DepthManager.bringToBottom(ground_mc);
				}
			}else {
				if (po.parent != null)
				{
					var destIndex:Int= po.parent.getChildIndex(po)+1;
					if(ground_mc!=null&&ground_mc.parent!=null&&(ground_mc.parent.getChildIndex(ground_mc)) != destIndex){
						ground_mc.parent.setChildIndex(ground_mc, destIndex);
					}
				}
			}
		}
	}
	
	/**
	 * If this Popup is visible, brings this Popup to the front and may make it the focused Popup.
	 * <p>Infact this brings this JPopup to the front in his owner, all owner's MovieClips' front.
	 * @see #toBack()
	 */
	public function toFront():Void{
		if(isAddedToList() && isVisible()){
			if(!DepthManager.isTop(ground_mc)){
				DepthManager.bringToTop(ground_mc);	
			}
		}
	}
	
	private var lastDragPos:IntPoint;
	override public function startDrag(lockCenter:Bool=false, bounds:Rectangle=null):Void{
		if(AsWingManager.getStage()!=null)	{
			super.startDrag(lockCenter, bounds);
			AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __dragMoving);
			AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_MOVE, __dragMoving, false, 0, false);
			lastDragPos = getLocation();
		}
	}
	
	override public function stopDrag():Void{
		super.stopDrag();
		if(AsWingManager.getStage()!=null)	{
			AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __dragMoving);
		}
	}
	
	private function __dragMoving(e:MouseEvent):Void{
		bounds.x = Std.int(d_x);
		bounds.y = Std.int(d_y);
		var newPos:IntPoint = getLocation();
		if(!newPos.equals(lastDragPos)){
			dispatchEvent(new MovedEvent(lastDragPos, newPos));
		}
		lastDragPos = newPos;
	}
	
	/**
	 * Returns all displable windows currently on specified stage. A window was disposed or destroied will not 
	 * included by this array.
	 * @param st the stage, if it is null, the <code>AsWingManager.getStage()</code> will be called.
	 * @return all displable windows currently.
	 * @see JPopup#getPopups()
	 */
	public static function getPopups(st:Stage=null):Array<Dynamic>{
		if (st == null){
			st = AsWingManager.getStage();
		}
		var fm:FocusManager = FocusManager.getManager(st);
		return fm.getPopupsVector().toArray();
	}
	
	/**
	 * Return an array containing all the popups this popup currently owns.
	 */
	public function getOwnedPopups():Array<Dynamic>{
		return getOwnedPopupsWithOwner(this);
	}
	
	/**
	 * Returns an array containing all the popups that is equiped and is this popup currently owns.
	 * <p>
	 * Whether a popup is Equiped, based on whether the popup is shown(by <code>show()</code> or 
	 * <code>setVisible(true)</code>) and not disposed(<code>dispose()</code>).
	 * </p>
	 */	
	public function getOwnedEquipedPopups():Array<JPopup>{
		return ownedEquipedPopups ;
	}
		
	/**
	 * getOwnedPopupsWithOwner(owner:JPopup)<br>
	 * getOwnedPopupsWithOwner(owner:DisplayObjectContainer)
	 * <p>
	 * Returns owned windows of the specifid owner.
	 * @return owned windows of the specifid owner.
	 */
	public static function getOwnedPopupsWithOwner(owner:DisplayObjectContainer):Array<Dynamic>{
		var fm:FocusManager = FocusManager.getManager(AsWingManager.getStage());
		if(fm!=null)	{
			var ws:Array<Dynamic>= new Array<Dynamic>();
			var pv:ArrayList = fm.getPopupsVector();
			var n:Int= pv.size();
			for(i in 0...n){
				var w:JPopup = AsWingUtils.as(pv.get(i),JPopup);
				if(w.getOwner() == owner){
					ws.push(w);
				}
			}
			return ws;
		}else{
			return [];
		}
	}	
	
	/**
	 * Returns the window's ancestor display object which it/it's owner is created on.
	 * @return the ancestor display object of this window 
	 */
	public function getPopupAncestorMC():DisplayObjectContainer{
		var ow:JPopup = this;
		while(ow.getPopupOwner() != null){
			ow = ow.getPopupOwner();
		}
		return ow.getDisplayOwner();
	}
	
	/**
	 * This is just for PopupUI to draw modalMC face.
	 * @return the modal sprite
	 */
	public function getModalMC():Sprite{
		return modalMC;
	}
	
	/**
	 * Resets the modal mc to cover the hole screen
	 */
	public function resetModalMC():Void{
		if(!isModal()){
			modalMC.width = 0;
			modalMC.height = 0;
			modalMC.visible = false;
			return;
		}
		modalMC.visible = true;
		//TODO modal
		var globalBounds:IntRectangle = AsWingUtils.getVisibleMaximizedBounds(ground_mc);
		modalMC.width = globalBounds.width + 200;
		modalMC.height = globalBounds.height + 200;
		modalMC.x = globalBounds.x - 100;
		modalMC.y = globalBounds.y - 100;
	}
		
	private function initModalMC():Void {
		#if(flash9)
		modalMC.tabEnabled = false;
		#end
		modalMC.visible = modal;
    	modalMC.graphics.clear();
    	var modalColor:ASColor = new ASColor(0, 0);
		var g:Graphics2D = new Graphics2D(modalMC.graphics);
		g.fillRectangle(new SolidBrush(modalColor), 0, 0, 1, 1);
	}	
	
	private function addOwnedEquipedPopup(pop:JPopup):Void{
		ownedEquipedPopups.push(pop);
	}
	
	private function removeOwnedEquipedPopup(pop:JPopup):Void{
		ownedEquipedPopups.remove(pop);
	}
	
	//--------------------------------------------------------
		
	private function __resetModelMCWhenStageResized(e:Event):Void{
		if(isVisible()){
			resetModalMC();
		}
	}
	
	private function equipPopupContents():Void{
		if(Std.is(owner,JPopup)){
			var jwo:JPopup = AsWingUtils.as(owner,JPopup);
			jwo.ground_mc.addChild(ground_mc);
			jwo.addOwnedEquipedPopup(this);
		}else if(Std.is(owner,DisplayObjectContainer)){
			var ownerMC:DisplayObjectContainer = AsWingUtils.as(owner,DisplayObjectContainer);
			ownerMC.addChild(ground_mc);
		}else{
			throw new  Error(this + " JPopup's owner is not a mc or JPopup, owner is : " + owner);
			 
		}
		if(lastLAF != UIManager.getLookAndFeel()){
			AsWingUtils.updateChildrenUI(this);
			lastLAF = UIManager.getLookAndFeel();
		}
	}
}
