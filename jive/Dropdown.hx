package jive;

import haxe.Timer;
import flash.Lib;
import org.aswing.geom.IntPoint;
import org.aswing.Component;
import org.aswing.JPopup;

class Dropdown extends JPopup {

    public var snapTo: Component;
    public var gap: Int = Jive.atom;

    private var timer: Timer;

    public function new() {
        super();
    }

    override public function append(com:Component, constraints:Dynamic=null):Void {
        super.append(com, constraints);
        pack();
    }

    override public function setVisible(v:Bool): Void {
        updateLocation();
        super.setVisible(v);
        if (v) {
            timer = new Timer(100);
            timer.run = updateLocation;
        } else {
            if (null != timer) timer.stop();
            timer == null;
        }
    }

    private function updateLocation() {
        var stageWidth = Lib.current.stage.stageWidth;
        var stageHeight = Lib.current.stage.stageHeight;
        var snapToLocation = snapTo.getGlobalLocation();
        var snapToBounds = snapTo.bounds;
        var b = bounds;

        var x: Int =
            if (snapToLocation.x + b.width <= stageWidth) snapToLocation.x
            else snapToLocation.x + snapToBounds.width - b.width;
        var y: Int =
            if (snapToLocation.y + snapToBounds.height + b.height + gap <= stageHeight) snapToLocation.y + snapToBounds.height + gap
            else snapToLocation.y - b.height - gap;
        location = new IntPoint(x, y);

    }
}
