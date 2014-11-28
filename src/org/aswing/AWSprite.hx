/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

import flash.events.Event;
import flash.events.MouseEvent;
import org.aswing.event.ReleaseEvent;
import org.aswing.geom.IntRectangle;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
/**
 * Dispatched when the mouse released or released out side.
 * If you need a event like AS2 <code>onRelease</code> you can 
 * use <code>Event.CLICK</code>
 * 
 * @eventType org.aswing.event.ReleaseEvent.RELEASE
 */
// [Event(name="release", type="org.aswing.event.ReleaseEvent")]

/**
 * Dispatched only when the mouse released out side.
 *
 * @eventType org.aswing.event.ReleaseEvent.RELEASE_OUT_SIDE
 */
// [Event(name="releaseOutSide", type="org.aswing.event.ReleaseEvent")]

/**
 * AsWing component based Sprite.
 * <p>
 * The AsWing Component Assets structure:(Assets means flash player display objects)
 * <pre>
 *             | -- foreground decorator asset
 *             |
 *             |    [other assets, there is no depth restrict between them, see below ]
 * AWSprite -- | -- [icon, border, ui creation, children component assets ...]          
 *             |    [they are above background decorator and below foreground decorator]
 *             |
 *             | -- background decorator asset
 * </pre>
 */
class AWSprite extends Sprite
{
	private var foregroundChild:DisplayObject;
	private var backgroundChild:DisplayObject;
	
	private var clipMasked:Bool;
	private var clipMaskRect:IntRectangle;
 
	private var maskShape:Shape;
	private var usingBitmap:Bool;
	
	public function new(){
		this.clipMasked=false;
			super();
		//focusRect = false;
		usingBitmap = false;
		clipMaskRect = new IntRectangle();
		setClipMasked(clipMasked);
		addEventListener(MouseEvent.MOUSE_DOWN, __awSpriteMouseDownListener);
		addEventListener(Event.REMOVED_FROM_STAGE, __awStageRemovedFrom);
	}
 
	private function d_addChild(child:DisplayObject):DisplayObject{
		return  addChild(child);
	}
	
	private function d_addChildAt(child:DisplayObject, index:Int):DisplayObject{
		return  addChildAt(child, index);
	}
	
 
	private function d_removeChild(child:DisplayObject):DisplayObject{
		return  removeChild(child);
	}
	
	/**
	 * Returns whether or not the child is this sprite's direct child.
	 */
	private function isChild(child:DisplayObject):Bool{
	 
			return contains(child);
	 	
	}
	
 
	
	private function d_removeChildAt(index:Int):DisplayObject{
		return  removeChildAt(index);
	}
	
 
	private function d_getChildAt(index:Int):DisplayObject{
		return  getChildAt(index);
	}
	
	 
	
	private function d_getChildByName(name:String):DisplayObject{
		return  getChildByName(name);
	}
	
	 
	
	private function d_getChildIndex(child:DisplayObject):Int{
		return getChildIndex(child);
	}
 
	
	/**
	 * Returns whether child is directly child of this sprite, true only if getChildIndex(child) >= 0.
	 * @return true only if getChildIndex(child) >= 0.
	 */
	public function containsChild(child:DisplayObject):Bool{
	 
			return  contains(child);
		 		
	}
	
	private function d_setChildIndex(child:DisplayObject, index:Int):Void{
		 setChildIndex(child, index);
	}
	
 
	
	private function d_swapChildren(child1:DisplayObject, child2:DisplayObject):Void{
		 swapChildren(child1, child2);
	}
	
	 
	private function d_swapChildrenAt(index1:Int, index2:Int):Void{
		 swapChildrenAt(index1, index2);
	}
	
	 
	
	private function get_d_numChildren():Int{
		return  numChildren;
	}
	
	 
	
	/**
	 * Adds a child DisplayObject instance to this DisplayObjectContainer instance. 
	 * The child is added to the front (top) of all other children except foreground decorator child(It is topest)
	 *  in this DisplayObjectContainer instance. 
	 * (To avoid this restrict and add a child to a specific index position, use the <code>addChildAt()</code> method.)
	 * (<b>Note:</b> Generally if you don't want to break the component asset depth management, use 
	 * getHighestIndexUnderForeground() and getLowestIndexAboveBackground() to get the 
	 * right depth you can use. You can also refer to getChildIndex() to
	 * insert child after or before an existing child) 
	 * 
	 * @param dis The DisplayObject instance to add as a child of this DisplayObjectContainer instance. 
	 * @see #getLowestIndexAboveBackground()
	 * @see #getHighestIndexUnderForeground()
	 * @see #http://livedocs.macromedia.com/flex/2/langref/flash/display/DisplayObjectContainer.html#getChildIndex()
	 */
 
	
	/**
	 * Returns the current top index for a new child(none forground child).
	 * @return the current top index for a new child that is not a foreground child.
	 */
	public function getHighestIndexUnderForeground():Int{
		if(foregroundChild == null){
			return numChildren;
		}else{
			return numChildren - 1;
		}
	}
	
	/**
	 * Returns the current bottom index for none background child.
	 * @return the current bottom index for child that is not a background child.
	 */		
	public function getLowestIndexAboveBackground():Int{
		if(backgroundChild == null){
			return 0;
		}else{
			return 1;
		}
	}
	
	 
	 
	
	/**
	 * Brings a child to top.
	 * This method will keep foreground child on top, if you bring a other object 
	 * to top, this method will only bring it on top of other objects
	 * (mean on top of others but bellow the foreground child).
	 * @param child the child to be bringed to top.
	 */
	public function bringToTop(child:DisplayObject):Void{
		var index:Int= numChildren-1;
		if(foregroundChild != null){
			if(foregroundChild != child){
				index = numChildren-2;
			}
		}
		setChildIndex(child, index);
	}
	

	/**
	 * Brings a child to bottom.
	 * This method will keep background child on bottom, if you bring a other object 
	 * to bottom, this method will only bring it at bottom of other objects
	 * (mean at bottom of others but on top of the background child).
	 * @param child the child to be bringed to bottom.
	 */	
	public function bringToBottom(child:DisplayObject):Void{
		var index:Int= 0;
		if(backgroundChild != null){
			if(backgroundChild != child){
				index = 1;
			}
		}
		setChildIndex(child, index);
	}
	override public function setChildIndex(child:DisplayObject,index:Int):Void{
		if(child==null||!this.contains(child))
		{
			trace("setChildIndex : object DisplayObject "+child.toString()+" not found.");
			return;
		}
		super.setChildIndex(child, index);
	}
	/**
	 * Sets the child to be the component background, it will be add to the bottom of all other children. 
	 * (old backgournd child will be removed). pass no paramter (null) to remove the background child.
	 * 
	 * @param child the background child to be added.
	 */
	private function setBackgroundChild(child:DisplayObject = null):Void{
		if(child != backgroundChild){
			if(backgroundChild != null){
				removeChild(backgroundChild);
			}
			backgroundChild = child;
			if(child != null){
				addChildAt(child, 0);
			}
		}
	}
	
	/**
	 * Returns the background child. 
	 * @return the background child.
	 * @see #setBackgroundChild()
	 */
	private function getBackgroundChild():DisplayObject{
		return backgroundChild;
	}
	
	/**
	 * Sets the child to be the component foreground, it will be add to the top of all other children. 
	 * (old foregournd child will be removed), pass no paramter (null) to remove the foreground child.
	 * 
	 * @param child the foreground child to be added.
	 */
	private function setForegroundChild(child:DisplayObject = null):Void{
		if(child != foregroundChild){
			if(foregroundChild != null){
				removeChild(foregroundChild);
			}
			foregroundChild = child;
			if(child != null){
				addChild(child);
			}
		}
	}
	
	/**
	 * Returns the foreground child. 
	 * @return the foreground child.
	 * @see #setForegroundChild()
	 */
	private function getForegroundChild():DisplayObject{
		return foregroundChild;
	}

	/**
	 * Sets whether the component clip should be masked by its bounds. By default it is true.
	 * <p>
	 * AsWing A3 use <code>scrollRect</code> property to do the clip mask.
	 * </p>
	 * @param m whether the component clip should be masked.
	 * @see #isClipMasked()
	 */
	public function setClipMasked(m:Bool):Void{
		if(m != clipMasked){
			clipMasked = m;
			setUsingBitmap(cacheAsBitmap && clipMasked);
			if(clipMasked)	{
				checkCreateMaskShape();
				if(maskShape.parent != this){
					 //d_addChild(maskShape);
					//mask = maskShape;
				}
                setClipMaskRect(clipMaskRect);
			}else{
				 
				 if(maskShape != null && maskShape.parent == this){
				//	d_removeChild(maskShape);
				} 
				//mask = null;
				this.scrollRect=null;
			}
		}
	}
	
	public function setClipMaskRect(b:IntRectangle):Void{
		 if (maskShape != null)	{
			 
			/*
			maskShape.x = b.x;
			maskShape.y = b.y;
			maskShape.height = b.height;
			maskShape.width = b.width;
			*/
			maskShape.graphics.clear();
			maskShape.graphics.beginFill(0xffffff);
			maskShape.graphics.drawRect(b.x, b.y, b.width, b.height);
			maskShape.graphics.endFill();
		}
		this.scrollRect=new Rectangle(b.x, b.y, b.width, b.height);
		clipMaskRect.setRect(b);
	}
	
	private function setUsingBitmap(b:Bool):Void{
		if(usingBitmap != b){
			usingBitmap = b;
			usingBitmapChanged();
		}
	}
	
	private function usingBitmapChanged():Void{
		 this.cacheAsBitmap = usingBitmap;
	}

	private function checkCreateMaskShape():Void {
		if (maskShape == null) {
			maskShape = new Shape();
		}
	}
	
	/**
	 * Returns whether the component clip should be masked by its bounds. By default it is true.
	 * <p>
	 * AsWing A3 use <code>scrollRect</code> property to do the clip mask.
	 * </p>
	 * @return whether the component clip should be masked.
	 * @see #setClipMasked()
	 */
	public function isClipMasked():Bool{
		return clipMasked;
	}
	
	private var pressedTarget:DisplayObject;
	private function __awSpriteMouseDownListener(e:MouseEvent):Void{
		pressedTarget = AsWingUtils.as(e.target, DisplayObject)	;
	 
		stage.addEventListener(MouseEvent.MOUSE_UP, __awStageMouseUpListener, false, 0, false);
			
		 
	 
	}
	private function __awStageRemovedFrom(e:Event):Void{
		pressedTarget = null;
		//why
		if(stage!=null)stage.removeEventListener(MouseEvent.MOUSE_UP, __awStageMouseUpListener);
	}
	private function __awStageMouseUpListener(e:MouseEvent):Void {
		 
		if(stage!=null)stage.removeEventListener(MouseEvent.MOUSE_UP, __awStageMouseUpListener);
		 
		var isOutSide:Bool= false;
		var target:DisplayObject = AsWingUtils.as(e.target,DisplayObject)	;
		if(!(this == target || AsWingUtils.isAncestorDisplayObject(this, target))){
			isOutSide = true;
		}
		dispatchEvent(new ReleaseEvent(ReleaseEvent.RELEASE, pressedTarget, isOutSide, e));
		if(isOutSide)	{
			dispatchEvent(new ReleaseEvent(ReleaseEvent.RELEASE_OUT_SIDE, pressedTarget, isOutSide, e));
		}

		pressedTarget = null;
	}
	
	override public function toString():String{
		var p:DisplayObject = this;
		var str:String= p.name;
		while(p.parent != null){
			var name:String= (p.parent == p.stage ? "Stage" : p.parent.name);
			p = p.parent;
			str = name + "." + str;
		}
		return str;
	}
	
	 
 
		public var d_numChildren (get, null):Int;
}
