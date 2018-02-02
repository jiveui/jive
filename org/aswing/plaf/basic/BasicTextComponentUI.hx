/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

	
import org.aswing.plaf.BaseComponentUI;
import org.aswing.JTextComponent;
	import org.aswing.Component;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.error.ImpMissError;

/**
 * The base class for text component UIs.
 * @author paling
 * @private
 */
class BasicTextComponentUI extends BaseComponentUI{
	
	private var textComponent:JTextComponent;
	
	public function new(){
		super();
	}

    private function getPropertyPrefix():String{
    	throw new ImpMissError();
        return "";
    }
    
    override public function paint(c:Component, g:Graphics2D, r:IntRectangle):Void{
    	super.paint(c, g, r);
    }
    
    override private function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):Void{
		//do not paint anything, the background decorator will paint
	}
    
	override public function installUI(c:Component):Void{
		textComponent = AsWingUtils.as(c,JTextComponent);
		installDefaults();
		installComponents();
		installListeners();
	}
    
	override public function uninstallUI(c:Component):Void{
		textComponent = AsWingUtils.as(c,JTextComponent);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
 	}
 	
 	private function installDefaults():Void{
        var pp:String = getPropertyPrefix(); 
        LookAndFeel.installColorsAndFont(textComponent, pp);
        LookAndFeel.installBorderAndBFDecorators(textComponent, pp);
        LookAndFeel.installBasicProperties(textComponent, pp);
 	}
	
 	private function uninstallDefaults():Void{
 		LookAndFeel.uninstallBorderAndBFDecorators(textComponent); 
 	}
 	
 	private function installComponents():Void{
 	}
	
 	private function uninstallComponents():Void{
 	}
 	
 	private function installListeners():Void{
 	}
	
 	private function uninstallListeners():Void{
 	}
	
	override public function getMaximumSize(c:Component):IntDimension
	{
		return IntDimension.createBigDimension();
	}
	override public function getMinimumSize(c:Component):IntDimension
	{
		return c.getInsets().getOutsideSize();
	}    
}