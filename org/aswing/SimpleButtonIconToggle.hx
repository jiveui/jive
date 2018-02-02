package org.aswing;


import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import org.aswing.graphics.Graphics2D;  
import flash.filters.BitmapFilter;
class SimpleButtonIconToggle implements Icon{
	
	private var asset:SimpleButton;
	private var upState:DisplayObject;
	private var overState:DisplayObject;
	private var downState:DisplayObject;
	private var width:Int;
	private var height:Int;
	
	private static var disabledFilters:Array<BitmapFilter>;
	private static var eabledFilters:Array<BitmapFilter> = [];
	
	
	public function new(asset:SimpleButton){
		this.asset = asset;
		width = Math.ceil(asset.width);
		height = Math.ceil(asset.height);
		asset.mouseEnabled = false;
		upState = asset.upState;
		overState = asset.overState;
		downState = asset.downState;
		
		if(disabledFilters == null){
			var cmatrix:Array<Dynamic>= [0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
			 
			#if(flash9)
			    disabledFilters = [AsWingUtils.as(new flash.filters.ColorMatrixFilter(cmatrix),BitmapFilter)];		
			#end
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return asset;
	}
	
	public function getIconWidth(c:Component):Int{
		return width;
	}
	
	public function getIconHeight(c:Component):Int{
		return height;
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		asset.x = x;
		asset.y = y;
		var b:AbstractButton = AsWingUtils.as(c,AbstractButton)	;
		var state:DisplayObject = null;
		if(b!=null)	{
			var model:ButtonModel = b.getModel();
			if(model.isPressed() && model.isArmed() || model.isSelected()) {
				state = downState;
			}else if(b.isRollOverEnabled() && model.isRollOver()) {
				state = overState;
			}else{
				state = upState;
			} 
			asset.upState = state;
			 
			asset.filters = model.isEnabled() ? eabledFilters : disabledFilters;
		}
	}
 
	
}