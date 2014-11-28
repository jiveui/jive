/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import flash.display.DisplayObject;

/**
 * A background with specified asset display object.
 * <p>
 * The display object will be added to component to be the backgound, and will 
 * be set <code>width</code> and <code>height</code> property to fit the size 
 * of the component.
 * </p>
 * @author paling
 */
class AssetBackground implements GroundDecorator{
	
	private var asset:DisplayObject;
	
	public function new(asset:DisplayObject){
		this.asset = asset;
	}
	
	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):Void{
		asset.x = bounds.x;
		asset.y = bounds.y;
		asset.width = bounds.width;
		asset.height = bounds.height;		
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return asset;
	}
}