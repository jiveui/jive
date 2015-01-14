/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import flash.display.DisplayObject;

/**
 * A background with specified asset display object.
 *
 * The display object will be added to component to be the backgound, and will 
 * be set `width` and `height` property to fit the size
 * of the component.
 *
 * Author paling, ngrebenshikov
 */
class AssetBackground implements GroundDecorator {

	public var asset: DisplayObject;

	public function new(asset:DisplayObject = null) {
		this.asset = asset;
	}
	
	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle): Void {
		if (null != asset) {
			asset.x = bounds.x;
			asset.y = bounds.y;
			asset.width = bounds.width;
			asset.height = bounds.height;
		}
	}
	
	public function getDisplay(c:Component): DisplayObject {
		return asset;
	}
}