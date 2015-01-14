package org.aswing;

	
import org.aswing.graphics.Graphics2D;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;

/**
 * Abstract class for A icon with a decorative displayObject.
 *
 * See `AttachIcon`, `LoadIcon`
 *
 * Authors senkay, paling, ngrebenshikov
 */	
class AssetIcon implements Icon {

	/**
	* If you specifiled the width of the Icon, and scale is true,
	* the mc will be scale to this width when paint. If you do not specified the with, it will use
	* `asset.width`.
	**/
	public var width(get, set): Int;
	private var _width:Int;
	private function get_width(): Int { return _width; }
	private function set_width(v: Int): Int { _width = v; validate(); return v; }

	/**
	* If you specifiled the height of the Icon, and scale is true,
	* the mc will be scale to this height when paint. If you do not specified the height, it will use
	* `asset.height`.
	**/
	public var height(get, set): Int;
	private var _height:Int;
	private function get_height(): Int { return _height; }
	private function set_height(v: Int): Int { _height = v; validate(); return v; }

	/**
	* Whether scale the icont content to fix the width and height specified. Default is false
	**/
	public var scale(get, set): Bool;
	private var _scale:Bool;
	private function get_scale(): Bool { return _scale; }
	private function set_scale(v: Bool): Bool { _scale = v; validate(); return v; }

	/**
	* The icon content
	**/
	public var asset(get, set): DisplayObject;
	private var _asset:DisplayObject;
	private function get_asset(): DisplayObject { return _asset; }
	private function set_asset(v: DisplayObject): DisplayObject { _asset = v; validate(); return v; }

	private var assetContainer:DisplayObjectContainer;
	private var maskShape:Shape;
	
	/**
	 * Creates a AssetIcon with a path to load external content.
	 *
	 * @param asset the icon content (DisplayObject).
	 * @param width (optional) if you specifiled the width of the Icon, and scale is true,
	 * 		the mc will be scale to this width when paint. If you do not specified the with, it will use 
	 * 		asset.width.
	 * @param height (optional) if you specifiled the height of the Icon, and scale is true,
	 * 		the mc will be scale to this height when paint. If you do not specified the height, it will use 
	 * 		asset.height.
	 * @param scale (optional) whether scale MC to fix the width and height specified. Default is false
	 */
	public function new(asset:DisplayObject=null, width:Int=-1, height:Int=-1, scale:Bool=false){
		_asset = asset;
		_width = width;
		_height = height;
		_scale = scale;
		validate();
	}

	private function validate() {
		this.assetContainer = null;
		this.maskShape = null;

		if (_width==-1 && _height==-1) {
			if(asset!=null)	{
				this._width = Std.int(asset.width);
				this._height = Std.int(asset.height);
			} else {
				this._width = 0;
				this._height = 0;
			}
		} else {
			assetContainer = AsWingUtils.createSprite(null, "assetContainer");
			maskShape = AsWingUtils.createShape(assetContainer, "maskShape");
			maskShape.graphics.beginFill(0xFF0000);
			maskShape.graphics.drawRect(0, 0, width, height);
			maskShape.graphics.endFill();
			if(_asset!=null) {
				assetContainer.addChild(_asset);
				_asset.mask = maskShape;
				if(scale) {
					_asset.width = width;
					_asset.height = height;
				}
			} else {
				assetContainer.removeChild(maskShape);
			}
		}
	}

	private function updateDisplay() {}
	
	@:dox(hide)
	public function getAsset():DisplayObject{
		return _asset;
	}

	@:dox(hide)
	private function setWidth(width:Int):Void{
		this._width = width;
	}

	@:dox(hide)
	private function setHeight(height:Int):Void{
		this._height = height;
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		var floor:DisplayObject = getDisplay(c);
		if(floor!=null)	{
			floor.x = x;
			floor.y = y;
		}
	}

	@:dox(hide)
	public function getIconHeight(c:Component):Int{
		return _height;
	}

	@:dox(hide)
	public function getIconWidth(c:Component):Int{
		return _width;
	}
	
	public function getDisplay(c:Component): DisplayObject {
		if(assetContainer!=null)	{
			return assetContainer;
		}else{
			return _asset;
		}
	}
 
}