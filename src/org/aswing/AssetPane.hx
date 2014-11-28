/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.Shape;

import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.error.ImpMissError;
import flash.display.Sprite;
import flash.display.DisplayObjectContainer;

/**
 * Abstract class for A container with a decorative asset.
 * <p>
 * External content will be load automatically when the pane was created if floorEnabled.
 * </p>
 * @see org.aswing.JLoadPane
 * @see org.aswing.JAttachPane
 * @author paling
 */	
class AssetPane extends Container{
	
	/**
	 * preffered size of this component will be the fit to contain both size of extenal image/animation
	 *  and counted from <code>LayoutManager</code>
	 */
	inline public static var PREFER_SIZE_BOTH:Int= 0;
	/**
	 * preffered size of this component will be the size of extenal image/animation
	 */
	inline public static var PREFER_SIZE_IMAGE:Int= 1;
	/**
	 * preffered size of this component will be counted by <code>LayoutManager</code>
	 */	
	inline public static var PREFER_SIZE_LAYOUT:Int= 2; 	
	
	/**
	 * Image scale mode is disabled.
	 */
	inline public static var SCALE_NONE:Int= 0;
	/**
	 * Proportional scale mode to fit pane.
	 */
	inline public static var SCALE_FIT_PANE:Int= 1;
	/**
	 * Stretch content to fill whole pane.
	 */
	inline public static var SCALE_STRETCH_PANE:Int= 2;
	/**
	 * Proportional image scale mode to fit pane's width.
	 */
	inline public static var SCALE_FIT_WIDTH:Int= 3;
	/**
	 * Proportional scale mode to fit pane's height.
	 */
	inline public static var SCALE_FIT_HEIGHT:Int= 4;
	/**
	 * Custom scaling of the image.
	 * @see setCustomScale
	 */
	inline public static var SCALE_CUSTOM:Int= 5;
	
	
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
    inline public static var LEFT:Int= AsWingConstants.LEFT;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var BOTTOM:Int= AsWingConstants.BOTTOM;
 	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    inline public static var RIGHT:Int= AsWingConstants.RIGHT;
    
	private var asset:DisplayObject;
	private var assetContainer:DisplayObjectContainer;
	private var assetMask:Shape;
	
	private var assetVisible:Bool;
	private var maskFloor:Bool;
	private var floorLoaded:Bool;
	private var prefferSizeStrategy:Int;
    private var verticalAlignment:Int;
    private var horizontalAlignment:Int;
    private var scaleMode:Int;
    private var customScale:Int;
    private var actualScale:Int;
    private var floorOriginalSize:IntDimension;
    private var floorOriginalScaleX:Float;
    private var floorOriginalScaleY:Float;
    private var hadscaled:Bool;
    private var offsetX:Float;
    private var offsetY:Float;
	
	/**
	 * AssetPane(path:String, prefferSizeStrategy:int) <br>
	 * AssetPane(path:String) prefferSizeStrategy default to PREFER_SIZE_BOTH<br>
	 * AssetPane() path default to null,prefferSizeStrategy default to PREFER_SIZE_IMAGE
	 * <p>
	 * Creates a AssetPane with a path to load external content.
	 * </p>
	 * @param asset the asset to be placed on this pane.
	 * @param prefferSizeStrategy the prefferedSize count strategy. Must be one of below:
	 * <ul>
	 * <li>{@link #PREFER_SIZE_BOTH}
	 * <li>{@link #PREFER_SIZE_IMAGE}
	 * <li>{@link #PREFER_SIZE_LAYOUT}
	 * </ul>
	 * @see #setAsset()
	 */
	public function new(asset:DisplayObject=null, prefferSizeStrategy:Int=PREFER_SIZE_IMAGE) {
		super();
		this.prefferSizeStrategy = prefferSizeStrategy;
		
    	verticalAlignment = TOP;
    	horizontalAlignment = LEFT;
    	scaleMode = SCALE_NONE;
    	actualScale = 100;
    	customScale = 100;
    	hadscaled = false;
    	maskFloor = true;
		floorOriginalSize = null;
		assetVisible = true;
		floorLoaded = false;
		offsetX = 0;
		offsetY = 0;
		floorOriginalScaleX = 1;
		floorOriginalScaleY = 1;
		setFocusable(false);
		assetContainer = AsWingUtils.createSprite(this, "assetContainer");
		assetMask = AsWingUtils.createShape(this, "assetMask");
		assetMask.graphics.beginFill(0xffffff);
		assetMask.graphics.drawRect(0, 0, 1, 1);
		assetMask.visible = false;
		setAsset(asset);
	}
	
	
	/**
	 * set the asset of the pane
	 * This method will cause old asset to be removed and new asset to be added.
	 * @param asset the asset of the pane.
	 */ 
	public function setAsset(asset:DisplayObject):Void{
		if (this.asset != asset){
			if(this.asset!=null)	{
				if(this.asset.parent == assetContainer){
					assetContainer.removeChild(this.asset);
				}
			}
			this.asset = asset;
			if(asset!=null)	{
				storeOriginalScale();
				assetContainer.addChild(asset);
			}
			setLoaded(asset != null);
			resetAsset();
		}
	}
	
	/**
	 * unload the asset of the pane
	 */ 
	public function unloadAsset():Void{
		setAsset(null);
	}
	
	private function storeOriginalScale():Void{
		if(asset!=null)	{
			floorOriginalScaleX = asset.scaleX;
			floorOriginalScaleY = asset.scaleY;
		}
	}
	
	private function resetAsset():Void{
		if(asset!=null)	{
			asset.scaleX = floorOriginalScaleX;
			asset.scaleY = floorOriginalScaleY;
			setAssetOriginalSize(new IntDimension(Std.int(asset.width), Std.int(asset.height)));
			asset.visible = assetVisible;
		}
		revalidate();
	}
	
	/**
	 * Returns the asset of the pane.
	 * <p>
	 * You should take care to do operation at this display object, 
	 * if you want to remove it, you should call <code>setAsset(null)</code> instead of 
	 * call <code>asset.parent.removeChild(asset)</code>;
	 * </p>
	 * @return the asset.
	 */
	public function getAsset():DisplayObject{
		return asset;
	}
	
	/**
	 * Sets the preffered size counting strategy. Must be one of below:
	 * <ul>
	 * <li>{@link #PREFER_SIZE_BOTH}
	 * <li>{@link #PREFER_SIZE_IMAGE}
	 * <li>{@link #PREFER_SIZE_LAYOUT}
	 * </ul>
	 */
	public function setPrefferSizeStrategy(p:Float):Void{
		prefferSizeStrategy =Std.int( p);
	}
	
	/**
	 * Returns the preffered size counting strategy.
	 * @see #setPrefferSizeStrategy()
	 */
	public function getPrefferSizeStrategy():Float{
		return prefferSizeStrategy;
	}	
	
    /**
     * Returns the vertical alignment of the image/animation.
     *
     * @return the <code>verticalAlignment</code> property, one of the
     *		following values: 
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function getVerticalAlignment():Float{
        return verticalAlignment;
    }
    
    /**
     * Sets the vertical alignment of the image/animation. 
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     * Default is CENTER.
     */
    public function setVerticalAlignment(alignment:Int=AsWingConstants.CENTER):Void{
        if (alignment == verticalAlignment){
        	return;
        }else{
        	verticalAlignment = alignment;
        	revalidate();
        }
    }
    
    /**
     * Returns the horizontal alignment of the image/animation.
     * @return the <code>horizontalAlignment</code> property,
     *		one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)
     * <li>AsWingConstants.LEFT
     * <li>AsWingConstants.CENTER
     * </ul>
     * Default is LEFT.
     */
    public function getHorizontalAlignment():Float{
        return horizontalAlignment;
    }
    
    /**
     * Sets the horizontal alignment of the image/animation.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)
     * <li>AsWingConstants.LEFT
     * <li>AsWingConstants.CENTER
     * </ul>
     */
    public function setHorizontalAlignment(alignment:Int=AsWingConstants.RIGHT):Void{
        if (alignment == horizontalAlignment){
        	return;
        }else{
        	horizontalAlignment = alignment;
        	revalidate();
        }
    }
    
    /**
     * Sets new content scale mode.
     * <p><b>Note:</b>Take care to use #scaleMode to load a swf, 
     * because swf has different size at different frame or
     * when some symbol invisible/visible.
     * @param mode the new image scale mode.
	 * <ul>
	 * <li>{@link #SCALE_NONE}
	 * <li>{@link #SCALE_PROPORTIONAL}
	 * <li>{@link #SCALE_COMPLETE}
	 * </ul>
     */
    public function setScaleMode(mode:Int):Void{
    	if(scaleMode != mode){
    		scaleMode = mode;
    		revalidate();
    	}
    }
    
    /**
     * Returns current image scale mode. 
     * @return current image scale mode.
	 * <ul>
	 * <li>{@link #SCALE_NONE}
	 * <li>{@link #SCALE_PROPORTIONAL}
	 * <li>{@link #SCALE_COMPLETE}
	 * </ul>
     */
    public function getScaleMode():Int{
    	return scaleMode;
    }
    
    /**
     * Sets new custom scale value in percents. Automatically turns scale mode into #SCALE_CUSTOM.
     * @param scale the new scale 
     * @see #setScaleMode
     */
    public function setCustomScale(scale:Int):Void{
    	setScaleMode(SCALE_CUSTOM);
    	if (customScale != scale) {
    		customScale = scale;
    		revalidate();	
    	}
    }
    
    /**
     * Returns current actual scale value in percents. If <code>scaleMode</code> is
     * #SCALE_STRETCH_PANE returns <code>null</code>. 
     */
    public function getActualScale():Int{
    	return actualScale;	
    }

    /**
     * Returns current custom scale value in percents.
     */
    public function getCustomScale():Int{
    	return customScale;	
    }
    
    /**
     * Sets the x offset of the position of the loaded image/animation.
     * If you dont want to locate the content to the topleft of the pane, you can set the offsets.
     * @param offset the x offset 
     */
    public function setOffsetX(offset:Float):Void{
    	if(offsetX != offset){
    		offsetX = offset;
    		revalidate();
    	}
    }
    
    /**
     * Sets the y offset of the position of the loaded image/animation.
     * If you dont want to locate the content to the topleft of the pane, you can set the offsets.
     * @param offset the y offset 
     */
    public function setOffsetY(offset:Float):Void{
    	if(offsetY != offset){
    		offsetY = offset;
    		revalidate();
    	}
    }    
    
    /**
     * @see #setOffsetX()
     */
    public function getOffsetX():Float{
    	return offsetX;
    }
    
    /**
     * @see #setOffsetY()
     */
    public function getOffsetY():Float{
    	return offsetY;
    }
	
	/**
	 * Sets the visible of the assets.
	 * @param b the visible property.
	 */
	public function setAssetVisible(b:Bool):Void{
		assetVisible = b;
		if(asset!=null)	{
			asset.visible = b;
		}
	}
	
	/**
	 * Returns the asset visible property.
	 * @return the asset visible property.
	 */
	public function isAssetVisible():Bool{
		return assetVisible;
	}
	
	/**
	 * Returns is the asset was loaded ok.
	 * @return true if the asset loaded ok, otherwise return false
	 */
	public function isLoaded():Bool{
		return floorLoaded;
	}
	
	/**
	 * Returns the asset's original size.
	 * If the asset are not loaded yet, return null.
	 * @return the asset original size. null if it is not loaded yet.
	 */
	public function getAssetOriginalSize():IntDimension{
		if(isLoaded()){
			return floorOriginalSize;
		}else{
			return null;
		}
	}
	
	/**
	 * layout this container
	 */
	override public function doLayout():Void{
		super.doLayout();
		fitImage();
	}	
	
	private function fitImage():Void{
		if(isLoaded()){
			// for child classes which redefines floorMC
			var floor:DisplayObject = getAsset();
			var b:IntRectangle = getPaintBounds();
			var s:IntDimension = countFloorSize();
			assetMask.x = b.x;
			assetMask.y = b.y;
			assetMask.width = b.width;
			assetMask.height = b.height;
			if(scaleMode == SCALE_STRETCH_PANE){
				floor.x = b.x - offsetX;
				floor.y = b.y - offsetY;
				floor.width = s.width;
				floor.height = s.height;
				hadscaled = true;
			} else if (scaleMode == SCALE_FIT_PANE || scaleMode == SCALE_FIT_WIDTH || scaleMode == SCALE_FIT_HEIGHT || scaleMode == SCALE_CUSTOM) {
				floor.width = s.width;
				floor.height = s.height;
				alignFloor();
				hadscaled = true;
			}else{
				if(hadscaled)	{
					if(floor.width != floorOriginalSize.width){
						floor.width = floorOriginalSize.width;
					}
					if(floor.height != floorOriginalSize.height){
						floor.height = floorOriginalSize.height;
					}
					hadscaled = false;
				}
				alignFloor();
			}
			// calc current scale
			if (scaleMode != SCALE_STRETCH_PANE) {
				actualScale = Math.floor(floor.width / floorOriginalSize.width * 100);
			} else {
				actualScale = 0;
			}
			setMaskAsset(maskFloor);
		}
	}
	
	/**
	 * Aligns floorMC clip. 
	 */
	private function alignFloor(b:IntRectangle=null):Void{
		// for child classes which redefines floorMC
		var floorMC:DisplayObject = getAsset();
		if (b == null) b = getPaintBounds();
		
		var mx:Float, my:Float;
		if(horizontalAlignment == CENTER){
			mx = b.x + (b.width - floorMC.width)/2;
		}else if(horizontalAlignment == RIGHT){
			mx = b.x + (b.width - floorMC.width);
		}else{
			mx = b.x;
		}
		if(verticalAlignment == CENTER){
			my = b.y + (b.height - floorMC.height)/2;
		}else if(verticalAlignment == BOTTOM){
			my = b.y + (b.height - floorMC.height);
		}else{
			my = b.y;
		}
		floorMC.x = mx - offsetX;
		floorMC.y = my - offsetY;
	}	
	
	/**
	 * count preffered size base on prefferSizeStrategy.
	 */
	override private function countPreferredSize():IntDimension{
		var size:IntDimension = super.countPreferredSize();
		var sizeByMC:IntDimension;
		if(isLoaded()){
			sizeByMC = countFloorSize();
			sizeByMC = getInsets().getOutsideSize(sizeByMC);
		}else{
			sizeByMC = size;
		}
		
		if(prefferSizeStrategy == PREFER_SIZE_IMAGE){
			return sizeByMC;
		}else if(prefferSizeStrategy == PREFER_SIZE_LAYOUT){
			return size;
		}else{
			return new IntDimension(
				Std.int(Math.max(sizeByMC.width, size.width)), 
				Std.int(Math.max(sizeByMC.height, size.height)));
		}
	}	
	
	private function countFloorSize():IntDimension {
		var b:IntRectangle = getPaintBounds();
		var size:IntDimension = new IntDimension();
		
		if(scaleMode == SCALE_STRETCH_PANE){
			size.width = b.width;
			size.height = b.height;
		} else if (scaleMode == SCALE_FIT_PANE || scaleMode == SCALE_FIT_WIDTH || scaleMode == SCALE_FIT_HEIGHT) {
			var hScale:Float= floorOriginalSize.width / b.width;
			var vScale:Float= floorOriginalSize.height / b.height; 
			var scale:Float= 1;
			if (scaleMode == SCALE_FIT_WIDTH) {
				scale = hScale;
			} else if (scaleMode == SCALE_FIT_HEIGHT) {
				scale = vScale;
			} else {
				scale = Math.max(hScale, vScale);
			}
			size.width = Std.int(floorOriginalSize.width/scale);
			size.height = Std.int(floorOriginalSize.height/scale);
		} else if (scaleMode == SCALE_CUSTOM){
			size.width = Std.int(floorOriginalSize.width*(customScale/100));
			size.height = Std.int(floorOriginalSize.height*(customScale/100));
		} else {
			size.width = Std.int(floorOriginalSize.width - offsetX);
			size.height =Std.int(floorOriginalSize.height - offsetY);
		}
		
		return size; 
	}
	
	/**
	 * Reload the asset. This will reset the asset to count currenty size and re-layout.
	 * @see org.aswing.JLoadPane
	 * @see org.aswing.JAttachPane
	 */
	public function reload():Void{
		resetAsset();
	}
	
	public function isMaskAsset():Bool{
		return maskFloor;
	}
	
	public function setMaskAsset(m:Bool):Void{
		maskFloor = m;
		applyMaskAsset();
	}
	
	private function applyMaskAsset():Void{
		if(maskFloor)	{
			assetMask.visible = true;
			assetContainer.mask = assetMask;
		}else{
			assetContainer.mask = null;
			assetMask.visible = false;
		}
	}
	
	private function setLoaded(b:Bool):Void{
		floorLoaded = b;
	}
	
	private function setAssetOriginalSize(size:IntDimension):Void{
		floorOriginalSize = new IntDimension(size.width, size.height);
	}
	
	//////////////////////
	
	/**
	 * load the floor content.
	 * <p> here it is empty.
	 * Subclass must override this method to make loading.
	 */
	private function loadFloor():Void{

	}
	
}