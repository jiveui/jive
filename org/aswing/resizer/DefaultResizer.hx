/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.resizer;


import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
import flash.events.MouseEvent;

import org.aswing.Component;
	import org.aswing.AWSprite;
	import org.aswing.ASColor;
	import org.aswing.Insets;
	import org.aswing.event.AWEvent;
import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.plaf.UIResource;
import org.aswing.util.DepthManager;

/**
 * Resizer is a resizer for Components to make it resizable when user mouse on 
 * component's edge.
 * @author paling
 */
class DefaultResizer implements Resizer implements UIResource{
	
	private static var RESIZE_MC_WIDTH:Float= 4;
		
	private var owner:Component;

	//-----------resize equiments--------------
	private var resizeMC:Sprite;
	
	private var resizeArrowCursor:DisplayObject;
	private var boundsShape:Shape;
	
	private var topResizeMC:AWSprite;
	private var leftResizeMC:AWSprite;
	private var bottomResizeMC:AWSprite;
	private var rightResizeMC:AWSprite;
	
	private var topLeftResizeMC:AWSprite;
	private var topRightResizeMC:AWSprite;
	private var bottomLeftResizeMC:AWSprite;
	private var bottomRightResizeMC:AWSprite;
	
	private var startX:Float;
	private var startY:Float;
	private var startBounds:IntRectangle;
	
	private var enabled:Bool;
	private var resizeDirectly:Bool;
	
	private var resizeArrowColor:ASColor;
	private var resizeArrowLightColor:ASColor;
	private var resizeArrowDarkColor:ASColor;
	
	/**
	 * Create a Resizer for specified component.
	 */
	public function new(){
		enabled = true;
		resizeDirectly = false;
		startX = 0;
		startY = 0;
		startBounds = new IntRectangle();
		//Default colors
	    resizeArrowColor = UIManager.getColor("resizeArrow");
	    resizeArrowLightColor = UIManager.getColor("resizeArrowLight");
	    resizeArrowDarkColor = UIManager.getColor("resizeArrowDark");
	}
	
	public function setResizeArrowColor(c:ASColor):Void{
		resizeArrowColor = c;
	}
	
	public function setResizeArrowLightColor(c:ASColor):Void{
		resizeArrowLightColor = c;
	}
	
	public function setResizeArrowDarkColor(c:ASColor):Void{
		resizeArrowDarkColor = c;
	}
	
	public function setOwner(c:Component):Void{
		if(owner != null){
			owner.removeEventListener(AWEvent.PAINT, locate);
			if(resizeMC != null){
				owner.removeChild(resizeMC);
			}
			hideBoundsMC();
		}
		owner = c;
		if(owner != null){
			owner.addEventListener(AWEvent.PAINT, locate);
			if(resizeMC == null){
				createResizeMCs();
			}
			owner.addChildAt(resizeMC, owner.numChildren);
		}
		locate();
	}
		
	/**
	 * <p>Indicate whether need resize component directly when drag the resizer arrow.
	 * <p>if set to false, there will be a rectange to represent then size what will be resized to.
	 * <p>if set to true, the component will be resize directly when drag, but this is need more cpu counting.
	 * <p>Default is false.
	 * @see org.aswing.JFrame
	 */	
	public function setResizeDirectly(r:Bool):Void{
		resizeDirectly = r;
	}
	
	/**
	 * Returns whether need resize component directly when drag the resizer arrow.
	 * @see #setResizeDirectly
	 */
	public function isResizeDirectly():Bool{
		return resizeDirectly;
	}
	
	//-----------------------For Handlers-------------------------
	
	public function setArrowRotation(r:Float):Void{
		resizeArrowCursor.rotation = r;
	}
	
	public function startArrowCursor():Void{
		if(resizeMC!=null && resizeMC.stage!=null){
			CursorManager.getManager(resizeMC.stage).showCustomCursor(resizeArrowCursor);
		}
	}
	
	public function stopArrowCursor():Void{
		if(resizeMC!=null&& resizeMC.stage!=null){
			CursorManager.getManager(resizeMC.stage).hideCustomCursor(resizeArrowCursor);
		}
	}
	
	private var resizingNow:Bool;
	public function setResizing(b:Bool):Void{
		resizingNow = b;
	}
	
	public function isResizing():Bool{
		return resizingNow;
	}
	
	public function startResize(strategy:ResizeStrategy, e:MouseEvent):Void{
		if(resizeDirectly!=true){
			representRect(owner.getComBounds());
		}
		startX = e.stageX;
		startY = e.stageY;
		startBounds = owner.getComBounds();
	}
	
	public function resizing(strategy:ResizeStrategy, e:MouseEvent):Void{
		var bounds:IntRectangle = strategy.getBounds(
			startBounds, 
			owner.getMinimumSize(), 
			owner.getMaximumSize(), 
			Std.int(e.stageX - startX), Std.int(e.stageY - startY));
		if(resizeDirectly)	{
			owner.setBounds(bounds);
			owner.revalidate();
			e.updateAfterEvent();
		}else{
			representRect(bounds);
		}
	}
	
	public function finishResize(strategy:ResizeStrategy):Void{
		if(resizeDirectly!=true){
			owner.setComBounds(lastRepresentedBounds);
			hideBoundsMC();
			owner.revalidate();
		}
	}
	
	
	private function hideBoundsMC():Void{
		var par:DisplayObjectContainer = owner.parent;
		if(boundsShape != null && par != null && par.contains(boundsShape)){
			par.removeChild(boundsShape);
		}
	}
	
	private var lastRepresentedBounds:IntRectangle;
	
	private function representRect(bounds:IntRectangle):Void{
		if(resizeDirectly!=true){
			var par:DisplayObjectContainer = owner.parent;
			if(!par.contains(boundsShape)){
				par.addChild(boundsShape);
			}
			DepthManager.bringToTop(boundsShape);
			
			var margin:Insets = owner.getResizerMargin();
			var db:IntRectangle = bounds.clone();
			db.x += margin.left;
			db.y += margin.top;
			db.width -= margin.getMarginWidth();
			db.height -= margin.getMarginHeight();
			var x:Float= db.x;
			var y:Float= db.y;
			var w:Float= db.width;
			var h:Float = db.height;
				//why	
	 
			var g:Graphics2D = new Graphics2D(boundsShape.graphics);
			boundsShape.graphics.clear();
		
			g.drawRectangle(new Pen(resizeArrowLightColor), x-1,y-1,w+2,h+2);
			g.drawRectangle(new Pen(resizeArrowColor), x,y,w,h);
			g.drawRectangle(new Pen(resizeArrowDarkColor), x+1,y+1,w-2,h-2);
		 
			lastRepresentedBounds = bounds;
		}
	}
	
	private function createResizeMCs():Void{
		var r:Float= RESIZE_MC_WIDTH;
		resizeMC = new Sprite();
		resizeMC.name = "resizer";
		resizeArrowCursor = Cursor.createCursor(Cursor.H_RESIZE_CURSOR);
		resizeArrowCursor.name = "resizeCursor";
		boundsShape = new Shape();
		boundsShape.name = "bounds";
		
		topResizeMC = new AWSprite();
		leftResizeMC = new AWSprite();
		rightResizeMC = new AWSprite();
		bottomResizeMC = new AWSprite();
		
		topLeftResizeMC = new AWSprite();
		topRightResizeMC = new AWSprite();
		bottomLeftResizeMC = new AWSprite();
		bottomRightResizeMC = new AWSprite();
		
		resizeMC.addChild(topResizeMC);
		resizeMC.addChild(leftResizeMC);
		resizeMC.addChild(rightResizeMC);
		resizeMC.addChild(bottomResizeMC);
		
		resizeMC.addChild(topLeftResizeMC);
		resizeMC.addChild(topRightResizeMC);
		resizeMC.addChild(bottomLeftResizeMC);
		resizeMC.addChild(bottomRightResizeMC);
		
		DefaultResizeBarHandler.createHandler(this, topResizeMC, 90, createResizeStrategy(0, -1));
		DefaultResizeBarHandler.createHandler(this, leftResizeMC, 0, createResizeStrategy(-1, 0));
		DefaultResizeBarHandler.createHandler(this, rightResizeMC, 0, createResizeStrategy(1, 0));
		DefaultResizeBarHandler.createHandler(this, bottomResizeMC, 90, createResizeStrategy(0, 1));
		
		DefaultResizeBarHandler.createHandler(this, topLeftResizeMC, 45, createResizeStrategy(-1, -1));
		DefaultResizeBarHandler.createHandler(this, topRightResizeMC, -45, createResizeStrategy(1, -1));
		DefaultResizeBarHandler.createHandler(this, bottomLeftResizeMC, -45, createResizeStrategy(-1, 1));
		DefaultResizeBarHandler.createHandler(this, bottomRightResizeMC, 45, createResizeStrategy(1, 1));
		
		var brush:SolidBrush = new SolidBrush(new ASColor(0, 0));
		var gdi:Graphics2D = new Graphics2D(topResizeMC.graphics);
		gdi.fillRectangle(brush, 0, 0, r, r);
		gdi = new Graphics2D(leftResizeMC.graphics);
		gdi.fillRectangle(brush, 0, 0, r, r);
		gdi = new Graphics2D(rightResizeMC.graphics);
		gdi.fillRectangle(brush, -r, 0, r, r);	
		gdi = new Graphics2D(bottomResizeMC.graphics);
		gdi.fillRectangle(brush, 0, -r, r, r);	
		
		gdi = new Graphics2D(topLeftResizeMC.graphics);
		gdi.fillRectangle(brush, 0, 0, r*2, r);
		gdi.fillRectangle(brush, 0, 0, r, r*2);
		gdi = new Graphics2D(topRightResizeMC.graphics);
		gdi.fillRectangle(brush, -r*2, 0, r*2, r);
		gdi.fillRectangle(brush, -r, 0, r, r*2);
		gdi = new Graphics2D(bottomLeftResizeMC.graphics);
		gdi.fillRectangle(brush, 0, -r, r*2, r);
		gdi.fillRectangle(brush, 0, -r*2, r, r*2);
		gdi = new Graphics2D(bottomRightResizeMC.graphics);
		gdi.fillRectangle(brush, -r*2, -r, r*2, r);
		gdi.fillRectangle(brush, -r, -r*2, r, r*2);
		
		resizeMC.visible = enabled;
	}
	
	/**
	 * Override this method if you want to use another resize strategy.
	 */
	private function createResizeStrategy(wSign:Float, hSign:Float):ResizeStrategy{
		return new ResizeStrategyImp(wSign, hSign); 
	}
	
	public function setEnabled(e:Bool):Void{
		enabled = e;
		resizeMC.visible = enabled;
	}
	
	public function isEnabled():Bool{
		return enabled;
	}
		
	/**
	 * Locate the resizer mcs to fit the component.
	 */
	private function locate(e:Event=null):Void{
		//var x:Number = 0;
		//var y:Number = 0;
		if(owner == null){
			return;
		}
		if(owner.getChildIndex(resizeMC) < owner.getHighestIndexUnderForeground() - 1){
			owner.bringToTop(resizeMC);
		}
		var margin:Insets = owner.getResizerMargin();
		var x:Float= margin.left;
		var y:Float= margin.top;
		var w:Float= owner.getWidth() - margin.right - margin.left;
		var h:Float= owner.getHeight() - margin.bottom - margin.top;
		var r:Float= RESIZE_MC_WIDTH;
		
		topResizeMC.width = Math.max(0, w-r*2);
		topResizeMC.x = r;
		topResizeMC.y = y;
		leftResizeMC.height = Math.max(0, h-r*2);
		leftResizeMC.x = x;
		leftResizeMC.y = r;
		rightResizeMC.height = Math.max(0, h-r*2);
		rightResizeMC.x = x+w;
		rightResizeMC.y = r;
		bottomResizeMC.width = Math.max(0, w-r*2);
		bottomResizeMC.x = r;
		bottomResizeMC.y = y+h;
		
		topLeftResizeMC.x = x;
		topLeftResizeMC.y = y;
		topRightResizeMC.x = x+w;
		topRightResizeMC.y = y;
		bottomLeftResizeMC.x = x;
		bottomLeftResizeMC.y = y+h;
		bottomRightResizeMC.x = x+w;
		bottomRightResizeMC.y = y+h;
	}
}