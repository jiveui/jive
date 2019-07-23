package jive;

import flash.display.Bitmap;
import flash.geom.ColorTransform;
import flash.filters.BlurFilter;
import flash.geom.Matrix;
import flash.display.Shape;
import org.aswing.plaf.basic.BasicGraphicsUtils;
import flash.display.GradientType;
import org.aswing.graphics.GradientBrush;
import flash.filters.DropShadowFilter;
import org.aswing.geom.IntPoint;
import org.aswing.graphics.SolidBrush;
import org.aswing.SolidBackground;
import org.aswing.AsWingUtils;
import org.aswing.ASColor;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import org.aswing.Component;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.BitmapBrush;
import org.aswing.graphics.Graphics2D;
import org.aswing.GroundDecorator;

class DropdownBackground implements GroundDecorator {

    public var color: ASColor;

    public function new() {}

    public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle): Void {
        var d: Dropdown = AsWingUtils.as(com, Dropdown);
        if (d == null) return;

        var arrowSize = d.arrowSize;
        var arrowGap = d.arrowGap;
        var round = d.round;
        var arrowHalfBase = Std.int(arrowSize * 0.6);

        var shadowSize = d.shadowSize;
        var b = bounds.clone();

        var snapToGlobalBounds = d.getSnapToGlobalBounds();
        if (null == snapToGlobalBounds) return;

        var snapToCorner = d.calcSnapCorner(snapToGlobalBounds);

        var centerPoint: IntPoint = switch(snapToCorner) {
            case DropdownSnapCorner.TopLeft: new IntPoint(b.x + arrowGap + arrowHalfBase, b.y);
            case DropdownSnapCorner.TopRight: new IntPoint(b.x + b.width - shadowSize - arrowGap - Std.int(arrowSize/2), b.y);
            case DropdownSnapCorner.BottomLeft: new IntPoint(b.x + Std.int(snapToGlobalBounds.width/2), b.y + b.height - shadowSize);
            case DropdownSnapCorner.BottomRight: new IntPoint(b.x + b.width - shadowSize - Std.int(snapToGlobalBounds.width/2), b.y + b.height - shadowSize);
        };

        var leftPoint: IntPoint =
            new IntPoint(
                centerPoint.x-arrowHalfBase,
                b.y +
                switch(snapToCorner) {
                    case DropdownSnapCorner.TopLeft: arrowSize;
                    case DropdownSnapCorner.TopRight: arrowSize;
                    case DropdownSnapCorner.BottomLeft: b.height-arrowSize;
                    case DropdownSnapCorner.BottomRight: b.y + b.height-arrowSize;
                });

        var rightPoint: IntPoint = leftPoint.clone();
        rightPoint.x = centerPoint.x + Std.int(arrowSize * 0.6);


        g.beginFill(new SolidBrush(color));
        g.moveTo(centerPoint.x, centerPoint.y);
        g.lineTo(leftPoint.x, leftPoint.y);
        g.lineTo(rightPoint.x, rightPoint.y);
        g.lineTo(centerPoint.x, centerPoint.y);
        g.endFill();

        switch(snapToCorner) {
            case DropdownSnapCorner.TopLeft: b.move(0, arrowSize); b.resize(0, -arrowSize);
            case DropdownSnapCorner.TopRight: b.move(0, arrowSize); b.resize(0, -arrowSize);
            case DropdownSnapCorner.BottomLeft: b.resize(0, -arrowSize);
            case DropdownSnapCorner.BottomRight: b.resize(0, -arrowSize);
        }

//        var shape =  new Shape();
//        shape.graphics.beginFill(0);
//        shape.graphics.drawRoundRect(shadowSize, shadowSize, b.width - 2*shadowSize, b.height - 2*shadowSize, round);
//        shape.graphics.endFill();
//        shape.filters = [new BlurFilter(shadowSize, shadowSize, 3)];
//        var bitmapData = new BitmapData(b.width, b.height, true, 0x000000);
//        var m = new Matrix();
//        m.translate(b.x, b.y);
//        bitmapData.draw(shape, m, new ColorTransform(1,1,1,0.2));
//
//        g.fillRectangle(new BitmapBrush(bitmapData), b.x, b.y, b.width, b.height);

        b.resize(-shadowSize, -shadowSize);

        if (round > 0) {
            g.fillRoundRect(new SolidBrush(ASColor.GRAY.changeAlpha(0.3)), b.x+shadowSize, b.y+shadowSize, b.width, b.height, round);
            g.fillRoundRect(new SolidBrush(color), b.x, b.y, b.width, b.height, round);
        } else {
            g.fillRectangle(new SolidBrush(ASColor.GRAY.changeAlpha(0.3)), b.x+shadowSize, b.y+shadowSize, b.width, b.height);
            g.fillRectangle(new SolidBrush(color), b.x, b.y, b.width, b.height);
        }
    }

    public function getDisplay(c:Component): DisplayObject { return null; }
}
