package jive;

import openfl.display.Sprite;
import jive.geom.IntDimension;
import jive.geom.IntRectangle;
import openfl.events.EventDispatcher;
import bindx.IBindable;
import openfl.display.DisplayObject;
import jive.geom.Metric;

using jive.geom.MetricHelper;

class Component extends EventDispatcher implements IBindable {

    private var needsPaint: Bool;
    private var needsCalcPreferredSize: Bool;

    public var x(get, set): Metric;
    private var _x: Metric;
    private function get_x(): Metric { return _x; }
    private function set_x(v: Metric): Metric {
        _x = v;
        return v;
    }
    public var y(get, set): Metric;
    private var _y: Metric;
    private function get_y(): Metric { return _y; }
    private function set_y(v: Metric): Metric {
        _y = v;
        return v;
    }

    public var width(get, set): Metric;
    private var _width: Metric;
    private function get_width(): Metric { return _width; }
    private function set_width(v: Metric): Metric {
        _width = v;
        recalcSize();
        return v;
    }

    public var height(get, set): Metric;
    private var _height: Metric;
    private function get_height(): Metric { return _height; }
    private function set_height(v: Metric): Metric {
        _height = v;
        recalcSize();
        return v;
    }

    public var preferredSize(get, null): IntDimension;
    private var _preferredSize: IntDimension;
    private function get_preferredSize(): IntDimension {
        if (needsCalcPreferredSize) _preferredSize = calcPreferredSize();
        needsCalcPreferredSize = false;
        return _preferredSize;
    }

    private function calcPreferredSize(): IntDimension {
        return new IntDimension(width.toAbsolute(this), height.toAbsolute(this));
    }

    public var paintSize(get, set): IntDimension;
    private var _paintSize: IntDimension;
    private function get_paintSize(): IntDimension {
        if (null == _paintSize) _paintSize = new IntDimension();
        return _paintSize;
    }
    private function set_paintSize(v: IntDimension): IntDimension {
        _paintSize = v;
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

    public function new() {
        super();
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

    public function paint(size: IntDimension) {
        needsPaint = false;
        if (!paintSize.equals(size)) {
            doPaint(size);
        }
    }

    private function doPaint(size: IntDimension) {}

    public function repaint() {
        needsPaint = true;
        if (parent != null) parent.repaintChildren();
    }

    private function recalcSize() {
        needsCalcPreferredSize = true;
        if (null != parent) { parent.relayout(); }
        repaint();
    }

}
