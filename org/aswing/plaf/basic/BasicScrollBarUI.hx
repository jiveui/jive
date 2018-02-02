/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

	
import flash.display.Sprite;
import flash.events.Event;
	import flash.events.MouseEvent;
	import org.aswing.AWKeyboard;

import org.aswing.ASColor;
	import org.aswing.JScrollBar;
	import org.aswing.AWSprite;
	import org.aswing.GroundDecorator;
	import org.aswing.JButton;
	import org.aswing.Icon;
	import org.aswing.Component;
	import org.aswing.BoundedRangeModel;
	import org.aswing.event.FocusKeyEvent;
	import org.aswing.event.AWEvent;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntDimension;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.BaseComponentUI;
import org.aswing.plaf.basic.icon.ScrollBarArrowIcon;
import org.aswing.util.Timer;
import org.aswing.event.ReleaseEvent;
	/**
 * The basic scrollbar ui.
 * @author paling
 * @private
 */
class BasicScrollBarUI extends BaseComponentUI{
	
	private var scrollBarWidth:Int;
	private var minimumThumbLength:Int;
	private var thumbRect:IntRectangle;
	private var isDragging:Bool;
	private var offset:Int;
	
    private var arrowShadowColor:ASColor;
    private var arrowLightColor:ASColor;
    
    private var scrollbar:JScrollBar;
    private var thumMC:AWSprite;
	private var thumbDecorator:GroundDecorator;
    private var incrButton:JButton;
    private var decrButton:JButton;
    private var leftIcon:Icon;
    private var rightIcon:Icon;
    private var upIcon:Icon;
    private var downIcon:Icon;
        
    private static var scrollSpeedThrottle:Int= 60; // delay in milli seconds
    private static var initialScrollSpeedThrottle:Int= 500; // first delay in milli seconds
    private var scrollTimer:Timer;
    private var scrollIncrement:Int;
    private var scrollContinueDestination:Int;
	
	public function new(){
		scrollBarWidth = 16;
		minimumThumbLength = 9;
		thumbRect = new IntRectangle();
		isDragging = false;
		offset = 0;
		scrollIncrement = 0;
		super();
	}
    	
    private function getPropertyPrefix():String{
        return "ScrollBar.";
    }    	
    	
    override public function installUI(c:Component):Void{
		scrollbar = AsWingUtils.as(c,JScrollBar);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override public function uninstallUI(c:Component):Void{
		scrollbar =  AsWingUtils.as(c,JScrollBar);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
	
	private function installDefaults():Void{
		configureScrollBarColors();
		var pp:String= getPropertyPrefix();
		if(containsKey(pp+"barWidth")){
			scrollBarWidth = getInt(pp+"barWidth");
		}
		if(containsKey(pp+"minimumThumbLength")){
			minimumThumbLength = getInt(pp+"minimumThumbLength");
		}
		LookAndFeel.installBasicProperties(scrollbar, pp);
        LookAndFeel.installBorderAndBFDecorators(scrollbar, pp);
	}
	
    private function configureScrollBarColors():Void{
		var pp:String= getPropertyPrefix();
    	LookAndFeel.installColorsAndFont(scrollbar, pp);
		arrowShadowColor = getColor(pp + "arrowShadowColor");
		arrowLightColor = getColor(pp + "arrowLightColor");
    }
    
    private function uninstallDefaults():Void{
    	LookAndFeel.uninstallBorderAndBFDecorators(scrollbar);
    }
    
	private function installComponents():Void{
		thumMC = new AWSprite();
		var pp:String= getPropertyPrefix();    			
		thumbDecorator = getGroundDecorator(pp + "thumbDecorator");
		if(thumbDecorator != null){
			if(thumbDecorator.getDisplay(scrollbar) != null){
				thumMC.addChild(thumbDecorator.getDisplay(scrollbar));
			}
		}
		scrollbar.addChild(thumMC);
		thumMC.addEventListener(MouseEvent.MOUSE_DOWN, __startDragThumb);
		thumMC.addEventListener(ReleaseEvent.RELEASE, __stopDragThumb);
		
		createIcons();
    	incrButton = createArrowButton();
    	incrButton.setName("JScrollbar_incrButton");
    	decrButton = createArrowButton();
    	decrButton.setName("JScrollbar_decrButton");
    	setButtonIcons();
        incrButton.setUIElement(true);
		decrButton.setUIElement(true);
        scrollbar.addChild(incrButton);
        scrollbar.addChild(decrButton);
		scrollbar.setEnabled(scrollbar.isEnabled());
    }
	private function uninstallComponents():Void{
		scrollbar.removeChild(incrButton);
		scrollbar.removeChild(decrButton);
		scrollbar.removeChild(thumMC);
		thumMC.removeEventListener(MouseEvent.MOUSE_DOWN, __startDragThumb);
		thumMC.removeEventListener(ReleaseEvent.RELEASE, __stopDragThumb);
		thumbDecorator = null;
    }
	
	private function installListeners():Void{
		scrollbar.addStateListener(__adjustChanged);
		
		incrButton.addEventListener(MouseEvent.MOUSE_DOWN, __incrButtonPress);
		incrButton.addEventListener(ReleaseEvent.RELEASE, __incrButtonReleased);
		
		decrButton.addEventListener(MouseEvent.MOUSE_DOWN, __decrButtonPress);
		decrButton.addEventListener(ReleaseEvent.RELEASE, __decrButtonReleased);
				
		scrollbar.addEventListener(MouseEvent.MOUSE_DOWN, __trackPress);
		scrollbar.addEventListener(ReleaseEvent.RELEASE, __trackReleased);
		
		scrollbar.addEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
		scrollbar.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
		
		scrollbar.addEventListener(Event.REMOVED_FROM_STAGE, __destroy);
		
		scrollTimer = new Timer(scrollSpeedThrottle);
		scrollTimer.setInitialDelay(initialScrollSpeedThrottle);
		scrollTimer.addActionListener(__scrollTimerPerformed);
	}
    
    private function uninstallListeners():Void{
		scrollbar.removeStateListener(__adjustChanged);
		
		incrButton.removeEventListener(MouseEvent.MOUSE_DOWN, __incrButtonPress);
		incrButton.removeEventListener(ReleaseEvent.RELEASE, __incrButtonReleased);
		
		decrButton.removeEventListener(MouseEvent.MOUSE_DOWN, __decrButtonPress);
		decrButton.removeEventListener(ReleaseEvent.RELEASE, __decrButtonReleased);
				
		scrollbar.removeEventListener(MouseEvent.MOUSE_DOWN, __trackPress);
		scrollbar.removeEventListener(ReleaseEvent.RELEASE, __trackReleased);
		
		scrollbar.removeEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
		scrollbar.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
		scrollbar.removeEventListener(Event.REMOVED_FROM_STAGE, __destroy);
		scrollTimer.stop();
		scrollTimer = null;
    }
	    
    private function isVertical():Bool{
    	return scrollbar.getOrientation() == JScrollBar.VERTICAL;
    }
    
    private function getThumbRect():IntRectangle{
    	return thumbRect.clone();
    }
    
    //-------------------------listeners--------------------------
    
    private function __destroy(e:Event):Void{
    	scrollTimer.stop();
    	if(isDragging)	{
    		AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __onMoveThumb);
    	}
    }
    
    private function __onMouseWheel(e:MouseEvent):Void{
		if(!scrollbar.isEnabled()){
			return;
		}
    	scrollByIncrement(-e.delta * scrollbar.getUnitIncrement());
    }
    
    private function __onKeyDown(e:FocusKeyEvent):Void{
		if(!(scrollbar.isEnabled() && scrollbar.isShowing())){
			return;
		}
    	var code:Int= e.keyCode;
    	if(code == AWKeyboard.UP || code == AWKeyboard.LEFT){
    		scrollByIncrement(-scrollbar.getUnitIncrement());
    	}else if(code == AWKeyboard.DOWN || code == AWKeyboard.RIGHT){
    		scrollByIncrement(scrollbar.getUnitIncrement());
    	}else if(code == AWKeyboard.PAGE_UP){
    		scrollByIncrement(-scrollbar.getBlockIncrement());
    	}else if(code == AWKeyboard.PAGE_DOWN){
    		scrollByIncrement(scrollbar.getBlockIncrement());
    	}else if(code == AWKeyboard.HOME){
    		scrollbar.setValue(scrollbar.getMinimum());
    	}else if(code == AWKeyboard.END){
    		scrollbar.setValue(scrollbar.getMaximum() - scrollbar.getVisibleAmount());
    	}
    }
    
    private function __scrollTimerPerformed(e:AWEvent):Void{
    	var value:Int= scrollbar.getValue() + scrollIncrement;
    	var finished:Bool= false;
    	if(scrollIncrement > 0){
    		if(value >= scrollContinueDestination){
    			finished = true;
    		}
    	}else{
    		if(value <= scrollContinueDestination){
    			finished = true;
    		}
    	}
    	if(finished)	{
    		scrollbar.setValue(scrollContinueDestination, false);
    		scrollTimer.stop();
    	}else{
    		scrollByIncrement(scrollIncrement);
    	}
    }
    
    private function __adjustChanged(e:Event):Void{
    	if(scrollbar.isVisible() && !isDragging)
    		paintAndLocateThumb(scrollbar.getPaintBounds());
    }
    
    private function __incrButtonPress(e:Event):Void{
    	scrollIncrement = scrollbar.getUnitIncrement();
    	scrollByIncrement(scrollIncrement);
    	scrollContinueDestination = scrollbar.getMaximum() - scrollbar.getVisibleAmount();
    	scrollTimer.restart();
    }
    
    private function __incrButtonReleased(e:Event):Void{
    	scrollTimer.stop();
    }
    
    private function __decrButtonPress(e:Event):Void{
    	scrollIncrement = -scrollbar.getUnitIncrement();
    	scrollByIncrement(scrollIncrement);
    	scrollContinueDestination = scrollbar.getMinimum();
    	scrollTimer.restart();
    }
    
    private function __decrButtonReleased(e:Event):Void{
    	scrollTimer.stop();
    }
    
    private function __trackPress(e:MouseEvent):Void{
    	var aimPoint:IntPoint = scrollbar.getMousePosition();
    	var isPressedInRange:Bool= false;
    	var tr:IntRectangle = getThumbRect();
    	var mousePos:Int;
    	if(isVertical()){
    		mousePos = aimPoint.y;
    		aimPoint.y -= Std.int(tr.height/2);
    		if(mousePos < tr.y && mousePos > decrButton.y + decrButton.height){
    			isPressedInRange = true;
    		}else if(mousePos > tr.y + tr.height && mousePos < incrButton.y){
    			isPressedInRange = true;
    		}
    	}else{
    		mousePos = aimPoint.x;
    		aimPoint.x -= Std.int(tr.width/2);
    		if(mousePos < tr.x && mousePos > decrButton.x + decrButton.width){
    			isPressedInRange = true;
    		}else if(mousePos > tr.x + tr.width && mousePos < incrButton.x){
    			isPressedInRange = true;
    		}
    	}
    	
    	if(isPressedInRange)	{
    		scrollContinueDestination = getValueWithPosition(aimPoint);
    		if(scrollContinueDestination > scrollbar.getValue()){
    			scrollIncrement = scrollbar.getBlockIncrement();
    		}else{
    			scrollIncrement = -scrollbar.getBlockIncrement();
    		}
    		scrollByIncrement(scrollIncrement);
    		scrollTimer.restart();
    	}
    }
    
    private function __trackReleased(e:Event):Void{
    	scrollTimer.stop();
    }
        
    private function scrollByIncrement(increment:Int):Void{
    	scrollbar.setValue(scrollbar.getValue() + increment, false);
    }
    
    private function __startDragThumb(e:Event):Void{
    	if(!scrollbar.isEnabled()){
    		return;
    	}
    	scrollbar.setValueIsAdjusting(true);
    	var mp:IntPoint = scrollbar.getMousePosition();
    	var mx:Int= mp.x;
    	var my:Int= mp.y;
    	var tr:IntRectangle = getThumbRect();
    	if(isVertical()){
    		offset = my - tr.y;
    	}else{
    		offset = mx - tr.x;
    	}
    	isDragging = true;
    	__startHandleDrag();
    }
    
    private function __stopDragThumb(e:Event):Void{
    	__stopHandleDrag();
    	if(!scrollbar.isEnabled()){
    		return;
    	}
    	if(isDragging)	{
    		scrollThumbToCurrentMousePosition();
    	}
    	offset = 0;
    	isDragging = false;
    	scrollbar.setValueIsAdjusting(false);
    }
    
    private function __startHandleDrag():Void{
    	AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_MOVE, __onMoveThumb, false, 0, false);
    }
    private function __stopHandleDrag():Void{
    	AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __onMoveThumb);
    }
    
    private function __onMoveThumb(e:MouseEvent):Void{
    	if(!scrollbar.isEnabled()){
    		return;
    	}
    	scrollThumbToCurrentMousePosition();
    	e.updateAfterEvent();
    }
    
    private function scrollThumbToCurrentMousePosition():Void{
    	var mp:IntPoint = scrollbar.getMousePosition();
    	var mx:Int= mp.x;
    	var my:Int= mp.y;
    	var thumbR:IntRectangle = getThumbRect();
    	
	    var thumbMin:Int, thumbMax:Int, thumbPos:Int;
	    
    	if(isVertical()){
			thumbMin = decrButton.getY() + decrButton.getHeight();
			thumbMax = incrButton.getY() - thumbR.height;
			thumbPos = Std.int(Math.min(thumbMax, Math.max(thumbMin, (my - offset))));
			setThumbRect(thumbR.x, thumbPos, thumbR.width, thumbR.height);	
    	}else{
		    thumbMin = decrButton.getX() + decrButton.getWidth();
		    thumbMax = incrButton.getX() - thumbR.width;
			thumbPos = Std.int(Math.min(thumbMax, Math.max(thumbMin, (mx - offset))));
			setThumbRect(thumbPos, thumbR.y, thumbR.width, thumbR.height);
    	}
    	
    	var scrollBarValue:Int= getValueWithThumbMaxMinPos(thumbMin, thumbMax, thumbPos);
    	scrollbar.setValue(scrollBarValue, false);
    }
    
    private function getValueWithPosition(point:IntPoint):Int{
    	var mx:Int= point.x;
    	var my:Int= point.y;
    	var thumbR:IntRectangle = getThumbRect();
    	
	    var thumbMin:Int, thumbMax:Int, thumbPos:Int;
	    
    	if(isVertical()){
			thumbMin = decrButton.getY() + decrButton.getHeight();
			thumbMax = incrButton.getY() - thumbR.height;
			thumbPos = my;
    	}else{
		    thumbMin = decrButton.getX() + decrButton.getWidth();
		    thumbMax = incrButton.getX() - thumbR.width;
		    thumbPos = mx;
    	}
    	return getValueWithThumbMaxMinPos(thumbMin, thumbMax, thumbPos);
    }
    
    private function getValueWithThumbMaxMinPos(thumbMin:Int, thumbMax:Int, thumbPos:Int):Int{
    	var model:BoundedRangeModel = scrollbar.getModel();
    	var scrollBarValue:Int;
    	if (thumbPos >= thumbMax) {
    		scrollBarValue = model.getMaximum() - model.getExtent();
    	}else{
			var valueMax:Int= model.getMaximum() - model.getExtent();
			var valueRange:Int= valueMax - model.getMinimum();
			var thumbValue:Int= thumbPos - thumbMin;
			var thumbRange:Int= thumbMax - thumbMin;
			var value:Int= Math.round((thumbValue / thumbRange) * valueRange);
			scrollBarValue = value + model.getMinimum();
    	}
    	return scrollBarValue;    	
    }
    
    //--------------------------paints----------------------------
    override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
    	super.paint(c, g, b);
    	layoutScrollBar();
    	paintAndLocateThumb(b);
    }
    
	override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		//do nothing, background decorator will paint it
	}	    
    
    private function paintAndLocateThumb(b:IntRectangle):Void{
     	if(!scrollbar.isEnabled()){
    		if(isVertical()){
    			if(scrollbar.mouseChildren)	{
    				trace("Logic Wrong : Scrollbar is not enabled, but its children enabled ");
    			}
    		}
    		thumMC.visible = false;
    		return;
    	}
    	thumMC.visible = true;
    	var min:Int= scrollbar.getMinimum();
    	var extent:Int= scrollbar.getVisibleAmount();
    	var range:Int= scrollbar.getMaximum() - min;
    	var value:Int= scrollbar.getValue();
    	
    	if(range <= 0){
    		if(range < 0)
    			trace("Logic Wrong : Scrollbar range = " + range + ", max="+scrollbar.getMaximum()+", min="+min);
    		thumMC.visible = false;
    		return;
    	}
    	
    	var trackLength:Int;
    	var thumbLength:Int;
    	if(isVertical()){
    		trackLength = b.height - incrButton.getHeight() - decrButton.getHeight();
    		thumbLength = Math.floor(trackLength*(extent/range));
    	}else{
    		trackLength = b.width - incrButton.getWidth() - decrButton.getWidth();
    		thumbLength = Math.floor(trackLength*(extent/range));
    	}
    	if(trackLength > minimumThumbLength){
    		thumbLength =Std.int( Math.max(thumbLength, minimumThumbLength));
    	}else{
			//trace("The visible range is so short can't view thumb now!");
    		thumMC.visible = false;
    		return;
    	}
    	
		var thumbRange:Int= trackLength - thumbLength;
		var thumbPos:Int;
		if((range - extent) == 0){
			thumbPos = 0;
		}else{
			thumbPos = Math.round(thumbRange * ((value - min) / (range - extent)));
		}
		if(isVertical()){
			setThumbRect(b.x, thumbPos + b.y + decrButton.getHeight(), 
						scrollBarWidth, thumbLength);
		}else{
			setThumbRect(thumbPos + b.x + decrButton.getWidth(), b.y, 
						thumbLength, scrollBarWidth);
		}
    }
    
    private function setThumbRect(x:Int, y:Int, w:Int, h:Int):Void{
    	var oldW:Int= thumbRect.width;
    	var oldH:Int= thumbRect.height;
    	
    	thumbRect.setRectXYWH(x, y, w, h);
    	
    	if(w != oldW || h != oldH){
    		paintThumb(thumMC, thumbRect.getSize(), isDragging);
    	}
    	thumMC.x = x;
    	thumMC.y = y;
    }
    
    /**
     * LAF notice.
     * 
     * Override this method to paint diff thumb in your LAF.
     */
    private function paintThumb(thumMC:Sprite, size:IntDimension, isPressed:Bool):Void{
    	thumMC.graphics.clear();
    	var g:Graphics2D = new Graphics2D(thumMC.graphics);
    	if(thumbDecorator != null){
    		thumbDecorator.updateDecorator(scrollbar, g, size.getBounds());
    	}
    }
    /**
     * LAF notice.
     * 
     * Override this method to paint diff thumb in your LAF.
     */    
    private function createArrowIcon(direction:Float):Icon{
    	var icon:Icon = new ScrollBarArrowIcon(direction, scrollBarWidth, scrollBarWidth);
		return icon;
    }
    
    /**
     * LAF notice.
     * 
     * Override this method to paint diff thumb in your LAF.
     */    
    private function createArrowButton():JButton{
		var b:JButton = new JButton();
		b.setFocusable(false);
		b.setBackground(null);
		b.setForeground(null);
		b.setMideground(null);
		b.setStyleTune(null);
		b.setStyleProxy(scrollbar);
		b.setPreferredSize(new IntDimension(scrollBarWidth, scrollBarWidth));
		return b;
    }
        
    private function createIcons():Void{
    	leftIcon = createArrowIcon(Math.PI);
    	rightIcon = createArrowIcon(0);
    	upIcon = createArrowIcon(-Math.PI/2);
    	downIcon = createArrowIcon(Math.PI/2);
    }
    
    private function setButtonIcons():Void{
    	if(isVertical()){
    		incrButton.setIcon(downIcon);
    		decrButton.setIcon(upIcon);
    	}else{
    		incrButton.setIcon(rightIcon);
    		decrButton.setIcon(leftIcon);
    	}
    }     
    //--------------------------Dimensions----------------------------
    
    override public function getPreferredSize(c:Component):IntDimension{
		var w:Int, h:Int;
		if(isVertical()){
			w = scrollBarWidth;
			h = scrollBarWidth*2;
		}else{
			w = scrollBarWidth*2;
			h = scrollBarWidth;
		}
		return scrollbar.getInsets().getOutsideSize(new IntDimension(w, h));
    }

    override public function getMaximumSize(c:Component):IntDimension{
		var w:Int, h:Int;
		if(isVertical()){
			w = scrollBarWidth;
			h = 100000;
		}else{
			w = 100000;
			h = scrollBarWidth;
		}
		return scrollbar.getInsets().getOutsideSize(new IntDimension(w, h));
    }

    override public function getMinimumSize(c:Component):IntDimension{
		return getPreferredSize(c);
    }
	
	//--------------------------Layout----------------------------
	private function layoutVScrollbar(sb:JScrollBar):Void{
    	var rd:IntRectangle = sb.getPaintBounds();
    	var bd:IntDimension = decrButton.getPreferredSize();
    	var w:Int= bd.width;
    	var h:Int= bd.height;
    	var x:Int= rd.x;
    	var y:Int= rd.y;
    	var sbw:Int= scrollBarWidth;
    	decrButton.setComBoundsXYWH(Std.int(x+(sbw-w)/2), y, w, h);
    	incrButton.setComBoundsXYWH(Std.int(x+(sbw-w)/2), y + rd.height - h, w, h);
	}
	
	private function layoutHScrollbar(sb:JScrollBar):Void{
    	var rd:IntRectangle = sb.getPaintBounds();
    	var bd:IntDimension = decrButton.getPreferredSize();
    	var w:Int= bd.width;
    	var h:Int= bd.height;
    	var x:Int= rd.x;
    	var y:Int= rd.y;
    	var sbw:Int= scrollBarWidth;
    	decrButton.setComBoundsXYWH(x, Std.int(y+(sbw-h)/2), w, h);
    	incrButton.setComBoundsXYWH(Std.int(x+rd.width-w), Std.int(y+(sbw-h)/2), w, h);
	}
	    
	public function layoutScrollBar():Void{
		if(isDragging)	{
			return;
		}
		setButtonIcons();
		if(isVertical()){
			layoutVScrollbar(scrollbar);
		}else{
			layoutHScrollbar(scrollbar);
		}
    }
	
}