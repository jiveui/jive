/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.UIResource;
	import org.aswing.JList;
	import org.aswing.Component;
	import org.aswing.ASColor;
	import org.aswing.ListCell;
	import org.aswing.FocusManager;
	import org.aswing.event.ListItemEvent;
import org.aswing.event.FocusKeyEvent;
import org.aswing.event.AWEvent;
import org.aswing.event.SelectionEvent;
import flash.events.MouseEvent;
import org.aswing.graphics.Graphics2D;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntPoint;
	import flash.display.Graphics;
import org.aswing.AWKeyboard;

/**
 * List UI basic imp.
 * @author  paling
 * @private
 */
class BasicListUI extends BaseComponentUI{
	
	private var list:JList;
	
	public function new(){
		super();
	}
	
    override public function installUI(c:Component):Void{
        list = AsWingUtils.as(c,JList);
        installDefaults();
        installListeners();
    }
    
    private function getPropertyPrefix():String{
        return "List.";
    }
    
    private function installDefaults():Void{
        var pp:String= getPropertyPrefix();
        
        LookAndFeel.installColorsAndFont(list, pp);
        LookAndFeel.installBorderAndBFDecorators(list, pp);
        LookAndFeel.installBasicProperties(list, pp);
        
		var sbg:ASColor = list.getSelectionBackground();
		if (sbg == null || Std.is(sbg,UIResource)) {
			list.setSelectionBackground(getColor(pp+"selectionBackground"));
		}

		var sfg:ASColor = list.getSelectionForeground();
		if (sfg == null || Std.is(sfg,UIResource)) {
			list.setSelectionForeground(getColor(pp+"selectionForeground"));
		}
    }
    
    private function installListeners():Void{
    	list.addEventListener(ListItemEvent.ITEM_CLICK, __onItemClick, false, 0, false);
    	list.addEventListener(ListItemEvent.ITEM_MOUSE_DOWN, __onItemMouseDown, false, 0, false);
    	list.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown, false, 0, false);
    	list.addEventListener(AWEvent.FOCUS_LOST, __onFocusLost, false, 0, false);
    	list.addEventListener(SelectionEvent.LIST_SELECTION_CHANGED, __onSelectionChanged, false, 0, false);
    	list.addEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel, false, 0, false);
    }
	
	override public function uninstallUI(c:Component):Void{
        uninstallDefaults();
        uninstallListeners();
    }
    
    private function uninstallDefaults():Void{
        LookAndFeel.uninstallBorderAndBFDecorators(list);
    }
    
    private function uninstallListeners():Void{
    	list.removeEventListener(ListItemEvent.ITEM_CLICK, __onItemClick);
    	list.removeEventListener(ListItemEvent.ITEM_MOUSE_DOWN, __onItemMouseDown);
    	list.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
    	list.removeEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
    	list.removeEventListener(SelectionEvent.LIST_SELECTION_CHANGED, __onSelectionChanged);
    	list.removeEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
    }
    
    private  var paintFocusedIndex:Int;
    private var paintFocusedCell:ListCell;
    private var focusGraphics:Graphics2D;
    private var focusRectangle:IntRectangle;
    private var focusGraphicsOwner:Graphics;
    
	override public function paintFocus(c:Component, g:Graphics2D, b:IntRectangle):Void{
    	var fm:FocusManager = FocusManager.getManager(list.stage);
    	if(fm!=null)	{
	    	focusGraphics = g;
	    	focusRectangle = b;
	    	focusGraphicsOwner = fm.moveFocusRectUpperTo(list).graphics;
	    	paintCurrentCellFocus();
    	}
    }
        
    private function paintCurrentCellFocus():Void{
    	if(paintFocusedCell != null){
    		paintCellFocus(paintFocusedCell.getCellComponent());
    	}else{
    		super.paintFocus(list, focusGraphics, focusRectangle);
    	}
    }
    
    private function paintCellFocusWithIndex(index:Int):Void{
    	if(index < 0 || index >= list.getModel().getSize()){
    		return;
    	}
		paintFocusedCell = list.getCellByIndex(index);
		paintFocusedIndex = index;
		if(paintFocusedCell!=null)	{
			paintCellFocus(paintFocusedCell.getCellComponent());
		}
    }
    
    private function paintCellFocus(cellComponent:Component):Void{
    	if(focusGraphicsOwner!=null)	focusGraphicsOwner.clear();
    	super.paintFocus(list, focusGraphics, focusRectangle);
    	super.paintFocus(list, focusGraphics, paintFocusedCell.getCellComponent().getComBounds());
    }
    
    //----------
    private function __onMouseWheel(e:MouseEvent):Void{
		if(!list.isEnabled()){
			return;
		}
    	var viewPos:IntPoint = list.getViewPosition();
    	if(e.shiftKey)	{
    		viewPos.x -= e.delta*list.getHorizontalUnitIncrement();
    	}else{
    		viewPos.y -= e.delta*list.getVerticalUnitIncrement();
    	}
    	list.setViewPosition(viewPos);
    }
    
    private function __onFocusLost(e:AWEvent):Void{
    	if(focusGraphicsOwner!=null)	focusGraphicsOwner.clear();
    }
    
    private function __onKeyDown(e:FocusKeyEvent):Void{
		if(!list.isEnabled()){
			return;
		}
    	 
			var code:Int = e.keyCode;
			 
    	var dir:Float= 0;
    	if(code == AWKeyboard.UP || code == AWKeyboard.DOWN || code == AWKeyboard.SPACE){
    		var fm:FocusManager = FocusManager.getManager(list.stage);
	    	if(fm!=null)	fm.setTraversing(true);
    	}
    	if(code == AWKeyboard.UP){
    		dir = -1;
    	}else if(code == AWKeyboard.DOWN){
    		dir = 1;
    	}
    	
    	if(paintFocusedIndex == -1){
    		paintFocusedIndex = list.getSelectedIndex();
    	}
    	if(paintFocusedIndex < -1){
    		paintFocusedIndex = -1;
    	}else if(paintFocusedIndex > list.getModel().getSize()){
    		paintFocusedIndex = list.getModel().getSize();
    	}
    	var index:Int= Std.int(paintFocusedIndex + dir);    	
    	if(code == AWKeyboard.HOME){
    		index = 0;
    	}else if(code == AWKeyboard.END){
    		index = list.getModel().getSize() - 1;
    	}
    	if(index < 0 || index >= list.getModel().getSize()){
    		return;
    	}
    	if(dir != 0 || (code == AWKeyboard.HOME || code == AWKeyboard.END)){
		    list.ensureIndexIsVisible(index);
		    list.validate();
    		if(e.shiftKey)	{
				var archor:Int= list.getAnchorSelectionIndex();
				if(archor < 0){
					archor = index;
				}
				list.setSelectionInterval(archor, index, false);
    		}else if(e.ctrlKey)	{
    		}else{
		    	list.setSelectionInterval(index, index, false);
    		}
    		//this make sure paintFocusedCell rememberd
    		paintCellFocusWithIndex(index);
    	}else{
    		if(code == AWKeyboard.SPACE){
		    	list.addSelectionInterval(index, index, false);
    			//this make sure paintFocusedCell rememberd
    			paintCellFocusWithIndex(index);
		    	list.ensureIndexIsVisible(index);
    		}
    	}
    }
    private function __onSelectionChanged(e:SelectionEvent):Void{
    	var fm:FocusManager = FocusManager.getManager(list.stage);
    	if(fm != null && fm.isTraversing() && list.isFocusOwner()){
    		if(focusGraphics == null){
    			list.paintFocusRect(true);
    		}
    		paintCellFocusWithIndex(list.getLeadSelectionIndex());
    	}
    }
    
	//------------------------------------------------------------------------
	//                 ---------  Selection ---------
	//------------------------------------------------------------------------
    
    private var pressedIndex:Float;
    private var pressedCtrl:Bool;
    private var pressedShift:Bool;
    private var doSelectionWhenRelease:Bool;    
    
    private function __onItemMouseDown(e:ListItemEvent):Void { 
		var index:Int= list.getItemIndexByCell(e.getCell());
		pressedIndex = index;
		pressedCtrl = e.ctrlKey;
		pressedShift = e.shiftKey;
		doSelectionWhenRelease = false;
		
		if(list.getSelectionMode() == JList.MULTIPLE_SELECTION){
			if(list.isSelectedIndex(index)){
				doSelectionWhenRelease = true;
			}else{
				doSelection();
			}
		}else { 
			list.setSelectionInterval(index, index, false);
		}
    }
    
    private function doSelection():Void{
    	var index:Int= Std.int(pressedIndex);
		if (pressedShift)	{
			
			var archor:Int= list.getAnchorSelectionIndex();
			if(archor < 0){
				archor = index;
			}
			list.setSelectionInterval(archor, index, false);
		}else if(pressedCtrl)	{
			if(!list.isSelectedIndex(index)){
				list.addSelectionInterval(index, index, false);
			}else{
				list.removeSelectionInterval(index, index, false);
			}
		}else {
			
			list.setSelectionInterval(index, index, false);
		}
    }
    
    private function __onItemClick(e:ListItemEvent):Void {
	 
    	if(doSelectionWhenRelease)	{
    		doSelection();
    		doSelectionWhenRelease = false;
    	}
    }
    	
	
}