/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import jive.plaf.flat.FlatComboBoxListCellFactory;
import org.aswing.ASColor;
import bindx.Bind;
import org.aswing.error.Error;
import org.aswing.event.AWEvent;
import org.aswing.event.InteractiveEvent;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.ComboBoxUI;
import flash.events.Event;
import flash.display.InteractiveObject;
import org.aswing.plaf.basic.BasicComboBoxUI;
import org.aswing.util.Reflection;

/**
 * A component that combines a button or editable field and a drop-down list.
 * The user can select a value from the drop-down list, which appears at the 
 * user's request. If you make the combo box editable, then the combo box
 * includes an editable field into which the user can type a value.
 * <p>
 * <code>JComboBox</code> use a <code>JList</code> to be the drop-down list, 
 * so of course you can operate list to do some thing.
 * </p>
 * <p>
 * By default <code>JComboBox</code> can't count its preffered width accurately 
 * like default JList, you have to set its preffered size if you want. 
 * Or you make a not shared cell factory to it. see <code>ListCellFactory</code> 
 * and <code>JList</code> for details.
 * </p>
 * @see JList
 * @see ComboBoxEditor
 * @see DefaultComboBoxEditor
 * @author paling
 */
@:event("org.aswing.event.AWEvent.ACT", "Dispatched when the combobox act, when value set or selection changed")
@:event("org.aswing.event.InteractiveEvent.SELECTION_CHANGED", "Dispatched when the combobox's selection changed")
class JComboBox extends Component  implements EditableComponent{

    /**
     * Determines whether the <code>JComboBox</code> field is editable.
     *
     * An editable <code>JComboBox</code> allows the user to type into the
     * field or selected an item from the list to initialize the field,
     * after which it can be edited. (The editing affects only the field,
     * the list item remains intact.) A non editable <code>JComboBox</code>
     * displays the selected item in the field,
     * but the selection cannot be modified.
     */
    public var editable(get, set): Bool;
    private var _editable: Bool;
    private function get_editable(): Bool { return isEditable(); }
    private function set_editable(v: Bool): Bool { setEditable(v); return v; }

    /**
     * A maximum number of rows the <code>JComboBox</code> displays.
     *
     * If the number of objects in the model is greater than count,
     * the combo box uses a scrollbar.
     */
    public var maximumRowCount(get, set): Int;
    private var _maximumRowCount: Int;
    private function get_maximumRowCount(): Int { return getMaximumRowCount(); }
    private function set_maximumRowCount(v: Int): Int { setMaximumRowCount(v); return v; }

    /**
     * An editor used to paint and edit the selected item in the
     * <code>JComboBox</code> field.
     *
     * The editor is used both if the
     * receiving <code>JComboBox</code> is editable and not editable.
     */
    public var editor(get, set): ComboBoxEditor;
    private var _editor: ComboBoxEditor;
    private function get_editor(): ComboBoxEditor { return getEditor(); }
    private function set_editor(v: ComboBoxEditor): ComboBoxEditor { setEditor(v); return v; }

    /**
	 * The popup list that display the items.
	 */
    public var popupList(get, null): JList;
    private var _popupList:JList;
    private function get_popupList(): JList { return getPopupList(); }

    /**
	 * A cell factory for the popup List.
	 *
	 * Setting will cause all cells recreating by new factory.
	 */
    public var listCellFactory(get, set): ListCellFactory;
    private function get_listCellFactory(): ListCellFactory { return getListCellFactory(); }
    private function set_listCellFactory(v: ListCellFactory): ListCellFactory { setListCellFactory(v); return v; }

    /**
	 * A list model to provide the data to JList.
	 * @see org.aswing.ListModel
	 */
    public var model(get, set): ListModel;
    private function get_model(): ListModel { return getModel(); }
    private function set_model(v: ListModel): ListModel { setModel(v); return v; }

    /**
     * A visibility of the popup, open or close.
     */
    public var popupVisible(get, set): Bool;
    private var _popupVisible: Bool;
    private function get_popupVisible(): Bool { return isPopupVisible(); }
    private function set_popupVisible(v: Bool): Bool { setPopupVisible(v); return v; }

    /**
     * The selected item in the combo box display area.
     *
     * If <code>item</code> is in the list, the display area shows
     * <code>item</code> selected.
     * >
     * If <code>item</code> is <i>not</i> in the list and the combo box is
     * uneditable, it will not change the current selection. For editable
     * combo boxes, the selection will change to <code>item</code>.
     *
     * <code>AWEvent.ACT</code> (<code>this.addActionListener()</code>)events added to the combo box will be notified
     * when this method is called.
     *
     * <code>InteractiveEvent.SELECTION_CHANGED</code> (<code>this.addSelectionListener()</code>)events added to the combo box will be notified
     * when this method is called only when the item is different from current selected item,
     * it means that only when the selected item changed.
     */
    @bindable public var selectedItem(get, set): Dynamic;
    private function get_selectedItem(): Dynamic { return getSelectedItem(); }
    private function set_selectedItem(v: Dynamic): Dynamic { setSelectedItem(v); return v; }

    /**
    * -1 if no item is selected or the selected item is not in the list.
    **/
    @bindable public var selectedIndex(get, set): Int;
    private function get_selectedIndex(): Int { return getSelectedIndex(); }
    private function set_selectedIndex(v: Int): Int { setSelectedIndex(v); return v; }

    public var length(get, null): Int;
    private function get_length(): Int { return getItemCount(); }

    public var notEditableForeground(get, set): ASColor;
    private var _notEditableForeground: ASColor;
    private function get_notEditableForeground(): ASColor { return _notEditableForeground; }
    private function set_notEditableForeground(v: ASColor): ASColor {
        _notEditableForeground = v;
        updateEditorComponentColors();
        return v;
    }


    public var notEditableBackground(get, set): ASColor;
    private var _notEditableBackground: ASColor;
    private function get_notEditableBackground(): ASColor { return _notEditableBackground; }
    private function set_notEditableBackground(v: ASColor): ASColor {
        _notEditableBackground = v;
        updateEditorComponentColors();
        return v;
    }

	/**
	 * Create a combobox with specified data.
	 */
	public function new(listData:Dynamic=null) {
		super();
		
		setName("JComboBox");
		_maximumRowCount = 7;
		_editable = false;
		setEditor(new DefaultComboBoxEditor());
		if(listData != null){
		 if(Std.is(listData,Array)){
				setListData(AsWingUtils.as(listData,Array) );
			}else if (Std.is(listData, ListModel)) {
				setModel( AsWingUtils.as(listData, ListModel));
			}else{
				setListData([]); //create new
			}
		}
		
		updateUI();

        addEventListener(AWEvent.FOCUS_GAINED, function(e) { doFocusTransition(); });
        addEventListener(AWEvent.FOCUS_LOST, function(e) { doFocusTransition(); });
	}
	
	/**
	 * Sets the ui.
	 * <p>
	 * JComboBox ui should implemented <code>ComboBoxUI</code> interface!
	 * </p>
	 * @param newUI the newUI
	 * @throws ArgumentError when the newUI is not an <code>ComboBoxUI</code> instance.
	 */
    @:dox(hide)
	override public function setUI(newUI:ComponentUI):Void{
		if(Std.is(newUI,ComboBoxUI)){
			super.setUI(newUI);
			getEditor().getEditorComponent().setFont(getFont());
            updateEditorComponentColors();
		}else{
			throw new Error("JComboBox ui should implemented ComboBoxUI interface!"); 
		}
	}

    @:dox(hide)
	override public function updateUI():Void{
		getPopupList().updateUI();
		_editor.getEditorComponent().updateUI();
		setUI(UIManager.getUI(this));
	}

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicComboBoxUI;
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "ComboBoxUI";
	}
	
    /**
     * Returns the ui for this combobox with <code>ComboBoxUI</code> instance
     * @return the combobox ui.
     */
    @:dox(hide)
    public function getComboBoxUI():ComboBoxUI{
    	return AsWingUtils.as(getUI() , ComboBoxUI);
    }
    
	/**
	 * The ActionListener will receive an ActionEvent when a selection has been made. 
	 * If the combo box is editable, then an ActionEvent will be fired when editing has stopped.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.AWEvent#ACT
	 */
	public function addActionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(AWEvent.ACT, listener, false, priority, useWeakReference);
	}
	
	/**
	 * Removes a action listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.AWEvent#ACT
	 */
	public function removeActionListener(listener:Dynamic -> Void):Void{
		removeEventListener(AWEvent.ACT, listener, false);
	}
	
    	
	/**
	 * Add a listener to listen the combobox's selection change event.
	 * When the combobox's selection changed or a different value inputed or set programmiclly.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.InteractiveEvent#SELECTION_CHANGED
	 */	
	public function addSelectionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(InteractiveEvent.SELECTION_CHANGED, listener, false, priority);
	}

	/**
	 * Removes a selection listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.InteractiveEvent#SELECTION_CHANGED
	 */
	public function removeSelectionListener(listener:Dynamic -> Void):Void{
		removeEventListener(InteractiveEvent.SELECTION_CHANGED, listener);
	}
	
	/**
	 * Returns the popup list that display the items.
	 */
    @:dox(hide)
	public function getPopupList():JList {
		if(_popupList == null){
			_popupList = new JList(null, new FlatComboBoxListCellFactory());
			_popupList.setSelectionMode(JList.SINGLE_SELECTION);
		}
		return _popupList;
	}
	
	/**
     * Sets the maximum number of rows the <code>JComboBox</code> displays.
     * If the number of objects in the model is greater than count,
     * the combo box uses a scrollbar.
     * @param count an integer specifying the maximum number of items to
     *              display in the list before using a scrollbar
     */
    @:dox(hide)
	public function setMaximumRowCount(count:Int):Void{
		_maximumRowCount = count;
	}
	
	/**
     * Returns the maximum number of items the combo box can display 
     * without a scrollbar
     * @return an integer specifying the maximum number of items that are 
     *         displayed in the list before using a scrollbar
     */
    @:dox(hide)
	public function getMaximumRowCount():Int{
		return _maximumRowCount;
	}
	
	/**
	 * @return the cellFactory for the popup List
	 */
    @:dox(hide)
	public function getListCellFactory():ListCellFactory{
		return getPopupList().getCellFactory();
	}
	
	/**
	 * This will cause all cells recreating by new factory.
	 * @param newFactory the new cell factory for the popup List
	 */
    @:dox(hide)
	public function setListCellFactory(newFactory:ListCellFactory):Void{
		getPopupList().setCellFactory(newFactory);
	}
	
	/**
     * Sets the editor used to paint and edit the selected item in the 
     * <code>JComboBox</code> field.  The editor is used both if the
     * receiving <code>JComboBox</code> is editable and not editable.
     * @param anEditor  the <code>ComboBoxEditor</code> that
     *			displays the selected item
     */
    @:dox(hide)
	public function setEditor(anEditor:ComboBoxEditor):Void{
		if(anEditor == null) return;
		
		var oldEditor:ComboBoxEditor = _editor;
		if (oldEditor != null){
			oldEditor.removeActionListener(__editorActed);
			oldEditor.getEditorComponent().removeFromContainer();
		}
		_editor = anEditor;
		_editor.setEditable(isEditable());
		addChild(_editor.getEditorComponent());
		if(_ui != null){//means ui installed
			_editor.getEditorComponent().setFont(getFont());
            updateEditorComponentColors();
		}
		_editor.addActionListener(__editorActed);
		revalidate();
	}
	
	/**
     * Returns the editor used to paint and edit the selected item in the 
     * <code>JComboBox</code> field.
     * @return the <code>ComboBoxEditor</code> that displays the selected item
     */
    @:dox(hide)
	public function getEditor():ComboBoxEditor{
		return _editor;
	}
	
	/**
	 * Returns the editor component internal focus object.
	 */
    @:dox(hide)
	override public function getInternalFocusObject():InteractiveObject{
		if(isEditable()){
			return getEditor().getEditorComponent().getInternalFocusObject();
		}else{
			return this;
		}
	}
	
	/**
	 * Apply a new font to combobox and its editor and its popup list.
	 */
    @:dox(hide)
	override public function setFont(newFont:ASFont):Void{
		super.setFont(newFont);
		getPopupList().setFont(newFont);
		getEditor().getEditorComponent().setFont(newFont);
	}
	
	/**
	 * Apply a new foreground to combobox and its editor.
	 * It will not apply this to popup list from 2.0, you can call <code>getPopupList()</code> 
	 * to operate manually.
	 */
    @:dox(hide)
	override public function setForeground(c:ASColor):Void{
		super.setForeground(c);
		updateEditorComponentColors();
	}
	
	/**
	 * Apply a new background to combobox and its editor.
	 * It will not apply this to popup list from 2.0, you can call <code>getPopupList()</code> 
	 * to operate manually.
	 */
    @:dox(hide)
	override public function setBackground(c:ASColor):Void{
		super.setBackground(c);
		updateEditorComponentColors();
	}
	
	/**
     * Determines whether the <code>JComboBox</code> field is editable.
     * An editable <code>JComboBox</code> allows the user to type into the
     * field or selected an item from the list to initialize the field,
     * after which it can be edited. (The editing affects only the field,
     * the list item remains intact.) A non editable <code>JComboBox</code> 
     * displays the selected item in the field,
     * but the selection cannot be modified.
     * 
     * @param b a boolean value, where true indicates that the
     *			field is editable
     */
    @:dox(hide)
	public function setEditable(b:Bool):Void{
		if(_editable != b){
			_editable = b;
			getEditor().setEditable(b);
			//editable changed, internal focus object will change too, so change the focus
			if (isFocusable() && isFocusOwner() && stage != null) {
			#if(flash9 || html5 || cpp)
				if(stage.focus != getInternalFocusObject()){
					stage.focus = getInternalFocusObject();
				}
			#end
			}
            updateEditorComponentColors();
		}
	}
	
	/**
     * Returns true if the <code>JComboBox</code> is editable.
     * By default, a combo box is not editable.
     * @return true if the <code>JComboBox</code> is editable, else false
     */
    @:dox(hide)
	public function isEditable():Bool{
		return _editable;
	}
	
	/**
     * Enables the combo box so that items can be selected. When the
     * combo box is disabled, items cannot be selected and values
     * cannot be typed into its field (if it is editable).
     *
     * @param b a boolean value, where true enables the component and
     *          false disables it
     */
    @:dox(hide)
	override public function setEnabled(b:Bool):Void{
		super.setEnabled(b);
        updateEditorComponentColors();
		if(!b && isPopupVisible()){
			setPopupVisible(false);
		}
		getEditor().setEditable(b && isEditable());
	}
	
	/**
	 * set a array to be the list data, but array is not a List Mode.
	 * So when the array content was changed, you should call updateListView
	 * to update the JList(the list for combo box).But this is not a good way, its slow.
	 * So suggest you to create a ListMode eg. VectorListMode,
	 * When you modify ListMode, it will automatic update JList.
	 * @see #setMode()
	 * @see org.aswing.ListModel
	 */
    @:dox(hide)
	public function setListData(ld:Array<Dynamic>):Void{
		getPopupList().setListData(ld);
	}
	
	/**
	 * Set the list mode to provide the data to JList.
	 * @see org.aswing.ListModel
	 */
    @:dox(hide)
	public function setModel(?m:ListModel):Void {
		//why
		if (m != null)   getPopupList().setModel(m);
	}
	
	/**
	 * @return the model of this List
	 */
    @:dox(hide)
	public function getModel():ListModel{
		return getPopupList().getModel();
	}	
	/** 
     * Causes the combo box to display its popup window.
     * @see #setPopupVisible()
     */
	public function showPopup():Void{
		setPopupVisible(true);
		
	}
	/** 
     * Causes the combo box to close its popup window.
     * @see #setPopupVisible()
     */
	public function hidePopup():Void{
		setPopupVisible(false);
	}

	/**
     * Sets the visibility of the popup, open or close.
     */
    @:dox(hide)
	public function setPopupVisible(v:Bool):Void{
		getComboBoxUI().setPopupVisible(this, v);
	}
	
	/** 
     * Determines the visibility of the popup.
     *
     * @return true if the popup is visible, otherwise returns false
     */
    @:dox(hide)
	public function isPopupVisible():Bool{
		return getComboBoxUI().isPopupVisible(this);
	}
	
	 /** 
     * Sets the selected item in the combo box display area to the object in 
     * the argument.
     * If <code>item</code> is in the list, the display area shows 
     * <code>item</code> selected.
     * <p>
     * If <code>item</code> is <i>not</i> in the list and the combo box is
     * uneditable, it will not change the current selection. For editable 
     * combo boxes, the selection will change to <code>item</code>.
     * </p>
     * <code>AWEvent.ACT</code> (<code>addActionListener()</code>)events added to the combo box will be notified
     * when this method is called.
     * <br>
     * <code>InteractiveEvent.SELECTION_CHANGED</code> (<code>addSelectionListener()</code>)events added to the combo box will be notified
     * when this method is called only when the item is different from current selected item, 
     * it means that only when the selected item changed.
     *
     * @param item  the list item to select; use <code>null</code> to
     *              clear the selection.
     * @param programmatic indicate if this is a programmatic change.
     */
    @:dox(hide)
	public function setSelectedItem(item:Dynamic, programmatic:Bool=true):Void{
		var fireChanged:Bool= false;
		if(item !=getSelectedItem()){
			fireChanged = true;
		}
		getEditor().setValue(item);
		var index:Int= indexInModel(item);
		if(index >= 0){
			if(getPopupList().getSelectedIndex() != index){
				getPopupList().setSelectedIndex(index, programmatic);
				fireChanged = false;
			}
			getPopupList().ensureIndexIsVisible(index);
		}
		if(isFocusOwner()){
			getEditor().selectAll();
		}
        Bind.notify(this.selectedItem);
        Bind.notify(this.selectedIndex);
		dispatchEvent(new AWEvent(AWEvent.ACT));
		if(fireChanged)	{
			dispatchEvent(new InteractiveEvent(InteractiveEvent.SELECTION_CHANGED, programmatic));
		}
	}
	
	/**
     * Returns the current selected item.
     * <p>
     * If the combo box is editable, then this value may not have been in 
     * the list model.
     * @return the current selected item
     * @see #setSelectedItem()
     */
    @:dox(hide)
	public function getSelectedItem():Dynamic{
		return getEditor().getValue();
	}
	
	/**
     * Selects the item at index <code>anIndex</code>.
     * <p>
     * <code>ON_ACT</code> (<code>addActionListener()</code>)events added to the combo box will be notified
     * when this method is called.
     *
     * @param anIndex an integer specifying the list item to select,
     *			where 0 specifies the first item in the list and -1 or greater than max index
     *			 indicates empty selection.
     * @param programmatic indicate if this is a programmatic change.
     */
    @:dox(hide)
	public function setSelectedIndex(anIndex:Int, programmatic:Bool=true):Void{
		var size:Int= getModel().getSize();
		if(anIndex < 0 || anIndex >= size){
			if(getSelectedItem() != null){
				getEditor().setValue(null);
				getPopupList().clearSelection();
			}
		}else{
			getEditor().setValue(getModel().getElementAt(anIndex));
			getPopupList().setSelectedIndex(anIndex, programmatic);
			getPopupList().ensureIndexIsVisible(anIndex);
		}
        Bind.notify(this.selectedIndex);
        Bind.notify(this.selectedItem);
        dispatchEvent(new AWEvent(AWEvent.ACT));
	}
	
	/**
     * Returns the first item in the list that matches the given item.
     * The result is not always defined if the <code>JComboBox</code>
     * allows selected items that are not in the list. 
     * Returns -1 if there is no selected item or if the user specified
     * an item which is not in the list.
     * @return an integer specifying the currently selected list item,
     *			where 0 specifies
     *                	the first item in the list;
     *			or -1 if no item is selected or if
     *                	the currently selected item is not in the list
     */
    @:dox(hide)
	public function getSelectedIndex():Int{
		return indexInModel(getEditor().getValue());
	}
	
	/**
     * Returns the number of items in the list.
     * @return an integer equal to the number of items in the list
     */
    @:dox(hide)
	public function getItemCount():Int{
		return getModel().getSize();
	}
	
	/**
     * Returns the list item at the specified index.  If <code>index</code>
     * is out of range (less than zero or greater than or equal to size)
     * it will return <code>undefined</code>.
     *
     * @param index  an integer indicating the list position, where the first
     *               item starts at zero
     * @return the <code>Object</code> at that list position; or
     *			<code>undefined</code> if out of range
     */
	public function getItemAt(index:Int):Dynamic{
		return getModel().getElementAt(index);
	}
	
	//----------------------------------------------------------
	private function __editorActed(e:Event):Void{
		if(!isPopupVisible()){
			setSelectedItem(getEditor().getValue());
		}
	}
	
	private function indexInModel(value:Dynamic):Int{
		var model:ListModel = getModel();
		var n:Int= model.getSize();
		for(i in 0...n){
			if(model.getElementAt(i) == value){
				return i;
			}
		}
		return -1;
	}

    private function updateEditorComponentColors() {
        if (!editable && enabled) {
            editor.getEditorComponent().background = notEditableBackground;
            editor.getEditorComponent().foreground = notEditableForeground;
        } else {
            editor.getEditorComponent().background = background;
            editor.getEditorComponent().foreground = foreground;
        }
    }
	
}