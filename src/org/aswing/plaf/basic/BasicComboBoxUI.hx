/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import org.aswing.AWKeyboard;

import org.aswing.Component;
	import org.aswing.JComboBox;
	import org.aswing.JPopup;
	import org.aswing.JScrollPane;
	import org.aswing.JButton;
	import org.aswing.Insets;
	import org.aswing.BorderLayout;
	import org.aswing.JList;
	import org.aswing.event.AWEvent;
import org.aswing.event.FocusKeyEvent;
import org.aswing.event.ListItemEvent;
import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.ComboBoxUI;
	import org.aswing.plaf.basic.icon.ArrowIcon;
	import org.aswing.AsWingManager;
import org.aswing.util.Timer;

/**
 * Basic combo box ui imp.
 * @author paling
 * @private
 */
class BasicComboBoxUI extends BaseComponentUI  implements ComboBoxUI{
		
	private var dropDownButton:Component;
	private var box:JComboBox;
	private var popup:JPopup;
	private var scollPane:JScrollPane;
	
	private var popupTimer:Timer;
	private var moveDir:Float;
		
	public function new() {
		super();
	}
	
    override public function installUI(c:Component):Void{
    	box = AsWingUtils.as(c,JComboBox);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override public function uninstallUI(c:Component):Void{
    	box = AsWingUtils.as(c,JComboBox);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
    
	private function getPropertyPrefix():String{
		return "ComboBox.";
	}
	
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
        LookAndFeel.installBorderAndBFDecorators(box, pp);
        LookAndFeel.installColorsAndFont(box, pp);
        LookAndFeel.installBasicProperties(box, pp);
	}
    
    private function uninstallDefaults():Void{
    	LookAndFeel.uninstallBorderAndBFDecorators(box);
    }
    
	private function installComponents():Void{
		dropDownButton = createDropDownButton();
		dropDownButton.setUIElement(true);
		box.addChild(dropDownButton);
    }
	private function uninstallComponents():Void{
		box.removeChild(dropDownButton);
		if(isPopupVisible(box)){
			setPopupVisible(box, false);
		}
    }
	
	private function installListeners():Void{
		getPopupList().setFocusable(false);
		box.addEventListener(MouseEvent.MOUSE_DOWN, __onBoxPressed);
		box.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onFocusKeyDown);
		box.addEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
		box.addEventListener(Event.REMOVED_FROM_STAGE, __onBoxRemovedFromStage);
		getPopupList().addEventListener(ListItemEvent.ITEM_CLICK, __onListItemReleased,  false, 0, false);
		popupTimer = new Timer(40);
		popupTimer.addActionListener(__movePopup);
	}
    
    private function uninstallListeners():Void{
    	popupTimer.stop();
    	popupTimer = null;
		box.removeEventListener(MouseEvent.MOUSE_DOWN, __onBoxPressed);
		box.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onFocusKeyDown);
		box.removeEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
		box.removeEventListener(Event.REMOVED_FROM_STAGE, __onBoxRemovedFromStage);
		getPopupList().removeEventListener(ListItemEvent.ITEM_CLICK, __onListItemReleased);
    }
    
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		layoutCombobox();
		dropDownButton.setEnabled(box.isEnabled());
	}
        
    override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
    	//do nothing, background decorator will paint it
    }
    
    /**
     * Just override this method if you want other LAF drop down buttons.
     */
    private function createDropDownButton():Component{
    	var btn:JButton = new JButton("", new ArrowIcon(
    				Math.PI/2, 16
    	));
    	btn.setFocusable(false);
    	btn.setPreferredSize(new IntDimension(16, 16));
    	btn.setBackgroundDecorator(null);
    	btn.setMargin(new Insets());
    	btn.setBorder(null);
    	//make it proxy to the combobox
    	btn.setMideground(null);
    	btn.setStyleTune(null);
    	return btn;
    }
    
    private function getScollPane():JScrollPane{
    	if(scollPane == null){
    		scollPane = new JScrollPane(getPopupList());
    		scollPane.setBorder(getBorder(getPropertyPrefix()+"popupBorder"));
    		scollPane.setOpaque(false);
    		scollPane.setStyleProxy(box);
    		scollPane.setBackground(null);
    		scollPane.setStyleTune(null);
		 
    	}
    	return scollPane;
    }
    
    private function getPopup():JPopup{
    	if(popup == null){
    		popup = new JPopup(AsWingManager.getRoot(), false);
    		popup.setLayout(new BorderLayout());
    		popup.append(getScollPane(), BorderLayout.CENTER);
    		popup.setClipMasked(false); 
    	}
    	return popup;
    }
    
    private function getPopupList():JList{
    	return box.getPopupList();
    }
    
    private function viewPopup():Void {
 
    	if(!box.isOnStage()){
    		return;
    	}
		
		var width:Int= box.getWidth();
		var cellHeight:Int;
		if(box.getListCellFactory().isAllCellHasSameHeight()){
			cellHeight = box.getListCellFactory().getCellHeight();
		}else{
			cellHeight = box.getPreferredSize().height;
		} 
		var height:Int=Std.int( Math.min(box.getItemCount(), box.getMaximumRowCount())*cellHeight);
		var i:Insets = getScollPane().getInsets();
		 
		height += i.top + i.bottom;
		width += (i.right - i.left);
		i = getPopupList().getInsets();
 
		height += i.top + i.bottom;
		width += (i.right - i.left);
		getPopup().changeOwner(AsWingUtils.getOwnerAncestor(box)); 
		getPopup().setSizeWH(width, height);  
		getPopup().show();
		startMoveToView();
		AsWingManager.callLater(__addMouseDownListenerToStage);
    }
    
    private function __addMouseDownListenerToStage():Void{
    	if(getPopup().isVisible() && box.stage!=null){
			AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDownWhenPopuped, false, 0, false);
    	}
    }
    
    private function hidePopup():Void{
    	if(AsWingManager.getStage()!=null)	{
    		AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_DOWN, __onMouseDownWhenPopuped);
    	}
		popupTimer.stop();
    	if(getPopup().isVisible()){
			getPopup().dispose();
    	}
    }
    
    private var scrollRect:IntRectangle;
    //return the destination pos
    private function startMoveToView():Void{
    	var popupPane:JPopup = getPopup();
    	var height:Int= popupPane.getHeight();
    	var popupPaneHeight:Int= height;
    	var downDest:IntPoint = box.componentToGlobal(new IntPoint(0, box.getHeight()));
    	var upDest:IntPoint = new IntPoint(downDest.x, downDest.y - box.getHeight() - popupPaneHeight);
    	var visibleBounds:IntRectangle = AsWingUtils.getVisibleMaximizedBounds(popupPane.parent);
    	var distToBottom:Int= visibleBounds.y + visibleBounds.height - downDest.y - popupPaneHeight;
    	var distToTop:Int= upDest.y - visibleBounds.y;
    	var gp:IntPoint = box.getGlobalLocation();
    	if(distToBottom > 0 || (distToBottom < 0 && distToTop < 0 && distToBottom > distToTop)){
    		moveDir = 1;
    		gp.y += box.getHeight();
			scrollRect = new IntRectangle(0, height, popupPane.getWidth(), 0);
    	}else{
    		moveDir = -1;
			scrollRect = new IntRectangle(0, 0, popupPane.getWidth(), 0);
    	}
    	popupPane.setGlobalLocation(gp);
    	popupPane.setClipMaskRect(scrollRect); 
		popupTimer.restart();
    }
    
    private function setComboBoxValueFromListSelection():Void{
		var selectedValue:Dynamic = getPopupList().getSelectedValue(); 
		box.setSelectedItem(selectedValue, false);
    }
    
    //-----------------------------
    
    private function __movePopup(e:Event):Void {
			
    	var popupPane:JPopup = getPopup();
    	var popupPaneHeight:Int= popupPane.getHeight();
    	var maxTime:Int= 10;
    	var minTime:Int= 3;
    	var speed:Int= 50;
    	if(popupPaneHeight < speed*minTime){
    		speed = Math.ceil(popupPaneHeight/minTime);
    	}else if(popupPaneHeight > speed*maxTime){
    		speed = Math.ceil(popupPaneHeight/maxTime);
    	}
    	if(popupPane.getHeight() - scrollRect.height <= speed){
    		//motion ending 
    		speed =Std.int( popupPane.getHeight() - scrollRect.height);
			popupTimer.stop(); 
			getPopupList().ensureIndexIsVisible(getPopupList().getSelectedIndex());
    	}
		if(moveDir > 0){
			scrollRect.y -= speed;
			scrollRect.height += speed;
		}else{
			popupPane.y -= speed;
			scrollRect.height += speed;
		} 
    	popupPane.setClipMaskRect(scrollRect);
    }
    
    private function __onFocusKeyDown(e:FocusKeyEvent):Void{
    	var code:Int= Std.int(e.keyCode);
    	if(code == AWKeyboard.DOWN){
    		if(!isPopupVisible(box)){
    			setPopupVisible(box, true);
    			return;
    		}
    	}
    	if(code == AWKeyboard.ESCAPE){
    		if(isPopupVisible(box)){
    			setPopupVisible(box, false);
    			return;
    		}
    	}
    	if(code == AWKeyboard.ENTER && isPopupVisible(box)){
	    	hidePopup();
	    	setComboBoxValueFromListSelection();
	    	return;
    	}
    	var list:JList = getPopupList();
    	var index:Int= list.getSelectedIndex();
    	if(code == AWKeyboard.DOWN){
    		index += 1;
    	}else if(code == AWKeyboard.UP){
    		index -= 1;
    	}else if(code == AWKeyboard.PAGE_DOWN){
    		index += box.getMaximumRowCount();
    	}else if(code == AWKeyboard.PAGE_UP){
    		index -= box.getMaximumRowCount();
    	}else if(code == AWKeyboard.HOME){
    		index = 0;
    	}else if(code == AWKeyboard.END){
    		index = list.getModel().getSize()-1;
    	}else{
    		return;
    	}
    	index = Std.int(Math.max(0, Math.min(list.getModel().getSize()-1, index)));
    	list.setSelectedIndex(index, false);
    	list.ensureIndexIsVisible(index);
    }
    
    private function __onFocusLost(e:Event):Void{
    	hidePopup();
    }
    
    private function __onBoxRemovedFromStage(e:Event):Void{
    	hidePopup();
    }
    
    private function __onListItemReleased(e:Event):Void{
    	hidePopup();
    	setComboBoxValueFromListSelection();
    }
    
    private function __onBoxPressed(e:Event):Void{
    	if(!isPopupVisible(box)){
    		if(box.isEditable()){
    			if(!box.getEditor().getEditorComponent().hitTestMouse()){
    				setPopupVisible(box, true);
    			}
    		}else{
    			setPopupVisible(box, true);
    		}
    	}else{
    		hidePopup();
    	}
    }
    
    private function __onMouseDownWhenPopuped(e:Event):Void{
    	if(!getPopup().hitTestMouse() && !box.hitTestMouse()){
    		hidePopup();
    	}
    }
    
	/**
     * Set the visiblity of the popup
     */
	public function setPopupVisible(c:JComboBox, v:Bool):Void {
	
		if(v)	{
			viewPopup();
		}else{
			hidePopup();
		}
	}
	
	/** 
     * Determine the visibility of the popup
     */
	public function isPopupVisible(c:JComboBox):Bool{
		return getPopup().isVisible();
	}
	
	//---------------------Layout Implementation---------------------------
    private function layoutCombobox():Void{
    	var td:IntDimension = box.getSize();
		var insets:Insets = box.getInsets();
		var top:Int= insets.top;
		var left:Int= insets.left;
		var right:Int= td.width - insets.right;
		
		var height:Int= td.height - insets.top - insets.bottom;
    	var buttonSize:IntDimension = dropDownButton.getPreferredSize(); 
    	dropDownButton.setSizeWH(buttonSize.width, height);
    	dropDownButton.setLocationXY(right - buttonSize.width, top);
    	box.getEditor().getEditorComponent().setLocationXY(left, top);
    	box.getEditor().getEditorComponent().setSizeWH(td.width-insets.left-insets.right- buttonSize.width, height);
		box.getEditor().getEditorComponent().revalidate();
    }
    
    override public function getPreferredSize(c:Component):IntDimension{
    	var insets:Insets = box.getInsets();
    	var listPreferSize:IntDimension = getPopupList().getPreferredSize();
    	var ew:Int= listPreferSize.width;
    	var wh:Int= box.getEditor().getEditorComponent().getPreferredSize().height;
    	var buttonSize:IntDimension = dropDownButton.getPreferredSize(); 
    	buttonSize.width += ew;
    	if(wh > buttonSize.height){
    		buttonSize.height = wh;
    	}
    	return insets.getOutsideSize(buttonSize);
    }

    override public function getMinimumSize(c:Component):IntDimension{
    	return box.getInsets().getOutsideSize(dropDownButton.getPreferredSize());
    }

    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }    
}