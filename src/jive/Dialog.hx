package jive;

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
    }

    private function updateSizeAndLocation(e: Dynamic) {
        pack();
        location = new IntPoint(
        Std.int((stage.stageWidth - width) / 2),
        Std.int((stage.stageHeight - height) / 2));
    }

    @:dox(hide)
    override public function setContentPane(cp:Container):Void {
        if (null != content) {
            content.addEventListener(ContainerEvent.COM_ADDED, updateSizeAndLocation);
        }
        super.setContentPane(cp);
        cp.addEventListener(ContainerEvent.COM_ADDED, updateSizeAndLocation);
    }
}
