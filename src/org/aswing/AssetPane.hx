/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import flash.display.DisplayObject;
import flash.display.Shape;

import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import flash.display.Sprite;
import flash.display.DisplayObjectContainer;

/**
 * Abstract class for A container with a decorative asset.
 *
 * External content will be load automatically when the pane was created if floorEnabled.
 *
 * @see `JLoadPane`
 *
 * @author paling
 * @author ngrebenshikov
 */	
class AssetPane extends Container{
	
	/**
	 * Preffered size of this component will be the fit to contain both size of extenal image/animation
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
	 * @see AssetPane.setCustomScale
	 */
	inline public static var SCALE_CUSTOM:Int= 5;
	
	
	/**
	 * A fast access to AsWingConstants Constant
	 * @see AsWingConstants
	 */
	inline public static var CENTER:Int= AsWingConstants.CENTER;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see AsWingConstants
	 */
	inline public static var TOP:Int= AsWingConstants.TOP;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see AsWingConstants
	 */
    inline public static var LEFT:Int= AsWingConstants.LEFT;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see AsWingConstants
	 */
    inline public static var BOTTOM:Int= AsWingConstants.BOTTOM;
 	/**
	 * A fast access to AsWingConstants Constant
	 * @see AsWingConstants
	 */
    inline public static var RIGHT:Int= AsWingConstants.RIGHT;

	/**
	* The content
	*
	* You should take care to do operation at this display object,
	* if you want to remove it, you should call `unloadAsset()` instead of
	* call `asset.parent.removeChild(asset)`
	**/
	public var asset(get, set): DisplayObject;
	private var _asset:DisplayObject;
	private function get_asset(): DisplayObject { return getAsset(); }
	private function set_asset(v: DisplayObject): DisplayObject { setAsset(v); return v; }

	public var assetVisible(get, set): Bool;
	private var _assetVisible: Bool;
	private function get_assetVisible(): Bool { return isAssetVisible(); }
	private function set_assetVisible(v: Bool): Bool { setAssetVisible(v); return v; }

	/**
	 * The preffered size counting strategy. Must be one of below:
	 * <ul>
	 * <li>`AssetPane.PREFER_SIZE_BOTH`
	 * <li>`AssetPane.PREFER_SIZE_IMAGE`
	 * <li>`AssetPane.PREFER_SIZE_LAYOUT`
	 * </ul>
	 */
	public var prefferSizeStrategy(get, set): Int;
	private var _prefferSizeStrategy: Int;
	private function get_prefferSizeStrategy(): Int { return Std.int(getPrefferSizeStrategy()); }
	private function set_prefferSizeStrategy(v: Int): Int { setPrefferSizeStrategy(v); return v; }

	/**
     * The vertical alignment of the image/animation.
     * Must be one of the following values:
     * <ul>
     * <li>`AsWingConstants.CENTER` (the default)
     * <li>`AsWingConstants.TOP`
     * <li>`AsWingConstants.BOTTOM`
     * </ul>
     */
	public var verticalAlignment(get, set): Int;
	private var _verticalAlignment:Int;
	private function get_verticalAlignment(): Int { return Std.int(getVerticalAlignment()); }
	private function set_verticalAlignment(v: Int): Int { setVerticalAlignment(v); return v; }

	/**
     * The horizontal alignment of the image/animation.
     * Must be one of the following values:
     * <ul>
     * <li>`AsWingConstants.RIGHT` (the default)
     * <li>`AsWingConstants.LEFT`
     * <li>`AsWingConstants.CENTER`
     * </ul>
     */
	public var horizontalAlignment(get, set): Int;
	private var _horizontalAlignment:Int;
	private function get_horizontalAlignment(): Int { return Std.int(getHorizontalAlignment()); }
	private function set_horizontalAlignment(v: Int): Int { setHorizontalAlignment(v); return v; }

	/**
	* The content scale mode.
	* <ul>
	* <li>`AssetPane.SCALE_NONE`
	* <li>`AssetPane.SCALE_FIT_PANE`
	* <li>`AssetPane.SCALE_STRETCH_PANE`
	* <li>`AssetPane.SCALE_FIT_WIDTH`
	* <li>`AssetPane.SCALE_FIT_HEIGHT`
	* <li>`AssetPane.SCALE_CUSTOM`
	* </ul>
	**/
	public var scaleMode(get, set): Int;
	private var _scaleMode:Int;
	private function get_scaleMode(): Int { return getScaleMode(); }
	private function set_scaleMode(v: Int): Int { setScaleMode(v); return v; }

	/**
     * The x offset of the position of the loaded image/animation.
     * If you dont want to locate the content to the topleft of the pane, you can set the offsets.
     */
	public var offsetX(get, set): Float;
	private var _offsetX:Float;
	private function get_offsetX(): Float { return getOffsetX(); }
	private function set_offsetX(v: Float): Float { setOffsetX(v); return v; }

	/**
     * The y offset of the position of the loaded image/animation.
     * If you dont want to locate the content to the topleft of the pane, you can set the offsets.
     */
	public var offsetY(get, set): Float;
	private var _offsetY:Float;
	private function get_offsetY(): Float { return getOffsetY(); }
	private function set_offsetY(v: Float): Float { setOffsetY(v); return v; }

	/**
     * The custom scale value in percents. Automatically turns scale mode into `SCALE_CUSTOM`.
     * @see `setScaleMode`
     */
	public var customScale(get, set): Int;
	private var _customScale:Int;
	private function get_customScale(): Int { return getCustomScale(); }
	private function set_customScale(v: Int): Int { setCustomScale(v); return v; }

	/**
     * A readonly current actual scale value in percents. If `AssetPane.scaleMode` is
     * `AssetPane.SCALE_STRETCH_PANE` returns `null`.
     */
	public var actualScale(default, null): Null<Int>;

	public var clipEnabled(get, set): Bool;
	private function get_clipEnabled(): Bool { return isMaskAsset(); }
	private function set_clipEnabled(v: Bool): Bool { setMaskAsset(v); return v; }

	private var assetContainer:DisplayObjectContainer;
	private var assetMask:Shape;
	
	private var maskFloor:Bool;
	private var floorLoaded:Bool;
    private var floorOriginalSize:IntDimension;
    private var floorOriginalScaleX:Float;
    private var floorOriginalScaleY:Float;
    private var hadscaled:Bool;

	/**
	 * Creates a AssetPane with a asset content.
	 *
	 * @param asset the asset to be placed on this pane.
	 * @param prefferSizeStrategy the prefferedSize count strategy. Must be one of below:
	 *
	 * <ul>
	 * <li> `AssetPane.PREFER_SIZE_BOTH`
	 * <li> `AssetPane.PREFER_SIZE_IMAGE`
	 * <li> `AssetPane.PREFER_SIZE_LAYOUT`
	 * </ul>
	 *
	 * @see AssetPane.asset
	 */
	public function new(asset:DisplayObject=null, prefferSizeStrategy:Int=PREFER_SIZE_IMAGE) {
		super();
		this._prefferSizeStrategy = prefferSizeStrategy;
		
    	_verticalAlignment = TOP;
    	_horizontalAlignment = LEFT;
    	_scaleMode = SCALE_NONE;
    	actualScale = 100;
    	_customScale = 100;
    	hadscaled = false;
    	maskFloor = true;
		floorOriginalSize = null;
		_assetVisible = true;
		floorLoaded = false;
		_offsetX = 0;
		_offsetY = 0;
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
	 * Set the asset of the pane
	 * This method will cause old asset to be removed and new asset to be added.
	 * @param asset the asset of the pane.
	 */ 
	@:dox(hide)
	public function setAsset(asset:DisplayObject):Void{
		if (this._asset != asset){
			if(this._asset!=null)	{
				if(this._asset.parent == assetContainer){
					assetContainer.removeChild(this._asset);
				}
			}
			this._asset = asset;
			if(asset!=null)	{
				storeOriginalScale();
				assetContainer.addChild(asset);
			}
			setLoaded(asset != null);
			resetAsset();
		}
	}
	
	/**
	 * Unload the asset of the pane
	 */ 
	public function unloadAsset():Void{
		asset = null;
	}
	
	private function storeOriginalScale():Void{
		if(_asset!=null)	{
			floorOriginalScaleX = _asset.scaleX;
			floorOriginalScaleY = _asset.scaleY;
		}
	}
	
	private function resetAsset():Void{
		if(_asset!=null)	{
			_asset.scaleX = floorOriginalScaleX;
			_asset.scaleY = floorOriginalScaleY;
			setAssetOriginalSize(new IntDimension(Std.int(_asset.width), Std.int(_asset.height)));
			_asset.visible = _assetVisible;
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
	@:dox(hide)
	public function getAsset():DisplayObject{
		return _asset;
	}
	
	/**
	 * Sets the preffered size counting strategy. Must be one of below:
	 * <ul>
	 * <li>{@link #PREFER_SIZE_BOTH}
	 * <li>{@link #PREFER_SIZE_IMAGE}
	 * <li>{@link #PREFER_SIZE_LAYOUT}
	 * </ul>
	 */
	@:dox(hide)
	public function setPrefferSizeStrategy(p:Float):Void{
		_prefferSizeStrategy =Std.int( p);
	}
	
	/**
	 * Returns the preffered size counting strategy.
	 * @see #setPrefferSizeStrategy()
	 */
	@:dox(hide)
	public function getPrefferSizeStrategy():Float{
		return _prefferSizeStrategy;
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
	@:dox(hide)
    public function getVerticalAlignment():Float{
        return _verticalAlignment;
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
	@:dox(hide)
    public function setVerticalAlignment(alignment:Int=AsWingConstants.CENTER):Void{
        if (alignment == _verticalAlignment){
        	return;
        }else{
        	_verticalAlignment = alignment;
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
	@:dox(hide)
    public function getHorizontalAlignment():Float{
        return _horizontalAlignment;
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
	@:dox(hide)
    public function setHorizontalAlignment(alignment:Int=AsWingConstants.RIGHT):Void{
        if (alignment == _horizontalAlignment){
        	return;
        }else{
        	_horizontalAlignment = alignment;
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
	@:dox(hide)
    public function setScaleMode(mode:Int):Void{
    	if(_scaleMode != mode){
    		_scaleMode = mode;
    		revalidate();
    	}
    }
    
    /**
     * Returns current image scale mode. 
     * @return current image scale mode.
	 * <ul>
	 * <li>`SCALE_NONE`
	 * <li>`SCALE_PROPORTIONAL`
	 * <li>`SCALE_COMPLETE`
	 * </ul>
     */
	@:dox(hide)
    public function getScaleMode():Int{
    	return _scaleMode;
    }
    
    /**
     * Sets new custom scale value in percents. Automatically turns scale mode into `SCALE_CUSTOM`.
     * @param scale the new scale 
     * @see #setScaleMode
     */
	@:dox(hide)
    public function setCustomScale(scale:Int):Void{
    	setScaleMode(SCALE_CUSTOM);
    	if (_customScale != scale) {
    		_customScale = scale;
    		revalidate();	
    	}
    }
    
    /**
     * Returns current actual scale value in percents. If `AssetPane.scaleMode` is
     * `AssetPane.SCALE_STRETCH_PANE` returns `null`.
     */
	@:dox(hide)
    public function getActualScale():Int {
    	return actualScale;
    }

    /**
     * Returns current custom scale value in percents.
     */
	@:dox(hide)
    public function getCustomScale():Int{
    	return _customScale;
    }
    
    /**
     * Sets the x offset of the position of the loaded image/animation.
     * If you dont want to locate the content to the topleft of the pane, you can set the offsets.
     * @param offset the x offset 
     */
	@:dox(hide)
    public function setOffsetX(offset:Float):Void{
    	if(_offsetX != offset){
    		_offsetX = offset;
    		revalidate();
    	}
    }
    
    /**
     * Sets the y offset of the position of the loaded image/animation.
     * If you dont want to locate the content to the topleft of the pane, you can set the offsets.
     * @param offset the y offset 
     */
	@:dox(hide)
    public function setOffsetY(offset:Float):Void{
    	if(_offsetY != offset){
    		_offsetY = offset;
    		revalidate();
    	}
    }    
    
    /**
     * @see #setOffsetX()
     */
	@:dox(hide)
    public function getOffsetX():Float{
    	return _offsetX;
    }
    
    /**
     * @see #setOffsetY()
     */
	@:dox(hide)
    public function getOffsetY():Float{
    	return _offsetY;
    }
	
	/**
	 * Sets the visible of the assets.
	 * @param b the visible property.
	 */
	@:dox(hide)
	public function setAssetVisible(b:Bool):Void{
		_assetVisible = b;
		if(_asset!=null)	{
			_asset.visible = b;
		}
	}
	
	/**
	 * Returns the asset visible property.
	 * @return the asset visible property.
	 */
	@:dox(hide)
	public function isAssetVisible():Bool{
		return _assetVisible;
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
	 * Layout this container
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
			if(_scaleMode == SCALE_STRETCH_PANE){
				floor.x = b.x - _offsetX;
				floor.y = b.y - _offsetY;
				floor.width = s.width;
				floor.height = s.height;
				hadscaled = true;
			} else if (_scaleMode == SCALE_FIT_PANE || _scaleMode == SCALE_FIT_WIDTH || _scaleMode == SCALE_FIT_HEIGHT || _scaleMode == SCALE_CUSTOM) {
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
			if (_scaleMode != SCALE_STRETCH_PANE) {
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
		if(_horizontalAlignment == CENTER){
			mx = b.x + (b.width - floorMC.width)/2;
		}else if(_horizontalAlignment == RIGHT){
			mx = b.x + (b.width - floorMC.width);
		}else{
			mx = b.x;
		}
		if(_verticalAlignment == CENTER){
			my = b.y + (b.height - floorMC.height)/2;
		}else if(_verticalAlignment == BOTTOM){
			my = b.y + (b.height - floorMC.height);
		}else{
			my = b.y;
		}
		floorMC.x = mx - _offsetX;
		floorMC.y = my - _offsetY;
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
		
		if(_prefferSizeStrategy == PREFER_SIZE_IMAGE){
			return sizeByMC;
		}else if(_prefferSizeStrategy == PREFER_SIZE_LAYOUT){
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
		
		if(_scaleMode == SCALE_STRETCH_PANE){
			size.width = b.width;
			size.height = b.height;
		} else if (_scaleMode == SCALE_FIT_PANE || _scaleMode == SCALE_FIT_WIDTH || _scaleMode == SCALE_FIT_HEIGHT) {
			var hScale:Float= floorOriginalSize.width / b.width;
			var vScale:Float= floorOriginalSize.height / b.height; 
			var scale:Float= 1;
			if (_scaleMode == SCALE_FIT_WIDTH) {
				scale = hScale;
			} else if (_scaleMode == SCALE_FIT_HEIGHT) {
				scale = vScale;
			} else {
				scale = Math.max(hScale, vScale);
			}
			size.width = Std.int(floorOriginalSize.width/scale);
			size.height = Std.int(floorOriginalSize.height/scale);
		} else if (_scaleMode == SCALE_CUSTOM){
			size.width = Std.int(floorOriginalSize.width*(_customScale/100));
			size.height = Std.int(floorOriginalSize.height*(_customScale/100));
		} else {
			size.width = Std.int(floorOriginalSize.width - _offsetX);
			size.height =Std.int(floorOriginalSize.height - _offsetY);
		}
		
		return size; 
	}
	
	/**
	 * Reload the asset. This will reset the asset to count currenty size and re-layout.
	 * See `JLoadPane`, `JAttachPane`
	 */
	public function reload():Void{
		resetAsset();
	}
	
	@:dox(hide)
	public function isMaskAsset():Bool{
		return maskFloor;
	}
	
	@:dox(hide)
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