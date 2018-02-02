/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
 

import org.aswing.CellEditor;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.event.FocusKeyEvent;
	import org.aswing.event.AWEvent;
	import org.aswing.event.CellEditorListener;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntPoint;
	import org.aswing.table.TableCellEditor;
import org.aswing.tree.TreeCellEditor;
import org.aswing.util.ArrayUtils;
import org.aswing.error.ImpMissError;
import flash.events.Event;
import org.aswing.AWKeyboard;

/**
 * @author paling
 */
class AbstractCellEditor implements CellEditor implements TableCellEditor implements TreeCellEditor{
	
	private var listeners:Array<Dynamic>;
	private var clickCountToStart:Int;
	
	private var popup:JPopup;
	
	public function new(){
		listeners = new Array<Dynamic>();
		clickCountToStart = 0;
		popup = new JPopup();
		popup.setLayout(new EmptyLayout());
	}
	
    /**
     * Specifies the number of clicks needed to start editing.
     * Default is 0.(mean start after pressed)
     * @param count  an int specifying the number of clicks needed to start editing
     * @see #getClickCountToStart()
     */
    public function setClickCountToStart(count:Float):Void{
		clickCountToStart = Std.int(count);
    }

    /**
     * Returns the number of clicks needed to start editing.
     * @return the number of clicks needed to start editing
     */
    public function getClickCountToStart():Float{
		return clickCountToStart;
    }	
    
    /**
     * Calls the editor's component to update UI.
     */
    public function updateUI():Void{
    	getEditorComponent().updateUI();
    }    
    
    public function getEditorComponent():Component{
		throw new ImpMissError();
		return null;
    }
	
	public function getCellEditorValue():Dynamic{		
		throw new ImpMissError();
		return null;
	}
	
   /**
    * Sets the value of this cell. Subclass must override this method to 
    * make editor display this value.
    * @param value the new value of this cell
    */
	private function setCellEditorValue(value:Dynamic):Void{		
		throw new ImpMissError();
 
	}

	public function isCellEditable(clickCount : Int) : Bool{
		return clickCount == clickCountToStart;
	}

	public function startCellEditing(owner : Container, value:Dynamic, bounds : IntRectangle) : Void{
		popup.changeOwner(AsWingUtils.getOwnerAncestor(owner));
		var gp:IntPoint = owner.getGlobalLocation().move(bounds.x, bounds.y);
		popup.setSizeWH(bounds.width, bounds.height);
		popup.show();
		popup.setGlobalLocation(gp);
		popup.validate();
		popup.toFront();
		
		var com:Component = getEditorComponent();
		com.removeEventListener(AWEvent.ACT, __editorComponentAct);
		com.removeEventListener(AWEvent.FOCUS_LOST, __editorComponentFocusLost);
		com.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __editorComponentKeyDown);
		com.setSizeWH(bounds.width, bounds.height);
		popup.append(com);
		setCellEditorValue(value);
		com.requestFocus();
		//if com is a container and can't has focus, then focus its first sub child.
		if(Std.is(com,Container)&& !com.isFocusOwner()){
			var con:Container = AsWingUtils.as(com,Container);
			var sub:Component;
			sub = con.getFocusTraversalPolicy().getDefaultComponent(con);
			if(sub != null) sub.requestFocus();
			if(sub == null || !sub.isFocusOwner()){
				for(i in 0...con.getComponentCount()){
					sub = con.getComponent(i);
					sub.requestFocus();
					if(sub.isFocusOwner()){
						break;
					}
				}
			}
		}
		com.addEventListener(AWEvent.ACT, __editorComponentAct);
		com.addEventListener(AWEvent.FOCUS_LOST, __editorComponentFocusLost);
		com.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __editorComponentKeyDown);
		com.validate();
	}
	
	private function __editorComponentFocusLost(e:Event):Void{ 
		cancelCellEditing();
	}
	
	private function __editorComponentAct(e:Event):Void{
		stopCellEditing();
	}
	
	private function __editorComponentKeyDown(e:FocusKeyEvent):Void{
		if(Std.int(e.keyCode) == AWKeyboard.ESCAPE){
			cancelCellEditing();
		}
	}

	public function stopCellEditing() : Bool{
		removeEditorComponent();
		fireEditingStopped();
		return true;
	}

	public function cancelCellEditing() : Void{
		removeEditorComponent();
		fireEditingCanceled();
	}
	
	public function isCellEditing() : Bool{
		var editorCom:Component = getEditorComponent();
		return editorCom != null && editorCom.isShowing();
	}

	public function addCellEditorListener(l : CellEditorListener) : Void{
		listeners.push(l);
	}

	public function removeCellEditorListener(l : CellEditorListener) : Void{
		ArrayUtils.removeFromArray(listeners, l);
	}
	
	private function fireEditingStopped():Void{
		for(i in 0...listeners.length ){
			var l:CellEditorListener = AsWingUtils.as(listeners[i],CellEditorListener);
			l.editingStopped(this);
		}
	}
	private function fireEditingCanceled():Void{
		for(i in 0...listeners.length ){
			var l:CellEditorListener =  AsWingUtils.as(listeners[i],CellEditorListener);
			l.editingCanceled(this);
		}
	}
	
	private function removeEditorComponent():Void{
		getEditorComponent().removeFromContainer();
		popup.dispose();
	}
}