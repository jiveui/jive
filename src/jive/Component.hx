package jive;

import openfl.geom.Matrix;
import jive.geom.IntPoint;
import openfl.geom.Rectangle;
import bindx.IBindable;
import openfl.display.Sprite;
import openfl.events.EventDispatcher;
import openfl.display.DisplayObject;

import jive.geom.IntDimension;
import jive.geom.Metric;
import jive.geom.PaintDimension;

using jive.geom.MetricHelper;

@:bindable
class Component extends EventDispatcher implements IBindable {

    private var needsPaint: Bool = true;

    public var x(get, set): Metric;
    private var _x: Metric;
    private function get_x(): Metric { return _x; }
    private function set_x(v: Metric): Metric {
        _x = v;
        reposition();
        return v;
    }

    public var y(get, set): Metric;
    private var _y: Metric;
    private function get_y(): Metric { return _y; }
    private function set_y(v: Metric): Metric {
        _y = v;
        reposition();
        return v;
    }

    public var width(get, set): Metric;
    private var _width: Metric;
    private function get_width(): Metric { return _width; }
    private function set_width(v: Metric): Metric {
        if (_width != v) {
            repaint();
            _width = v;
        }
        return v;
    }

    public var height(get, set): Metric;
    private var _height: Metric;
    private function get_height(): Metric { return _height; }
    private function set_height(v: Metric): Metric {
        if (_height != v) {
            repaint();
            _height = v;
        }
        return v;
    }

    public var rotationAngle(get, set): Float;
    private var _rotationAngle: Float;
    private function get_rotationAngle(): Float {
        return _rotationAngle;
    }
    private function set_rotationAngle(v: Float): Float {
        _rotationAngle = v;
        if (rotationPivot == null) {
            displayObject.rotation = v;
        } else {
            var matrix:Matrix = new Matrix();
            matrix.translate(-rotationPivot.x, -rotationPivot.y);
            matrix.rotate((rotationAngle / 180) * Math.PI);
            //TODO: move to the paint process because the issues can be found when the parent size is changed
            matrix.translate(
                x.toAbsolute(if (null != parent) parent.absoluteWidth else 0) + rotationPivot.x,
                y.toAbsolute(if (null != parent) parent.absoluteHeight else 0) + rotationPivot.y);
            displayObject.transform.matrix = matrix;
        }
        return v;
    }

    public var rotationPivot(get, set): IntPoint;
    private var _rotationPivot: IntPoint;
    private function get_rotationPivot(): IntPoint { return _rotationPivot; }
    private function set_rotationPivot(v: IntPoint): IntPoint {
        _rotationPivot = v;
        rotationAngle = rotationAngle;
        return v;
    }

    public var displayObject(get, null): DisplayObject;
    private function get_displayObject(): DisplayObject {
        if (null == displayObject) {
            displayObject = createDisplayObject();
        }
        return displayObject;
    }

    public var parent(default, set): Container;
    private function set_parent(c: Container): Container {
        return parent = c;
    }

    public var absoluteWidth(get, never): Int;
    private function get_absoluteWidth(): Int {
        return switch (_width) {
            case absolute(v) : v;
            case percent(v) : (parent != null) ? Std.int(parent.absoluteWidth * v / 100) : 0;
            case virtual(v) : 0; // TODO virtual pixels
            case auto: 0;
        }
    }

    public var absoluteHeight(get, never): Int;
    private function get_absoluteHeight(): Int {
        return switch (_height) {
            case absolute(v) : v;
            case percent(v) : (parent != null) ? Std.int(parent.absoluteHeight * v / 100) : 0;
            case virtual(v) : 0; // TODO virtual pixels
            case auto: 0;
        }
    }

    public function new() {
        super();
        x = Metric.absolute(0);
        y = Metric.absolute(0);
        width = Metric.none;
        height = Metric.none;
    }

    private function createDisplayObject(): DisplayObject {
        return new Sprite();
    }

    /**
    * destroy component
    * e.g. delete all bitmap graphics
    * and remove all listeners
    **/
    public function dispose() {}

    public function paint(size: PaintDimension): IntDimension {
        if (needsPaint) {
            needsPaint = false;
            displayObject.scrollRect = new Rectangle(0, 0, absoluteWidth, absoluteHeight);
        }

        displayObject.x = x.toAbsolute(if (null != parent) parent.absoluteWidth else 0);
        displayObject.y = y.toAbsolute(if (null != parent) parent.absoluteHeight else 0);

        return new IntDimension(Std.int(displayObject.width), Std.int(displayObject.height));
    }

    public function repaint() {
        needsPaint = true;
        if (parent != null) parent.repaintChildren();
    }

    public function reposition() {
        if (parent != null) parent.repaintChildren();
    }
}
