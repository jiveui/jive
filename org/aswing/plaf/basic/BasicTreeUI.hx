/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;
 

import flash.display.Shape;
import flash.events.MouseEvent;
import org.aswing.AWKeyboard;

import org.aswing.Insets;
	import org.aswing.CellPane;
	import org.aswing.JTree;
	import org.aswing.Component;
	import org.aswing.ASColor;
	import org.aswing.EmptyLayout;
	import org.aswing.FocusManager;
	import org.aswing.event.TreeModelListener;
	import org.aswing.event.PropertyChangeEvent;
	import org.aswing.event.TreeSelectionEvent;
	import org.aswing.event.ClickCountEvent;
	import org.aswing.event.FocusKeyEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.event.TreeEvent;
	import org.aswing.event.TreeModelEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.TreeUI;
	import org.aswing.plaf.UIResource;
	import org.aswing.plaf.basic.tree.ExpandControl;
import org.aswing.tree.NodeDimensions;
	import org.aswing.tree.AbstractLayoutCache;
	import org.aswing.tree.TreeModel;
	import org.aswing.tree.TreeCellEditor;
	import org.aswing.tree.TreeSelectionModel;
	import org.aswing.tree.FixedHeightLayoutCache;
	import org.aswing.tree.TreePath;
	import org.aswing.tree.TreeCell;
	import org.aswing.util.ArrayList;

/**
 * @author paling
 * @private
 */
class BasicTreeUI extends BaseComponentUI  implements TreeUI implements NodeDimensions implements TreeModelListener{
	
	private static var EMPTY_INSETS:Insets;

	/** Object responsible for handling sizing and expanded issues. */
	private var treeState:AbstractLayoutCache;	
	
	private var rendererPane:CellPane;	
	/** Total distance that will be indented.  The sum of leftChildIndent
	  * and rightChildIndent. 
	  */
	private var totalChildIndent:Int;
	/** How much the depth should be offset to properly calculate
	 * x locations. This is based on whether or not the root is visible,
	 * and if the root handles are visible. 
	 */
	private var depthOffset:Int;
	/** Distance between left margin and where vertical dashes will be
	  * drawn. */
	private var leftChildIndent:Int;
	/** Distance to add to leftChildIndent to determine where cell
	  * contents will be drawn. */
	private var rightChildIndent:Int;	   
	/** If true, the property change event for LEAD_SELECTION_PATH_PROPERTY,
	 * or ANCHOR_SELECTION_PATH_PROPERTY will not generate a repaint. */
	private var ignoreLAChange:Bool;
	
	private var tree:JTree;
	private var treeModel:TreeModel;
	private var editor:TreeCellEditor;
	private var selectionModel:TreeSelectionModel;
	private var cells:ArrayList;
	private var validCachedViewSize:Bool;
	private var viewSize:IntDimension;
	private var lastViewPosition:IntPoint;
	
	private var expandControl:ExpandControl;
	
	public function new() {
		super();
		if(EMPTY_INSETS == null){
			EMPTY_INSETS = new Insets(0, 0, 0, 0);
		}
		totalChildIndent = 0;
		depthOffset = 0;
		leftChildIndent = 0;
		rightChildIndent = 0;
		
		paintFocusedIndex = -1;
		cells = new ArrayList();
		lastViewPosition = new IntPoint();
		viewSize = new IntDimension();
		validCachedViewSize = false;
	}
	
	override public function installUI(c:Component):Void{
		tree = AsWingUtils.as(c,JTree);
		installDefaults();
		installComponents();
		installListeners();
	}
	
	override public function uninstallUI(c:Component):Void{
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
	}
	
	private function getPropertyPrefix():String{
		return "Tree.";
	}
	
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
		LookAndFeel.installColorsAndFont(tree, pp);
		LookAndFeel.installBorderAndBFDecorators(tree, pp);
		LookAndFeel.installBasicProperties(tree, pp);
		
		var sbg:ASColor = tree.getSelectionBackground();
		if (sbg == null || Std.is(sbg,UIResource)) {
			tree.setSelectionBackground(getColor(pp+"selectionBackground"));
		}

		var sfg:ASColor = tree.getSelectionForeground();
		if (sfg == null || Std.is(sfg,UIResource)) {
			tree.setSelectionForeground(getColor(pp+"selectionForeground"));
		}
		tree.setRowHeight(getInt(pp+"rowHeight"));
		tree.setRowHeightSet(false);
		setLeftChildIndent(getInt(pp+"leftChildIndent"));
		setRightChildIndent(getInt(pp+"rightChildIndent"));
		updateDepthOffset();
		treeState = new FixedHeightLayoutCache();
		treeState.setModel(tree.getModel());
		treeState.setSelectionModel(tree.getSelectionModel());
		treeState.setNodeDimensions(this);
		treeState.setRowHeight(tree.getRowHeight());
		editor = tree.getCellEditor();
		setRootVisible(tree.isRootVisible());
		
		expandControl =AsWingUtils.as( getInstance(pp+"expandControl") , ExpandControl);
	}
	
	private function uninstallDefaults():Void{
		LookAndFeel.uninstallBorderAndBFDecorators(tree);
	}
		
	private function installComponents():Void{
		rendererPane = new CellPane();
		rendererPane.setLayout(new EmptyLayout());
		tree.append(rendererPane);
	}
	
	private function uninstallComponents():Void{
		tree.remove(rendererPane);
		cells.clear();
		rendererPane = null;
	}
	
	private function installListeners():Void{
		tree.addEventListener(TreeEvent.TREE_EXPANDED, __treeExpanded);
		tree.addEventListener(TreeEvent.TREE_COLLAPSED, __treeCollapsed);
		tree.addStateListener(__viewportStateChanged);
		tree.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, __propertyChanged);
		tree.addEventListener(MouseEvent.MOUSE_DOWN, __onPressed);
		tree.addEventListener(MouseEvent.CLICK, __onReleased);
		tree.addEventListener(ClickCountEvent.CLICK_COUNT, __onClicked);
		tree.addEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
		tree.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
		
		setModel(tree.getModel());
		setSelectionModel(tree.getSelectionModel());
	}
	
	private function uninstallListeners():Void{
		tree.removeEventListener(TreeEvent.TREE_EXPANDED, __treeExpanded);
		tree.removeEventListener(TreeEvent.TREE_COLLAPSED, __treeCollapsed);
		tree.removeStateListener(__viewportStateChanged);
		tree.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, __propertyChanged);
		tree.removeEventListener(MouseEvent.MOUSE_DOWN, __onPressed);
		tree.removeEventListener(MouseEvent.CLICK, __onReleased);
		tree.removeEventListener(ClickCountEvent.CLICK_COUNT, __onClicked);
		tree.removeEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
		tree.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
		
		setModel(null);
		setSelectionModel(null);
	}
	
	private function setModel(tm:TreeModel):Void{
		cancelEditing(tree);
		if(treeModel != null){
			treeModel.removeTreeModelListener(this);
		}
		treeModel = tm;
		if(treeModel != null) {
			treeModel.addTreeModelListener(this);
		}
		if(treeState != null) {
			treeState.setModel(tm);
			updateLayoutCacheExpandedNodes();
			updateSize();
		}
	}
	
	private function setSelectionModel(sm:TreeSelectionModel):Void{
		if(selectionModel != null){
			selectionModel.removePropertyChangeListener(__selectionModelPropertyChanged);
			selectionModel.removeTreeSelectionListener(__selectionChanged);
		}
		selectionModel = sm;
		if(selectionModel != null){
			selectionModel.addPropertyChangeListener(__selectionModelPropertyChanged);
			selectionModel.addTreeSelectionListener(__selectionChanged);
		}
		if(treeState != null){
			treeState.setSelectionModel(selectionModel);
		}
		tree.repaint();
	}
	
	/**
	 * Sets the root to being visible.
	 */
	private function setRootVisible(newValue:Bool):Void{
		cancelEditing(tree);
		updateDepthOffset();
		if(treeState != null) {
			treeState.setRootVisible(newValue);
			treeState.invalidateSizes();
			updateSize();
		}
	}	
	
	/**
	 * Sets the row height, this is forwarded to the treeState.
	 */
	private function setRowHeight(rowHeight:Int):Void{
		cancelEditing(tree);
		if(treeState != null) {
			treeState.setRowHeight(rowHeight);
			updateSize();
		}
	}	
	
	private function setCellEditor(editor:TreeCellEditor):Void{
		cancelEditing(tree);
		this.editor = editor;
	}
	
	/**
	 * Configures the receiver to allow, or not allow, editing.
	 */
	private function setEditable(newValue:Bool):Void{
		cancelEditing(tree);
		if(newValue)	{
			editor = tree.getCellEditor();
		}else{
			editor = null;
		}
	}	
	
	private function repaintPath(path:TreePath):Void{
	}
	
	private function cellFactoryChanged():Void{
		for(i in 0...cells.size() ){
			var cell:TreeCell = AsWingUtils.as(cells.get(i),TreeCell);
			cell.getCellComponent().removeFromContainer();
		}
		cells.clear();
		treeState.invalidateSizes();
		updateSize();
	}
	
	/**
	 * Makes all the nodes that are expanded in JTree expanded in LayoutCache.
	 * This invokes updateExpandedDescendants with the root path.
	 */
	private function updateLayoutCacheExpandedNodes():Void{
		if(treeModel != null && treeModel.getRoot() != null){
			updateExpandedDescendants(new TreePath([treeModel.getRoot()]));
		}
	}
		
	/**
	 * Returns true if <code>mouseX</code> and <code>mouseY</code> fall
	 * in the area of row that is used to expand/collapse the node and
	 * the node at <code>row</code> does not represent a leaf.
	 */
	private function isLocationInExpandControl(path:TreePath, mouseX:Int, mouseY:Int):Bool{
		if(path != null && !treeModel.isLeaf(path.getLastPathComponent())){
			var boxWidth:Int;
		   // var i:Insets = tree.getInsets();
			boxWidth = leftChildIndent;
	
			var boxLeftX:Int= getRowX(tree.getRowForPath(path), path.getPathCount() - 1) - boxWidth;
			//boxLeftX += i.left;
			var boxRightX:Int= boxLeftX + boxWidth;
	
			return mouseX >= boxLeftX && mouseX <= boxRightX;
		}
		return false;
	}	
	
	/**
	 * Expands path if it is not expanded, or collapses row if it is expanded.
	 * If expanding a path and JTree scrolls on expand, ensureRowsAreVisible
	 * is invoked to scroll as many of the children to visible as possible
	 * (tries to scroll to last visible descendant of path).
	 */
	private function toggleExpandState(path:TreePath):Void{
		if(!tree.isExpanded(path)) {
			var row:Int= getRowForPath(tree, path);
			tree.expandPath(path);
			updateSize();
			if(row != -1) {
				if(tree.isScrollsOnExpand()){
					ensureRowsAreVisible(row, row + treeState.getVisibleChildCount(path));
				}else{
					ensureRowsAreVisible(row, row);
				}
			}
		}else{
			tree.collapsePath(path);
			updateSize();
		}
	}	
	
	/**
	  * Ensures that the rows identified by beginRow through endRow are
	  * visible.
	  */
	private function ensureRowsAreVisible(beginRow:Int, endRow:Int):Void{
		if(tree != null && beginRow >= 0 && endRow < getRowCount(tree)) {
			tree.scrollRowToVisible(endRow);
			tree.scrollRowToVisible(beginRow);
		}
	}	
	
	/**
	 * Messaged when the user clicks the particular row, this invokes
	 * toggleExpandState.
	 */
	private function handleExpandControlClick(path:TreePath, mouseX:Int, mouseY:Int):Void{
		toggleExpandState(path);
	}	
	
	private function selectPathForEvent(path:TreePath, e:MouseEvent):Void{
		doSelectWhenRelease = false;
		pressedPath = path;
		if(tree.isPathSelected(path)){
			doSelectWhenRelease = true;
		}else{
			doSelectPathForEvent(e);
		}
		paintFocusedIndex = tree.getRowForPath(path);
	}
	
	private function doSelectPathForEvent(e:MouseEvent):Void{
		var path:TreePath = pressedPath;
		var ctrl:Bool= false;
		var shift:Bool= false;
		ctrl = e.ctrlKey;
		shift = e.shiftKey;
		if(shift)	{
			var anchor:TreePath = tree.getAnchorSelectionPath();
			var anchorRow:Int= (anchor == null) ? -1 : getRowForPath(tree, anchor);
	
			if(anchorRow == -1 || selectionModel.getSelectionMode() == JTree.SINGLE_TREE_SELECTION) {
				tree.setSelectionPath(path, false);
			}else {
				var row:Int= getRowForPath(tree, path);
				var lastAnchorPath:TreePath = anchor;
		
				if(ctrl)	{
					if (tree.isRowSelected(anchorRow)) {
						tree.addSelectionInterval(anchorRow, row, false);
					} else {
						tree.removeSelectionInterval(anchorRow, row, false);
						tree.addSelectionInterval(row, row, false);
					}
				} else if(row < anchorRow) {
					tree.setSelectionInterval(row, anchorRow, false);
				} else {
					tree.setSelectionInterval(anchorRow, row, false);
				}
				ignoreLAChange = true;
				//lastSelectedRow = row;
				tree.setAnchorSelectionPath(lastAnchorPath);
				tree.setLeadSelectionPath(path);
				ignoreLAChange = false;
			}
		}else if(ctrl)	{
			// Should this event toggle the selection of this row?
			/* Control toggles just this node. */
			if(tree.isPathSelected(path)){
				tree.removeSelectionPath(path, false);
			}else{
				tree.addSelectionPath(path, false);
			}
			//lastSelectedRow = getRowForPath(tree, path);
			ignoreLAChange = true;
			tree.setAnchorSelectionPath(path);
			tree.setLeadSelectionPath(path);
			ignoreLAChange = false;
		}else{
			tree.setSelectionPath(path, false);
		}
	}
	
	//------------------------------handlers------------------------
	private function __selectionModelPropertyChanged(e:PropertyChangeEvent):Void{
		selectionModel.resetRowSelection();
	}
	private function __selectionChanged(event:TreeSelectionEvent):Void{
		// Stop editing
		stopEditing(tree);
		// Make sure all the paths are visible, if necessary.
		if(tree.isExpandsSelectedPaths() && selectionModel != null) {
			var paths:Array<Dynamic>= selectionModel.getSelectionPaths();
	
			if(paths != null) {
				for(counter in 0...paths.length  ){
					var path:TreePath = paths[counter].getParentPath();
					var expand:Bool= true;

					while (path != null) {
						// Indicates this path isn't valid anymore,
						// we shouldn't attempt to expand it then.
						if (treeModel.isLeaf(path.getLastPathComponent())){
							expand = false;
							path = null;
						}else {
							path = path.getParentPath();
						}
					}
					if(expand)	{
						tree.makePathVisible(paths[counter]);
					}
				}
			}
		}
		
		paintFocusedIndex = tree.getMinSelectionRow();
		var lead:TreePath = tree.getSelectionModel().getLeadSelectionPath();
		ignoreLAChange = true;
		tree.setAnchorSelectionPath(lead);
		tree.setLeadSelectionPath(lead);
		ignoreLAChange = false;
		tree.repaint();
	}
	
	private function __onClicked(e:ClickCountEvent):Void{
		var edit:Bool= (tree.isEditable() && editor != null && editor.isCellEditable(e.getCount()));
		var toggle:Bool= (e.getCount() == tree.getToggleClickCount());
		if(!(edit || toggle)){
			return;
		}
		var p:IntPoint = rendererPane.getMousePosition();
		p.y += tree.getViewPosition().y;
		var path:TreePath = getClosestPathForLocation(tree, p.x, p.y);
		if(path != null){
			var bounds:IntRectangle = getPathBounds(tree, path);
			if (p.x > bounds.x && p.x <= (bounds.x + bounds.width)) {
				if(edit)	{
					tree.startEditingAtPath(path);
				}else{
					toggleExpandState(path);
				}
			}
		}
	}
	
	private function __onPressed(e:MouseEvent):Void{
		var p:IntPoint = rendererPane.getMousePosition();
		p.y += tree.getViewPosition().y;
		var path:TreePath = getClosestPathForLocation(tree, p.x, p.y);
		if(path != null){
			if(isLocationInExpandControl(path, p.x, p.y)){
				handleExpandControlClick(path, p.x, p.y);
			}
			var bounds:IntRectangle = getPathBounds(tree, path);
			if (p.x > bounds.x && p.x <= (bounds.x + bounds.width)) {
			   selectPathForEvent(path, e);
			}
		}
	}

	private var doSelectWhenRelease:Bool;
	private var pressedPath:TreePath;
		
	private function __onReleased(e:MouseEvent):Void{
		if(doSelectWhenRelease)	{
			doSelectPathForEvent(e);
			doSelectWhenRelease = false;
		}
	}
	
	private function __onMouseWheel(e:MouseEvent):Void{
		var pos:IntPoint = tree.getViewPosition();
		if(e.shiftKey)	{
			pos.x -= tree.getHorizontalUnitIncrement()*e.delta;
		}else{
			pos.y -= tree.getVerticalUnitIncrement()*e.delta;
		}
		tree.setViewPosition(pos);
	}
	
	private var paintFocusedIndex:Int;
	private function __onKeyDown(e:FocusKeyEvent):Void{
		if(!tree.isEnabled()){
			return;
		}
		var code:Int= e.keyCode;
		var dir:Int= 0;
		if(isControlKey(code)){
    		var fm:FocusManager = FocusManager.getManager(tree.stage);
			if(fm!=null)	fm.setTraversing(true);
		}else{
			return;
		}
		if(code == AWKeyboard.UP){
			dir = -1;
		}else if(code == AWKeyboard.DOWN){
			dir = 1;
		}
		
		if(paintFocusedIndex == -1){
			paintFocusedIndex = tree.getSelectionModel().getMinSelectionRow();
		}
		if(paintFocusedIndex < -1){
			paintFocusedIndex = -1;
		}else if(paintFocusedIndex > tree.getRowCount()){
			paintFocusedIndex = tree.getRowCount();
		}
		var index:Int= paintFocusedIndex + dir;
		if(code == AWKeyboard.HOME){
			index = 0;
		}else if(code == AWKeyboard.END){
			index = tree.getRowCount() - 1;
		}
		if(index < 0 || index >= tree.getRowCount()){
			return;
		}
		var path:TreePath = tree.getPathForRow(index);
		if(code == AWKeyboard.LEFT){
			tree.collapseRow(index);
		}else if(code == AWKeyboard.RIGHT){
			tree.expandRow(index);
		}else if(dir != 0 || (code == AWKeyboard.HOME || code == AWKeyboard.END)){
			if(e.shiftKey)	{
				var anchor:TreePath = tree.getAnchorSelectionPath();
				var anchorRow:Int= (anchor == null) ? -1 : getRowForPath(tree, anchor);
				var lastAnchorPath:TreePath = anchor;
				if(index < anchorRow) {
					tree.setSelectionInterval(index, anchorRow);
				} else {
					tree.setSelectionInterval(anchorRow, index);
				}
				ignoreLAChange = true;
				tree.setAnchorSelectionPath(lastAnchorPath);
				tree.setLeadSelectionPath(path);
				ignoreLAChange = false;
				
				paintFocusedIndex = index;
			}else if(e.ctrlKey)	{
				paintFocusedIndex = index;
			}else{
				tree.setSelectionInterval(index, index);
			}
			tree.scrollRowToVisible(index);
		}else{
			if(code == AWKeyboard.SPACE){
				tree.addSelectionInterval(index, index);
				tree.scrollRowToVisible(index);
				ignoreLAChange = true;
				tree.setAnchorSelectionPath(path);
				tree.setLeadSelectionPath(path);
				ignoreLAChange = false;
			}else if(code == getEditionKey()){
				var edit:Bool= (tree.isEditable() && editor != null);
				if(edit)	{
					tree.startEditingAtPath(path);
				}
				return;
			}
		}
		tree.repaint();
	}
	
	private function isControlKey(code:Int):Bool{
		return (code == AWKeyboard.UP || code == AWKeyboard.DOWN || code == AWKeyboard.SPACE
			|| code == AWKeyboard.LEFT || code == AWKeyboard.RIGHT || code == AWKeyboard.HOME 
			|| code == AWKeyboard.END || code == getEditionKey());
	}
	
	private function getEditionKey():Int{
		return AWKeyboard.ENTER;
	}
	
	private function __viewportStateChanged(e:InteractiveEvent):Void{
		var viewPosition:IntPoint = tree.getViewPosition();
		if(!lastViewPosition.equals(viewPosition)){
			if(lastViewPosition.y == viewPosition.y){
				positRendererPaneX(viewPosition.x);
				lastViewPosition.setLocation(viewPosition);
				return;
			}
			tree.repaint();
		}
	}
	
	private function __propertyChanged(e:PropertyChangeEvent):Void{
		var changeName:String= e.getPropertyName();
		var ov:Dynamic= e.getOldValue();
		var nv:Dynamic= e.getNewValue();
		if (changeName == JTree.LEAD_SELECTION_PATH_PROPERTY) {
			if(ignoreLAChange!=true) {
				updateLeadRow();
				repaintPath(AsWingUtils.as(ov,TreePath));
				repaintPath(AsWingUtils.as(nv,TreePath));
			}
		}else if (changeName == JTree.ANCHOR_SELECTION_PATH_PROPERTY) {
			if(ignoreLAChange!=true) {
				repaintPath(AsWingUtils.as(ov,TreePath));
				repaintPath(AsWingUtils.as(nv,TreePath));
			}
		}else if(changeName == JTree.CELL_FACTORY_PROPERTY) {
			cellFactoryChanged();
		}else if(changeName == JTree.TREE_MODEL_PROPERTY) {
			setModel(AsWingUtils.as(nv,TreeModel));
		}else if(changeName == JTree.ROOT_VISIBLE_PROPERTY) {
			setRootVisible(nv == true);
		}else if(changeName == JTree.ROW_HEIGHT_PROPERTY) {
			setRowHeight(nv);
		}else if(changeName == JTree.CELL_EDITOR_PROPERTY) {
			setCellEditor(AsWingUtils.as(nv,TreeCellEditor));
		}else if(changeName == JTree.EDITABLE_PROPERTY) {
			setEditable(nv == true);
		}else if(changeName == JTree.SELECTION_MODEL_PROPERTY) {
			setSelectionModel(tree.getSelectionModel());
		}else if(changeName == JTree.FONT_PROPERTY) {
			cancelEditing(tree);
			if(treeState != null)
				treeState.invalidateSizes();
			updateSize();
		}	
	}
	
	private function positRendererPaneX(viewX:Int):Void{
		rendererPane.setX(tree.getInsets().left - viewX);
		rendererPane.validate();
	}
	
	//---------------------------------------------------
	public function setLeftChildIndent(newAmount:Int):Void{
		leftChildIndent = newAmount;
		totalChildIndent = leftChildIndent + rightChildIndent;
		if(treeState != null)
			treeState.invalidateSizes();
		updateSize();
	}
	public function getLeftChildIndent():Int{
		return leftChildIndent;
	}

	public function setRightChildIndent(newAmount:Int):Void{
		rightChildIndent = newAmount;
		totalChildIndent = leftChildIndent + rightChildIndent;
		if(treeState != null)
			treeState.invalidateSizes();
		updateSize();
	}

	public function getRightChildIndent():Int{
		return rightChildIndent;
	}	
	
	/**
	 * Updates how much each depth should be offset by.
	 */
	private function updateDepthOffset():Void{
		if(tree.isRootVisible()) {
			depthOffset = 1;
		}else{
			depthOffset = 0;
		}
	}	
	
	/**
	 * Marks the cached size as being invalid, and messages the
	 * tree with <code>treeDidChange</code>.
	 */
	private function updateSize():Void{
		validCachedViewSize = false;
		tree.treeDidChange();
	}
	
	//**********************************************************************
	//						Paint methods
	//**********************************************************************
	override public function paintFocus(c:Component, g:Graphics2D, b:IntRectangle):Void{
		var ib:IntRectangle = treeState.getBounds(tree.getPathForRow(paintFocusedIndex), null);
		if(ib != null){
			b = ib;
			b.setLocation(tree.getPixelLocationFromLogicLocation(b.getLocation()));
		}
		//why	
	 
		g.drawRectangle(new Pen(getDefaultFocusColorInner(), 1), b.x+0.5, b.y+0.5, b.width-1, b.height-1);
		g.drawRectangle(new Pen(getDefaultFocusColorOutter(), 1), b.x+1.5, b.y+1.5, b.width-3, b.height-3);
	 
	}
	
	private var rendererShape:Shape;
	private function createRendererPaneGraphics():Graphics2D{
		if(rendererShape == null){
			rendererShape = new Shape();
			rendererPane.addChild(rendererShape);
		}
		rendererShape.graphics.clear();
		return new Graphics2D(rendererShape.graphics);
	}
		
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		
		var viewSize:IntDimension = getViewSize(tree);
		rendererPane.setComBoundsXYWH(0, b.y, viewSize.width, b.height);
		rendererPane.validate();
		checkCreateCells();
		var viewPosition:IntPoint = tree.getViewPosition();
		lastViewPosition.setLocation(viewPosition);
		var x:Int= viewPosition.x;
		var y:Int= viewPosition.y;
		var ih:Int= tree.getRowHeight();
		var startIndex:Int= Std.int(y/ih);
		var startY:Int= startIndex*ih - y;
		var rowCount:Int= getRowCount(tree);
		
		positRendererPaneX(x);
		
		var cy:Int= startY;
		
		var showBounds:IntRectangle = b.clone();
		showBounds.y = y;
		showBounds.x = x;
		var showRowCount:Int= Std.int(Math.min(cells.size(), rowCount));
		var initialPath:TreePath = getClosestPathForLocation(tree, 0, showBounds.y);
		var paintingEnumerator:Array<Dynamic>= treeState.getVisiblePathsFrom(initialPath, showRowCount);
		if(paintingEnumerator == null) paintingEnumerator = [];
		var row:Int= treeState.getRowContainingYLocation(showBounds.y);
		
		var expanded:Bool;
		var leaf:Bool;
		var selected:Bool;
		var bounds:IntRectangle = new IntRectangle();
		var boundsBuffer:IntRectangle = new IntRectangle();
		var treeModel:TreeModel = tree.getModel();
		g = createRendererPaneGraphics();
		var n:Int= cells.getSize();
		var paintingN:Int= paintingEnumerator.length;
		for(i in 0...n){
			var cell:TreeCell = cells.get(i);
			var path:TreePath = paintingEnumerator[i];
			var cellCom:Component = cell.getCellComponent();
			if(i < paintingN){
				leaf = treeModel.isLeaf(path.getLastPathComponent());
				if(leaf)	{
					expanded = false;
				}else {
					expanded = treeState.getExpandedState(path);
				}
				selected = tree.getSelectionModel().isPathSelected(path);
				//trace("cell path = " + path);
				bounds = treeState.getBounds(path, bounds);
				// trace("bounds : " + bounds);
				 if (bounds == null)
				 {
					 bounds = new IntRectangle();
				 }
				cell.setCellValue(path.getLastPathComponent());
				// trace(path.getLastPathComponent() + " cell value of " + cell);
				cellCom.setVisible(true);
				cell.setTreeCellStatus(tree, selected, expanded, leaf, row);
				boundsBuffer.setRectXYWH(bounds.x, cy, bounds.width, ih);
				cellCom.setBounds(boundsBuffer);
				cellCom.validate();
				cellCom.paintImmediately();
				boundsBuffer.x += b.x;
				boundsBuffer.y += b.y;
				paintExpandControl(g, boundsBuffer, path, row, expanded, leaf);
				
				cy += ih;
				row++;
			}else{
				cellCom.setVisible(false);
				cellCom.validate();
			}
		}
	}
	
	private function paintExpandControl(g:Graphics2D, bounds:IntRectangle, path:TreePath,
					  row:Int, expanded:Bool, leaf:Bool):Void{
		if(expandControl!=null)	{
			expandControl.paintExpandControl(tree, g, bounds, totalChildIndent, path, row, expanded, leaf);
		}
	}
	
	private function checkCreateCells():Void{
		var ih:Int= tree.getRowHeight();
		var needNum:Int= Math.floor(tree.getExtentSize().height/ih) + 2;
		
		if(cells.getSize() == needNum/* || !displayable*/){
			return;
		}
		var i:Int;
		var cell:TreeCell;
		//create needed
		if(cells.getSize() < needNum){
			var addNum:Int= needNum - cells.getSize();
			for(i in 0...addNum){
				cell = tree.getCellFactory().createNewCell();
				rendererPane.append(cell.getCellComponent());
				cells.append(cell);
			}
		}else if(cells.getSize() > needNum){ //remove mored
			var removeIndex:Int= needNum;
			var removed:Array<Dynamic>= cells.removeRange(removeIndex, cells.getSize()-1);
			for(i in 0...removed.length){
				cell = AsWingUtils.as(removed[i],TreeCell);
				rendererPane.remove(cell.getCellComponent());
			}
		}
	}
	
	//---------------------------------------
	private function updateLeadRow():Void{
		paintFocusedIndex = getRowForPath(tree, tree.getLeadSelectionPath());
	}	
	
	/**
	 * Returns the location, along the x-axis, to render a particular row
	 * at. The return value does not include any Insets specified on the JTree.
	 * This does not check for the validity of the row or depth, it is assumed
	 * to be correct and will not throw an Exception if the row or depth
	 * doesn't match that of the tree.
	 *
	 * @param row Row to return x location for
	 * @param depth Depth of the row
	 * @return amount to indent the given row.
	 */
	private function getRowX(row:Int, depth:Int):Int{
		return totalChildIndent * (depth + depthOffset);
	}
	
	/**
	 * Updates the expanded state of all the descendants of <code>path</code>
	 * by getting the expanded descendants from the tree and forwarding
	 * to the tree state.
	 */
	private function updateExpandedDescendants(path:TreePath):Void{
		//completeEditing();
		if(treeState != null) {
			treeState.setExpandedState(path, true);
	
			var descendants:Array<Dynamic>= tree.getExpandedDescendants(path);
	
			if(descendants != null) {
				for(i in 0...descendants.length){
					treeState.setExpandedState(AsWingUtils.as(descendants[i],TreePath), true);
				}
			}
			updateLeadRow();
			updateSize();
		}
	}	
	
	//**********************************************************************
	//						NodeDimensions methods
	//**********************************************************************
	private var currentCellRenderer:TreeCell;
	public function countNodeDimensions(value :Dynamic, row : Int, depth : Int, expanded : Bool, size : IntRectangle) : IntRectangle {
		var prefSize:IntDimension;
		if(tree.getFixedCellWidth() >= 0){
			prefSize = new IntDimension(tree.getFixedCellWidth(), tree.getRowHeight());
		}else{
			if(currentCellRenderer == null){
				currentCellRenderer = tree.getCellFactory().createNewCell();
			}
			currentCellRenderer.setCellValue(value);
			//TODO check this selected is needed
			currentCellRenderer.setTreeCellStatus(tree, /*selected*/false, expanded, tree.getModel().isLeaf(value), row);
	
			prefSize = currentCellRenderer.getCellComponent().getPreferredSize();
		}
		if(size != null) {
			size.x = getRowX(row, depth);
			size.width = prefSize.width;
			size.height = prefSize.height;
		}else {
			size = new IntRectangle(getRowX(row, depth), 0,
					 prefSize.width, prefSize.height);
		}
		return size;
	}
	//**********************************************************************
	//						TreeUI methods
	//**********************************************************************

	/**
	  * Returns the IntRectangle enclosing the label portion that the
	  * last item in path will be drawn into.  Will return null if
	  * any component in path is currently valid.
	  */
	public function getPathBounds(tree:JTree, path:TreePath):IntRectangle {
		if(tree != null && treeState != null) {
			var i:Insets = tree.getInsets();
			var bounds:IntRectangle = treeState.getBounds(path, null);
	
			if(bounds != null && i != null) {
				bounds.x += i.left;
				bounds.y += i.top;
			}
			return bounds;
		}
		return null;
	}

	/**
	  * Returns the path for passed in row.  If row is not visible
	  * null is returned.
	  */
	public function getPathForRow(tree:JTree, row:Int):TreePath {
		return (treeState != null) ? treeState.getPathForRow(row) : null;
	}

	/**
	  * Returns the row that the last item identified in path is visible
	  * at.  Will return -1 if any of the elements in path are not
	  * currently visible.
	  */
	public function getRowForPath(tree:JTree, path:TreePath):Int{
		return (treeState != null) ? treeState.getRowForPath(path) : -1;
	}

	/**
	  * Returns the number of rows that are being displayed.
	  */
	public function getRowCount(tree:JTree):Int{
		return (treeState != null) ? treeState.getRowCount() : 0;
	}

	/**
	  * Returns the path to the node that is closest to x,y.  If
	  * there is nothing currently visible this will return null, otherwise
	  * it'll always return a valid path.  If you need to test if the
	  * returned object is exactly at x, y you should get the bounds for
	  * the returned path and test x, y against that.
	  */
	public function getClosestPathForLocation(tree:JTree, x:Int, y:Int):TreePath {
		if(tree != null && treeState != null) {
			var i:Insets = tree.getInsets();
	
			if(i == null){
				i = EMPTY_INSETS;
			}
	
			return treeState.getPathClosestTo(x - i.left, y - i.top);
		}
		return null;
	}
	
	/**
	 * Returns the treePath that the user mouse pointed, null if no path was pointed.
	 */
	public function getMousePointedPath():TreePath{
		var p:IntPoint = rendererPane.getMousePosition();
		p.y += tree.getViewPosition().y;
		var path:TreePath = getClosestPathForLocation(tree, p.x, p.y);
		return path;
	}

	/**
	  * Returns true if the tree is being edited.  The item that is being
	  * edited can be returned by getEditingPath().
	  */
	public function isEditing(tree:JTree):Bool{
		return editor.isCellEditing();
	}

	/**
	  * Stops the current editing session.  This has no effect if the
	  * tree isn't being edited.  Returns true if the editor allows the
	  * editing session to stop.
	  */
	public function stopEditing(tree:JTree):Bool{
		if(editor != null && editor.isCellEditing()) {
			return editor.stopCellEditing();
		}
		return false;
	}

	/**
	  * Cancels the current editing session.
	  */
	public function cancelEditing(tree:JTree):Void{
		if(editor != null && editor.isCellEditing()) {
			editor.cancelCellEditing();
		}
	}

	/**
	  * Selects the last item in path and tries to edit it.  Editing will
	  * fail if the CellEditor won't allow it for the selected item.
	  * 
	  * @return true is started sucessful, editing fail
	  */
	public function startEditingAtPath(tree:JTree, path:TreePath):Bool{
		if(editor == null){
			return false;
		}
		tree.scrollPathToVisible(path);
		if(path != null && tree.isPathVisible(path)){
			var editor:TreeCellEditor = tree.getCellEditor();
			if (editor.isCellEditing()){
				if(!editor.stopCellEditing()){
					return false;
				}
			}
			editingPath = path;
			var bounds:IntRectangle = tree.getPathBounds(path);
			bounds.setLocation(tree.getPixelLocationFromLogicLocation(bounds.getLocation()));
			editor.startCellEditing(tree, path.getLastPathComponent(), bounds);
			return true;
		}
		return false;
	}
	private var editingPath:TreePath;

	/**
	 * Returns the path to the element that is being edited.
	 */
	public function getEditingPath(tree:JTree):TreePath {
		return editingPath;
	}
	
	//******************************************************************
	//							 Size Methods
	//******************************************************************
	
	private function updateCachedViewSize():Void{
		if(treeState != null) {
			viewSize.width = treeState.getPreferredWidth(null);
			viewSize.height = treeState.getPreferredHeight();
		}
		validCachedViewSize = true;
	}
	
	override public function getMinimumSize(c:Component):IntDimension {
		return c.getInsets().getOutsideSize();
	}

	override public function getPreferredSize(c:Component):IntDimension {
		var height:Int=  tree.getVisibleRowCount() * tree.getRowHeight();
		var width:Int= getViewSize(tree).width;
		return c.getInsets().getOutsideSize(new IntDimension(width, height));
	}
	
	public function getViewSize(theTree:JTree):IntDimension {
		if(validCachedViewSize!=true){
			updateCachedViewSize();
		}
		if(tree != null) {
			return new IntDimension(viewSize.width, viewSize.height);
		}else{
			return new IntDimension(0, 0);
		}
	}

	override public function getMaximumSize(c:Component):IntDimension {
		return IntDimension.createBigDimension();
	}
		//
		// TreeExpansionListener
		//
	public function __treeExpanded(e:TreeEvent):Void{
		if(e.getPath() != null) {
			updateExpandedDescendants(e.getPath());
		}
	}

	public function __treeCollapsed(e:TreeEvent):Void{
		if(e.getPath() != null) {
			//completeEditing();
			if(e.getPath() != null && tree.isPathVisible(e.getPath())) {
				treeState.setExpandedState(e.getPath(), false);
				updateLeadRow();
				updateSize();
			}
		}
	}	

	//******************************************************************
	//							 TreeModelListener Methods
	//******************************************************************
	
	public function treeNodesChanged(e : TreeModelEvent) : Void{
		if(treeState != null && e != null) {
			treeState.treeNodesChanged(e);
	
			var pPath:TreePath = e.getTreePath().getParentPath();
	
			if(pPath == null || treeState.isExpanded(pPath)){
				updateSize();
			}
		}
	}

	public function treeNodesInserted(e : TreeModelEvent) : Void{
		if(treeState != null && e != null) {
			treeState.treeNodesInserted(e);
	
			updateLeadRow();
	
			var path:TreePath = e.getTreePath();
	
			if(treeState.isExpanded(path)) {
				updateSize();
			}else {
				// PENDING(sky): Need a method in TreeModelEvent
				// that can return the count, getChildIndices allocs
				// a new array!
				var indices:Array<Dynamic>= e.getChildIndices();
				var childCount:Int= tree.getModel().getChildCount(path.getLastPathComponent());
	
				if(indices != null && (childCount - indices.length) == 0){
					updateSize();
				}
			}
		}
	}

	public function treeNodesRemoved(e : TreeModelEvent) : Void{
		if(treeState != null && e != null) {
			treeState.treeNodesRemoved(e);
	
			updateLeadRow();
	
			var path:TreePath = e.getTreePath();
	
			if(treeState.isExpanded(path) || tree.getModel().getChildCount(path.getLastPathComponent()) == 0){
				updateSize();
			}
		}
	}

	public function treeStructureChanged(e : TreeModelEvent) : Void{
		if(treeState != null && e != null) {
			treeState.treeStructureChanged(e);
	
			updateLeadRow();
	
			var pPath:TreePath = e.getTreePath();
	
			if (pPath != null) {
				pPath = pPath.getParentPath();
			}
			if(pPath == null || treeState.isExpanded(pPath)){
				updateSize();
			}
		}
	}
	
	public function toString():String{
		return "BasicTreeUI[]";
	}
}