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
 * `JFrame` is a window with title and maximized/iconified/normal state, and resizer.
 * @author paling
 */
@:event("org.aswing.event.InteractiveEvent.STATE_CHANGED", "Dispatched when the frame's state changed")
@:event("org.aswing.event.FrameEvent.FRAME_ICONIFIED", "Dispatched when the frame be iconified")
@:event("org.aswing.event.FrameEvent.FRAME_RESTORED", "Dispatched when the frame be restored")
@:event("org.aswing.event.FrameEvent.FRAME_MAXIMIZED", "Dispatched when the frame be maximized")
@:event("org.aswing.event.FrameEvent.FRAME_CLOSING", "Dispatched when the frame is closing by user")
@:event("org.aswing.event.FrameEvent.FRAME_ABILITY_CHANGED", "Dispatched When the frame's ability (resizeable, closable, dragable) changed")
@:event("", "")
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
	
    public var titleBar(get, set): FrameTitleBar;
    private var _titleBar: FrameTitleBar;
    private function get_titleBar(): FrameTitleBar { return getTitleBar(); }
    private function set_titleBar(v: FrameTitleBar): FrameTitleBar { setTitleBar(v); return v; }

    /**
	 * The text to be displayed in the title bar for this frame.
	 *
	 * null to display no text in the title bar.
	 */
    public var title(get, set): String;
    private var _title: String;
    private function get_title(): String { return getTitle(); }
    private function set_title(v: String): String { setTitle(v); return v; }

    /**
	 * The icon to be displayed in the title bar for this frame.
	 *
	 * null to display no icon in the title bar.
	 */
    public var icon(get, set): Icon;
    private var _icon: Icon;
    private function get_icon(): Icon { return getIcon(); }
    private function set_icon(v: Icon): Icon { setIcon(v); return v; }

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
    public var defaultCloseOperation(get, set): Int;
    private var _defaultCloseOperation: Int;
    private function get_defaultCloseOperation(): Int { return getDefaultCloseOperation(); }
    private function set_defaultCloseOperation(v: Int): Int {
        setDefaultCloseOperation(v);
        return v;
    }

    private var state:Int;
	private var maximizedBounds:IntRectangle;
	private var lastNormalStateBounds:IntRectangle;

    /**
	 * Whether this frame can be dragged by the user.  By default, it's true.
	 *
	 * "dragable" means drag to move the frame.
	 */
    public var dragable(get, set): Bool;
    private var _dragable: Bool;
    private function get_dragable(): Bool { return isDragable(); }
    private function set_dragable(v: Bool): Bool { setDragable(v); return v; }

    /**
	 * Whether this frame is resizable by the user.
	 *
	 * <p>"resizable" means include capability of restore normal resize, maximize, iconified and resize by drag.
	 */
    public var resizable(get, set): Bool;
    private var _resizable: Bool;
    private function get_resizable(): Bool { return isResizable(); }
    private function set_resizable(v: Bool): Bool { setResizable(v); return v; }

    /**
	 * Whether this frame can be closed by the user. By default, it's true.
	 *
	 * Whether the frame will be hide or dispose, depend on the value returned by <code>this.getDefaultCloseOperation</code>.
	 */
    public var closable(get, set): Bool;
    private var _closable: Bool;
    private function get_closable(): Bool { return isClosable(); }
    private function set_closable(v: Bool): Bool { setClosable(v); return v; }

    /**
	 * Indicate whether need move frame directly when drag the frame.
	 *
	 * if set to false, there will be a rectange to represent then bounds what will be move to.
	 * if set to true, the frame will be move directly when drag, but this is need more cpu counting.<br>
	 * Default is false.
	 */
    public var dragDirectly(get, set): Bool;
    private var _dragDirectly: Bool;
    private function get_dragDirectly(): Bool { return isDragDirectly(); }
    private function set_dragDirectly(v: Bool): Bool { setDragDirectly(v); return v; }

    /**
	 * Whether dragDirectly property is set by user.
	 */
    public var dragDirectlySet(get, set): Bool;
    private var _dragDirectlySet: Bool;
    private function get_dragDirectlySet(): Bool { return isDragDirectlySet(); }
    private function set_dragDirectlySet(v: Bool): Bool { setDragDirectlySet(v); return v; }
	
	private var resizer:Resizer;
	private var resizerController:ResizerController;
	
	/**
	 * Create a `JWindow`
	 * @param owner the owner of this popup, it can be a `DisplayObjectContainer` or a `JPopup`, default it is default
	 * is <code>AsWingManager.getRoot()</code>
	 * @param title the title, default is "".
	 * @param modal true for a modal dialog, false for one that allows other windows to be active at the same time,
	 *  default is false.
	 * @see org.aswing.AsWingManager#getRoot()
	 * @throws AsWingManagerNotInited if not specified the owner, and aswing default root is not specified either.
	 * @throws TypeError if the owner is not a JPopup nor DisplayObjectContainer
	 */	
	public function new(owner:Dynamic=null, title:String="", modal:Bool=false) {
		super(owner, modal);
		setClipMasked(true);
		this._title = title;
		
		state = NORMAL;
		_defaultCloseOperation = DISPOSE_ON_CLOSE;
		_dragable  = true;
		_resizable = true;
		_closable  = true;
		_icon = DefaultEmptyDecoraterResource.INSTANCE;
		lastNormalStateBounds = new IntRectangle(0, 0, 200, 100);
		setName("JFrame");
		addEventListener(Event.ADDED_TO_STAGE, __frameAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, __frameRemovedFromStage);
		addEventListener(MovedEvent.MOVED, __frameMoved,false,0,false);
		updateUI();
		setTitleBar(new JFrameTitleBar());
		
	}
	
	@:dox(hide)
    override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }

    @:dox(hide)
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
    @:dox(hide)
    override public function setUI(newUI:ComponentUI):Void{
    	if(Std.is(newUI,FrameUI)){
    		super.setUI(newUI);
    	}else{
    		throw new Error("JFrame just accept FrameUI instance!!!");
			 
    	}
    }
    
    @:dox(hide)
    public function getTitleBar():FrameTitleBar{
    	return _titleBar;
    }

    @:dox(hide)
    public function setTitleBar(t:FrameTitleBar):Void{
    	if(_titleBar != t){
    		var old:FrameTitleBar = _titleBar;
    		if(_titleBar!=null)	{
    			_titleBar.setFrame(null);
    			remove(_titleBar.getSelf());
    		}
    		_titleBar = t;
    		if(_titleBar!=null)	{
    			_titleBar.setText(getTitle());
    			_titleBar.setIcon(getIcon());
	    		insert(0, _titleBar.getSelf(), WindowLayout.TITLE);
	    		_titleBar.setFrame(this);
    		}
    		dispatchEvent(new PropertyChangeEvent(PROPERTY_TITLE_BAR, old, t));
    	}
    }
    
    /**
     * Returns the ui for this frame with <code>FrameUI</code> instance
     * @return the frame ui.
     */
    @:dox(hide)
    public function getFrameUI():FrameUI{
    	return AsWingUtils.as(getUI() , FrameUI);
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "FrameUI";
	}
		
	/**
	 * Sets the text to be displayed in the title bar for this frame.
	 * @param t the text to be displayed in the title bar, 
	 * null to display no text in the title bar.
	 */
    @:dox(hide)
	public function setTitle(t:String):Void{
		if(_title != t){
			_title = t;
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
    @:dox(hide)
	public function getTitle():String{
		return _title;
	}
	
	/**
	 * Sets the icon to be displayed in the title bar for this frame.
	 * @param ico the icon to be displayed in the title bar, 
	 * null to display no icon in the title bar.
	 */
    @:dox(hide)
	public function setIcon(ico:Icon):Void{
		if(_icon != ico){
			_icon = ico;
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
    @:dox(hide)
	public function getIcon():Icon{
		return _icon;
	}
		
	/**
	 * Sets whether this frame is resizable by the user.
	 * 
	 * <p>"resizable" means include capability of restore normal resize, maximize, iconified and resize by drag.
	 * @param b true user can resize the frame by click resize buttons or drag to scale the frame, false user can't.
	 * @see #isResizable()
	 */
	public function setResizable(b:Bool):Void{
		if(_resizable != b){
			_resizable = b;
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
		return _resizable;
	}
	
	/**
	 * Sets whether this frame can be dragged by the user.  By default, it's true.
	 * 
	 * <p>"dragable" means drag to move the frame.
	 * @param b 
	 * @see #isDragable()
	 */
    @:dox(hide)
	public function setDragable(b:Bool):Void{
		if(_dragable != b){
			_dragable = b;
			repaint();
			revalidate();
			dispatchEvent(new FrameEvent(FrameEvent.FRAME_ABILITY_CHANGED, true));
		}
	}
	
	/**
	 * Returns whether this frame can be dragged by the user. By default, it's true.
	 * @see #setDragnable()
	 */
    @:dox(hide)
	public function isDragable():Bool{
		return _dragable;
	}
	

	/**
	 * Sets whether this frame can be closed by the user. By default, it's true.
	 * Whether the frame will be hide or dispose, depend on the value returned by <code>getDefaultCloseOperation</code>.
	 * @param b true user can click close button to generate the close event, false user can't.
	 * @see #getClosable()
	 */
    @:dox(hide)
	public function setClosable(b:Bool):Void{
		if(_closable != b){
			_closable = b;
			repaint();
			dispatchEvent(new FrameEvent(FrameEvent.FRAME_ABILITY_CHANGED, true));
		}
	}
	
	/**
	 * Returns whether this frame can be closed by the user. By default, it's true.
	 * @see #setClosable()
	 */
    @:dox(hide)
	public function isClosable():Bool{
		return _closable;
	}
	
	/**
	 * Only did effect when state is <code>NORMAL</code>
	 */
    @:dox(hide)
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
    @:dox(hide)
    public function setDefaultCloseOperation(operation:Int):Void{
    	if(operation != DO_NOTHING_ON_CLOSE 
    		&& operation != HIDE_ON_CLOSE
    		&& operation != DISPOSE_ON_CLOSE)
    	{
    			operation = DISPOSE_ON_CLOSE;
    	}
    	_defaultCloseOperation = operation;
    }
    
	/**
	 * Returns the operation that will happen by default when
     * the user initiates a "close" on this frame.
	 * @see #setDefaultCloseOperation()
	 */
    @:dox(hide)
	public function getDefaultCloseOperation():Int{
		return _defaultCloseOperation;
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
			if(_titleBar!=null)	{
				iconifiedSize = _titleBar.getSelf().getMinimumSize();
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
    @:dox(hide)
	public function setDragDirectly(b:Bool):Void{
		_dragDirectly = b;
		setDragDirectlySet(true);
	}
	
	/**
	 * Return whether need move frame directly when drag the frame.
	 * @see #setDragDirectly()
	 */
    @:dox(hide)
	public function isDragDirectly():Bool{
		return _dragDirectly;
	}
	
	/**
	 * Sets is dragDirectly property is set by user.
	 */
    @:dox(hide)
	public function setDragDirectlySet(b:Bool):Void{
		_dragDirectlySet = b;
	}
	
	/**
	 * Return is dragDirectly property is set by user.
	 */
    @:dox(hide)
	public function isDragDirectlySet():Bool{
		return _dragDirectlySet;
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
		if(_defaultCloseOperation == HIDE_ON_CLOSE){
			hide();
		}else if(_defaultCloseOperation == DISPOSE_ON_CLOSE){
			dispose();
			 
		}		
	}
	 
	private function fireStateChanged(programmatic:Bool=true):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
	}
	
	@:dox(hide)
    override private function initModalMC():Void{
		super.initModalMC();
		getModalMC().addEventListener(MouseEvent.MOUSE_DOWN, __flashModelFrame);
	}
	
	private function __flashModelFrame(e:MouseEvent):Void{
		if(getFrameUI() != null){
			getFrameUI().flashModalFrame();
		}
	}

    private override function set_foreground(v: ASColor): ASColor {
        cast(_titleBar, JFrameTitleBar).foreground = v;
        return super.set_foreground(v);
    }
}
