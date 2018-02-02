/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.ext;


import org.aswing.error.Error;
import org.aswing.JPanel;
import org.aswing.LayoutManager;
import org.aswing.util.ArrayList;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.AsWingConstants;
import org.aswing.geom.IntDimension;
import org.aswing.event.ContainerEvent;

/**
 * FormRow is a row in the Form.<br/>
 * A row include column children, each child sit a row, null child make a column blank, 
 * also a child can sit a continuous serveral columns.<br/>
 * For the 3 case, they are:
 * <p>
 * <ul>
 * 
 * <li>
 * [ --child1-- ][ --child2-- ][ --child3-- ]<br/>
 * 3 children sit 3 columns, one by one: <br/>
 * <code>setColumnChildren(child1, child2, child3);</code>
 * </li>
 * 
 * <li>
 * [ ---------- ][ --child1-- ][ --child2-- ]<br/>
 * First blank, and then 2 children sit 2 columns: <br/>
 * <code>setColumnChildren(null, child1, child2);</code>
 * </li>
 * 
 * <li>
 * [ ----------child1-------- ][ --child2-- ]<br/>
 * child1 sit first two column2, child2 sit last column: <br/>
 * <code>setColumnChildren(child1, child1, child2);</code>
 * </li>
 * 
 * </ul>
 * </p>
 * <p>
 * Use <code>setColumnChildren</code> and <code>setColumnChild</code> to set the columns 
 * instead of <code>append/remove</code> method of <code>Container</code>.
 * </p>
 * 
 * @author paling
 */
class FormRow extends JPanel  implements LayoutManager{
	
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	inline public static var CENTER:Int= AsWingConstants.CENTER;
	
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	inline public static var TOP:Int= AsWingConstants.TOP;
	
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var BOTTOM:Int= AsWingConstants.BOTTOM;
        
    private var verticalAlignment:Int;
    private var columns:ArrayList;
    private var widthes:Array<Dynamic>;
	private var columnVerticalAlignments:Array<Dynamic>;
	private var gap:Int;
	private var columnChildrenIndecis:String;
    
    /**
     * Create a form row with specified column children.
     * @see #setColumnChildren()
     */
	public function new(?columnChildren: Array<Dynamic>){
		super();
		_layout = this;
		verticalAlignment = AsWingConstants.CENTER;
		columns = new ArrayList();
		columns.appendAll(columnChildren);
		appendChildren(columnChildren);
		columnVerticalAlignments = new Array<Dynamic>();
		gap = 0;
		addEventListener(ContainerEvent.COM_ADDED, __childrenChangedResetColumns);
		addEventListener(ContainerEvent.COM_REMOVED, __childrenChangedResetColumns);
	}
	
	private function appendChildren(arr:Array<Dynamic>):Void{
		for(i in 0...arr.length){
			var com:Component = AsWingUtils.as(arr[i], Component);
			if(com != null){
				append(com);
			}
		}
	}
	
	public function setGap(gap:Int):Void{
		this.gap = gap;
	}
	
	public function getGap():Int{
		return gap;
	}
	
	/**
	 * Sets the column children.
	 * @param columnChildren the children list.
	 */
	public function setColumnChildren(columnChildren:Array<Dynamic>):Void{
		removeAll();
		columns = new ArrayList();
		columns.appendAll(columnChildren);
		appendChildren(columnChildren);
	}
	
	/**
	 * This is used for GuiBuilder.
	 * If a columnChildrenIndecis is set, when children changed, it will reset the 
	 * columns value with columnChildrenIndecis. Default is null
	 * <br>
	 * Set it null to not automatical reset column when children changed.
	 * <p>
	 * For example: 
	 * "-1,0,0,1" means [ ---------- ][ --child0 sit two column-- ][ --child1-- ]
	 * </p>
	 * @param indices the indices of children to be the columns, null to disable this automatic column set.
	 */
	public function setColumnChildrenIndecis(indices:String):Void{
		if(indices == null){
			columnChildrenIndecis = null;
			return;
		}
		columnChildrenIndecis = indices;
		var childIndecis:Array<Dynamic>= indices.split(",");
		columns = new ArrayList();
		for(i in 0...childIndecis.length){
			var index:Int= Std.parseInt(childIndecis[i]);
			if((index==0)) index = -1;
			if(index >= 0 && index < getComponentCount()){
				columns.append(getComponent(index));
			}else{
				columns.append(null);
			}
		}
		revalidate();
	}
	
	private function __childrenChangedResetColumns(e:ContainerEvent):Void{
		if(columnChildrenIndecis != null){
			setColumnChildrenIndecis(columnChildrenIndecis);
		}
	}
	
	/**
	 * Sets the specified column position child.
	 * @param column the column position.
	 * @param child the child.
	 */
	public function setColumnChild(column:Int, child:Component):Component{
		if(column < 0 || column > getColumnCount()){
			throw new Error("Out of column bounds!");
			return null;
		}
		var old:Component = null;
		if(column < getColumnCount()){
			columns.get(column);
			columns.setElementAt(column, child);
		}else{
			columns.append(child);
		}
		if(old != null){
			if(!columns.contains(old)){
				remove(old);
			}
		}
		if(child != null){
			append(child);
		}
		return old;
	}
	
	/**
	 * Returns the child of column.
	 * @return a component, or null.
	 */
	public function getColumnChild(column:Int):Component{
		return columns.get(column);
	}
	
	/**
	 * Returns the column count.
	 * @return column count.
	 */
	public function getColumnCount():Int{
		return columns.size();
	}
	
	/**
	 * Returns the preferred size of specified column.
	 */
	public function getColumnPreferredWidth(column:Int):Int{
		var child:Component = getColumnChild(column);
		if(child == null){
			return 0;
		}
		return Math.ceil(child.getPreferredWidth()/getContinuousCount(column));
	}
	
    /**
     * Returns the default vertical alignment of the children in the row.
     *
     * @return the <code>verticalAlignment</code> property, one of the
     *		following values: 
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function getVerticalAlignment():Int{
        return verticalAlignment;
    }
    
    /**
     * Sets the default vertical alignment of the children in the row.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function setVerticalAlignment(alignment:Int):Void{
        if (alignment == verticalAlignment){
        	return;
        }else{
        	verticalAlignment = alignment;
        	revalidate();
        }
    }

    /**
     * Returns the vertical alignment of a row.
     *
     * @return the <code>verticalAlignment</code> property, one of the
     *		following values: 
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function getColumnVerticalAlignment(column:Int):Int{
    	if(columnVerticalAlignments[column] == null){
        	return verticalAlignment;
     	}else{
     		return columnVerticalAlignments[column];
     	}
    }
    
    /**
     * Sets the vertical alignment of a row.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function setColumnVerticalAlignment(column:Int, alignment:Int):Void{
        if (alignment == columnVerticalAlignments[column]){
        	return;
        }else{
        	columnVerticalAlignments[column] = alignment;
        	revalidate();
        }
    }    
	
	override public function setLayout(layout:LayoutManager):Void{
		if(!(Std.is(layout,FormRow))){
			throw new  Error("layout must be FormRow instance!");
			return;
		}
		super.setLayout(layout);
	}
	
	private function getContinuousCount(column:Int):Int{
		var child:Component = columns.get(column);
		var total:Int= getColumnCount();
		var count:Int= 1;
		var i:Int;
		for(i in column+1...total){
			if(getColumnChild(i) != child){
				break;
			}
			count++;
		}
		for(i in 0...column ){
			if(getColumnChild(i) != child){
				break;
			}
			count++;
		}
		return count;
	}
	
	/**
	 * Sets the width of all columns.
	 * @param widthes a array that contains all width of columns.
	 */
	public function setColumnWidthes(widthes:Array<Dynamic>):Void{
		this.widthes = widthes.copy();
	}
	
	/**
	 * Returns the width of column.
	 * @return the width of column.
	 */
	public function getColumnWidth(column:Int):Int{
		if(widthes == null) return 0;
		if(widthes[column] == null) return 0;
		return widthes[column];
	}
	
	//___________________________layout manager_________________________________
	
	public function addLayoutComponent(comp:Component, constraints:Dynamic):Void{
	}
	
	public function invalidateLayout(target:Container):Void{
	}
	
	public function minimumLayoutSize(target:Container):IntDimension{
		return getInsets().getOutsideSize(new IntDimension(0, 0));
	}
	
	public function preferredLayoutSize(target:Container):IntDimension{
		var h:Int= 0;
		var w:Int= 0;
		var i:Int;
		var n:Int;
		for(i in 0...getComponentCount() ){
			var ih:Int= getComponent(i).getPreferredHeight();
			if(ih > h) h = ih;
		}
		n = getColumnCount();
		for(i in 0...n){
			w += getColumnPreferredWidth(i);
		}
		if(n > 1){
			w += (n-1)*gap;
		}
		return getInsets().getOutsideSize(new IntDimension(w, h));
	}
	
	public function maximumLayoutSize(target:Container):IntDimension{
		return IntDimension.createBigDimension();
	}
	
	public function layoutContainer(target:Container):Void{
		var c:Component;
		var i:Int;
		var n:Int;
		n = getColumnCount();
		var sx:Int= getInsets().left;
		var sy:Int= getInsets().top;
		var h:Int = getHeight() - getInsets().getMarginHeight();
		i = 0;
		while(i<n){
			c = getColumnChild(i);
			var ccount:Int= getContinuousCount(i);
			var va:Int= getColumnVerticalAlignment(i);
			var ph:Int= 0;
			if(c!=null)	{
				ph = c.getPreferredHeight();
			}
			var pw:Int= getColumnWidth(i)*ccount;
			var py:Int= sy;
			if(va == TOP){
			}else if(va == BOTTOM){
				py = sy + h - ph;
			}else{
				py = Std.int(sy + (h - ph)/2);
			}
			if(ccount > 1){
				i += Std.int(ccount-1);
				pw += (ccount-1)*gap;
			}
			if(c!=null)	{
				c.setComBoundsXYWH(sx, sy, pw, ph);
			}
			sx += (pw + gap);
			i++;
		}
	}
	
	public function removeLayoutComponent(comp:Component):Void{
	}
	
	public function getLayoutAlignmentY(target:Container):Float{
		return getAlignmentY();
	}
	
	public function getLayoutAlignmentX(target:Container):Float{
		return getAlignmentX();
	}
	
}