/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;

import org.aswing.geom.IntDimension;
import org.aswing.graphics.Graphics2D;
import org.aswing.util.ArrayList;

/**
 * MultipleAssetIcon is a Icon impelmentation that use multiple decorative DisplayObject-s.
 * 
 * @see org.aswing.AssetIcon
 * @see org.aswing.AttachIcon
 * @see org.aswing.LoadIcon
 * 
 * @author srdjan
 */	
class MultipleAssetIcon implements Icon{
	
	/**
	 * Align asset to horizontal or vertical center position.
	 */
	inline public static var CENTER:Int= 0;
	
	/**
	 * Align asset to top position.
	 */
	inline public static var TOP:Int= 1;
	
	/**
	 * Align asset to bottom position.
	 */
	inline public static var BOTTOM:Int= 2;

	/**
	 * Align asset to left position.
	 */
	inline public static var LEFT:Int= 3;

	/**
	 * Align asset to right position.
	 */
	 
	inline public static var RIGHT:Int= 4;
	
	/**
	 * Contains AssetItem objects in order that need to be shown.
	 */
	private var assets:ArrayList;
	
	private var assetContainer:DisplayObjectContainer;
	private var assetGapInsets:Insets;
	
	/**
	 * if relativeMaxSize is used if absoluteSize is not in use
	 */
	private var relativeMaxSize:IntDimension;
	
	/**
	 * if absoluteSize is used,  the relativeMaxSize is not in use.
	 */
	private var absoluteSize:IntDimension;
	
	/**
	 * Creates a MultipleAssetIcon.
	 * 
	 * @param absoluteSize set the absolute size of a asset. 
	 * If it's not set it will be used size of the biggest 
	 * asset that it's added with <code>addAsset()</code> method.
	 */
	public function new(absoluteSize:IntDimension=null){
		this.absoluteSize = absoluteSize;
		this.relativeMaxSize = new IntDimension(-1,-1);
		assets =  new ArrayList();
		assetContainer = AsWingUtils.createSprite(null, "assetContainer");
		assetGapInsets = new Insets(0,0,0,0);
	}
	
	/**
	 * Add a new asset to asset container. Last added asset will be at the top of all other.
	 * 
	 * @param asset display object to be show.
	 * @param width (optional)if you specifiled the width of the Icon, and scale is true,
	 * 		the mc will be scale to this width when paint. If you do not specified the with, it will use 
	 * 		asset.width.
	 * @param height (optional)if you specifiled the height of the Icon, and scale is true, 
	 * 		the mc will be scale to this height when paint. If you do not specified the height, it will use 
	 * 		asset.height.
	 * @param scale (optional)whether scale MC to fix the width and height specified. Default is true
	 * @param horizontalPosition The horizontal position of asset 
	 * @param verticalPosition The vertical position of asset (affect only if scale is not true and asset size is bigged than asset)
	 *
	 * @see #addAssetItem()
	 */
	public function addAsset(asset:DisplayObject, width:Float=-1, height:Float=-1, scale:Bool=false, horizontalPosition:Int=-1, verticalPosition:Int=-1  ):Void{
		var assetItem:AssetItem = new AssetItem(asset,Std.int( width), Std.int(height), scale,Std.int( horizontalPosition), Std.int(verticalPosition));
		addAssetItem(assetItem);
	}
	
	/**
	 * Add a new asset to asset container. Last added asset will be at the top of all other.
	 *
	 * @param assetItem
	 * 	
	 *  @see #addAsset()
	 */
	private function addAssetItem(assetItem:AssetItem):Void{
		
		assets.append(assetItem);
		
		if (assetItem.getWidth()==-1 && assetItem.getHeight()==-1){
			assetItem.setWidth(Std.int(assetItem.getAsset().width));
			assetItem.setHeight(Std.int(assetItem.getAsset().height));				
		}
		
		relativeMaxSize.width = Std.int(Math.max(relativeMaxSize.width, assetItem.getWidth()));
		relativeMaxSize.height = Std.int(Math.max(relativeMaxSize.height, assetItem.getHeight()));
		
		var maskShape:Shape = AsWingUtils.createShape(assetContainer, "maskShape");
		assetContainer.addChild(assetItem.getAsset());
		assetItem.getAsset().mask = maskShape;
	}
	
	/**
	 * Set  value for a blank space from each one side of asset.
	 * 
	 * @param insets 
	 */
	public function setGapFromEdge(insets:Insets):Void{
		assetGapInsets = insets;
	}
		
	/**
	 * Return value for a blank space from each one side of asset.
	 * 
	 * @return 
	 */
	public function getGapFromEdge():Insets{
		return assetGapInsets;
	}
	
	/**
	 * Return the number of assets.
	 * 
	 * @return
	 */
	private function getAssetsCount():Int{
		return assets.size();
	}
	
	/**
	 * Return the asset item at index position.
	 * 
	 * @return
	 */
	private function getAssetItemAt(index:Int):AssetItem{
		return assets.elementAt(index);
	}
	
	/**
	 * Clone the MultipleAssetIcon instance
	 * 
	 * @param multipleAssetIcon Source MultipleAssetIcon
	 * @return Cloned MultipleAssetIcon
	 */
	public function clone():MultipleAssetIcon{
		 
		var clonedMultipleAssetIcon:MultipleAssetIcon = new MultipleAssetIcon(absoluteSize);
		clonedMultipleAssetIcon.setGapFromEdge(getGapFromEdge());
		 	
		for(i in 0...assets.size()){
			clonedMultipleAssetIcon.addAssetItem(getAssetItemAt(i).clone());
		}
			 	
		return clonedMultipleAssetIcon;
	}
	 
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		
		assetContainer.x = x+assetGapInsets.left;
		assetContainer.y = y+assetGapInsets.top;
		
		var w:Int= relativeMaxSize.width;
		var h:Int= relativeMaxSize.height;
		if(absoluteSize!=null){
		
			w = absoluteSize.width;
			h = absoluteSize.height;
		}
		
		for (i in 0...assets.size()){
			var assetItem:AssetItem = assets.elementAt(i);
			var asset:DisplayObject = assetItem.getAsset();

			// draw mask
			var maskShape:Shape = AsWingUtils.as(asset.mask,Shape);
			maskShape.graphics.clear();
			maskShape.graphics.beginFill(0xffffff);
			maskShape.graphics.drawRect(0, 0, w, h);
			maskShape.graphics.endFill();
			
			//scale
			if(assetItem.getScale()){
				asset.width = w;
				asset.height = h;
			}
			// set position
			else if(assetItem.getHorizontalPosition()!=-1 && assetItem.getVerticalPosition()!=-1){
				switch(assetItem.getHorizontalPosition()){
					case CENTER:
						asset.x = Math.floor((w - assetItem.getWidth())/2);
					break;
					case RIGHT:
						asset.x = Math.floor(w - assetItem.getWidth());
					break;
					case LEFT:
					default:
						asset.x = 0;
					break;
				}
				switch(assetItem.getVerticalPosition()){
					case CENTER:
						asset.y = Math.floor((h - assetItem.getHeight())/2);
					break;
					case BOTTOM:
						asset.y = Math.floor(h - assetItem.getHeight());
					break;
					case TOP:
					default:
						asset.y = 0;
					break;
				}
			}
		}

	}
	
	public function getIconHeight(c:Component):Int{
		if(absoluteSize != null){
			return absoluteSize.height + assetGapInsets.getMarginHeight();
		}
		return relativeMaxSize.height + assetGapInsets.getMarginHeight();
	}
	
	public function getIconWidth(c:Component):Int{
		if(absoluteSize != null){
			return absoluteSize.width + assetGapInsets.getMarginWidth();
		}
		return relativeMaxSize.width + assetGapInsets.getMarginWidth();
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return assetContainer;
	}
 
}

/**
 * AssetItem is a holder for asset properties.
 * 
 * @see com.awssoft.fwindows.components.MultipleAssetIcon
 */	
 class AssetItem{
	
	private var width:Int;
	private var height:Int;
	private var scale:Bool; 
	private var asset:DisplayObject;
	private var hPosition:Int;
	private var vPosition:Int;
	
	/**
	 * Creates a AssetItem that holds asset properties.
	 * 
	 * @param asset The display object that will be shown.
	 * @param width (optional)if you specifiled the width of the Icon, and scale is true,
	 * 		the mc will be scale to this width when paint. If you do not specified the with, it will use 
	 * 		asset.width.
	 * @param height (optional)if you specifiled the height of the Icon, and scale is true, 
	 * 		the mc will be scale to this height when paint. If you do not specified the height, it will use 
	 * 		asset.height.
	 * @param scale (optional)whether scale MC to fix the width and height specified. Default is true
	 * @param hPosition The horizontal position of asset display object (affect only if scale is not true and asset size is bigged than asset display object)
	 * @param vPosition The vertical position of asset display object (affect only if scale is not true and asset size is bigged than asset display object)
	 */ 
	public function new(asset:DisplayObject=null, width:Int=-1, height:Int=-1, scale:Bool=false, hPosition:Int=-1,  vPosition:Int=-1 ){
		this.asset = asset;
		this.scale = scale;
		this.width = width;
		this.height = height;
		this.hPosition=hPosition;
		this.vPosition=vPosition;
	}
	
	/**
	 * Return asset.
	 */
	public function getAsset():DisplayObject{
		return asset;
	}
	
	/**
	 * Return whatever the asset need to be scaled.
	 */
	public function getScale():Bool{
		return scale;
	}
	
	/**
	 * Return asset width.
	 */
	public function getWidth():Int{
		return width;
	}
	
	/**
	 * Return asset height.
	 */
	public function getHeight():Int{
		return height;
	}
	
	/**
	 * Return hPosition.
	 */
	public function getHorizontalPosition():Int{
		return hPosition;
	}
	
	/**
	 * Return vPosition.
	 */
	public function getVerticalPosition():Int{
		return vPosition;
	}
	
	/**
	 * Set asset.
	 */
	public function setAsset(asset:DisplayObject):Void{
		this.asset = asset;
	}
	
	/**
	 * Set whatever the asset need to be scaled.
	 */
	public function setScale(scale:Bool):Void{
		this.scale=scale;
	}
	
	/**
	 * Set asset width.
	 */
	public function setWidth(width:Int):Void{
		this.width=width;
	}
	
	/**
	 * Set asset height.
	 */
	public function setHeight(height:Int):Void{
		this.height=height;
	}
	
	/**
	 * Set hPosition.
	 */
	public function setHorizontalPosition(hPosition:Int):Void{
		this.hPosition=hPosition;
	}
	
	/**
	 * Set vPosition.
	 */
	public function setVerticalPosition(vPosition:Int):Void{
		this.vPosition=vPosition;
	}
	
	/**
	 * Clone the asset item.
	 * 
	 * @return Clone of this
	 */
	 
	 public function clone():AssetItem{
	 	var clazz:Class<Dynamic>= Type.getClass(asset);
	 	var clonedAsset:DisplayObject =AsWingUtils.as(Type.createInstance( clazz,[]) , DisplayObject);
	 	var clone:AssetItem = new AssetItem(clonedAsset, width, height, scale, hPosition,  vPosition);
	 	return clone;
	 }
}