/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent; 
import flash.geom.Rectangle;
import org.aswing.util.Timer;
import org.aswing.event.WindowEvent;  
import org.aswing.event.AWEvent;
import org.aswing.event.PopupEvent;
import org.aswing.JFrame;
	import org.aswing.FrameTitleBar;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.Icon;
	import org.aswing.Insets;
	import org.aswing.event.PropertyChangeEvent;
	import org.aswing.event.ReleaseEvent;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntPoint;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.FrameUI;
	import org.aswing.plaf.UIResource;
	import org.aswing.resizer.Resizer;

/**
 * Basic frame ui imp.
 * @author paling
 * @private
 */
class BasicFrameUI extends BaseComponentUI  implements FrameUI{
	
	private var frame:JFrame;
	private var titleBar:FrameTitleBar;
	
	private var resizeArrowColor:ASColor;
	private var resizeArrowLightColor:ASColor;
	private var resizeArrowDarkColor:ASColor;
	
	private var mouseMoveListener:Dynamic;
	private var boundsMC:Sprite;
	private var flashTimer:Timer;
	
	public function new() {
		super();
	}

    override public function installUI(c:Component):Void{
        frame = AsWingUtils.as(c,JFrame);
        installDefaults();
		installComponents();
		installListeners();
    }
    
	private function getPropertyPrefix():String{
		return "Frame.";
	}
	
    private function installDefaults():Void{
    	var pp:String= getPropertyPrefix();
		LookAndFeel.installColorsAndFont(frame, pp);
		LookAndFeel.installBorderAndBFDecorators(frame, pp);
		LookAndFeel.installBasicProperties(frame, pp);
		
	    resizeArrowColor = getColor("resizeArrow");
	    resizeArrowLightColor = getColor("resizeArrowLight");
	    resizeArrowDarkColor = getColor("resizeArrowDark");
	    var ico:Icon = frame.getIcon();
	    if(Std.is(ico,UIResource)){
	    	frame.setIcon(getIcon(getPropertyPrefix()+"icon"));
	    }
	    if(Std.is(frame.getResizerMargin(), UIResource)){
	    	frame.setResizerMargin(getInsets(getPropertyPrefix()+"resizerMargin"));
	    }
    }
    
    private function installComponents():Void{
    	if(frame.getResizer() == null || Std.is(frame.getResizer() , UIResource)){
	    	var resizer:Resizer = AsWingUtils.as(getInstance(getPropertyPrefix()+"resizer") , Resizer);
	    	frame.setResizer(resizer);
    	}
    	if(!frame.isDragDirectlySet()){
    		frame.setDragDirectly(getBoolean(getPropertyPrefix()+"dragDirectly"));
    		frame.setDragDirectlySet(false);
    	}
    	boundsMC = new Sprite();
    	boundsMC.name = "drag_bounds";
	}
	
	private function installListeners():Void{
		frame.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, __titleBarChanged);
		frame.addEventListener(WindowEvent.WINDOW_ACTIVATED, __activeChange);
		frame.addEventListener(WindowEvent.WINDOW_DEACTIVATED, __activeChange);
		frame.addEventListener(PopupEvent.POPUP_CLOSED, __frameClosed);
		frame.addEventListener(Event.REMOVED_FROM_STAGE, __frameClosed);
		
		__titleBarChanged(null);
	}

    override public function uninstallUI(c:Component):Void{
        uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
    
    private function uninstallDefaults():Void{
		LookAndFeel.uninstallBorderAndBFDecorators(frame);
		frame.filters = [];
    }
    
	private function uninstallComponents():Void{
		removeBoundsMC();
	}
	
	private function uninstallListeners():Void{
		frame.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, __titleBarChanged);
		frame.removeEventListener(WindowEvent.WINDOW_ACTIVATED, __activeChange);
		frame.removeEventListener(WindowEvent.WINDOW_DEACTIVATED, __activeChange);
		frame.removeEventListener(PopupEvent.POPUP_CLOSED, __frameClosed);
		frame.removeEventListener(Event.REMOVED_FROM_STAGE, __frameClosed);
		removeTitleBarListeners();
		if(flashTimer != null){
			flashTimer.stop();
			flashTimer = null;
		}
	}
	
	private var flashing:Bool;
	private var flashingActivedColor:Bool;

	/**
	 * Flash the modal frame. (User clicked other where is not in the modal frame, 
	 * flash the frame to make notice this frame is modal.)
	 */
	public function flashModalFrame():Void{
		if(flashTimer == null){
			flashTimer = new Timer(50, 8);
			flashTimer.addEventListener(AWEvent.ACT, __flashTick);
			flashTimer.addEventListener(AWEvent.ACT_COMPLETE, __flashComplete);
		}
		flashing = true;
		flashingActivedColor = false; 
		flashTimer.restart();
	}
	
	private function __flashTick(e:AWEvent):Void{
		flashingActivedColor = !flashingActivedColor;
		frame.repaint();
		titleBar.getSelf().repaint();
	}
    
	private function __flashComplete(e:AWEvent):Void{
		flashing = false;
		frame.repaint();
		titleBar.getSelf().repaint();
	}

	/**
	 * For <code>flashModalFrame</code> to judge whether paint actived color or inactived color.
	 */    
	public function isPaintActivedFrame():Bool{
		if(flashing)	{
			return flashingActivedColor;
		}else{
			return frame.isActive();
		}
	}
    //----------------------------------------------------------
    override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
    	//do nothing background decorator will do this
    }
    
    //----------------------------------------------------------
	
	private function __titleBarChanged(e:PropertyChangeEvent):Void{
		if(e != null && e.getPropertyName() != JFrame.PROPERTY_TITLE_BAR){
			return;
		}
		var oldTC:Component=null;
		if(e!= null && e.getOldValue()!= null){
			var oldT:FrameTitleBar = e.getOldValue();
			oldTC = oldT.getSelf();
		}
		if(oldTC!=null)	{
			oldTC.removeEventListener(MouseEvent.MOUSE_DOWN, __onTitleBarPress);
			oldTC.removeEventListener(ReleaseEvent.RELEASE, __onTitleBarRelease);
			oldTC.removeEventListener(MouseEvent.DOUBLE_CLICK, __onTitleBarDoubleClick);
			#if(flash9)
			oldTC.doubleClickEnabled = false;
			#end
		}
		titleBar = frame.getTitleBar();
		addTitleBarListeners();
	}
	
	private function addTitleBarListeners():Void{
		if(titleBar!=null)	{
			var titleBarC:Component = titleBar.getSelf();
			titleBarC.addEventListener(MouseEvent.MOUSE_DOWN, __onTitleBarPress,false,0,false);
			titleBarC.addEventListener(ReleaseEvent.RELEASE, __onTitleBarRelease, false, 0, false);
			 
			titleBarC.doubleClickEnabled = true;
			 
			titleBarC.addEventListener(MouseEvent.DOUBLE_CLICK, __onTitleBarDoubleClick,false,0,false);
		}
	}
	
	private function removeTitleBarListeners():Void{
		if(titleBar!=null)	{
			var titleBarC:Component = titleBar.getSelf();
			titleBarC.removeEventListener(MouseEvent.MOUSE_DOWN, __onTitleBarPress);
			titleBarC.removeEventListener(ReleaseEvent.RELEASE, __onTitleBarRelease);
			 
			titleBarC.doubleClickEnabled = false;
			 
			titleBarC.removeEventListener(MouseEvent.DOUBLE_CLICK, __onTitleBarDoubleClick);
		}
	} 
	
	private function isMaximizedFrame():Bool{
		var state:Int= frame.getState();
		return ((state & JFrame.MAXIMIZED_HORIZ) == JFrame.MAXIMIZED_HORIZ)
				|| ((state & JFrame.MAXIMIZED_VERT) == JFrame.MAXIMIZED_VERT);
	}
	
	private function __activeChange(e:Event):Void{
		frame.repaint();
	}
	
	private var startPos:IntPoint;
	private var startMousePos:IntPoint;
    private function __onTitleBarPress(e:MouseEvent):Void {
	 
    	if(e.target != titleBar && e.target != titleBar.getLabel()){
    		return;
    	}
    	if(!titleBar.isTitleEnabled()){
    		return;
    	}
    	if(frame.isDragable() && !isMaximizedFrame()){
    		if(frame.isDragDirectly()){
    			var db:Rectangle = frame.getInsets().getInsideBounds(frame.getMaximizedBounds()).toRectangle();
    			var gap:Float= titleBar.getSelf().getHeight();
    			db.x -= (frame.getWidth() - gap);
    			db.y -= frame.getInsets().top;
    			db.width += (frame.getWidth() - gap*2);
    			db.height -= gap;
    			
    			frame.startDrag(false, db);
    		}else{
    			startMousePos = frame.getMousePosition();
    			startPos = frame.getLocation();
    			if(AsWingManager.getStage()!=null)	{
    				AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove, false, 0, false);
    			}
				trace("__onTitleBarPress");
    		}
    	}
    }
    
    private function __onTitleBarRelease(e:ReleaseEvent):Void {
		
    	if(AsWingUtils.as(e.getPressTarget(),FrameTitleBar) != titleBar && e.getPressTarget() != titleBar.getLabel()){
    		return;
    	}
    	if(!titleBar.isTitleEnabled()){
    		return;
    	}
    	frame.stopDrag();
    	if(AsWingManager.getStage()!=null)	{
    		AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove);
    	}
    	if(frame.isDragable() && !isMaximizedFrame() && !frame.isDragDirectly()){
	    	var dest:IntPoint = representMoveBounds();
	    	frame.setLocation(dest);
	    	frame.validate();
    	}
    	removeBoundsMC();
    }
    
    private function __onTitleBarDoubleClick(e:Event):Void{
    	if(e.target != titleBar && e.target != titleBar.getLabel()){
    		return;
    	}
    	if(!titleBar.isTitleEnabled()){
    		return;
    	}
		if(frame.isResizable()){
			var state:Int= frame.getState();
			
			if((state & JFrame.MAXIMIZED_HORIZ) == JFrame.MAXIMIZED_HORIZ
				|| (state & JFrame.MAXIMIZED_VERT) == JFrame.MAXIMIZED_VERT
				|| (state & JFrame.ICONIFIED) == JFrame.ICONIFIED){
					frame.setState(JFrame.NORMAL, false);
			}else{
				frame.setState(JFrame.MAXIMIZED, false);
			}
		}
    }
    
    private function __frameClosed(e:Event):Void{
    	removeBoundsMC();
    	if(flashTimer != null){
    		flashTimer.stop();
    		flashTimer = null;
    	}
    	if(AsWingManager.getStage()!=null)	{
    		AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove);
    	}
    }
    
    private function removeBoundsMC():Void{
    	if(frame.parent != null && frame.parent.contains(boundsMC)){
    		frame.parent.removeChild(boundsMC);
    	}
    }
    
    private function representMoveBounds(e:MouseEvent=null):IntPoint{
    	var par:DisplayObjectContainer = frame.parent;
    	if(boundsMC.parent != par){
    		par.addChild(boundsMC);
    	}
    	var currentMousePos:IntPoint = frame.getMousePosition();
    	var bounds:IntRectangle = frame.getComBounds();
    	bounds.x = startPos.x + currentMousePos.x - startMousePos.x;
    	bounds.y = startPos.y + currentMousePos.y - startMousePos.y;
    	
    	//these make user can't drag frames out the stage
    	var gap:Float= titleBar.getSelf().getHeight();
    	var frameMaxBounds:IntRectangle = frame.getMaximizedBounds();
    	
    	var topLeft:IntPoint = frameMaxBounds.leftTop();
    	var topRight:IntPoint = frameMaxBounds.rightTop();
    	var bottomLeft:IntPoint = frameMaxBounds.leftBottom();
    	if(bounds.x < topLeft.x - bounds.width + gap){
    		bounds.x = Std.int(topLeft.x - bounds.width + gap);
    	}
    	if(bounds.x > topRight.x - gap){
    		bounds.x =Std.int( topRight.x - gap);
    	}
    	if(bounds.y < topLeft.y){
    		bounds.y = topLeft.y;
    	}
    	if(bounds.y > bottomLeft.y - gap){
    		bounds.y =Std.int( bottomLeft.y - gap);
    	}
    	
    	var margin:Insets = frame.getResizerMargin();
    	var db:IntRectangle = bounds.clone();
		db.x += margin.left;
		db.y += margin.top;
		db.width -= margin.getMarginWidth();
		db.height -= margin.getMarginHeight();
		var x:Float= db.x;
		var y:Float= db.y;
		var w:Float= db.width;
		var h:Float= db.height;
		var g:Graphics2D = new Graphics2D(boundsMC.graphics);
		boundsMC.graphics.clear();
		//why	
		 
		g.drawRectangle(new Pen(resizeArrowLightColor, 1), x-1,y-1,w+2,h+2);
		g.drawRectangle(new Pen(resizeArrowColor, 1), x,y,w,h);
		g.drawRectangle(new Pen(resizeArrowDarkColor, 1), x+1,y+1,w-2,h-2);
		 
		return bounds.leftTop();
    }
    private function __onMouseMove(e:MouseEvent):Void{
    	representMoveBounds(e);
    }
}
