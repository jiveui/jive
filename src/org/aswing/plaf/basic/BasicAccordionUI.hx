/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

	
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import org.aswing.AWKeyboard;
import org.aswing.event.AWEvent;
import org.aswing.util.Timer;
import org.aswing.LayoutManager;
	import org.aswing.JAccordion;
	import org.aswing.Component;
	import org.aswing.Insets;
	import org.aswing.FocusManager;
	import org.aswing.Container;
	import org.aswing.event.FocusKeyEvent;
import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.InsetsUIResource;
	import org.aswing.plaf.UIResource;
	import org.aswing.plaf.basic.accordion.BasicAccordionHeader;
	import org.aswing.plaf.basic.tabbedpane.Tab;

/**
 * Basic accordion ui imp.
 * @author paling
 * @private
 */
class BasicAccordionUI extends BaseComponentUI  implements LayoutManager{
	
	private static var MOTION_SPEED:Int= 50;
	
	private var accordion:JAccordion;
	private var headers:Array<Dynamic>;
	private var motionTimer:Timer;
	private var headerDestinations:Array<Dynamic>;
	private var childrenDestinations:Array<Dynamic>;
	private var childrenOrderYs:Array<Dynamic>;
	private var destSize:IntDimension;
	private var motionSpeed:Int;
	
	private var headerContainer:Sprite;
	
	public function new(){
		super();
	}
	
    override public function installUI(c:Component):Void{
    	headers = new Array<Dynamic>();
    	destSize = new IntDimension();
    	accordion = AsWingUtils.as(c,JAccordion);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override public function uninstallUI(c:Component):Void{
    	accordion = AsWingUtils.as(c,JAccordion);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
    
	private function getPropertyPrefix():String{
		return "Accordion.";
	}
	
	private function installDefaults():Void{
		accordion.setLayout(this);
		var pp:String= getPropertyPrefix();
        LookAndFeel.installBorderAndBFDecorators(accordion, pp);
        LookAndFeel.installColorsAndFont(accordion, pp);
        LookAndFeel.installBasicProperties(accordion, pp);
        motionSpeed = getInt(pp + "motionSpeed");
        if(motionSpeed <=0 || motionSpeed==0){
        	motionSpeed = MOTION_SPEED;
        }
       	var tabMargin:Insets = getInsets(pp + "tabMargin");
		if(tabMargin == null){
			tabMargin = new InsetsUIResource(1, 1, 1, 1);	
		}
		var i:Insets = accordion.getMargin();
		if (i == null || Std.is(i,UIResource)) {
	    	accordion.setMargin(tabMargin);
		}
	}
    
    private function uninstallDefaults():Void{
    	LookAndFeel.uninstallBorderAndBFDecorators(accordion);
    }
    
	private function installComponents():Void{
		headerContainer = new Sprite();
		#if(flash9)
		headerContainer.tabEnabled = false;
		#end
		accordion.addChild(headerContainer);
		synTabs();
		synHeaderProperties();
    }
    
	private function uninstallComponents():Void{
		for(i in 0...headers.length){
			var header:Tab = getHeader(i);
			headerContainer.removeChild(header.getTabComponent());
    		header.getTabComponent().removeEventListener(MouseEvent.CLICK, __tabClick);
		}
		headers.slice(0);
		accordion.removeChild(headerContainer);
    }
	
	private function installListeners():Void{
		accordion.addStateListener(__onSelectionChanged);
		accordion.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
		motionTimer = new Timer(40);
		motionTimer.addEventListener(AWEvent.ACT, __onMotion);
	}
    
    private function uninstallListeners():Void{
		accordion.removeStateListener(__onSelectionChanged);
		accordion.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onKeyDown);
		motionTimer.stop();
		motionTimer = null;
    }
    
   	override public function paintFocus(c:Component, g:Graphics2D, b:IntRectangle):Void{
    	var header:Tab = getSelectedHeader();
    	if(header != null){
    		header.getTabComponent().paintFocusRect(true);
    	}else{
    		super.paintFocus(c, g, b);
    	}
    } 
    
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
    	super.paint(c, g, b);
    }
    
    /**
     * Just override this method if you want other LAF headers.
     */
    private function createNewHeader():Tab{
    	var header:Tab = AsWingUtils.as(getInstance(getPropertyPrefix() + "header"), Tab);
    	if(header == null){
    		header = new BasicAccordionHeader();
    	}
    	header.initTab(accordion);
    	header.getTabComponent().setFocusable(false);
    	return header;
    }
        
    private function getHeader(i:Int):Tab{
    	return AsWingUtils.as(headers[i], Tab);
    }

    private function synTabs():Void{
    	var comCount:Int= accordion.getComponentCount();
    	if(comCount != headers.length){
    		var i:Int;
    		var header:Tab;
    		if(comCount > headers.length){
    			for(i  in headers.length... comCount){
    				header = createNewHeader();
    				header.setTextAndIcon(accordion.getTitleAt(i), accordion.getIconAt(i));
    				setHeaderProperties(header);
    				header.getTabComponent().setToolTipText(accordion.getTipAt(i));
    				header.getTabComponent().addEventListener(MouseEvent.CLICK, __tabClick);
    				headerContainer.addChild(header.getTabComponent());
    				headers.push(header);
    			}
    		}else{
    			for(i  in 0... headers.length-comCount){
    				header = AsWingUtils.as(headers.pop(),Tab);
    				header.getTabComponent().removeEventListener(MouseEvent.CLICK, __tabClick);
    				headerContainer.removeChild(header.getTabComponent());
    			}
    		}
    	}
    }
        
    private function synHeaderProperties():Void{
    	for(i in 0...headers.length){
    		var header:Tab = getHeader(i);
    		header.setTextAndIcon(accordion.getTitleAt(i), accordion.getIconAt(i));
    		setHeaderProperties(header);
    		header.getTabComponent().setUIElement(true);
    		header.getTabComponent().setEnabled(accordion.isEnabledAt(i));
    		header.getTabComponent().setVisible(accordion.isVisibleAt(i));
    		header.getTabComponent().setToolTipText(accordion.getTipAt(i));
    	}
    }
    
    private function setHeaderProperties(header:Tab):Void{
    	header.setHorizontalAlignment(accordion.getHorizontalAlignment());
    	header.setHorizontalTextPosition(accordion.getHorizontalTextPosition());
    	header.setIconTextGap(accordion.getIconTextGap());
    	header.setMargin(accordion.getMargin());
    	header.setVerticalAlignment(accordion.getVerticalAlignment());
    	header.setVerticalTextPosition(accordion.getVerticalTextPosition());
    	header.setFont(accordion.getFont());
    	header.setForeground(accordion.getForeground());
    }
    
    private function ensureHeadersOnTopDepths():Void{
    	accordion.bringToTop(headerContainer);
    }
    
    private function getSelectedHeader():Tab{
    	if(accordion.getSelectedIndex() >= 0){
    		return getHeader(accordion.getSelectedIndex());
    	}else{
    		return null;
    	}
    }
    
    private function indexOfHeaderComponent(tab:Component):Int{
    	for(i in 0...headers.length){
    		if(getHeader(i).getTabComponent() == tab){
    			return i;
    		}
    	}
    	return -1;
    }
    
    //------------------------------Handlers--------------------------------
    
    private function __tabClick(e:Event):Void{
    	accordion.setSelectedIndex(indexOfHeaderComponent(AsWingUtils.as(e.currentTarget,Component)	));
    }
    
    private function __onSelectionChanged(e:Event):Void{
    	accordion.revalidate();
    	accordion.repaint();
    }
    
    private function __onKeyDown(e:FocusKeyEvent):Void{
    	if(headers.length > 0){
    		var n:Int= accordion.getComponentCount();
    		var code:Int= e.keyCode;
    		var index:Int;
	    	if(code == AWKeyboard.DOWN){
	    		setTraversingTrue();
		    	index = accordion.getSelectedIndex();
		    	index++;
		    	while(index<n && (!accordion.isEnabledAt(index) || !accordion.isVisibleAt(index))){
		    		index++;
		    	}
		    	if(index >= n){
		    		return;
		    	}
		    	accordion.setSelectedIndex(index);
	    	}else if(code == AWKeyboard.UP){
	    		setTraversingTrue();
		    	index = accordion.getSelectedIndex();
		    	index--;
		    	while(index >= 0 && (!accordion.isEnabledAt(index) || !accordion.isVisibleAt(index))){
		    		index--;
		    	}
		    	if(index < 0){
		    		return;
		    	}
		    	accordion.setSelectedIndex(index);
	    	}
    	}
    }
    
    private function setTraversingTrue():Void{
    	var fm:FocusManager = FocusManager.getManager(accordion.stage);
    	if(fm!=null)	{
    		fm.setTraversing(true);
    	}
    }
    
    private function __onMotion(e:AWEvent):Void{
    	var isFinished:Bool= true;
    	var n:Int= headerDestinations.length;
    	var selected:Int= accordion.getSelectedIndex();
    	var i:Int= 0;
    	var child:Component;
    	
    	for(i in 0...n){
    		var header:Tab = getHeader(i);
    		var tab:Component = header.getTabComponent();
    		var curY:Int= tab.getY();
    		var desY:Int= headerDestinations[i];
    		var toY:Int;
    		if(Math.abs(desY - curY) <= motionSpeed){
    			toY = desY;
    		}else{
    			if(desY > curY){
    				toY = curY + motionSpeed;
    			}else{
    				toY = curY - motionSpeed;
    			}
    			isFinished = false;
    		}
    		tab.setLocationXY(tab.getX(), toY);
    		tab.validate();
    		child = accordion.getComponent(i);
    		child.setLocationXY(child.getX(), toY + tab.getHeight());
    	}
    	
    	adjustClipSizes();
    	
    	if(isFinished)	{
    		motionTimer.stop();
    		for(i in 0...n){
	    		child = accordion.getComponent(i);
	    		if(selected == i){
	    			child.setVisible(true);
	    		}else{
	    			child.setVisible(false);
	    		}
    		}
    	}
    	
    	for(i in 0...n){
    		child = accordion.getComponent(i);
    		child.validate();
    	}
    	//if(e != null) e.updateAfterEvent();
    }
    
    private function adjustClipSizes():Void{
    	var n:Int= headerDestinations.length;
    	for(i in 0...n){
    		var child:Component = accordion.getComponent(i);
    		var orderY:Int= childrenOrderYs[i];
    		if(child.isVisible()){
    			child.setClipSize(new IntDimension(destSize.width, destSize.height - (child.getY()-orderY)));
    		}
    	}
    }
    
	//---------------------------LayoutManager Imp-------------------------------
	
	public function addLayoutComponent(comp:Component, constraints:Dynamic):Void{
		synTabs();
	}
	
	public function removeLayoutComponent(comp:Component):Void{
		synTabs();
	}
	
	public function invalidateLayout(target:Container):Void{
	}
	
	public function layoutContainer(target:Container):Void{
    	synHeaderProperties();
    	
    	var insets:Insets = accordion.getInsets();
    	var i:Int= 0;
    	var x:Int= insets.left;
    	var y:Int= insets.top;
    	var w:Int= accordion.getWidth() - x - insets.right;
    	var h:Int= accordion.getHeight() - y - insets.bottom;
		var header:Tab;
		var tab:Component;
		var size:IntDimension;
		
    	var count:Int= accordion.getComponentCount();
    	var selected:Int= accordion.getSelectedIndex();
    	if(selected < 0){
    		if(count > 0){
    			accordion.setSelectedIndex(0);
    		}
    		return;
    	}
    	
    	headerDestinations = new Array<Dynamic>();
    	childrenOrderYs = new Array<Dynamic>();
    	
    	var vX:Int, vY:Int, vWidth:Int, vHeight:Int;
    	vHeight = h;
    	vWidth = w;
    	vX = x;
    	for(i in 0...selected+1){
    		if (!accordion.isVisibleAt(i)) continue;
    		header = getHeader(i);
    		tab = header.getTabComponent();
    		size = tab.getPreferredSize();
    		tab.setSizeWH(w, size.height);
    		tab.setLocationXY(x, tab.getY());
    		accordion.getComponent(i).setLocationXY(x, tab.getY()+size.height);
    		headerDestinations[i] = y;
    		y += size.height;
    		childrenOrderYs[i] = y;
    		vHeight -= size.height;
    		if(i == selected){
    			header.setSelected(true);
    			accordion.getComponent(i).setVisible(true);
    		}else{
    			header.setSelected(false);
    		}
    		tab.validate();
    	}
    	vY = y;
		// 	for(i=selected+1; i<count; i++){
    	for(i in selected+1...count){
    		if (!accordion.isVisibleAt(i)) continue;
    		header = getHeader(i);
    		tab = header.getTabComponent();
    		y += tab.getPreferredSize().height;
    		childrenOrderYs[i] = y;
    	}
    	
    	y = accordion.getHeight() - insets.bottom;
		//	for(i=count-1; i>selected; i--){
		i=count-1;
    	while(i>selected){
    		if (!accordion.isVisibleAt(i)) continue;
    		header = getHeader(i);
    		tab = header.getTabComponent();
    		size = tab.getPreferredSize();
    		y -= size.height;
    		headerDestinations[i] = y;
    		tab.setSizeWH(w, size.height);
    		tab.setLocationXY(x, tab.getY());
    		accordion.getComponent(i).setLocationXY(x, tab.getY()+size.height);
    		header.setSelected(false);
    		vHeight -= size.height;
    		tab.validate();
			i--;
    	}
    	destSize.setSizeWH(vWidth, vHeight);
    	for(i in 0...count){
    		if (!accordion.isVisibleAt(i)) continue;
    		if(accordion.getComponent(i).isVisible()){
    			accordion.getComponent(i).setSize(destSize);
    		}
    	}
    	motionTimer.start();
    	__onMotion(null);
    	ensureHeadersOnTopDepths();
	}
	
	public function preferredLayoutSize(target:Container):IntDimension{
    	if(target == accordion){
    		synHeaderProperties();
    		
	    	var insets:Insets = accordion.getInsets();
	    	
	    	var w:Int= 0;
	    	var h:Int= 0;
	    	var i:Int= 0;
	    	var size:IntDimension;
	    	
	    	for(i in 0...accordion.getComponentCount() ){
	    		size = accordion.getComponent(i).getPreferredSize();
	    		w = Std.int(Math.max(w, size.width));
	    		h = Std.int(Math.max(h, size.height));
	    	}
	    	
	    	for(i in 0...accordion.getComponentCount() ){
	    		size = getHeader(i).getTabComponent().getPreferredSize();
	    		w = Std.int(Math.max(w, size.width));
	    		h += size.height;
	    	}
	    	
	    	return insets.getOutsideSize(new IntDimension(w, h));
    	}
    	return null;
	}
	
	public function minimumLayoutSize(target:Container):IntDimension{
    	if(target == accordion){
    		synHeaderProperties();
    		
	    	var insets:Insets = accordion.getInsets();
	    	
	    	var w:Int= 0;
	    	var h:Int= 0;
	    	var i:Int= 0;
	    	var size:IntDimension;
	    	
	    	for(i in 0...accordion.getComponentCount() ){
	    		size = accordion.getComponent(i).getMinimumSize();
	    		w = Std.int(Math.max(w, size.width));
	    		h = Std.int(Math.max(h, size.height));
	    	}
	    	
	    	for(i in 0...accordion.getComponentCount() ){
	    		size = getHeader(i).getTabComponent().getMinimumSize();
	    		w = Std.int(Math.max(w, size.width));
	    		h += size.height;
	    	}
	    	
	    	return insets.getOutsideSize(new IntDimension(w, h));
    	}
    	return null;
	}
	
	public function maximumLayoutSize(target:Container):IntDimension
	{
		return IntDimension.createBigDimension();
	}
	
	public function getLayoutAlignmentX(target:Container):Float{
		return 0;
	}
	
	public function getLayoutAlignmentY(target:Container):Float{
		return 0;
	}
	
	override public function getMaximumSize(c:Component):IntDimension{
		return maximumLayoutSize(accordion);
	}
	
	override public function getMinimumSize(c:Component):IntDimension{
		return minimumLayoutSize(accordion);
	}
	
	override public function getPreferredSize(c:Component):IntDimension{
		return preferredLayoutSize(accordion);
	}	
	
}