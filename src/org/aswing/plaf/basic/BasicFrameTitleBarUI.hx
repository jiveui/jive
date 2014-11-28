/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.FrameTitleBar;
import org.aswing.LookAndFeel;
import org.aswing.StyleResult;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.BaseComponentUI;

/**
 * @private
 * @author paling
 */
class BasicFrameTitleBarUI extends BaseComponentUI{
	
	private var bar:FrameTitleBar;
	
	public function new(){
		super();
	}

	override public function installUI(c:Component):Void{
		bar = AsWingUtils.as(c,FrameTitleBar)	;
		installDefaults();
		installComponent();
	}

	override public function uninstallUI(c:Component):Void{
		uninstallDefaults();
		uninstallComponent();
		bar = null;
	}

	private function installDefaults():Void{
		var pp:String= "FrameTitleBar.";
		LookAndFeel.installColorsAndFont(bar.getSelf(), pp);
		LookAndFeel.installBorderAndBFDecorators(bar.getSelf(), pp);
		LookAndFeel.installBasicProperties(bar.getSelf(), pp);
	}
	
	private function installComponent():Void{
		if(bar.getIconifiedButton()!=null){
			bar.getIconifiedButton().setIcon(getIcon("FrameTitleBar.iconifiedIcon"));
		}
		if(bar.getMaximizeButton()!=null){
			bar.getMaximizeButton().setIcon(getIcon("FrameTitleBar.maximizeIcon"));
		}
		if(bar.getRestoreButton()!=null){
			bar.getRestoreButton().setIcon(getIcon("FrameTitleBar.normalIcon"));
		}
		if(bar.getCloseButton()!=null){
			bar.getCloseButton().setIcon(getIcon("FrameTitleBar.closeIcon"));
		}
			
		bar.setButtonIconGap(getInt("FrameTitleBar.buttonGap"));
		bar.setMinimizeHeight(getInt("FrameTitleBar.titleBarHeight"));
		bar.getSelf().revalidateIfNecessary();
	}
	
	private function uninstallComponent():Void{
	}
	
	private function uninstallDefaults():Void{
		LookAndFeel.uninstallBorderAndBFDecorators(bar.getSelf());
	}
	
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		
		var cl:ASColor = bar.getSelf().getForeground();
		var colors:StyleResult = new StyleResult(cl, bar.getSelf().getStyleTune());
		bar.getLabel().setForeground(bar.isActive() ? colors.bdark : colors.blight);
		bar.getLabel().setFont(bar.getSelf().getFont());
		bar.getLabel().paintImmediately();
	}
	
	override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		//do nothing, bg decorator will do this job
	}	
}