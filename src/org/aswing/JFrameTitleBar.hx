package org.aswing;


import flash.events.Event;

import org.aswing.border.EmptyBorder;
import org.aswing.event.FrameEvent;
import org.aswing.event.InteractiveEvent;
import org.aswing.event.WindowEvent;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicFrameTitleBarUI;

/**
 * The default Imp of FrameTitleBar
 */
class JFrameTitleBar extends Container  implements FrameTitleBar implements UIResource{
	
    public var iconifiedButton(get, set): AbstractButton;
    private var _iconifiedButton: AbstractButton;
    private function get_iconifiedButton(): AbstractButton { return getIconifiedButton(); }
    private function set_iconifiedButton(v: AbstractButton): AbstractButton { setIconifiedButton(v); return v; }

    public var maximizeButton(get, set): AbstractButton;
    private var _maximizeButton: AbstractButton;
    private function get_maximizeButton(): AbstractButton { return getMaximizeButton(); }
    private function set_maximizeButton(v: AbstractButton): AbstractButton { setMaximizeButton(v); return v; }

    public var restoreButton(get, set): AbstractButton;
    private var _restoreButton: AbstractButton;
    private function get_restoreButton(): AbstractButton { return getRestoreButton(); }
    private function set_restoreButton(v: AbstractButton): AbstractButton { setRestoreButton(v); return v; }

    public var closeButton(get, set): AbstractButton;
    private var _closeButton: AbstractButton;
    private function get_closeButton(): AbstractButton { return getCloseButton(); }
    private function set_closeButton(v: AbstractButton): AbstractButton { setCloseButton(v); return v; }

	private var titleLabel:JLabel;

    public var icon(get, set): Icon;
    private var _icon: Icon;
    private function get_icon(): Icon { return getIcon(); }
    private function set_icon(v: Icon): Icon { setIcon(v); return v; }

    public var text(get, set): String;
    private var _text: String;
    private function get_text(): String { return getText(); }
    private function set_text(v: String): String { setText(v); return v; }

    public var titleEnabled(get, set): Bool;
    private var _titleEnabled: Bool;
    private function get_titleEnabled(): Bool { return isTitleEnabled(); }
    private function set_titleEnabled(v: Bool): Bool { setTitleEnabled(v); return v; }

    public var minimizeHeight(get, set): Int;
    private var _minimizeHeight: Int;
    private function get_minimizeHeight(): Int { return getMinimizeHeight(); }
    private function set_minimizeHeight(v: Int): Int { setMinimizeHeight(v); return v; }
	
	private var buttonPane:Container;
	private var buttonPaneLayout:SoftBoxLayout;
	
    public var owner(get, set): JWindow;
    private var _owner: JWindow;
    private function get_owner(): JWindow { return getFrame(); }
    private function set_owner(v: JWindow): JWindow { setFrame(v); return v; }

	private var frame:JFrame;
	
	public function new(){
		super();
		setClipMasked(true);
		_titleEnabled = true;
		_minimizeHeight = 22;
		setLayout(new FrameTitleBarLayout());
			
		buttonPane = new Container();
		buttonPane.setCachePreferSizes(false);
		buttonPaneLayout = new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0);
		buttonPane.setLayout(buttonPaneLayout);
		
		var labelPane:Container = new Container();
		 
		labelPane.setBorder(new EmptyBorder(null, new Insets(-3)));//make label y offset -3
		labelPane.setLayout(new BorderLayout());
		titleLabel = new JLabel();
		titleLabel.setHorizontalAlignment(JLabel.LEFT);
		titleLabel.setVerticalAlignment(JLabel.CENTER);
		titleLabel.setUIElement(true);
		labelPane.setUIElement(true);
		labelPane.append(titleLabel, BorderLayout.CENTER);
		labelPane.mouseEnabled = false;
		labelPane.mouseChildren = false;
		 
		append(labelPane, BorderLayout.CENTER);
		 
		var btnpP:Container = new Container();
		btnpP.setLayout(new BorderLayout());
		btnpP.append(buttonPane, BorderLayout.NORTH);
		append(btnpP, BorderLayout.EAST);
		
		setIconifiedButton(createIconifiedButton());
		setMaximizeButton(createMaximizeButton());
		setRestoreButton(createRestoreButton());
		setCloseButton(createCloseButton());
		setMaximizeButtonVisible(false);
		buttonPane.appendAll([_iconifiedButton, _restoreButton, _maximizeButton, _closeButton]);
		buttonPane.setUIElement(true);
	
		updateUI();
	}
	
	@:dox(hide)
    override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicFrameTitleBarUI;
    }
	
	private function createPureButton():JButton{
		var b:JButton = new JButton();
		b.setBackgroundDecorator(null);
		b.setMargin(new Insets());
		b.setStyleTune(null);
		b.setBackground(null);
		b.setForeground(null);
		b.setMideground(null);
		b.setStyleProxy(this);
		return b;
	}
	
	private function createIconifiedButton():AbstractButton{
		return createPureButton();
	}
	
	private function createMaximizeButton():AbstractButton{
		return createPureButton();
	}
	
	private function createRestoreButton():AbstractButton{
		return createPureButton();
	}
	
	private function createCloseButton():AbstractButton{
		return createPureButton();
	}
	
	public function setButtonIconGap(gap:Int):Void{
		buttonPaneLayout.setGap(gap);
	}
	
	@:dox(hide)
    public function getSelf():Component{
		return this;
	}

    @:dox(hide)
	public function setFrame(f:JWindow):Void{
		if(_owner!=null)	{
			_owner.removeEventListener(FrameEvent.FRAME_ABILITY_CHANGED, __frameAbilityChanged);
			_owner.removeEventListener(InteractiveEvent.STATE_CHANGED, __stateChanged);
			_owner.removeEventListener(WindowEvent.WINDOW_ACTIVATED, __activeChange);
			_owner.removeEventListener(WindowEvent.WINDOW_DEACTIVATED, __activeChange);
		}
		_owner = f;
		frame = AsWingUtils.as(f,JFrame)	;
		if(_owner!=null)	{
			_owner.addEventListener(FrameEvent.FRAME_ABILITY_CHANGED, __frameAbilityChanged, false, 0, false);
			_owner.addEventListener(InteractiveEvent.STATE_CHANGED, __stateChanged, false, 0, false);
			_owner.addEventListener(WindowEvent.WINDOW_ACTIVATED, __activeChange, false, 0, false);
			_owner.addEventListener(WindowEvent.WINDOW_DEACTIVATED, __activeChange, false, 0, false);
		}
		__stateChanged(null);
		repaint();
	}

    @:dox(hide)
	public function getFrame():JWindow{
		return _owner;
	}
	
	@:dox(hide)
    public function setTitleEnabled(b:Bool):Void{
		_titleEnabled = b;
	}

    @:dox(hide)
	public function isTitleEnabled():Bool{
		return _titleEnabled;
	}
	
	@:dox(hide)
    public function setMinimizeHeight(h:Int):Void{
		_minimizeHeight = h;
	}
	
	@:dox(hide)
    public function getMinimizeHeight():Int{
		return _minimizeHeight;
	}
		
	public function addExtraControl(c:Component, position:Int):Void{
		if(position == AsWingConstants.LEFT){
			buttonPane.insert(0, c);
		}else{
			buttonPane.append(c);
		}
	}
	
	public function removeExtraControl(c:Component):Component{
		return buttonPane.remove(c);
	}
	
	public function getLabel():JLabel{
		return titleLabel;
	}
	
	@:dox(hide)
    public function setIcon(i:Icon):Void {
		_icon = i;
		if(titleLabel!=null)	{
			titleLabel.setIcon(i);
		}
	}

    @:dox(hide)
	public function getIcon():Icon {
		return _icon;
	}
	
	@:dox(hide)
    public function setText(t:String):Void{
		_text = t;
		if(titleLabel!=null)	{
			titleLabel.setText(t);
		}
	}

    @:dox(hide)
	public function getText():String{
		return _text;
	}
	
	public function isActive():Bool{
		if(_owner!=null)	{
			return _owner.isActive();
		}
		return true;
	}

	@:dox(hide)
	public function setIconifiedButton(b:AbstractButton):Void {
		if(_iconifiedButton != b){
			var index:Int= -1;
			if(_iconifiedButton!=null)	{
				index = buttonPane.getIndex(_iconifiedButton);
				buttonPane.removeAt(index);
				_iconifiedButton.removeActionListener(__iconifiedPressed);
			}
			_iconifiedButton = b;
			if(_iconifiedButton!=null)	{
				buttonPane.insert(index, _iconifiedButton);
				_iconifiedButton.addActionListener(__iconifiedPressed);
			}
		}
	}

    @:dox(hide)
	public function setMaximizeButton(b:AbstractButton):Void {
		if(_maximizeButton != b){
			var index:Int= -1;
			if(_maximizeButton!=null)	{
				index = buttonPane.getIndex(_maximizeButton);
				buttonPane.removeAt(index);
				_maximizeButton.removeActionListener(__maximizePressed);
			}
			_maximizeButton = b;
			if(_maximizeButton!=null)	{
				buttonPane.insert(index, _maximizeButton);
				_maximizeButton.addActionListener(__maximizePressed);
			}
		}
	}

    @:dox(hide)
	public function setRestoreButton(b:AbstractButton):Void {
		if(_restoreButton != b){
			var index:Int= -1;
			if(_restoreButton!=null)	{
				index = buttonPane.getIndex(_restoreButton);
				buttonPane.removeAt(index);
				_restoreButton.removeActionListener(__restorePressed);
			}
			_restoreButton = b;
			if(_restoreButton!=null)	{
				buttonPane.insert(index, _restoreButton);
				_restoreButton.addActionListener(__restorePressed);
			}
		}
	}
	
	@:dox(hide)
    public function setCloseButton(b:AbstractButton):Void{
		if(_closeButton != b){
			var index:Int= -1;
			if(_closeButton!=null)	{
				index = buttonPane.getIndex(_closeButton);
				buttonPane.removeAt(index);
				_closeButton.removeActionListener(__closePressed);
			}
			_closeButton = b;
			if(_closeButton!=null)	{
				buttonPane.insert(index, _closeButton);
				_closeButton.addActionListener(__closePressed);
			}
		}
	}

    @:dox(hide)
	public function getIconifiedButton():AbstractButton{
		return _iconifiedButton;
	}

    @:dox(hide)
	public function getMaximizeButton():AbstractButton{
		return _maximizeButton;
	}

    @:dox(hide)
	public function getRestoreButton():AbstractButton{
		return _restoreButton;
	}

    @:dox(hide)
	public function getCloseButton():AbstractButton{
		return _closeButton;
	}

	@:dox(hide)
    public function setIconifiedButtonVisible(b:Bool):Void{
		if(getIconifiedButton()!=null){
			getIconifiedButton().setVisible(b);
		}
	}

    @:dox(hide)
	public function setMaximizeButtonVisible(b:Bool):Void{
		if(getMaximizeButton()!=null){
			getMaximizeButton().setVisible(b);
		}
	}

    @:dox(hide)
	public function setRestoreButtonVisible(b:Bool):Void{
		if(getRestoreButton()!=null){
			getRestoreButton().setVisible(b);
		}
	}

    @:dox(hide)
	public function setCloseButtonVisible(b:Bool):Void{
		if(getCloseButton()!=null){
			getCloseButton().setVisible(b);
		}
	}
	
	private function __iconifiedPressed(e:Event):Void{
		if(frame!=null && isTitleEnabled() ){
			frame.setState(JFrame.ICONIFIED, false);
		}
	}
	
	private function __maximizePressed(e:Event):Void{
		if(frame!=null && isTitleEnabled() ){
			frame.setState(JFrame.MAXIMIZED, false);
		}
	}
	
	private function __restorePressed(e:Event):Void{
		if(frame!=null && isTitleEnabled() ){
			frame.setState(JFrame.NORMAL, false);
		}
	}
	
	private function __closePressed(e:Event):Void{
		if(frame!=null && isTitleEnabled()){
			frame.closeReleased();
		}
	}
	
	private function __activeChange(e:Event):Void{
		repaint();
		//or paintImmediately();
	}
			
	private function __frameAbilityChanged(e:FrameEvent):Void{
		__stateChanged(null);
	}
	
	private function __stateChanged(e:InteractiveEvent):Void{
		if(frame == null){
			return;
		}
		var state:Int= frame.getState();
		if(state != JFrame.ICONIFIED 
			&& state != JFrame.NORMAL
			&& state != JFrame.MAXIMIZED_HORIZ
			&& state != JFrame.MAXIMIZED_VERT
			&& state != JFrame.MAXIMIZED){
			state = JFrame.NORMAL;
		}
		if(state == JFrame.ICONIFIED){
			setIconifiedButtonVisible(false);
			setMaximizeButtonVisible(false);
			setRestoreButtonVisible(true);
			setCloseButtonVisible(frame.isClosable());
		}else if(state == JFrame.NORMAL){
			setIconifiedButtonVisible(frame.isResizable());
			setRestoreButtonVisible(false);
			setMaximizeButtonVisible(frame.isResizable());
			setCloseButtonVisible(frame.isClosable());
		}else{
			setIconifiedButtonVisible(frame.isResizable());
			setRestoreButtonVisible(frame.isResizable());
			setMaximizeButtonVisible(false);
			setCloseButtonVisible(frame.isClosable());
		}
		revalidateIfNecessary();
	}
	 
}
