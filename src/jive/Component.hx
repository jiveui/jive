package jive;

import bindx.IBindable;
import openfl.display.Sprite;
import openfl.events.EventDispatcher;
import openfl.display.DisplayObject;

import jive.geom.IntDimension;
import jive.geom.Metric;
import jive.geom.PaintDimension;

class Component extends EventDispatcher implements IBindable {

    private var needsPaint: Bool;

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

    public function paint(size: PaintDimension): IntDimension {
        if (needsPaint) {
            needsPaint = false;
        }

        return new IntDimension(displayObject.width, displayObject.height);
    }

    public function repaint() {
        needsPaint = true;
        if (parent != null) parent.repaintChildren();
    }
}
