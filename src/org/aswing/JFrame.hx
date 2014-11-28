/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import flash.display.StageScaleMode;
import org.aswing.error.Error;
import flash.events.Event;
import flash.events.MouseEvent;

import org.aswing.event.PropertyChangeEvent;
	import org.aswing.event.FrameEvent;
	import org.aswing.event.MovedEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.plaf.ComponentUI;
	import org.aswing.plaf.FrameUI;
	import org.aswing.plaf.basic.BasicFrameUI;
import org.aswing.resizer.Resizer;
	import org.aswing.resizer.ResizerController;
	import org.aswing.plaf.DefaultEmptyDecoraterResource;
	/**
 * Dispatched when the frame's state changed. the state is all about:
 * <ul>
 * <li>NORMAL</li>
 * <li>ICONIFIED</li>
 * <li>MAXIMIZED</li>
 * <li>MAXIMIZED_HORIZ</li>
 * <li>MAXIMIZED_VERT</li>
 * </ul>
 * </p>
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * Dispatched when the frame be iconified.
 * @eventType org.aswing.event.FrameEvent.FRAME_ICONIFIED
 */
// [Event(name="frameIconified", type="org.aswing.event.FrameEvent")]
	
/**
 * Dispatched when the frame be restored.
 * @eventType org.aswing.event.FrameEvent.FRAME_RESTORED
 */
// [Event(name="frameRestored", type="org.aswing.event.FrameEvent")]

/**
 * Dispatched when the frame be maximized.
 * @eventType org.aswing.event.FrameEvent.FRAME_MAXIMIZED
 */
// [Event(name="frameMaximized", type="org.aswing.event.FrameEvent")]

/**
 * Dispatched when the frame is closing by user.
 * @eventType org.aswing.event.FrameEvent.FRAME_CLOSING
 */
// [Event(name="frameClosing", type="org.aswing.event.FrameEvent")]

/**
 * Dispatched When the frame's ability changed. Include:
 * <ul>
 * <li> resizable </li>
 * <li> closable </li>
 * <li> dragable </li>
 * </ul>
 * @eventType org.aswing.event.FrameEvent.FRAME_ABILITY_CHANGED
 */
// [Event(name="frameAbilityChanged", type="org.aswing.event.FrameEvent")]

/**
 * JFrame is a window with title and maximized/iconified/normal state, and resizer. 
 * @author paling
 */
class JFrame extends JWindow{
		
	/**
	 * @see #setState()
	 */
	inline public static var NORMAL:Int= 0; //0
	/**
	 * @see #setState()
	 */
	inline public static var ICONIFIED:Int= 2; //10
	/**
	 * @see #setState()
	 */
	inline public static var MAXIMIZED_HORIZ:Int= 4;  //100
	/**
	 * @see #setState()
	 */
	inline public static var MAXIMIZED_VERT:Int= 8;  //1000
	/**
	 * @see #setState()
	 */
	inline public static var MAXIMIZED:Int= 12;  //1100
	//-----------------------------------------
	
	/**
	 * @see #setDefaultCloseOperation()
	 */
	inline public static var DO_NOTHING_ON_CLOSE:Int= 0;
	/**
	 * @see #setDefaultCloseOperation()
	 */
	inline public static var HIDE_ON_CLOSE:Int= 1;
	/**
	 * @see #setDefaultCloseOperation()
	 */
	inline public static var DISPOSE_ON_CLOSE:Int= 2;
	
	/**
	 * For title bar changed event property name.
	 */
	inline public static var PROPERTY_TITLE_BAR:String= "titleBar";
	//--------------------------------------------------------
	
	private var titleBar:FrameTitleBar;
	private var title:String;
	private var icon:Icon;
	private var state:Int;
	private var defaultCloseOperation:Int;
	private var maximizedBounds:IntRectangle;
	private var lastNormalStateBounds:IntRectangle;
	
	private var dragable:Bool;
	private var resizable:Bool;
	private var closable:Bool;
	private var dragDirectly:Bool;
	private var dragDirectlySet:Bool;
	
	private var resizer:Resizer;
	private var resizerController:ResizerController;
	
	/**
	 * Create a JWindow
	 * @param owner the owner of this popup, it can be a DisplayObjectContainer or a JPopup, default it is default 
	 * is <code>AsWingManager.getRoot()</code>
	 * @param title the title, default is "".
	 * @param modal true for a modal dialog, false for one that allows other windows to be active at the same time,
	 *  default is false.
	 * @see org.aswing.AsWingManager#getRoot()
	 * @throw AsWingManagerNotInited if not specified the owner, and aswing default root is not specified either.
	 * @throw TypeError if the owner is not a JPopup nor DisplayObjectContainer
	 */	
	public function new(owner:Dynamic=null, title:String="", modal:Bool=false) {
		super(owner, modal);
		setClipMasked(true);
		this.title = title;
		
		state = NORMAL;
		defaultCloseOperation = DISPOSE_ON_CLOSE;
		dragable  = true;
		resizable = true;
		closable  = true;
		icon = DefaultEmptyDecoraterResource.INSTANCE;
		lastNormalStateBounds = new IntRectangle(0, 0, 200, 100);
		setName("JFrame");
		addEventListener(Event.ADDED_TO_STAGE, __frameAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, __frameRemovedFromStage);
		addEventListener(MovedEvent.MOVED, __frameMoved,false,0,false);
		updateUI();
		setTitleBar(new JFrameTitleBar());
		
	}
	
	override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }
	
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicFrameUI;
    }
    
	
	/**
	 * Sets the ui.
	 * <p>
	 * JFrame ui should implemented <code>FrameUI</code> interface!
	 * </p>
	 * @param newUI the newUI
	 * @throws ArgumentError when the newUI is not an <code>FrameUI</code> instance.
	 */
    override public function setUI(newUI:ComponentUI):Void{
    	if(Std.is(newUI,FrameUI)){
    		super.setUI(newUI);
    	}else{
    		throw new Error("JFrame just accept FrameUI instance!!!");
			 
    	}
    }
    
    public function getTitleBar():FrameTitleBar{
    	return titleBar;
    }
    
    public function setTitleBar(t:FrameTitleBar):Void{
    	if(titleBar != t){
    		var old:FrameTitleBar = titleBar;
    		if(titleBar!=null)	{
    			titleBar.setFrame(null);
    			remove(titleBar.getSelf());
    		}
    		titleBar = t;
    		if(titleBar!=null)	{
    			titleBar.setText(getTitle());
    			titleBar.setIcon(getIcon());
	    		insert(0, titleBar.getSelf(), WindowLayout.TITLE);
	    		titleBar.setFrame(this);
    		}
    		dispatchEvent(new PropertyChangeEvent(PROPERTY_TITLE_BAR, old, t));
    	}
    }
    
    /**
     * Returns the ui for this frame with <code>FrameUI</code> instance
     * @return the frame ui.
     */
    public function getFrameUI():FrameUI{
    	return AsWingUtils.as(getUI() , FrameUI);
    }
    
	override public function getUIClassID():String{
		return "FrameUI";
	}
		
	/**
	 * Sets the text to be displayed in the title bar for this frame.
	 * @param t the text to be displayed in the title bar, 
	 * null to display no text in the title bar.
	 */
	public function setTitle(t:String):Void{
		if(title != t){
			title = t;
			if(getTitleBar()!=null){
				getTitleBar().setText(t);
			}
			repaint();
			revalidate();
		}
	}
	
	/**
	 * Returns the text displayed in the title bar for this frame.
	 * @return the text displayed in the title bar for this frame.
	 */
	public function getTitle():String{
		return title;
	}
	
	/**
	 * Sets the icon to be displayed in the title bar for this frame.
	 * @param ico the icon to be displayed in the title bar, 
	 * null to display no icon in the title bar.
	 */	
	public function setIcon(ico:Icon):Void{
		if(icon != ico){
			icon = ico;
			if(getTitleBar()!=null){
				getTitleBar().setIcon(ico);
			}
			repaint();
			revalidate();
		}
	}
	
	/**
	 * Returns the icon displayed in the title bar for this frame.
	 * @return the icon displayed in the title bar for this frame.
	 */
	public function getIcon():Icon{
		return icon;
	}
		
	/**
	 * Sets whether this frame is resizable by the user.
	 * 
	 * <p>"resizable" means include capability of restore normal resize, maximize, iconified and resize by drag.
	 * @param b true user can resize the frame by click resize buttons or drag to scale the frame, false user can't.
	 * @see #isResizable()
	 */
	public function setResizable(b:Bool):Void{
		if(resizable != b){
			resizable = b;
			getResizer().setEnabled(b);
			repaint();
			dispatchEvent(new FrameEvent(FrameEvent.FRAME_ABILITY_CHANGED, true));
		}
	}
	
	/**
	 * Returns whether this frame is resizable by the user. By default, all frames are initially resizable. 
	 * 
	 * <p>"resizable" means include capability of restore normal resize, maximize, iconified and resize by drag.
	 * @see #setResizable()
	 */
	public function isResizable():Bool{
		return resizable;
	}
	
	/**
	 * Sets whether this frame can be dragged by the user.  By default, it's true.
	 * 
	 * <p>"dragable" means drag to move the frame.
	 * @param b 
	 * @see #isDragable()
	 */
	public function setDragable(b:Bool):Void{
		if(dragable != b){
			dragable = b;
			repaint();
			revalidate();
			dispatchEvent(new FrameEvent(FrameEvent.FRAME_ABILITY_CHANGED, true));
		}
	}
	
	/**
	 * Returns whether this frame can be dragged by the user. By default, it's true.
	 * @see #setDragnable()
	 */
	public function isDragable():Bool{
		return dragable;
	}
	

	/**
	 * Sets whether this frame can be closed by the user. By default, it's true.
	 * Whether the frame will be hide or dispose, depend on the value returned by <code>getDefaultCloseOperation</code>.
	 * @param b true user can click close button to generate the close event, false user can't.
	 * @see #getClosable()
	 */	
	public function setClosable(b:Bool):Void{
		if(closable != b){
			closable = b;
			repaint();
			dispatchEvent(new FrameEvent(FrameEvent.FRAME_ABILITY_CHANGED, true));
		}
	}
	
	/**
	 * Returns whether this frame can be closed by the user. By default, it's true.
	 * @see #setClosable()
	 */		
	public function isClosable():Bool{
		return closable;
	}
	
	/**
	 * Only did effect when state is <code>NORMAL</code>
	 */
	override public function pack():Void{
		if(getState() == NORMAL){
			super.pack();
		}
	}
	
	/**
	 * Gets maximized bounds for this frame.<br>
	 * If the maximizedBounds was setted by setMaximizedBounds it will return the setted value.
	 * else if the owner is a JWindow it will return the owner's content pane's bounds, if
	 * the owner is a movieclip it will return the movie's stage bounds.
	 */
	public function getMaximizedBounds():IntRectangle{
		if(maximizedBounds == null){
			var b:IntRectangle = AsWingUtils.getVisibleMaximizedBounds(this.parent);
			return getInsets().getOutsideBounds(b);
		}else{
			return maximizedBounds.clone();
		}
	}
	
	/**
	 * Sets the maximized bounds for this frame. 
	 * <br>
	 * @param b bounds for the maximized state, null to back to use default bounds descripted in getMaximizedBounds's comments.
	 * @see #getMaximizedBounds()
	 */
	public function setMaximizedBounds(b:IntRectangle):Void{
		if(b != null){
			maximizedBounds = b.clone();
			revalidate();
		}else{
			maximizedBounds = null;
		}
	}	

    /**                   
     * Sets the operation that will happen by default when
     * the user initiates a "close" on this frame.
     * You must specify one of the following choices:
     * <p>
     * <ul>
     * <li><code>DO_NOTHING_ON_CLOSE</code>
     * (defined in <code>WindowConstants</code>):
     * Don't do anything; require the
     * program to handle the operation in the <code>windowClosing</code>
     * method of a registered EventListener object.
     *
     * <li><code>HIDE_ON_CLOSE</code>
     * (defined in <code>WindowConstants</code>):
     * Automatically hide the frame after
     * invoking any registered EventListener objects.
     *
     * <li><code>DISPOSE_ON_CLOSE</code>
     * (defined in <code>WindowConstants</code>):
     * Automatically hide and dispose the 
     * frame after invoking any registered EventListener objects.
     * </ul>
     * <p>
     * The value is set to <code>DISPOSE_ON_CLOSE</code> by default.
     * if you set a value is not three of them, think of it is will be changed to default value.
     * @param operation the operation which should be performed when the
     *        user closes the frame
     * @see org.aswing.Component#addEventListener()
     * @see #getDefaultCloseOperation()
     */
    public function setDefaultCloseOperation(operation:Int):Void{
    	if(operation != DO_NOTHING_ON_CLOSE 
    		&& operation != HIDE_ON_CLOSE
    		&& operation != DISPOSE_ON_CLOSE)
    	{
    			operation = DISPOSE_ON_CLOSE;
    	}
    	defaultCloseOperation = operation;
    }
    
	/**
	 * Returns the operation that will happen by default when
     * the user initiates a "close" on this frame.
	 * @see #setDefaultCloseOperation()
	 */
	public function getDefaultCloseOperation():Int{
		return defaultCloseOperation;
	}
	
	public function setState(s:Int, programmatic:Bool=true):Void{
		if(state != s){
			if(state == NORMAL){
				lastNormalStateBounds.setRect(getComBounds());
			}
			state = s;
			fireStateChanged();
			if(state == ICONIFIED){
				precessIconified(programmatic);
			}else if(((state & MAXIMIZED_HORIZ) == MAXIMIZED_HORIZ) || ((state & MAXIMIZED_VERT) == MAXIMIZED_VERT)){
				precessMaximized(programmatic);
			}else{
				precessRestored(programmatic);
			}
			doStateChange();
		}
	}
	
	private function isMaximized():Bool{
		return ((state & MAXIMIZED_HORIZ) == MAXIMIZED_HORIZ)
			|| ((state & MAXIMIZED_VERT) == MAXIMIZED_VERT);
	}
	
	
	private function doStateChange():Void{
		if(state == ICONIFIED){
			var iconifiedSize:IntDimension = new IntDimension(60, 20);
			if(titleBar!=null)	{
				iconifiedSize = titleBar.getSelf().getMinimumSize();
			}
			setSize(getInsets().getOutsideSize(iconifiedSize));
    		var frameMaxBounds:IntRectangle = getMaximizedBounds();
			if(x < frameMaxBounds.x){
				x = frameMaxBounds.x;
			}
		}else if(state == NORMAL){
			setBounds(lastNormalStateBounds);
		}else{
			setSizeToFixMaxmimized();
		}
		if(getResizer() != null){
			getResizer().setEnabled(isResizable() && state == JFrame.NORMAL);
		}
		revalidateIfNecessary();
	}
	
	private function __frameMoved(e:MovedEvent):Void{
		if(state == ICONIFIED){
			lastNormalStateBounds.setLocation(e.getNewLocation());
		}
	}
	
	private function __frameAddedToStage(e:Event):Void{
		AsWingManager.getStage().addEventListener(Event.RESIZE, __frameStageResized, false, 0, false);
	}
	
	private function __frameRemovedFromStage(e:Event):Void{
		//why
		if(AsWingManager.getStage() != null)	AsWingManager.getStage().removeEventListener(Event.RESIZE, __frameStageResized);
	}
	
	private function __frameStageResized(e:Event=null):Void{
		if(stage == null || AsWingManager.getStage().scaleMode != StageScaleMode.NO_SCALE){
			return;
		}
		if(isMaximized()){
			setSizeToFixMaxmimized();
			revalidateIfNecessary();
		}
	}
	
	private function setSizeToFixMaxmimized():Void{
		var maxBounds:IntRectangle = getMaximizedBounds();
		var b:IntRectangle = getComBounds();
		if((state & MAXIMIZED_HORIZ) == MAXIMIZED_HORIZ){
			b.x = maxBounds.x;
			b.width = maxBounds.width;
		}
		if((state & JFrame.MAXIMIZED_VERT) == JFrame.MAXIMIZED_VERT){
			b.y = maxBounds.y;
			b.height = maxBounds.height;
		}
		setBounds(b);
	}
		
	/**
	 * Do the precesses when iconified.
	 */
	private function precessIconified(programmatic:Bool=true):Void{
		doSubPopusVisible();
		dispatchEvent(new FrameEvent(FrameEvent.FRAME_ICONIFIED, programmatic));
	}
	/**
	 * Do the precesses when restored.
	 */
	private function precessRestored(programmatic:Bool=true):Void{
		doSubPopusVisible();
		dispatchEvent(new FrameEvent(FrameEvent.FRAME_RESTORED, programmatic));
	}
	/**
	 * Do the precesses when maximized.
	 */
	private function precessMaximized(programmatic:Bool=true):Void{
		doSubPopusVisible();
		dispatchEvent(new FrameEvent(FrameEvent.FRAME_MAXIMIZED, programmatic));
	}
	
	private function doSubPopusVisible():Void{
		var owneds:Array<Dynamic>= getOwnedEquipedPopups();
		for(i in 0...owneds.length){
			var pop:JPopup = owneds[i];
			pop.getGroundContainer().visible = pop.shouldGroundVisible();
		}
	}
		
	override public function shouldOwnedPopupGroundVisible(popup:JPopup):Bool{
		if(getState() == ICONIFIED){
			return false;
		}
		return super.shouldOwnedPopupGroundVisible(popup);
	}
	
	public function getState():Int{
		return state;
	}
	
	public function setResizer(r:Resizer):Void{
		if(r != resizer){
			resizer = r;
			if(resizerController == null){
				resizerController = ResizerController.create(this, r);
			}else{
				resizerController.setResizer(resizer);
			}
			resizerController.setResizable(isResizable());
		}
	}
	
	public function getResizer():Resizer{
		return resizer;
	}
	
	/**
	 * Indicate whether need resize frame directly when drag the resizer arrow.
	 * if set to false, there will be a rectange to represent then size what will be resized to.
	 * if set to true, the frame will be resize directly when drag, but this is need more cpu counting.<br>
	 * Default is false.
	 * @see org.aswing.Resizer#setResizeDirectly()
	 */
	public function setResizeDirectly(b:Bool):Void{
		if(resizerController!=null)	{
			resizerController.setResizeDirectly(b);
		}
	}
	
	/**
	 * Return whether need resize frame directly when drag the resizer arrow.
	 * @see #setResizeDirectly()
	 */
	public function isResizeDirectly():Bool{
		if(resizerController!=null)	{
			return resizer.isResizeDirectly();
		}else{
			return false;
		}
	}
	
	/**
	 * Indicate whether need move frame directly when drag the frame.
	 * if set to false, there will be a rectange to represent then bounds what will be move to.
	 * if set to true, the frame will be move directly when drag, but this is need more cpu counting.<br>
	 * Default is false.
	 */	
	public function setDragDirectly(b:Bool):Void{
		dragDirectly = b;
		setDragDirectlySet(true);
	}
	
	/**
	 * Return whether need move frame directly when drag the frame.
	 * @see #setDragDirectly()
	 */	
	public function isDragDirectly():Bool{
		return dragDirectly;
	}
	
	/**
	 * Sets is dragDirectly property is set by user.
	 */
	public function setDragDirectlySet(b:Bool):Void{
		dragDirectlySet = b;
	}
	
	/**
	 * Return is dragDirectly property is set by user.
	 */	
	public function isDragDirectlySet():Bool{
		return dragDirectlySet;
	}
	
	/**
	 * User pressed close button to close the Frame depend on the <code>defaultCloseOperation</code>
	 * <p>
	 * This method will fire a <code>FrameEvent.FRAME_CLOSING</code> event.
	 * </p>
	 * @see #tryToClose()
	 */
	public function closeReleased():Void{
		dispatchEvent(new FrameEvent(FrameEvent.FRAME_CLOSING, false));
		tryToClose();
	}
	
	/**
	 * Try to close the Frame depend on the <code>defaultCloseOperation</code>
	 * @see #closeReleased()
	 */
	public function tryToClose():Void{
		if(defaultCloseOperation == HIDE_ON_CLOSE){
			hide();
		}else if(defaultCloseOperation == DISPOSE_ON_CLOSE){
			dispose();
			 
		}		
	}
	 
	private function fireStateChanged(programmatic:Bool=true):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
	}
	
	override private function initModalMC():Void{
		super.initModalMC();
		getModalMC().addEventListener(MouseEvent.MOUSE_DOWN, __flashModelFrame);
	}
	
	private function __flashModelFrame(e:MouseEvent):Void{
		if(getFrameUI() != null){
			getFrameUI().flashModalFrame();
		}
	}
}
