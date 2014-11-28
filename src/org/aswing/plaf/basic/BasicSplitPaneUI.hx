package org.aswing.plaf.basic;

	
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
import flash.events.KeyboardEvent;
import org.aswing.LayoutManager;
	import org.aswing.JSplitPane;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.Insets;
	import org.aswing.CursorManager;
	import org.aswing.Container;
	import org.aswing.event.AWEvent;
	import org.aswing.event.FocusKeyEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.event.ReleaseEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.plaf.SplitPaneUI;
	import org.aswing.plaf.basic.splitpane.Divider;
	/**
 * @private
 */
class BasicSplitPaneUI extends SplitPaneUI  implements LayoutManager{
	
	private var sp:JSplitPane;
	private var divider:Divider;
	private var lastContentSize:IntDimension;
	private var spLis:Dynamic;
	private var mouseLis:Dynamic;
	private var vSplitCursor:DisplayObject;
	private var hSplitCursor:DisplayObject;
	private var presentDragColor:ASColor;
	private var defaultDividerSize:Int;
	
	private var startDragPos:IntPoint;
	private var startLocation:Int;
	private var startDividerPos:IntPoint;
	private var dragRepresentationMC:Shape;
	private var pressFlag:Bool;  //the flag for pressed left or right collapseButton
	private var mouseInDividerFlag:Bool;	
	
	public function new() {
		super();
	}
	
    private function getPropertyPrefix():String{
        return "SplitPane.";
    }
    
    override public function installUI(c:Component):Void{
        sp = AsWingUtils.as(c,JSplitPane);
        installDefaults();
        installComponents();
        installListeners();
    }

    override public function uninstallUI(c:Component):Void{
        sp = AsWingUtils.as(c,JSplitPane);
        uninstallDefaults();
        uninstallComponents();
        uninstallListeners();
    }
    
    private function installDefaults():Void{
    	var pp:String= getPropertyPrefix();
        LookAndFeel.installColorsAndFont(sp, pp);
        LookAndFeel.installBorderAndBFDecorators(sp, pp);
        LookAndFeel.installBasicProperties(sp, pp);
        presentDragColor = getColor(pp+"presentDragColor");
        defaultDividerSize = getInt(pp+"defaultDividerSize");
        lastContentSize = new IntDimension();
        sp.setLayout(this);
    }

    private function uninstallDefaults():Void{
        LookAndFeel.uninstallBorderAndBFDecorators(sp);
        sp.setDividerLocation(0, true);
    }
	
	private function installComponents():Void{
		vSplitCursor = createSplitCursor(true);
		hSplitCursor = createSplitCursor(false);
		divider = createDivider();
		divider.setUIElement(true);
		sp.append(divider, JSplitPane.DIVIDER);
		
		divider.addEventListener(MouseEvent.MOUSE_DOWN, __div_pressed);
		divider.addEventListener(ReleaseEvent.RELEASE, __div_released);
		divider.addEventListener(MouseEvent.ROLL_OVER, __div_rollover);
		divider.addEventListener(MouseEvent.ROLL_OUT, __div_rollout);
		
		divider.getCollapseLeftButton().addEventListener(MouseEvent.ROLL_OVER, __div_rollout);
		divider.getCollapseRightButton().addEventListener(MouseEvent.ROLL_OVER, __div_rollout);
		divider.getCollapseLeftButton().addEventListener(MouseEvent.ROLL_OUT, __div_rollover);
		divider.getCollapseRightButton().addEventListener(MouseEvent.ROLL_OUT, __div_rollover);		
		divider.getCollapseLeftButton().addActionListener(__collapseLeft);
		divider.getCollapseRightButton().addActionListener(__collapseRight);
	}
	
	private function uninstallComponents():Void{
		sp.remove(divider);
		divider.removeEventListener(MouseEvent.MOUSE_DOWN, __div_pressed);
		divider.removeEventListener(ReleaseEvent.RELEASE, __div_released);
		divider.removeEventListener(MouseEvent.ROLL_OVER, __div_rollover);
		divider.removeEventListener(MouseEvent.ROLL_OUT, __div_rollout);
		
		divider.getCollapseLeftButton().removeEventListener(MouseEvent.ROLL_OVER, __div_rollout);
		divider.getCollapseRightButton().removeEventListener(MouseEvent.ROLL_OVER, __div_rollout);
		divider.getCollapseLeftButton().removeEventListener(MouseEvent.ROLL_OUT, __div_rollover);
		divider.getCollapseRightButton().removeEventListener(MouseEvent.ROLL_OUT, __div_rollover);
		divider.getCollapseLeftButton().removeActionListener(__collapseLeft);
		divider.getCollapseRightButton().removeActionListener(__collapseRight);
		divider = null;
	}
	
	private function installListeners():Void{
		sp.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __on_splitpane_key_down);
		sp.addEventListener(InteractiveEvent.STATE_CHANGED, __div_location_changed);
	}
	
	private function uninstallListeners():Void{
		sp.removeEventListener(KeyboardEvent.KEY_DOWN, __on_splitpane_key_down);
		sp.removeEventListener(InteractiveEvent.STATE_CHANGED, __div_location_changed);
	}
	
	/**
	 * Override this method to return a different splitCursor for your UI<br>
	 * Credit to Kristof Neirynck for added this.
	 */
	private function createSplitCursor(vertical:Bool):DisplayObject{
		var result:DisplayObject;
		if(vertical)	{
			result = Cursor.createCursor(Cursor.V_MOVE_CURSOR);
		}else{
			result = Cursor.createCursor(Cursor.H_MOVE_CURSOR);
		}
		return result;
	}
	
	/**
	 * Override this method to return a different divider for your UI
	 */
	private function createDivider():Divider{
		return new Divider(sp);
	}
    
	/**
	 * Override this method to return a different default divider size for your UI
	 */
    private function getDefaultDividerSize():Int{
    	return defaultDividerSize;
    }
    /**
	 * Override this method to return a different default DividerDragingRepresention for your UI
	 */
    private function paintDividerDragingRepresention(g:Graphics2D):Void{
		g.fillRectangle(new SolidBrush(presentDragColor.changeAlpha(0.4)), 0, 0, 1, 1);
    }
	
    /**
     * Messaged to relayout the JSplitPane based on the preferred size
     * of the children components.
     */
    override public function resetToPreferredSizes(jc:JSplitPane):Void{
    	var loc:Int= jc.getDividerLocation();
    	if(isVertical()){
    		if(jc.getLeftComponent() == null){
    			loc = 0;
    		}else{
    			loc = jc.getLeftComponent().getPreferredHeight();
    		}
    	}else{
    		if(jc.getLeftComponent() == null){
    			loc = 0;
    		}else{
    			loc = jc.getLeftComponent().getPreferredWidth();
    		}
    	}
		loc =Std.int( Math.max(
			getMinimumDividerLocation(), 
			Math.min(loc, getMaximumDividerLocation())));
		jc.setDividerLocation(loc);
    }
    
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		divider.paintImmediately();
	}    
    
    public function layoutWithLocation(location:Int):Void{
    	var rect:IntRectangle = sp.getSize().getBounds(0, 0);
    	rect = sp.getInsets().getInsideBounds(rect);
    	var lc:Component = sp.getLeftComponent();
    	var rc:Component = sp.getRightComponent();
    	var dvSize:Int= getDividerSize();
    	location = Math.floor(location);
    	if(location < 0){
    		//collapse left
			if(isVertical()){
				divider.setComBoundsXYWH(rect.x, rect.y, rect.width, dvSize);
				if(rc!=null)	rc.setComBoundsXYWH(rect.x, rect.y+dvSize, rect.width, rect.height-dvSize);
			}else{
				divider.setComBoundsXYWH(rect.x, rect.y, dvSize, rect.height);
				if(rc!=null)	rc.setComBoundsXYWH(rect.x+dvSize, rect.y, rect.width-dvSize, rect.height);
			}
			if(lc!=null)	lc.setVisible(false);
    		if(rc!=null)	rc.setVisible(true);
    	}else if(location == AsWingConstants.MAX_VALUE){
    		//collapse right
			if(isVertical()){
				divider.setComBoundsXYWH(
					rect.x, 
					rect.y+rect.height-dvSize, 
					rect.width, 
					dvSize);
				if(lc!=null)	{
					lc.setComBoundsXYWH(
						rect.x, 
						rect.y,
						rect.width, 
						rect.height-dvSize);
				}
			}else{
				divider.setComBoundsXYWH(
					rect.x+rect.width-dvSize, 
					rect.y, 
					dvSize, 
					rect.height);
				if(lc!=null)	{
					lc.setComBoundsXYWH(
						rect.x, 
						rect.y,
						rect.width-dvSize, 
						rect.height);
				}
			}
			if(lc!=null)	lc.setVisible(true);
    		if(rc!=null)	rc.setVisible(false);
    	}else{
    		//both visible
			if(isVertical()){
				divider.setComBoundsXYWH(
					rect.x, 
					rect.y+location, 
					rect.width, 
					dvSize);
				if(lc!=null)	lc.setComBoundsXYWH(
					rect.x, 
					rect.y,
					rect.width, 
					location);
				if(rc!=null)	rc.setComBoundsXYWH(
					rect.x, 
					rect.y+location+dvSize, 
					rect.width, 
					rect.height-location-dvSize
				);
			}else{
				divider.setComBoundsXYWH(
					rect.x+location, 
					rect.y, 
					dvSize, 
					rect.height);
				if(lc!=null)	lc.setComBoundsXYWH(
					rect.x, 
					rect.y,
					location, 
					rect.height);
				if(rc!=null)	rc.setComBoundsXYWH(
					rect.x+location+dvSize, 
					rect.y, 
					rect.width-location-dvSize, 
					rect.height
				);
			}
			if(lc!=null)	lc.setVisible(true);
    		if(rc!=null)	rc.setVisible(true);
    	}
    	if(lc!=null)	lc.revalidateIfNecessary();
    	if(rc!=null)	rc.revalidateIfNecessary();
    	divider.revalidateIfNecessary();
    }
    
    public function getMinimumDividerLocation():Int{
    	var leftCom:Component = sp.getLeftComponent();
    	if(leftCom == null){
    		return 0;
    	}else{
    		if(isVertical()){
    			return leftCom.getMinimumHeight();
    		}else{
    			return leftCom.getMinimumWidth();
    		}
    	}
    }
    
    public function getMaximumDividerLocation():Int{
    	var rightCom:Component = sp.getRightComponent();
    	var insets:Insets = sp.getInsets();
    	var rightComSize:Int= 0;
    	if(rightCom != null){
    		rightComSize = isVertical() ? rightCom.getMinimumHeight() : rightCom.getMinimumWidth();
    	}
		if(isVertical()){
			return sp.getHeight() - insets.top - insets.bottom - getDividerSize() - rightComSize;
		}else{
			return sp.getWidth() - insets.left - insets.right - getDividerSize() - rightComSize;
		}
    }
    
    private function isVertical():Bool{
    	return sp.getOrientation() == JSplitPane.VERTICAL_SPLIT;
    }
    
    private function getDividerSize():Int{
    	var si:Int= sp.getDividerSize();
    	if(si < 0){
    		return getDefaultDividerSize();
    	}else{
    		return si;
    	}
    }
    
    private function restrictDividerLocation(loc:Int):Int{
    	return Std.int(Math.max(
				getMinimumDividerLocation(), 
				Math.min(loc, getMaximumDividerLocation())));
    }
    //-----------------------------------------------------------------------
    
	private function __collapseLeft(e:AWEvent) : Void{
		pressFlag = true;
		if(sp.getDividerLocation() == AsWingConstants.MAX_VALUE){
			sp.setDividerLocation(sp.getLastDividerLocation());
			divider.getCollapseLeftButton().setEnabled(true);
			divider.getCollapseRightButton().setEnabled(true);
		}else if(sp.getDividerLocation() >= 0){
			sp.setDividerLocation(-1);
			divider.getCollapseLeftButton().setEnabled(false);
		}else{
			divider.getCollapseLeftButton().setEnabled(true);
		}
	}

	private function __collapseRight(e:AWEvent) : Void{
		pressFlag = true;		
		if(sp.getDividerLocation() < 0){
			sp.setDividerLocation(sp.getLastDividerLocation());
			divider.getCollapseRightButton().setEnabled(true);
			divider.getCollapseLeftButton().setEnabled(true);
		}else if(sp.getDividerLocation() != AsWingConstants.MAX_VALUE){
			sp.setDividerLocation(AsWingConstants.MAX_VALUE);
			divider.getCollapseRightButton().setEnabled(false);
		}else{
			divider.getCollapseRightButton().setEnabled(false);
		}
	}
	
	private function __on_splitpane_key_down(e:FocusKeyEvent):Void{
		var code:Int= e.keyCode;
		var dir:Float= 0;
		if(code == KeyStroke.VK_HOME.getCode()){
			if(sp.getDividerLocation() < 0){
				sp.setDividerLocation(sp.getLastDividerLocation());
			}else{
				sp.setDividerLocation(-1);
			}
			return;
		}else if(code == KeyStroke.VK_END.getCode()){
			if(sp.getDividerLocation() == AsWingConstants.MAX_VALUE){
				sp.setDividerLocation(sp.getLastDividerLocation());
			}else{
				sp.setDividerLocation(AsWingConstants.MAX_VALUE);
			}
			return;
		}
		if(code == KeyStroke.VK_LEFT.getCode() || code == KeyStroke.VK_UP.getCode()){
			dir = -1;
		}else if(code == KeyStroke.VK_RIGHT.getCode() || code == KeyStroke.VK_DOWN.getCode()){
			dir = 1;
		}
		if(e.shiftKey)	{
			dir *= 10;
		}
		sp.setDividerLocation(restrictDividerLocation(Std.int(sp.getDividerLocation() + dir)));
	}
    
    private function __div_location_changed(e:InteractiveEvent):Void{
    	layoutWithLocation(sp.getDividerLocation());
        if(sp.getDividerLocation() >= 0 && sp.getDividerLocation() != AsWingConstants.MAX_VALUE){
        	divider.setEnabled(true);
        }else{
        	divider.setEnabled(false);
        }
    }
	
	private function __div_pressed(e:MouseEvent) : Void{
		if (e.target != divider){
			pressFlag = true;
			return;
		}
		spliting = true;
		showMoveCursor();
		startDragPos = sp.getMousePosition();
		startLocation = sp.getDividerLocation();
		startDividerPos = divider.getGlobalLocation();
		sp.removeEventListener(MouseEvent.MOUSE_MOVE, __div_mouse_moving);
		sp.addEventListener(MouseEvent.MOUSE_MOVE, __div_mouse_moving);
	}

	private function __div_released(e:ReleaseEvent) : Void{
		if (e.getPressTarget() != divider) return;		
		if(pressFlag)	{
			pressFlag = false;
			return;
		}
		if(dragRepresentationMC != null && sp.contains(dragRepresentationMC)){
			sp.removeChild(dragRepresentationMC);
		}
		
		validateDivMoveWithCurrentMousePos();
		sp.removeEventListener(MouseEvent.MOUSE_MOVE, __div_mouse_moving);
		spliting = false;
		if(mouseInDividerFlag!=true){
			hideMoveCursor();
		}
	}

	private function __div_mouse_moving(e:MouseEvent) : Void{
		if(!sp.isContinuousLayout()){
			if(dragRepresentationMC == null){
				dragRepresentationMC = new Shape();
				var g:Graphics2D = new Graphics2D(dragRepresentationMC.graphics);
				paintDividerDragingRepresention(g);
			}
			if(!sp.contains(dragRepresentationMC)){
				sp.addChild(dragRepresentationMC);
			}
			var newGlobalPos:IntPoint = startDividerPos.clone();
			if(isVertical()){
				newGlobalPos.y += getCurrentMovedDistance();
			}else{
				newGlobalPos.x += getCurrentMovedDistance();
			}
			var newPoint:Point = newGlobalPos.toPoint();
			newPoint = dragRepresentationMC.parent.globalToLocal(newPoint);
			dragRepresentationMC.x = Math.round(newPoint.x);
			dragRepresentationMC.y = Math.round(newPoint.y);
			dragRepresentationMC.width = divider.width;
			dragRepresentationMC.height = divider.height;
		}else{
			validateDivMoveWithCurrentMousePos();
		}
	}
	
	private function validateDivMoveWithCurrentMousePos():Void{
		var newLocation:Int= startLocation + getCurrentMovedDistance();
		sp.setDividerLocation(newLocation);
	}
	
	private function getCurrentMovedDistance():Int{
		var mouseP:IntPoint = sp.getMousePosition();
		var delta:Int= 0;
		if(isVertical()){
			delta = mouseP.y - startDragPos.y;
		}else{
			delta = mouseP.x - startDragPos.x;
		}
		var newLocation:Int= startLocation + delta;
		newLocation = Std.int(Math.max(
			getMinimumDividerLocation(), 
			Math.min(newLocation, getMaximumDividerLocation())));
		return newLocation - startLocation;
	}
	
	private function __div_rollover(e:MouseEvent) : Void{
		mouseInDividerFlag = true;
		if(!e.buttonDown && !spliting){
			showMoveCursor();
		}
	}

	private function __div_rollout(e:Event) : Void{
		mouseInDividerFlag = false;
		if(spliting!=true){
			hideMoveCursor();
		}
	}
	
	private  var spliting:Bool;
	private var cursorManager:CursorManager;
	private function showMoveCursor():Void{
		cursorManager = CursorManager.getManager(sp.stage);
		if(isVertical()){
			cursorManager.hideCustomCursor(hSplitCursor);
			cursorManager.showCustomCursor(vSplitCursor);
		}else{
			cursorManager.hideCustomCursor(vSplitCursor);
			cursorManager.showCustomCursor(hSplitCursor);
		}
	}
	
	private function hideMoveCursor():Void{
		if(cursorManager == null){
			return;
		}
		cursorManager.hideCustomCursor(vSplitCursor);
		cursorManager.hideCustomCursor(hSplitCursor);
		cursorManager = null;
	}
    
    //-----------------------------------------------------------------------
    //                     Layout implementation
    //-----------------------------------------------------------------------
	public function addLayoutComponent(comp : Component, constraints : Dynamic) : Void{
	}

	public function removeLayoutComponent(comp : Component) : Void{
	}

	public function preferredLayoutSize(target : Container) : IntDimension {
		var insets:Insets = sp.getInsets();
    	var lc:Component = sp.getLeftComponent();
    	var rc:Component = sp.getRightComponent();
    	var lcSize:IntDimension = (lc == null ? new IntDimension() : lc.getPreferredSize());
    	var rcSize:IntDimension = (rc == null ? new IntDimension() : rc.getPreferredSize());
    	var size:IntDimension;
    	if(isVertical()){
    		size = new IntDimension(
    			Std.int(Math.max(lcSize.width, rcSize.width)), 
    			lcSize.height + rcSize.height + getDividerSize()
    		);
    	}else{
    		size = new IntDimension(
    			lcSize.width + rcSize.width + getDividerSize(), 
    			Std.int(Math.max(lcSize.height, rcSize.height))
    		);
    	}
    	return insets.getOutsideSize(size);
	}

	public function minimumLayoutSize(target : Container) : IntDimension {
		return target.getInsets().getOutsideSize();
	}

	public function maximumLayoutSize(target : Container) : IntDimension {
		return IntDimension.createBigDimension();
	}
	
	public function layoutContainer(target : Container) : Void{
		var size:IntDimension = sp.getSize();
		size = sp.getInsets().getInsideSize(size);
		var layouted:Bool= false;
		if(!size.equals(lastContentSize)){
			//re weight the split
			var deltaSize:Int= 0;
			if(isVertical()){
				deltaSize = size.height - lastContentSize.height;
			}else{
				deltaSize = size.width - lastContentSize.width;
			}
			lastContentSize = size.clone();
			var locationDelta:Int= Std.int(deltaSize*sp.getResizeWeight());
			layouted = (locationDelta != 0);
			var newLocation:Int= sp.getDividerLocation()+locationDelta;
			
			newLocation =Std.int( Math.max(
				getMinimumDividerLocation(), 
				Math.min(newLocation, getMaximumDividerLocation())));
			
			sp.setDividerLocation(newLocation, true);
		}
		if(layouted!=true){
			layoutWithLocation(sp.getDividerLocation());
		}
	}

	public function getLayoutAlignmentX(target : Container) : Float{
		return 0;
	}

	public function getLayoutAlignmentY(target : Container) : Float{
		return 0;
	}

	public function invalidateLayout(target : Container) : Void{
	}
}