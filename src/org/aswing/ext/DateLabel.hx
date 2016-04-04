package org.aswing.ext;


import flash.events.MouseEvent;

import org.aswing.ASColor;
import org.aswing.Icon;
import org.aswing.JLabel;
import org.aswing.UIManager;


/**
 * @author paling (Burstyx Studio)
 */
class DateLabel extends JLabel{
	
	private var selectionBackground:ASColor;
	private var selectionForeground:ASColor;
	private var highlightColor:ASColor;
	private var disabledColor:ASColor;
	private var enabledColor:ASColor;
	
	private var date:Int;
	private   var dateEnabled:Bool;
	private   var selected:Bool;
	
	public function new(date:Int){
		
		super( Std.string(date));
		dateEnabled=true;
		selected = false;
		this.date = 0;
		
		this.date = date;
		selectionForeground = UIManager.getColor("selectionForeground");
		selectionBackground = UIManager.getColor("selectionBackground");
		highlightColor = ASColor.RED;
		disabledColor = getForeground().brighter().brighter();
		enabledColor = getForeground().darker();
		
		setForeground(enabledColor);
		mouseChildren = false;
		
		this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	public function getDate():Int{
		return date;
	}
	 
	
	private function onMouseOver(e:MouseEvent):Void{
		updateView(true, false);
	}
	
	private function onMouseOut(e:MouseEvent):Void{
		updateView(false, true);
	}
	
	private function onMouseDown(e:MouseEvent):Void{
	}
	
	public function setSelected(b:Bool):Void{
		if(b != selected){
			selected = b;
			updateView();
		}
	}
	
	private function updateView(over:Bool=false, out:Bool=false):Void{
		if(!isDateEnabled()){
			setForeground(disabledColor);
			if(selected)	{
				setBackground(selectionBackground);
				setOpaque(true);
			}else{
				setOpaque(false);
			}
		}else if(selected)	{
			setForeground(selectionForeground);
			setBackground(selectionBackground);
			setOpaque(true);
		}else if(over)	{
			setBackground(selectionBackground.changeAlpha(0.5));
			setForeground(selectionForeground);
			setOpaque(true);
		}else if(out)	{
			setForeground(enabledColor);
			setOpaque(false);
		}else{
			setForeground(enabledColor);
			setOpaque(false);
		}
	}
	
	public function isSelected():Bool{
		return selected;
	}
	
	public function setDateEnabled(b:Bool):Void{
		if(b != dateEnabled){
			dateEnabled = b;
			mouseEnabled = b;
			updateView();
		}
	}
	
	public function isDateEnabled():Bool{
		return dateEnabled;
	}
}