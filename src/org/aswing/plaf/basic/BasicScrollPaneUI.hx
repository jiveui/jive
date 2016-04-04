/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

	
import org.aswing.plaf.BaseComponentUI;
import org.aswing.JScrollPane;
import org.aswing.LookAndFeel;
	import org.aswing.Viewportable;
	import org.aswing.Component;
	import org.aswing.JScrollBar;
	import org.aswing.event.ScrollPaneEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	/**
 * The basic scroll pane ui imp.
 * @author paling
 * @private
 */
class BasicScrollPaneUI extends BaseComponentUI{

	private var scrollPane:JScrollPane;
	private var lastViewport:Viewportable;
	
	public function new() {
		super();	
	}
    	
    override public function installUI(c:Component):Void{
		scrollPane = AsWingUtils.as(c,JScrollPane);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override public function uninstallUI(c:Component):Void{
		scrollPane =  AsWingUtils.as(c,JScrollPane);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
    
    private function getPropertyPrefix():String{
        return "ScrollPane.";
    }
    
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
        LookAndFeel.installColorsAndFont(scrollPane, pp);
        LookAndFeel.installBorderAndBFDecorators(scrollPane, pp);
        LookAndFeel.installBasicProperties(scrollPane, pp);
        if(!scrollPane.getVerticalScrollBar().isFocusableSet()){
        	scrollPane.getVerticalScrollBar().setFocusable(false);
        	scrollPane.getVerticalScrollBar().setFocusableSet(false);
        }
        if(!scrollPane.getHorizontalScrollBar().isFocusableSet()){
        	scrollPane.getHorizontalScrollBar().setFocusable(false);
        	scrollPane.getHorizontalScrollBar().setFocusableSet(false);
        }
	}
    
    private function uninstallDefaults():Void{
    	LookAndFeel.uninstallBorderAndBFDecorators(scrollPane);
    }
    
	private function installComponents():Void{
    }
	private function uninstallComponents():Void{
    }
	
	private function installListeners():Void{
		scrollPane.addAdjustmentListener(__adjustChanged);
		scrollPane.addEventListener(ScrollPaneEvent.VIEWPORT_CHANGED, __viewportChanged);
		__viewportChanged(null);
	}
    
    private function uninstallListeners():Void{
		scrollPane.removeAdjustmentListener(__adjustChanged);
		scrollPane.removeEventListener(ScrollPaneEvent.VIEWPORT_CHANGED, __viewportChanged);
		if(lastViewport != null){
			lastViewport.removeStateListener(__viewportStateChanged);
		}
    }
    
	//-------------------------listeners--------------------------
    private function syncScrollPaneWithViewport():Void{
		var viewport:Viewportable = scrollPane.getViewport();
		var vsb:JScrollBar = scrollPane.getVerticalScrollBar();
		var hsb:JScrollBar = scrollPane.getHorizontalScrollBar();
		if (viewport != null) {
		    var extentSize:IntDimension = viewport.getExtentSize();
		    if(extentSize.width <=0 || extentSize.height <= 0){
		    	//trace("/w/zero extent size");
		    	return;
		    }
		    var viewSize:IntDimension = viewport.getViewSize();
		    var viewPosition:IntPoint = viewport.getViewPosition();
			var extent:Int, max:Int, value:Int;
		    if (vsb != null) {
				extent = extentSize.height;
				max = viewSize.height;
				value = Std.int(Math.max(0, Math.min(viewPosition.y, max - extent)));
				vsb.setValues(value, extent, 0, max);
				vsb.setUnitIncrement(viewport.getVerticalUnitIncrement());
				vsb.setBlockIncrement(viewport.getVerticalBlockIncrement());
	    	}

		    if (hsb != null) {
				extent = extentSize.width;
				max = viewSize.width;
				value = Std.int(Math.max(0, Math.min(viewPosition.x, max - extent)));
				hsb.setValues(value, extent, 0, max);
				hsb.setUnitIncrement(viewport.getHorizontalUnitIncrement());
				hsb.setBlockIncrement(viewport.getHorizontalBlockIncrement());
	    	}
		}
    }	
	
	private function __viewportChanged(e:ScrollPaneEvent):Void{
		if(lastViewport != null){
			lastViewport.removeStateListener(__viewportStateChanged);
		}
		lastViewport = scrollPane.getViewport();
		lastViewport.addStateListener(__viewportStateChanged);
	}
	
	private function __viewportStateChanged(e:InteractiveEvent):Void{
		syncScrollPaneWithViewport();
	}
	
    private function __adjustChanged(e:ScrollPaneEvent):Void{
    	var viewport:Viewportable = scrollPane.getViewport();
    	viewport.scrollRectToVisible(scrollPane.getVisibleRect(), e.isProgrammatic());
    }
	
}