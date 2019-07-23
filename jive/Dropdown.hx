package jive;

import org.aswing.geom.IntRectangle;
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;
import org.aswing.Insets;
import org.aswing.border.EmptyBorder;
import jive.DropdownSnapCorner;
import haxe.Timer;
import flash.Lib;
import org.aswing.geom.IntPoint;
import org.aswing.Component;
import org.aswing.JPopup;

class Dropdown extends JPopup {

    public var snapTo: Component;
    public var calcSnapGlobalBounds: Void -> IntRectangle;
    public var gap: Int = Jive.atom;
    public var shadowSize: Int = Jive.atom;
    public var arrowSize: Int = Jive.atom;
    public var arrowGap: Int = 2*Jive.atom;
    public var round: Int = Jive.atom;

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

        var snapToGlobalBounds = getSnapToGlobalBounds();
        if (null == snapToGlobalBounds) return;

        var arrowHalfBase = Std.int(arrowSize * 0.6);

        var snapCorner = calcSnapCorner(snapToGlobalBounds);
        var b = bounds;
        var x: Int =
            if (snapCorner == TopLeft || snapCorner == BottomLeft) snapToGlobalBounds.x + Std.int(snapToGlobalBounds.width/2) - arrowGap - arrowHalfBase;
            else snapToGlobalBounds.x + Std.int(snapToGlobalBounds.width/2) - b.width + shadowSize + arrowGap + arrowHalfBase;
        var y: Int =
            if (snapCorner == TopLeft || snapCorner == TopRight) snapToGlobalBounds.y + snapToGlobalBounds.height + gap
            else snapToGlobalBounds.y - b.height - gap - shadowSize;
        location = new IntPoint(x, y);
    }

    public function getSnapToGlobalBounds(): IntRectangle {
        if (null != calcSnapGlobalBounds) {
            return calcSnapGlobalBounds();
        } else if (null != snapTo) {
            var snapToLocation = snapTo.getGlobalLocation();
            var snapToBounds = snapTo.bounds;
            return new IntRectangle(snapToLocation.x, snapToLocation.y, snapToBounds.width, snapToBounds.height);
        } else {
            return null;
        }
    }

    public function calcSnapCorner(globalBounds: IntRectangle): DropdownSnapCorner {
        var stageWidth = Lib.current.stage.stageWidth;
        var stageHeight = Lib.current.stage.stageHeight;
        var snapToLocation = globalBounds.getLocation();
        var snapToBounds = globalBounds;
        var b = bounds;
        return
            if (snapToLocation.x + b.width <= stageWidth)
                if (snapToLocation.y + snapToBounds.height + b.height + gap <= stageHeight) DropdownSnapCorner.TopLeft;
                else DropdownSnapCorner.BottomLeft;
            else if (snapToLocation.y + snapToBounds.height + b.height + gap <= stageHeight) DropdownSnapCorner.TopRight;
                else BottomRight;
    }
}
