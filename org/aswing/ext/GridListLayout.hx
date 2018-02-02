/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.ext;


import org.aswing.error.Error;
import org.aswing.EmptyLayout;
	import org.aswing.Container;
	import org.aswing.Insets;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	class GridListLayout extends EmptyLayout{

    private var hgap:Int;

    private var vgap:Int;

    private var rows:Int;

    private var cols:Int;
    
    private var tileWidth:Int;
    private var tileHeight:Int;

    /**
     * @param     rows   the rows, with the value zero meaning 
     *                   any number of rows
     * @param     cols   the columns, with the value zero meaning 
     *                   any number of columns
     * @param     hgap   (optional)the horizontal gap, default 0
     * @param     vgap   (optional)the vertical gap, default 0
     * @throws ArgumentError  if the value of both
     *			<code>rows</code> and <code>cols</code> is 
     *			set to zero
     */
    public function new(rows:Int=1, cols:Int=0, hgap:Int=0, vgap:Int=0) {
		if ((rows == 0) && (cols == 0)) {
	     	throw new Error("rows and cols cannot both be zero");
	 	}
	    
		this.rows = rows;
		this.cols = cols;
		this.hgap = hgap;
		this.vgap = vgap;
		super();
    }
    
    public function getRows():Int{
		return rows;
    }
    
    public function setRows(rows:Int):Void{
		this.rows = rows;
    }

    public function getColumns():Int{
		return cols;
    }
    
    public function setColumns(cols:Int):Void{
		this.cols = cols;
    }

    public function getHgap():Int{
		return hgap;
    }
    
    public function setHgap(hgap:Int):Void{
		this.hgap = hgap;
    }
    
    public function getVgap():Int{
		return vgap;
    }
    
    public function setVgap(vgap:Int):Void{
		this.vgap = vgap;
    }
	
	public function getTileWidth():Int{
		return tileWidth;
	}
	
	public function getTileHeight():Int{
		return tileHeight;
	}
	
	public function setTileWidth(w:Int):Void{
		tileWidth = w;
	}
	
	public function setTileHeight(h:Int):Void{
		tileHeight = h;
	}	
	
    override public function preferredLayoutSize(target:Container):IntDimension{
		if ((cols == 0) && (this.rows == 0)) {
	    	throw new Error("rows and cols cannot both be zero");
		}
		var insets:Insets = target.getInsets();
		var ncomponents:Int= target.getComponentCount();
		var nrows:Int= rows;
		var ncols:Int= cols;
		if (nrows > 0){
			ncols = Math.floor(((ncomponents + nrows) - 1) / nrows);
		}else{
			nrows = Math.floor(((ncomponents + ncols) - 1) / ncols);
		}
		var w:Int= tileWidth;
		var h:Int= tileHeight;
		return new IntDimension((((insets.left + insets.right) + (ncols * w)) + ((ncols - 1) * hgap)), (((insets.top + insets.bottom) + (nrows * h)) + ((nrows - 1) * vgap))); 	
    }
    
    public function getViewSize(target:GridCellHolder):IntDimension{
		if ((cols == 0) && (this.rows == 0)) {
	    	throw new Error("rows and cols cannot both be zero");  
		}
		var insets:Insets = target.getInsets();
		var ncomponents:Int= target.getComponentCount();
		var nrows:Int= rows;
		var ncols:Int= cols;
		var list:GridList = target.getList();
		var bounds:IntDimension = list.getExtentSize();
		if(list.isTracksWidth() || list.isTracksHeight()){
			if(list.isTracksHeight()){
				nrows = Math.floor((bounds.height+vgap)/(tileHeight+vgap));
				ncols = Math.floor(((ncomponents + nrows) - 1) / nrows);
			}else{
				ncols = Math.floor((bounds.width+hgap)/(tileWidth+hgap));
				nrows = Math.floor(((ncomponents + ncols) - 1) / ncols);
			}
		}else{
			if(nrows > 0){
				ncols = Math.floor(((ncomponents + nrows) - 1) / nrows);
			}else{
				nrows = Math.floor(((ncomponents + ncols) - 1) / ncols);
			}
		}
		var w:Int= tileWidth;
		var h:Int= tileHeight;
		return new IntDimension((((insets.left + insets.right) + (ncols * w)) + ((ncols - 1) * hgap)), (((insets.top + insets.bottom) + (nrows * h)) + ((nrows - 1) * vgap)));    	
    }

    override public function minimumLayoutSize(target:Container):IntDimension{
		return target.getInsets().getOutsideSize();
    }
	
	/**
	 * return new IntDimension(1000000, 1000000);
	 */
    override public function maximumLayoutSize(target:Container):IntDimension{
    	return new IntDimension(1000000, 1000000);
    }
    
    override public function layoutContainer(target:Container):Void{
		if ((cols == 0) && (this.rows == 0)) {
	    	throw new Error("rows and cols cannot both be zero");
		}
		var insets:Insets = target.getInsets();
		var ncomponents:Int= target.getComponentCount();
		var nrows:Int= rows;
		var ncols:Int= cols;
		if (ncomponents == 0){
			return ;
		}
		var bounds:IntRectangle = insets.getInsideBounds(target.getSize().getBounds());
		var list:GridList = AsWingUtils.as(target,GridCellHolder).getList();
		if(list.isTracksWidth() || list.isTracksHeight()){
			if(list.isTracksHeight()){
				nrows = Math.floor((bounds.height+vgap)/(tileHeight+vgap));
				ncols = Math.floor(((ncomponents + nrows) - 1) / nrows);
			}else{
				ncols = Math.floor((bounds.width+hgap)/(tileWidth+hgap));
				nrows = Math.floor(((ncomponents + ncols) - 1) / ncols);
			}
		}else{
			if(nrows > 0){
				ncols = Math.floor(((ncomponents + nrows) - 1) / nrows);
			}else{
				nrows = Math.floor(((ncomponents + ncols) - 1) / ncols);
			}
		}
		var w:Int= getTileWidth();
		var h:Int= getTileHeight();
		var x:Int= insets.left;
		var y:Int= insets.top;
		for (r in 0...nrows){
			x = insets.left;
			for (c in 0...ncols){
				var i:Int= ((r * ncols) + c);
				if (i < ncomponents){
					target.getComponent(i).setBounds(new IntRectangle(x, y, w, h));
					list.getCellByIndex(i).setGridListCellStatus(list, list.isSelectedIndex(i), i);
				}
				x += (w + hgap);
			}
			y += (h + vgap);
		}
	}
}