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
    public var keepRatio: Bool;

	public function new(asset:DisplayObject = null, keepRatio: Bool = false) {
		this.asset = asset;
        this.keepRatio = keepRatio;
	}
	
	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle): Void {
        if (null != asset) {
            if (!keepRatio) {
                asset.x = bounds.x;
                asset.y = bounds.y;
                asset.width = bounds.width;
                asset.height = bounds.height;
            } else {
                var w = asset.width/asset.scaleX;
                var h = asset.height/asset.scaleY;

                //put the background to the center
                if (w/h < bounds.width/bounds.height) {
                    asset.width = bounds.width;
                    asset.height = h * bounds.width / w;
                    asset.x = 0;
                    asset.y = -(asset.height-bounds.height)/2;
                } else {
                    asset.height = bounds.height;
                    asset.width = w * bounds.height / h;
                    asset.y = 0;
                    asset.x = -(asset.width-bounds.width)/2;
                }
           }
		}
	}
	
	public function getDisplay(c:Component): DisplayObject {
		return asset;
	}
}