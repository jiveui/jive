package org.aswing.ext;


import org.aswing.Component;
import org.aswing.Container;
import org.aswing.Insets;
import org.aswing.LayoutManager;
import org.aswing.geom.IntDimension;


/**
 * @author paling (Burstyx Studio)
 */
class DateGridLayout implements LayoutManager{
	
	private var indent:Int;
	private var days:Int;
	
	private var hgap:Int;
	private var vgap:Int;
	private var rows:Int;
	private var cols:Int;
	
	/**
	 * DateGrid's rows and cols are fixed after construction.
	 */
	public function new(rows:Int, cols:Int, hgap:Int=0, vgap:Int=0){
		this.rows = rows;
		this.cols = cols;
		this.hgap = hgap;
		this.vgap = vgap;
		indent = 0;
		days = 31;
	}
	
	public function setMonth(indent:Int, days:Int):Void{
		this.indent = indent;
		this.days   = days;
	}
	
	public function addLayoutComponent(comp:Component, constraints:Dynamic):Void{
	}
	
	public function removeLayoutComponent(comp:Component):Void{
	}
	
	private function countLayoutSize(target:Container, sizeFuncName:String):IntDimension{
		var n:Int= target.getComponentCount();
		var w:Int= 0;
		var h:Int= 0;
		for(i in 0...n){
			var c:Component = target.getComponent(i);
			
			var size:IntDimension=  Reflect.callMethod(c, Reflect.field(c, sizeFuncName), []);
			if(size.width > w){
				w = size.width;
			}
			if(size.height > h){
				h = size.height;
			}
		}
		var insets:Insets = target.getInsets();
		return new IntDimension((((insets.left + insets.right) + (cols * w)) + ((cols - 1) * hgap)), (((insets.top + insets.bottom) + (rows * h)) + ((rows - 1) * vgap))); 	
	}
	
	public function preferredLayoutSize(target:Container):IntDimension{
		return countLayoutSize(target, "getPreferredSize");
	}
	
	public function minimumLayoutSize(target:Container):IntDimension{
		return countLayoutSize(target, "getMinimumSize");
	}
	
	public function maximumLayoutSize(target:Container):IntDimension{
		return new IntDimension(1000000, 1000000);
	}
	
	public function layoutContainer(target:Container):Void{
		var insets:Insets = target.getInsets();
		var n:Int= target.getComponentCount();
		if (n == 0){
			return ;
		}
		var w:Int= (target.getWidth() - (insets.left + insets.right));
		var h:Int= (target.getHeight() - (insets.top + insets.bottom));
		w = Math.floor((w - ((cols - 1) * hgap)) / cols);
		h = Math.floor((h - ((rows - 1) * vgap)) / rows);
		var x:Int= insets.left;
		var y:Int= insets.top;
		
		var i:Int=0;
		for(r in 0...rows){
			x = insets.left;
			for(c in 0...cols){
				i = ((r * cols) + c - indent);
				if(i>=0 && i<days && i<n){
					var comp:Component = target.getComponent(i);
					target.getComponent(i).setComBoundsXYWH(x, y, w, h);
				}
				x += (w + hgap);
			}
			y += (h + vgap);
		}
		
		//TODO remainder children's
		//for()
	}
	
	public function getLayoutAlignmentX(target:Container):Float{
		return 0.5;
	}
	
	public function getLayoutAlignmentY(target:Container):Float{
		return 0.5;
	}
	
	public function invalidateLayout(target:Container):Void{
	}
	
}