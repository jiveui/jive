package jive;

import openfl.Lib;
import openfl.events.Event;
import org.aswing.AsWingManager;
import org.aswing.event.ContainerEvent;
import org.aswing.geom.IntPoint;
import org.aswing.Container;
import org.aswing.JFrame;

class Dialog extends JFrame {
    public function new(owner:Dynamic=null, title:String="", modal:Bool=false) {
        super(owner, title, modal);
        resizable = false;
        defaultCloseOperation = JFrame.HIDE_ON_CLOSE;
        content.addEventListener(ContainerEvent.COM_ADDED, updateSizeAndLocation);

        addEventListener(Event.ADDED_TO_STAGE, function(e) {
            Lib.current.stage.addEventListener(Event.RESIZE, onResize);
        });

        addEventListener(Event.REMOVED_FROM_STAGE, function(e) {
            Lib.current.stage.removeEventListener(Event.RESIZE, onResize);
        });
    }

    private function onResize(e) {
        if (visible) {
            updateSizeAndLocation(null);
            toFront();
        }
    }

    private function updateSizeAndLocation(e: Dynamic) {
        pack();
        location = new IntPoint(
			Std.int((Lib.current.stage.stageWidth - currentSize.width) / 2),
			Std.int((Lib.current.stage.stageHeight - currentSize.height) / 2));
    }

    @:dox(hide)
    override public function setContentPane(cp:Container):Void {
        if (null != content) {
            content.addEventListener(ContainerEvent.COM_ADDED, updateSizeAndLocation);
        }
        super.setContentPane(cp);
        cp.addEventListener(ContainerEvent.COM_ADDED, updateSizeAndLocation);
    }
	
	@:dox(hide)
	override public function setVisible(v:Bool):Void{
		updateSizeAndLocation(null);
        toFront();
		super.setVisible(v);
	}	
}
