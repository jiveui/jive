/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import flash.display.Shape;
import org.aswing.error.Error;
import flash.events.Event;
import flash.filters.GlowFilter;
import flash.events.MouseEvent; 
import org.aswing.AWKeyboard;
import flash.filters.BitmapFilter;
import org.aswing.JSlider;
	import org.aswing.Icon;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.StyleTune;
	import org.aswing.JToolTip;
	import org.aswing.Insets;
	import org.aswing.event.ReleaseEvent;
	import org.aswing.event.FocusKeyEvent;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.graphics.Pen;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.SliderUI;
	import org.aswing.util.Timer;
	/**
 * Basic slider ui imp.
 * @author paling
 * @private
 */
class BasicSliderUI extends BaseComponentUI  implements SliderUI{
	
	private var slider:JSlider;
	private var thumbIcon:Icon;

	private var progressColor:ASColor;
	
	private var trackRect:IntRectangle;
	private var trackDrawRect:IntRectangle;
	private var tickRect:IntRectangle;
	private var thumbRect:IntRectangle;
	
	private var offset:Int;
	private var isDragging:Bool;
	private var scrollIncrement:Int;
	private var scrollContinueDestination:Int;
	private var scrollTimer:Timer;
	private static var scrollSpeedThrottle:Float= 60; // delay in milli seconds
	private static var initialScrollSpeedThrottle:Float= 500; // first delay in milli seconds
	
	private var trackCanvas:Shape;
	private var progressCanvas:Shape;
	
	public function new(){
		super();
		trackRect   = new IntRectangle();
		tickRect	= new IntRectangle();
		thumbRect   = new IntRectangle();
		trackDrawRect = new IntRectangle();
		offset	  = 0;
		isDragging  = false;
	}
		
	private function getPropertyPrefix():String{
		return "Slider.";
	}
		
	override public function installUI(c:Component):Void{
		slider = AsWingUtils.as(c,JSlider);
		installDefaults();
		installComponents();
		installListeners();
	}
	
	override public function uninstallUI(c:Component):Void{
		slider = AsWingUtils.as(c,JSlider);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
	}
	
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
		LookAndFeel.installColorsAndFont(slider, pp);
		LookAndFeel.installBasicProperties(slider, pp);
		LookAndFeel.installBorderAndBFDecorators(slider, pp);
		configureSliderColors();
	}
	
	private function configureSliderColors():Void{
		var pp:String= getPropertyPrefix();
		progressColor = getColor(pp+"progressColor");
	}
	
	private function uninstallDefaults():Void{
		LookAndFeel.uninstallBorderAndBFDecorators(slider);
	}
	
	private function installComponents():Void{
		var pp:String= getPropertyPrefix();
		thumbIcon = getIcon(pp+"thumbIcon");
		if(thumbIcon.getDisplay(slider)==null){
			throw new Error("Slider thumb icon must has its own display object(getDisplay()!=null)!");  
		}
		trackCanvas = new Shape();
		progressCanvas = new Shape();
		slider.addChild(trackCanvas);
		slider.addChild(progressCanvas);
		slider.addChild(thumbIcon.getDisplay(slider));
	}
	
	private function uninstallComponents():Void{
		slider.removeChild(trackCanvas);
		slider.removeChild(progressCanvas);
		slider.removeChild(thumbIcon.getDisplay(slider));
		thumbIcon = null;
		progressCanvas = null;
		trackCanvas = null;
	}
	
	private function installListeners():Void{
		slider.addEventListener(MouseEvent.MOUSE_DOWN, __onSliderPress);
		slider.addEventListener(ReleaseEvent.RELEASE, __onSliderReleased);
		slider.addEventListener(MouseEvent.MOUSE_WHEEL, __onSliderMouseWheel);
		slider.addStateListener(__onSliderStateChanged);
		slider.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onSliderKeyDown);
		scrollTimer = new Timer(Std.int(scrollSpeedThrottle));
		scrollTimer.setInitialDelay(Std.int(initialScrollSpeedThrottle));
		scrollTimer.addActionListener(__scrollTimerPerformed);
	}
	
	private function uninstallListeners():Void{
		slider.removeEventListener(MouseEvent.MOUSE_DOWN, __onSliderPress);
		slider.removeEventListener(ReleaseEvent.RELEASE, __onSliderReleased);
		slider.removeEventListener(MouseEvent.MOUSE_WHEEL, __onSliderMouseWheel);
		slider.removeStateListener(__onSliderStateChanged);
		slider.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onSliderKeyDown);
		scrollTimer.stop();
		scrollTimer = null;
	}
	
	private function isVertical():Bool{
		return slider.getOrientation() == JSlider.VERTICAL;
	}
	
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		countTrackRect(b);
		countThumbRect();
		countTickRect(b);
		paintTrack(g, trackDrawRect);
		paintThumb(g, thumbRect);
		paintTick(g, tickRect);
	}
	
	private function countTrackRect(b:IntRectangle):Void{
		var thumbSize:IntDimension = getThumbSize();
		var h_margin:Int, v_margin:Int;
		if(isVertical()){
			v_margin = Math.ceil(thumbSize.height/2.0);
			h_margin = Std.int(4/2);
			//h_margin = thumbSize.width/3-1;
			trackDrawRect.setRectXYWH(b.x+h_margin, b.y+v_margin, 
				thumbSize.width-h_margin*2, b.height-v_margin*2);
			trackRect.setRectXYWH(b.x, b.y+v_margin, 
				thumbSize.width, b.height-v_margin*2);
		}else{
			h_margin = Math.ceil(thumbSize.width/2.0);
			v_margin = Std.int(4/2);
			//v_margin = thumbSize.height/3-1;
			trackDrawRect.setRectXYWH(b.x+h_margin, b.y+v_margin, 
				b.width-h_margin*2, thumbSize.height-v_margin*2);
			trackRect.setRectXYWH(b.x+h_margin, b.y, 
				b.width-h_margin*2, thumbSize.height);
		}
	}
	
	private function countTickRect(b:IntRectangle):Void{
		if(isVertical()){
			tickRect.y = trackRect.y;
			tickRect.x = trackRect.x+trackRect.width+getTickTrackGap();
			tickRect.height = trackRect.height;
			tickRect.width = b.width-trackRect.width-getTickTrackGap();
		}else{
			tickRect.x = trackRect.x;
			tickRect.y = trackRect.y+trackRect.height+getTickTrackGap();
			tickRect.width = trackRect.width;
			tickRect.height = b.height-trackRect.height-getTickTrackGap();
		}
	}
	
	private function countThumbRect():Void{
		thumbRect.setSize(getThumbSize());
		if (slider.getSnapToTicks()){
			var sliderValue:Int= slider.getValue();
			var snappedValue:Int= sliderValue; 
			var majorTickSpacing:Int= slider.getMajorTickSpacing();
			var minorTickSpacing:Int= slider.getMinorTickSpacing();
			var tickSpacing:Int= 0;
			if (minorTickSpacing > 0){
				tickSpacing = minorTickSpacing;
			}else if (majorTickSpacing > 0){
				tickSpacing = majorTickSpacing;
			}
			if (tickSpacing != 0){
				// If it's not on a tick, change the value
				if ((sliderValue - slider.getMinimum()) % tickSpacing != 0){
					var temp:Float= (sliderValue - slider.getMinimum()) / tickSpacing;
					var whichTick:Int= Math.round( temp );
					snappedValue = slider.getMinimum() + (whichTick * tickSpacing);
				}
				if(snappedValue != sliderValue){ 
					slider.setValue(snappedValue);
				}
			}
		}
		var valuePosition:Int;
		if (isVertical()) {
			valuePosition = yPositionForValue(slider.getValue());
			thumbRect.x = trackRect.x;
			thumbRect.y = Std.int(valuePosition - (thumbRect.height / 2));
		}else {
			valuePosition = Std.int(xPositionForValue(slider.getValue()));
			thumbRect.x =Std.int( valuePosition - (thumbRect.width / 2));
			thumbRect.y = trackRect.y;
		}
	}
	
	private function getThumbSize():IntDimension{
		if(isVertical()){
			return new IntDimension(thumbIcon.getIconHeight(slider), thumbIcon.getIconWidth(slider));
		}else{
			return new IntDimension(thumbIcon.getIconWidth(slider), thumbIcon.getIconHeight(slider));
		}
	}
	
	private function countTickSize(sliderRect:IntRectangle):IntDimension{
		if(isVertical()){
			return new IntDimension(Std.int(getTickLength()), sliderRect.height);
		}else{
			return new IntDimension(sliderRect.width, Std.int(getTickLength()));
		}
	}
	
	/**
	 * Gets the height of the tick area for horizontal sliders and the width of the
	 * tick area for vertical sliders.  BasicSliderUI uses the returned value to
	 * determine the tick area rectangle.  If you want to give your ticks some room,
	 * make this larger than you need and paint your ticks away from the sides in paintTicks().
	 */
	private function getTickLength():Float{
		return 10;
	}	
	
	private function countTrackAndThumbSize(sliderRect:IntRectangle):IntDimension{
		if(isVertical()){
			return new IntDimension(getThumbSize().width, sliderRect.height);
		}else{
			return new IntDimension(sliderRect.width, getThumbSize().height);
		}
	}
	
	private function getTickTrackGap():Int{
		return 2;
	}
	
	public function xPositionForValue(value:Int):Float{
		var min:Int= slider.getMinimum();
		var max:Int= slider.getMaximum();
		var trackLength:Int= trackRect.width;
		var valueRange:Int= max - min;
		var pixelsPerValue:Float= trackLength / valueRange;
		var trackLeft:Int= trackRect.x;
		var trackRight:Int= trackRect.x + (trackRect.width - 0);//0
		var xPosition:Int;

		if ( !slider.getInverted() ) {
			xPosition = trackLeft;
			xPosition += Math.round(pixelsPerValue * (value - min));
		}else {
			xPosition = trackRight;
			xPosition -= Math.round(pixelsPerValue * (value - min));
		}

		xPosition = Std.int(Math.max( trackLeft, xPosition ));
		xPosition = Std.int(Math.min( trackRight, xPosition ));

		return xPosition;
	}

	public function yPositionForValue( value:Int):Int{
		var min:Int= slider.getMinimum();
		var max:Int= slider.getMaximum();
		var trackLength:Int= trackRect.height; 
		var valueRange:Int= max - min;
		var pixelsPerValue:Float= trackLength / valueRange;
		var trackTop:Int= trackRect.y;
		var trackBottom:Int= trackRect.y + (trackRect.height - 1);
		var yPosition:Int;

		if ( !slider.getInverted() ) {
			yPosition = trackTop;
			yPosition += Math.round(pixelsPerValue * (max - value));
		}
		else {
			yPosition = trackTop;
			yPosition += Math.round(pixelsPerValue * (value - min));
		}

		yPosition = Std.int(Math.max( trackTop, yPosition ));
		yPosition = Std.int(Math.min( trackBottom, yPosition ));

		return yPosition;
	}	
	
	/**
	 * Returns a value give a y position.  If yPos is past the track at the top or the
	 * bottom it will set the value to the min or max of the slider, depending if the
	 * slider is inverted or not.
	 */
	public function valueForYPosition( yPos:Int):Int{
		var value:Int;
		var minValue:Int= slider.getMinimum();
		var maxValue:Int= slider.getMaximum();
		var trackLength:Int= trackRect.height;
		var trackTop:Int= trackRect.y;
		var trackBottom:Int= trackRect.y + (trackRect.height - 1);
		var inverted:Bool= slider.getInverted();
		if ( yPos <= trackTop ) {
			value = inverted ? minValue : maxValue;
		}else if ( yPos >= trackBottom ) {
			value = inverted ? maxValue : minValue;
		}else {
			var distanceFromTrackTop:Int= yPos - trackTop;
			var valueRange:Int= maxValue - minValue;
			var valuePerPixel:Float= valueRange / trackLength;
			var valueFromTrackTop:Int= Math.round(distanceFromTrackTop * valuePerPixel);
	
			value = inverted ? minValue + valueFromTrackTop : maxValue - valueFromTrackTop;
		}
		return value;
	}
  
	/**
	 * Returns a value give an x position.  If xPos is past the track at the left or the
	 * right it will set the value to the min or max of the slider, depending if the
	 * slider is inverted or not.
	 */
	public function valueForXPosition( xPos:Int):Int{
		var value:Int;
		var minValue:Int= slider.getMinimum();
		var maxValue:Int= slider.getMaximum();
		var trackLength:Int= trackRect.width;
		var trackLeft:Int= trackRect.x; 
		var trackRight:Int= trackRect.x + (trackRect.width - 0);//1
		var inverted:Bool= slider.getInverted();
		if ( xPos <= trackLeft ) {
			value = inverted ? maxValue : minValue;
		}else if ( xPos >= trackRight ) {
			value = inverted ? minValue : maxValue;
		}else {
			var distanceFromTrackLeft:Int= xPos - trackLeft;
			var valueRange:Int= maxValue - minValue;
			var valuePerPixel:Float= valueRange / trackLength;
			var valueFromTrackLeft:Int= Math.round(distanceFromTrackLeft * valuePerPixel);
			
			value = inverted ? maxValue - valueFromTrackLeft : minValue + valueFromTrackLeft;
		}
		return value;
	}
	
	//-------------------------
	
	private function paintTrack(g:Graphics2D, drawRect:IntRectangle):Void{
		trackCanvas.graphics.clear();
		if(!slider.getPaintTrack()){
			return;
		}
		g = new Graphics2D(trackCanvas.graphics);
		var verticle:Bool= (slider.getOrientation() == AsWingConstants.VERTICAL);
		var style:StyleTune = slider.getStyleTune();
		var b:IntRectangle = drawRect.clone();
		var radius:Float= 0;
		if(verticle)	{
			radius = Math.floor(b.width/2);
		}else{
			radius = Math.floor(b.height/2);
		}
		if(radius > style.round){
			radius = style.round;
		}
		g.fillRoundRect(new SolidBrush(slider.getBackground()), b.x, b.y, b.width, b.height, radius);
	    var trackCanvas_f :Array<BitmapFilter>= new Array<BitmapFilter>();
		
		trackCanvas_f.push(new flash.filters.GlowFilter(0x0, style.shadowAlpha, 5, 5, 1, 1, true));
		trackCanvas.filters = trackCanvas_f; 
	}
	
	private function paintTrackProgress(g:Graphics2D, trackDrawRect:IntRectangle):Void{
		if(!slider.getPaintTrack()){
			return;
		}
		return;//do not paint progress here
		var rect:IntRectangle = trackDrawRect.clone();
		var width:Int;
		var height:Int;
		var x:Int;
		var y:Int;
		var inverted:Bool= slider.getInverted();
		if(isVertical()){
			width = rect.width-5;
			height = Std.int(thumbRect.y + thumbRect.height/2 - rect.y - 5);
			x = rect.x + 2;
			if(inverted)	{
				y = rect.y + 2;
			}else{
				height = Std.int(rect.y + rect.height - thumbRect.y - thumbRect.height/2 - 2);
				y = Std.int(thumbRect.y + thumbRect.height/2);
			}
		}else{
			height = rect.height-5;
			if(inverted)	{
				width = Std.int(rect.x + rect.width - thumbRect.x - thumbRect.width/2 - 2);
				x = Std.int(thumbRect.x + thumbRect.width/2);
			}else{
				width = Std.int(thumbRect.x + thumbRect.width/2 - rect.x - 5);
				x = rect.x + 2;
			}
			y = rect.y + 2;
		}
		g.fillRectangle(new SolidBrush(progressColor), x, y, width, height);		
	}
	
	private function paintThumb(g:Graphics2D, drawRect:IntRectangle):Void{
		if(isVertical()){
			thumbIcon.getDisplay(slider).rotation = 90;
			thumbIcon.updateIcon(slider, g, drawRect.x+thumbIcon.getIconHeight(slider), drawRect.y);
		}else{
			thumbIcon.getDisplay(slider).rotation = 0;
			thumbIcon.updateIcon(slider, g, drawRect.x, drawRect.y);
		}
	}
	
	private function paintTick(g:Graphics2D, drawRect:IntRectangle):Void{
		if(!slider.getPaintTicks()){
			return;
		}		
		var tickBounds:IntRectangle = drawRect;
		var majT:Int= slider.getMajorTickSpacing();
		var minT:Int= slider.getMinorTickSpacing();
		var max:Int= slider.getMaximum();
		//why	
	 
		g.beginDraw(new Pen(slider.getForeground(), 0));
			
		var yPos:Int= 0;
		var value:Int= 0;
		var xPos:Int= 0;
			
		if (isVertical()) {
			xPos = tickBounds.x;
			value = slider.getMinimum();
			yPos = 0;

			if ( minT > 0 ) {
				while ( value <= max ) {
					yPos = yPositionForValue( value );
					paintMinorTickForVertSlider( g, tickBounds, xPos, yPos );
					value += minT;
				}
			}

			if ( majT > 0 ) {
				value = slider.getMinimum();
				while ( value <= max ) {
					yPos = yPositionForValue( value );
					paintMajorTickForVertSlider( g, tickBounds, xPos, yPos );
					value += majT;
				}
			}
		}else {
			yPos = tickBounds.y;
			value = slider.getMinimum();
			xPos = 0;

			if ( minT > 0 ) {
				while ( value <= max ) {
					xPos = Std.int(xPositionForValue( value ));
					paintMinorTickForHorizSlider( g, tickBounds, xPos, yPos );
					value += minT;
				}
			}

			if ( majT > 0 ) {
				value = slider.getMinimum();

				while ( value <= max ) {
					xPos = Std.int(xPositionForValue( value ));
					paintMajorTickForHorizSlider( g, tickBounds, xPos, yPos );
					value += majT;
				}
			}
		}
		g.endDraw();
	 
	}

	private function paintMinorTickForHorizSlider( g:Graphics2D, tickBounds:IntRectangle, x:Int, y:Int):Void{
		g.line( x, y, x, y+tickBounds.height / 2 - 1);
	}

	private function paintMajorTickForHorizSlider( g:Graphics2D, tickBounds:IntRectangle, x:Int, y:Int):Void{
		g.line( x, y, x, y+tickBounds.height - 2);
	}

	private function paintMinorTickForVertSlider( g:Graphics2D, tickBounds:IntRectangle, x:Int, y:Int):Void{
		g.line( x, y, x+tickBounds.width / 2 - 1, y );
	}

	private function paintMajorTickForVertSlider( g:Graphics2D, tickBounds:IntRectangle, x:Int, y:Int):Void{
		g.line( x, y, x+tickBounds.width - 2, y );
	}
	
	//----------------------------
	
	private function __onSliderStateChanged(e:Event):Void{
		if(isDragging!=true){
			countThumbRect();
			paintThumb(null, thumbRect);
			progressCanvas.graphics.clear();
			paintTrackProgress(new Graphics2D(progressCanvas.graphics), trackDrawRect);
		}
	}
	
	private function __onSliderKeyDown(e:FocusKeyEvent):Void{
		if(!slider.isEnabled()){
			return;
		}
		var code:Int= e.keyCode;
		var unit:Int= getUnitIncrement();
		var block:Int= slider.getMajorTickSpacing() > 0 ? slider.getMajorTickSpacing() : unit*5;
		if(isVertical()){
			unit = -unit;
			block = -block;
		}
		if(slider.getInverted()){
			unit = -unit;
			block = -block;
		}
		if(code == AWKeyboard.UP || code == AWKeyboard.LEFT){
			scrollByIncrement(-unit);
		}else if(code == AWKeyboard.DOWN || code == AWKeyboard.RIGHT){
			scrollByIncrement(unit);
		}else if(code == AWKeyboard.PAGE_UP){
			scrollByIncrement(-block);
		}else if(code == AWKeyboard.PAGE_DOWN){
			scrollByIncrement(block);
		}else if(code == AWKeyboard.HOME){
			slider.setValue(slider.getMinimum());
		}else if(code == AWKeyboard.END){
			slider.setValue(slider.getMaximum() - slider.getExtent());
		}
	}
	
	private function __onSliderPress(e:Event):Void{
		var mousePoint:IntPoint = slider.getMousePosition();
		if(thumbRect.containsPoint(mousePoint)){
			__startDragThumb();
		}else{
			var inverted:Bool= slider.getInverted();
			var thumbCenterPos:Float;
			if(isVertical()){
				thumbCenterPos = thumbRect.y + thumbRect.height/2;
				if(mousePoint.y > thumbCenterPos){
					scrollIncrement = inverted ? getUnitIncrement() : -getUnitIncrement();
				}else{
					scrollIncrement = inverted ? -getUnitIncrement() : getUnitIncrement();
				}
				scrollContinueDestination = valueForYPosition(mousePoint.y);
			}else{
				thumbCenterPos = thumbRect.x + thumbRect.width/2;
				if(mousePoint.x > thumbCenterPos){
					scrollIncrement = inverted ? -getUnitIncrement() : getUnitIncrement();
				}else{
					scrollIncrement = inverted ? getUnitIncrement() : -getUnitIncrement();
				}
				scrollContinueDestination = valueForXPosition(mousePoint.x);
			}
			scrollTimer.restart();
			__scrollTimerPerformed(null);//run one time immediately first
		}
	}
	private function __onSliderReleased(e:Event):Void {
 
		if(isDragging)	{
			__stopDragThumb();
		}
		if(scrollTimer.isRunning()){
			scrollTimer.stop();
		}
	}
	private function __onSliderMouseWheel(e:MouseEvent):Void{
		if(!slider.isEnabled()){
			return;
		}
		var delta:Int= e.delta;
		if(slider.getInverted()){
			delta = -delta;
		}
		scrollByIncrement(delta*getUnitIncrement());
	}
	
	private function __scrollTimerPerformed(e:Event):Void{
		var value:Int= slider.getValue() + scrollIncrement;
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
			slider.setValue(scrollContinueDestination);
			scrollTimer.stop();
		}else{
			scrollByIncrement(scrollIncrement);
		}
	}	
	
	private function scrollByIncrement(increment:Int):Void{
		slider.setValue(slider.getValue() + increment);
	}
	
	private function getUnitIncrement():Int{
		var unit:Int= 0;
		if(slider.getMinorTickSpacing() >0 ){
			unit = slider.getMinorTickSpacing();
		}else if(slider.getMajorTickSpacing() > 0){
			unit = slider.getMajorTickSpacing();
		}else{
			var range:Float= slider.getMaximum() - slider.getMinimum();
			if(range > 2){
				unit = Std.int(Math.max(1, Math.round(range/500)));
			}else{
				unit = Std.int(range/100);
			}
		}
		return unit;
	}
	
	private function __startDragThumb():Void{
		isDragging = true;
		slider.setValueIsAdjusting(true);
		var mp:IntPoint = slider.getMousePosition();
		var mx:Int= mp.x;
		var my:Int= mp.y;
		var tr:IntRectangle = thumbRect;
		if(isVertical()){
			offset = my - tr.y;
		}else{
			offset = mx - tr.x;
		}
		__startHandleDrag();
	}
	
	private function __stopDragThumb():Void{
		__stopHandleDrag();
		if(isDragging)	{
			isDragging = false;
			countThumbRect();
		}
		slider.setValueIsAdjusting(false);
		offset = 0;
	}
	
	private function __startHandleDrag():Void{
		if(AsWingManager.getStage()!=null)	{
			AsWingManager.getStage().addEventListener(MouseEvent.MOUSE_MOVE, __onMoveThumb, false, 0, false);
			slider.addEventListener(Event.REMOVED_FROM_STAGE, __onMoveThumbRFS, false, 0, false);
			showValueTip();
		}
	}
	private function __onMoveThumbRFS(e:Event):Void{
		AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, __onMoveThumb);
		slider.removeEventListener(Event.REMOVED_FROM_STAGE, __onMoveThumbRFS);
	}
	private function __stopHandleDrag():Void{
		if(slider.stage!=null)	{
			__onMoveThumbRFS(null);
		}
		disposValueTip();
	}
	private function __onMoveThumb(e:MouseEvent):Void{
		scrollThumbToCurrentMousePosition();
		showValueTip();
		e.updateAfterEvent();
	}
	
	private function showValueTip():Void{
		if(slider.getShowValueTip()){
			var tip:JToolTip = slider.getValueTip();
			tip.setWaitThenPopupEnabled(false);
			tip.setTipText(slider.getValue()+"");
			if(!tip.isShowing()){
				tip.showToolTip();
			}
			tip.moveLocationRelatedTo(slider.componentToGlobal(slider.getMousePosition()));
		}
	}
	
	private function disposValueTip():Void{
		if(slider.getValueTip() != null){
			slider.getValueTip().disposeToolTip();
		}
	}
	
	private function scrollThumbToCurrentMousePosition():Void{
		var mp:IntPoint = slider.getMousePosition();
		var mx:Int= mp.x;
		var my:Int= mp.y;
		
		var thumbPos:Int, minPos:Int, maxPos:Int;
		var halfThumbLength:Int;
		var sliderValue:Int;
		var paintThumbRect:IntRectangle = thumbRect.clone();
		if(isVertical()){
			halfThumbLength = Std.int(thumbRect.height / 2);
			thumbPos = my - offset;
			if(!slider.getInverted()){
				maxPos = yPositionForValue(slider.getMinimum()) - halfThumbLength;
				minPos = yPositionForValue(slider.getMaximum() - slider.getExtent()) - halfThumbLength;
			}else{
				minPos = yPositionForValue(slider.getMinimum()) - halfThumbLength;
				maxPos = yPositionForValue(slider.getMaximum() - slider.getExtent()) - halfThumbLength;
			}
			thumbPos = Std.int(Math.max(minPos, Math.min(maxPos, thumbPos)));
			sliderValue = valueForYPosition(thumbPos + halfThumbLength);
			slider.setValue(sliderValue);
			thumbRect.y = yPositionForValue(slider.getValue()) - halfThumbLength;
			paintThumbRect.y = thumbPos;
		}else{
			halfThumbLength =Std.int( thumbRect.width / 2);
			thumbPos = mx - offset;
			if(slider.getInverted()){
				maxPos = Std.int(xPositionForValue(slider.getMinimum()) - halfThumbLength);
				minPos = Std.int(xPositionForValue(slider.getMaximum() - slider.getExtent()) - halfThumbLength);
			}else{
				minPos = Std.int(xPositionForValue(slider.getMinimum()) - halfThumbLength);
				maxPos = Std.int(xPositionForValue(slider.getMaximum() - slider.getExtent()) - halfThumbLength);
			}
			thumbPos = Std.int(Math.max(minPos, Math.min(maxPos, thumbPos)));
			sliderValue = valueForXPosition(thumbPos + halfThumbLength);
			slider.setValue(sliderValue);
			thumbRect.x = Std.int(xPositionForValue(slider.getValue()) - halfThumbLength);
			paintThumbRect.x = thumbPos;
		}
		paintThumb(null, paintThumbRect);
		progressCanvas.graphics.clear();
		paintTrackProgress(new Graphics2D(progressCanvas.graphics), trackDrawRect);
	}

    public function getTrackMargin():Insets{
    	var b:IntRectangle = slider.getPaintBounds();
    	countTrackRect(b);
    	
    	var insets:Insets = new Insets();
    	insets.top = trackRect.y - b.y;
    	insets.bottom = b.y + b.height - trackRect.y - trackRect.height;
    	insets.left = trackRect.x - b.x;
    	insets.right = b.x + b.width - trackRect.x - trackRect.width;
    	return insets;
    }	
	
	//---------------------
	
	private function getPrefferedLength():Int{
		return 200;
	}
		
    override public function getPreferredSize(c:Component):IntDimension{
    	var size:IntDimension;
    	var thumbSize:IntDimension = getThumbSize();
    	var tickLength:Int= Std.int(this.getTickLength());
    	var gap:Int= this.getTickTrackGap();
    	var wide:Int= slider.getPaintTicks() ? gap+tickLength : 0;
    	if(isVertical()){
    		wide += thumbSize.width;
    		size = new IntDimension(wide, Std.int(Math.max(wide, getPrefferedLength())));
    	}else{
    		wide += thumbSize.height;
    		size = new IntDimension(Std.int(Math.max(wide, getPrefferedLength())), wide);
    	}
    	return c.getInsets().getOutsideSize(size);
    }

    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }

	override public function getMinimumSize(c:Component):IntDimension{
    	var size:IntDimension;
    	var thumbSize:IntDimension = getThumbSize();
    	var tickLength:Int= Std.int(this.getTickLength());
    	var gap:Int= this.getTickTrackGap();
    	var wide:Int= slider.getPaintTicks() ? gap+tickLength : 0;
    	if(isVertical()){
    		wide += thumbSize.width;
    		size = new IntDimension(wide, thumbSize.height);
    	}else{
    		wide += thumbSize.height;
    		size = new IntDimension(thumbSize.width, wide);
    	}
    	return c.getInsets().getOutsideSize(size);
    }    	
}