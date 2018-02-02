package org.aswing;


import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;


/**
 * Each child will have a weight, for its width(X_AXIS) or height(Y_AXIS) share from parent.
 * @author paling (Burstyx Studio)
 */
class WeightBoxLayout implements LayoutManager{
	
	/**
	 * Specifies that components should be laid out left to right.
	 */
	inline public static var X_AXIS:Int= AsWingConstants.HORIZONTAL;
	
	/**
	 * Specifies that components should be laid out top to bottom.
	 */
	inline public static var Y_AXIS:Int= AsWingConstants.VERTICAL;
	
	private var axis:Int;
	private var gap:Int;
	
	public function new(axis:Int=X_AXIS, gap:Int=0){
		this.axis = axis;
		this.gap  = gap;
	}
	
	/**
	 * Sets new axis. Must be one of:
	 * <ul>
	 *  <li>X_AXIS
	 *  <li>Y_AXIS
	 * </ul> Default is X_AXIS.
	 * @param axis new axis
	 */
	public function setAxis(axis:Int= X_AXIS):Void{
		this.axis = axis ;
	}
	
	/**
	 * Gets axis.
	 * @return axis
	 */
	public function getAxis():Int{
		return axis;	
	}
	
	/**
	 * Sets new gap.
	 * @param get new gap
	 */	
	public function setGap(gap:Int= 0):Void{
		this.gap = gap ;
	}
	
	/**
	 * Gets gap.
	 * @return gap
	 */
	public function getGap():Int{
		return gap;	
	}
		
	
	public function addLayoutComponent(comp:Component, constraints:Dynamic):Void{
		comp.setConstraints(constraints);
	}
	
	public function removeLayoutComponent(comp:Component):Void{
	}
	
	public function preferredLayoutSize(target:Container):IntDimension{
		var count:Int= target.getComponentCount();
		var insets:Insets = target.getInsets();
		var width:Int= 0;
		var height:Int= 0;
		var wTotal:Int= 0;
		var hTotal:Int= 0;
		for(i in 0...count){
			var c:Component = target.getComponent(i);
			if(c.isVisible()){
				var size:IntDimension = c.getPreferredSize();
				width = Std.int(Math.max(width, size.width));
				height = Std.int(Math.max(height, size.height));
				var g:Int= i > 0 ? gap : 0;
				wTotal += (size.width + g);
				hTotal += (size.height + g);
			}
		}
		if(axis == Y_AXIS){
			height = hTotal;
		}else{
			width = wTotal;
		}
		
		var dim:IntDimension = new IntDimension(width, height);
		return insets.getOutsideSize(dim);
	}
	
	public function minimumLayoutSize(target:Container):IntDimension{
		return target.getInsets().getOutsideSize(); 
	}
	
	public function maximumLayoutSize(target:Container):IntDimension{
		return new IntDimension(100000, 100000);
	}
	
	private function getWeightOfComp(c:Component):Float{
		var weight:Float=  Std.parseFloat(c.getConstraints());
		if( weight==0){
			weight = 0;
		}
		return weight;
	}
	
	public function layoutContainer(target:Container):Void{
		var count:Int= target.getComponentCount();
		var size:IntDimension = target.getSize();
		var insets:Insets = target.getInsets();
		var rd:IntRectangle = insets.getInsideBounds(size.getBounds());
		var ch:Int= rd.height;
		var cw:Int= rd.width;
		var x:Int= rd.x;
		var y:Int= rd.y;
		var i:Int= 0;
		var sumWeight:Float= 0;
		for(i in 0...count){
			sumWeight += getWeightOfComp(target.getComponent(i));
		}
		
		var sumGap:Int= (count-1) * gap;
		
		var comp:Component;
		var weight:Float;
		if(axis == X_AXIS){
			var contentW:Int= cw - sumGap;
			for(i in 0...count){
				comp = target.getComponent(i);
				weight = getWeightOfComp(comp);
				var compW:Int= Math.floor(weight/sumWeight*contentW);
				target.getComponent(i).setComBoundsXYWH(x, y, compW, ch);
				x += (gap + compW);
			}
		}else{
			var contentH:Int= ch - sumGap;
			for(i in 0...count){
				comp = target.getComponent(i);
				weight = getWeightOfComp(comp);
				var compH:Int= Math.floor(weight/sumWeight*contentH);
				target.getComponent(i).setComBoundsXYWH(x, y, cw, compH);
				y += (gap + compH);
			}
		}
		
	}
	
	public function getLayoutAlignmentX(target:Container):Float{
		return 0;
	}
	
	public function getLayoutAlignmentY(target:Container):Float{
		return 0;
	}
	
	public function invalidateLayout(target:Container):Void{
	}
	
}