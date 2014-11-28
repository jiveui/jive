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
	
	private var iconifiedButton:AbstractButton;
	private var maximizeButton:AbstractButton;
	private var restoreButton:AbstractButton;
	private var closeButton:AbstractButton;
	private var titleLabel:JLabel;
	private var icon:Icon;
	private var text:String;
	private var titleEnabled:Bool;
	private var minimizeHeight:Int;
	
	private var buttonPane:Container;
	private var buttonPaneLayout:SoftBoxLayout;
	
	private var owner:JWindow;
	private var frame:JFrame;
	
	public function new(){
		super();
		setClipMasked(true);
		titleEnabled = true;
		minimizeHeight = 22;
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
		buttonPane.appendAll([iconifiedButton, restoreButton, maximizeButton, closeButton]);
		buttonPane.setUIElement(true);
	
		updateUI();
	}
	
	override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }
	
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
	
	public function getSelf():Component{
		return this;
	}
	
	public function setFrame(f:JWindow):Void{
		if(owner!=null)	{
			owner.removeEventListener(FrameEvent.FRAME_ABILITY_CHANGED, __frameAbilityChanged);
			owner.removeEventListener(InteractiveEvent.STATE_CHANGED, __stateChanged);
			owner.removeEventListener(WindowEvent.WINDOW_ACTIVATED, __activeChange);
			owner.removeEventListener(WindowEvent.WINDOW_DEACTIVATED, __activeChange);
		}
		owner = f;
		frame = AsWingUtils.as(f,JFrame)	;
		if(owner!=null)	{
			owner.addEventListener(FrameEvent.FRAME_ABILITY_CHANGED, __frameAbilityChanged, false, 0, false);
			owner.addEventListener(InteractiveEvent.STATE_CHANGED, __stateChanged, false, 0, false);
			owner.addEventListener(WindowEvent.WINDOW_ACTIVATED, __activeChange, false, 0, false);
			owner.addEventListener(WindowEvent.WINDOW_DEACTIVATED, __activeChange, false, 0, false);
		}
		__stateChanged(null);
		repaint();
	}
	
	public function getFrame():JWindow{
		return owner;
	}
	
	public function setTitleEnabled(b:Bool):Void{
		titleEnabled = b;
	}
	
	public function isTitleEnabled():Bool{
		return titleEnabled;
	}
	
	public function setMinimizeHeight(h:Int):Void{
		minimizeHeight = h;
	}
	
	public function getMinimizeHeight():Int{
		return minimizeHeight;
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
	
	public function setIcon(i:Icon):Void{
		icon = i;
		if(titleLabel!=null)	{
			titleLabel.setIcon(i);
		}
	}
	
	public function getIcon():Icon{
		return icon;
	}
	
	public function setText(t:String):Void{
		text = t;
		if(titleLabel!=null)	{
			titleLabel.setText(t);
		}
	}
	
	public function getText():String{
		return text;
	}
	
	public function isActive():Bool{
		if(owner!=null)	{
			return owner.isActive();
		}
		return true;
	}
	
	public function setIconifiedButton(b:AbstractButton):Void{
		if(iconifiedButton != b){
			var index:Int= -1;
			if(iconifiedButton!=null)	{
				index = buttonPane.getIndex(iconifiedButton);
				buttonPane.removeAt(index);
				iconifiedButton.removeActionListener(__iconifiedPressed);
			}
			iconifiedButton = b;
			if(iconifiedButton!=null)	{
				buttonPane.insert(index, iconifiedButton);
				iconifiedButton.addActionListener(__iconifiedPressed);
			}
		}
	}
	
	public function setMaximizeButton(b:AbstractButton):Void{
		if(maximizeButton != b){
			var index:Int= -1;
			if(maximizeButton!=null)	{
				index = buttonPane.getIndex(maximizeButton);
				buttonPane.removeAt(index);
				maximizeButton.removeActionListener(__maximizePressed);
			}
			maximizeButton = b;
			if(maximizeButton!=null)	{
				buttonPane.insert(index, maximizeButton);
				maximizeButton.addActionListener(__maximizePressed);
			}
		}
	}
	
	public function setRestoreButton(b:AbstractButton):Void{
		if(restoreButton != b){
			var index:Int= -1;
			if(restoreButton!=null)	{
				index = buttonPane.getIndex(restoreButton);
				buttonPane.removeAt(index);
				restoreButton.removeActionListener(__restorePressed);
			}
			restoreButton = b;
			if(restoreButton!=null)	{
				buttonPane.insert(index, restoreButton);
				restoreButton.addActionListener(__restorePressed);
			}
		}
	}
	
	public function setCloseButton(b:AbstractButton):Void{
		if(closeButton != b){
			var index:Int= -1;
			if(closeButton!=null)	{
				index = buttonPane.getIndex(closeButton);
				buttonPane.removeAt(index);
				closeButton.removeActionListener(__closePressed);
			}
			closeButton = b;
			if(closeButton!=null)	{
				buttonPane.insert(index, closeButton);
				closeButton.addActionListener(__closePressed);
			}
		}
	}
	
	public function getIconifiedButton():AbstractButton{
		return iconifiedButton;
	}
	
	public function getMaximizeButton():AbstractButton{
		return maximizeButton;
	}
	
	public function getRestoreButton():AbstractButton{
		return restoreButton;
	}
	
	public function getCloseButton():AbstractButton{
		return closeButton;
	}
	
	public function setIconifiedButtonVisible(b:Bool):Void{
		if(getIconifiedButton()!=null){
			getIconifiedButton().setVisible(b);
		}
	}
	
	public function setMaximizeButtonVisible(b:Bool):Void{
		if(getMaximizeButton()!=null){
			getMaximizeButton().setVisible(b);
		}
	}
	
	public function setRestoreButtonVisible(b:Bool):Void{
		if(getRestoreButton()!=null){
			getRestoreButton().setVisible(b);
		}
	}
	
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
