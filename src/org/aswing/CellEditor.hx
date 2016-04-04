/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
 

import org.aswing.Container;
import org.aswing.event.CellEditorListener;
import org.aswing.geom.IntRectangle;

/**
 * This interface defines the methods any general editor should be able
 * to implement. 
 * <p>
 * Having this interface enables complex components (the client of the
 * editor) such as <code>JList</code>, <code>JTree</code>, and
 * <code>JTable</code> to allow any generic editor to
 * edit values in a table cell, or tree cell, etc.  Without this generic
 * editor interface, <code>JTable</code> would have to know about specific editors,
 * such as <code>JTextField</code>, <code>JCheckBox</code>, <code>JComboBox</code>,
 * etc.  In addition, without this interface, clients of editors such as
 * <code>JTable</code> would not be able
 * to work with any editors developed in the future by the user
 * or a 3rd party ISV. 
 * </p>
 * <p>
 * To use this interface, a developer creating a new editor can have the
 * new component implement the interface.  Or the developer can
 * choose a wrapper based approach and provide a companion object which
 * implements the <code>CellEditor</code> interface (See
 * <code>JCellEditor</code> for example).  The wrapper approach
 * is particularly useful if the user want to use a 3rd party ISV 
 * editor with <code>JTable</code>, but the ISV didn't implement the
 * <code>CellEditor</code> interface.  The user can simply create an object 
 * that contains an instance of the 3rd party editor object and "translate"
 * the <code>CellEditor</code> API into the 3rd party editor's API.
 * </p>
 * 
 * @see org.aswing.event.CellEditorListener
 *
 * @author paling
 */
interface CellEditor {

    /**
     * Returns the value contained in the editor.
     * @return the value contained in the editor
     */
    function getCellEditorValue():Dynamic;

    /**
     * Asks the editor if it can start editing using <code>clickCount</code>.
     * <code>clickCount</code> 0 means pressed, 1 means released, 2 or more means 
     * real clicked times.<br>
     * If editing can be started this method returns true.
     * 
     * @param	clickCount		the clickCount the editor should use to consider
     *				whether to begin editing or not, 0 means pressed, 1 means released, 
     *				2 or more means real clicked times.
     * @return	true if editing can be started
     */
    function isCellEditable(clickCount:Int):Bool;

    /**
     * Returns true if the editing cell should be selected, false otherwise.
     * Typically, the return value is true, because is most cases the editing
     * cell should be selected.  However, it is useful to return false to
     * keep the selection from changing for some types of edits.
     * eg. A table that contains a column of check boxes, the user might
     * want to be able to change those checkboxes without altering the
     * selection.  (See Netscape Communicator for just such an example) 
     * Of course, it is up to the client of the editor to use the return
     * value, but it doesn't need to if it doesn't want to.
     *
     * @param	anEvent		the event the editor should use to start
     *				editing
     * @return	true if the editor would like the editing cell to be selected;
     *    otherwise returns false
     * @see #isCellEditable
     */
    //function shouldSelectCell(EventObject anEvent):Boolean;
	
	/**
	 * Tells the editor to show the edit component to start editing.
	 * @param owner the owner component of this editor
	 * @param value the currently value of this cell
	 * @param bounds the bounds of the editor in the owner coordinate system
	 */
	function startCellEditing(owner:Container, value:Dynamic, bounds:IntRectangle):Void;

    /**
     * Tells the editor to stop editing and accept any partially edited
     * value as the value of the editor.  The editor returns false if
     * editing was not stopped; this is useful for editors that validate
     * and can not accept invalid entries.
     *
     * @return	true if editing was stopped; false otherwise
     */
    function stopCellEditing():Bool;

	/**
	 * Returns is the cell editor is editing.
	 * @return true if the it is editing, false otherwise
	 */
	function isCellEditing():Bool;

    /**
     * Tells the editor to cancel editing and not accept any partially
     * edited value.
     */
    function cancelCellEditing():Void;

    /**
     * Adds a listener to the list that's notified when the editor 
     * stops, or cancels editing.
     *
     * @param	l		the CellEditorListener
     */  
    function addCellEditorListener(l:CellEditorListener):Void;

    /**
     * Removes a listener from the list that's notified
     *
     * @param	l		the CellEditorListener
     */  
    function removeCellEditorListener(l:CellEditorListener):Void;
    
    /**
     * Calls the editor's component to update UI.
     */
    function updateUI():Void;
}