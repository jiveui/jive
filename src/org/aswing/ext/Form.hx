/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.ext;


import org.aswing.error.Error;
import org.aswing.BorderLayout;
import org.aswing.CenterLayout;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.FlowLayout;
import org.aswing.Insets;
import org.aswing.JLabel;
import org.aswing.JPanel;
import org.aswing.JSeparator;
import org.aswing.JSpacer;
import org.aswing.LayoutManager;
import org.aswing.geom.IntDimension;

/**
 * Form is a vertical list of <code>FormRow</code>s.
 * Form will are tring to manage to layout <code>FormRow</code>s, if you append non-FormRow 
 * component to be child of Form, it will layouted as a <code>SoftBoxLayout</code> layouted.
 * @author paling
 * @see FormRow
 */
class Form extends JPanel  implements LayoutManager{
	
	private var hGap:Int;
	private var vGap:Int;
	
	public function new(){
		super();
		_layout = this;
		hGap = vGap = 2;
	}
	
	public function setVGap(gap:Int):Void{
		if(this.vGap != gap){
			this.vGap = gap;
			revalidate();
		}
	}
	
	public function getVGap():Int{
		return vGap;
	}	
	
	public function setHGap(gap:Int):Void{
		if(this.hGap != gap){
			this.hGap = gap;
			revalidate();
		}
	}
	
	public function getHGap():Int{
		return hGap;
	}	
	
	override public function setLayout(layout:LayoutManager):Void{
		if(!(Std.is(layout,Form))){
			throw new  Error("layout must be Form instance!");
			return;
		}
		super.setLayout(layout);
	}
	
	/**
	 * Adds a FormRow with columns children. Each child sit a row, null child make a column blank, 
	 * also a child can sit a continuous serveral columns.<br/>
	 * For the 3 case, they are:
	 * <p>
	 * <ul>
	 * 
	 * <li>
	 * [ --child1-- ][ --child2-- ][ --child3-- ]<br/>
	 * 3 children sit 3 columns, one by one: <br/>
	 * <code>addRow(child1, child2, child3);</code>
	 * </li>
	 * 
	 * <li>
	 * [ ---------- ][ --child1-- ][ --child2-- ]<br/>
	 * First blank, and then 2 children sit 2 columns: <br/>
	 * <code>addRow(null, child1, child2);</code>
	 * </li>
	 * 
	 * <li>
	 * [ ----------child1-------- ][ --child2-- ]<br/>
	 * child1 sit first two column2, child2 sit last column: <br/>
	 * <code>addRow(child1, child1, child2);</code>
	 * </li>
	 * 
	 * </ul>
	 * </p>
	 * <p>
	 * @return the form row.
	 */
	public function addRow(columns: Array<Dynamic>):FormRow{
		var row:FormRow = createRow(columns);
		append(row);
		return row;
	}
	
	/**
	 * Appends a <code>JSeparator</code> and return it.
	 * @return the separator.
	 */
	public function addSeparator():JSeparator{
		var sp:JSeparator = new JSeparator(JSeparator.HORIZONTAL);
		append(sp);
		return sp;
	}
	
	public function addSpacer(height:Int= 4):JSpacer{
		var sp:JSpacer = JSpacer.createVerticalSpacer(height);
		append(sp);
		return sp;
	}
	
	/**
	 * @see #addRow()
	 */	
	public function createRow(columns:Array<Dynamic>):FormRow{
		var row:FormRow = new FormRow();
		row.setColumnChildren(columns);
		row.setGap(getHGap());
		return row;
	}
	
	/**
	 * @see #addRow()
	 */
	public function insertRow(index:Int, columns: Array<Dynamic>):FormRow{
		var row:FormRow = createRow(columns);
		insert(index, row);
		return row;
	}
	
	public function createLeftLabel(text:String):JLabel{
		return new JLabel(text, null, JLabel.LEFT);
	}
	
	public function createRightLabel(text:String):JLabel{
		return new JLabel(text, null, JLabel.RIGHT);
	}
	
	public function createCenterLabel(text:String):JLabel{
		return new JLabel(text, null, JLabel.CENTER);
	}
	
	public function centerHold(comp:Component):Container{
		var p:JPanel = new JPanel(new CenterLayout());
		p.append(comp);
		return p;
	}
	
	public function leftHold(comp:Component):Container{
		var p:JPanel = new JPanel(new BorderLayout());
		p.append(comp, BorderLayout.WEST);
		return p;
	}
	
	public function rightHold(comp:Component):Container{
		var p:JPanel = new JPanel(new BorderLayout());
		p.append(comp, BorderLayout.EAST);
		return p;
	}
	
	public function flowLeftHold(gap:Int, comps: Array<Dynamic>):Container{
		var p:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, gap, 0, false));
		for (i in comps ){
			p.append(i);
		}
		return p;
	}
	
	public function flowCenterHold(gap:Int, comps: Array<Dynamic>):Container{
		var p:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, gap, 0, false));
		for (i in comps ){
			p.append(i);
		}
		return p;
	}
	
	public function flowRightHold(gap:Int, comps: Array<Dynamic>):Container{
		var p:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, gap, 0, false));
		for (i in comps ){
			p.append(i);
		}
		return p;
	}
	
	/**
	 * Returns the FormRows list in the children list.
	 */
	public function getRows():Array<Dynamic>{
		var rows:Array<Dynamic>= new Array<Dynamic>();
		var n:Int= getComponentCount();
		for(i in 0...n){
			var c:Component = this.getComponent(i);
			if(Std.is(c,FormRow)){
				rows.push(c);
			}
		}
		return rows;
	}
	
	/**
	 * Returns the children that are not Form Row.
	 */
	public function getOtherChildren():Array<Dynamic>{
		var others:Array<Dynamic>= new Array<Dynamic>();
		var n:Int= getComponentCount();
		for(i in 0...n){
			var c:Component = this.getComponent(i);
			if(!(Std.is(c,FormRow))){
				others.push(c);
			}
		}
		return others;
	}
	
	public function getColumnCount():Int{
		var rows:Array<Dynamic>= getRows();
		var count:Int= 0;
		for(i in 0...rows.length){
			var row:FormRow = rows[i];
			if(row.isVisible()){
				count = Std.int(Math.max(count, row.getColumnCount()));
			}
		}
		return count;
	}
	//___________________________layout manager_________________________________
	
	/**
	 * Returns the preferred size of specified column.
	 */
	private function getColumnPreferredWidth(column:Int, rows:Array<Dynamic>):Int{
		var wid:Int= 0;
		for(i in 0...rows.length){
			var row:FormRow = rows[i];
			if(row.isVisible()){
				wid =Std.int( Math.max(wid, row.getColumnPreferredWidth(column)));
			}
		}
		return wid;
	}	
	
	public function addLayoutComponent(comp:Component, constraints:Dynamic):Void{
	}
	
	public function invalidateLayout(target:Container):Void{
	}
	
	public function minimumLayoutSize(target:Container):IntDimension{
		return getInsets().getOutsideSize(new IntDimension(0, 0)); 
	}
	
	public function preferredLayoutSize(target:Container):IntDimension{
		var rows:Array<Dynamic>= getRows();
    	var count:Int;
    	var insets:Insets = target.getInsets();
    	var height:Int= 0;
    	var width:Int= 0;
    	var c:Component;
    	var i:Int= 0;
    	count = getComponentCount();
    	for(i in 0...count){
    		c = getComponent(i);
    		if(c.isVisible()){
	    		var g:Int= i > 0 ? getVGap() : 0;
	    		height += (c.getPreferredHeight() + g);
    		}
    	}
    	count = getColumnCount();
    	for(i in 0...count){
    		width += getColumnPreferredWidth(i, rows);
    		if(i > 0){
    			width += getHGap();
    		}
    	}
    	var others:Array<Dynamic>= getOtherChildren();
    	count = others.length;
    	for(i in 0...count){
    		c = others[i];
    		if(c.isVisible()){
    			width = Std.int(Math.max(width, c.getPreferredWidth()));
    		}
    	}
    	
    	var dim:IntDimension = new IntDimension(width, height);
    	return insets.getOutsideSize(dim);
	}
	
	public function maximumLayoutSize(target:Container):IntDimension{
		return IntDimension.createBigDimension();
	}
	
	public function layoutContainer(target:Container):Void{
		var rows:Array<Dynamic>= getRows();
    	var columnWids:Array<Dynamic>= new Array<Dynamic>();
    	var n:Int;
    	var i:Int;
    	n = getColumnCount();
    	for(i in 0...n){
    		columnWids.push(getColumnPreferredWidth(i, rows));
    	}
    	
    	var insets:Insets = getInsets();
		var sx:Int= insets.left;
		var sy:Int= insets.top;
		var w:Int= getWidth() - insets.getMarginWidth();
    	n = getComponentCount();
    	for(i in 0...n){
    		var c:Component = getComponent(i);
    		if(c.isVisible()){
	    		var row:FormRow = AsWingUtils.as(c,FormRow)	;
	    		var ph:Int= c.getPreferredHeight();
	    		if(row!=null)	{
	    			row.setColumnWidthes(columnWids);
	    			row.setGap(getHGap());
	    		}
	    		c.setComBoundsXYWH(sx, sy, w, ph);
	    		sy += (ph + getVGap());
    		}
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