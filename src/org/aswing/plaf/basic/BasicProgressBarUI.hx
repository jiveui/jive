/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

	
import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.aswing.GroundDecorator;
	import org.aswing.JProgressBar;
	import org.aswing.Component;
	import org.aswing.event.InteractiveEvent;
import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.util.DepthManager;

/**
 * @private
 */
class BasicProgressBarUI extends BaseComponentUI{
	
	private var iconDecorator:GroundDecorator;
	private var stringText:TextField;
	private var stateListener:Dynamic;
	private var progressBar:JProgressBar;
	private var barSize:Int;
	
	public function new() {
		super();
		barSize = 12;//default
	}

    private function getPropertyPrefix():String{
        return "ProgressBar.";
    }    	

	override public function installUI(c:Component):Void{
		progressBar = AsWingUtils.as(c,JProgressBar);
		installDefaults();
		installComponents();
		installListeners();
	}
	
	override public function uninstallUI(c:Component):Void{
		progressBar = AsWingUtils.as(c,JProgressBar);	
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
	}
	
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
		LookAndFeel.installColorsAndFont(progressBar, pp);
		LookAndFeel.installBasicProperties(progressBar, pp);
		LookAndFeel.installBorderAndBFDecorators(progressBar, pp);
		
		barSize = getInt(pp+"barWidth");
		if(barSize == -1) barSize = 1000;
		if(!progressBar.isIndeterminateDelaySet()){
			progressBar.setIndeterminateDelay(getUint(pp + "indeterminateDelay"));
			progressBar.setIndeterminateDelaySet(false);
		}
	}
	
	private function uninstallDefaults():Void{
		LookAndFeel.uninstallBorderAndBFDecorators(progressBar);
	}
	
	private function installComponents():Void{
		stringText = new TextField();
	
		 
		stringText.mouseEnabled = false;
		#if (flash9)
		stringText.autoSize = TextFieldAutoSize.CENTER;
		stringText.tabEnabled = false;
		#end
		stringText.selectable = false;
		progressBar.addChild(stringText);
	}
	
	private function uninstallComponents():Void{
		if(stringText.parent != null) {
    		stringText.parent.removeChild(stringText);
		}
		stringText = null;
		iconDecorator = null;
	}
	
	private function installListeners():Void{
		progressBar.addEventListener(InteractiveEvent.STATE_CHANGED, __stateChanged);
	}
	private function uninstallListeners():Void{
		progressBar.removeEventListener(InteractiveEvent.STATE_CHANGED, __stateChanged);
	}
	
	private function __stateChanged(source:JProgressBar):Void{
		source.repaint();
	}
	
    override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		var sp:JProgressBar = AsWingUtils.as(c,JProgressBar);
		if(sp.getString() != null && sp.getString().length>0){
			stringText.text = sp.getString();
	    	AsWingUtils.applyTextFontAndColor(stringText, sp.getFont(), sp.getForeground());
			
			if (sp.getOrientation() == JProgressBar.VERTICAL){
				//TODO use bitmap to achieve rotate
				stringText.rotation = -90;
				stringText.x = Math.round(b.x + (b.width - stringText.width)/2);
				stringText.y = Math.round(b.y + (b.height - stringText.height)/2 + stringText.height);
			}else{
				stringText.rotation = 0;
				stringText.x = Math.round(b.x + (b.width - stringText.width)/2);
				stringText.y = Math.round(b.y + (b.height - stringText.height)/2);
			}
			DepthManager.bringToTop(stringText);
		}else{
			stringText.text = "";
		}
	}
	
    override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
    	//do nothing, background decorator will paint it
    }	

    //--------------------------Dimensions----------------------------
    
	override public function getPreferredSize(c:Component):IntDimension{
		var sp:JProgressBar = AsWingUtils.as(c,JProgressBar);
		var size:IntDimension;
		if (sp.getOrientation() == JProgressBar.VERTICAL){
			size = getPreferredInnerVertical();
		}else{
			size = getPreferredInnerHorizontal();
		}
		
		if(sp.getString() != null){
			var textSize:IntDimension = c.getFont().computeTextSize(sp.getString(), false);
			if (sp.getOrientation() == JProgressBar.VERTICAL){
				size.width =Std.int( Math.max(size.width, textSize.height));
				size.height = Std.int( Math.max(size.height, textSize.width));
			}else{
				size.width = Std.int( Math.max(size.width, textSize.width));
				size.height = Std.int( Math.max(size.height, textSize.height));
			}
		}
		return sp.getInsets().getOutsideSize(size);
	}
    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }
    override public function getMinimumSize(c:Component):IntDimension{
		return c.getInsets().getOutsideSize(new IntDimension(1, 1));
    }
    
    private function getPreferredInnerHorizontal():IntDimension{
    	return new IntDimension(80, barSize);
    }
    private function getPreferredInnerVertical():IntDimension{
    	return new IntDimension(barSize, 80);
    }	
	
}