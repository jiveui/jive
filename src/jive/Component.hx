package jive;

import openfl.display.Sprite;
import jive.geom.IntDimension;
import jive.geom.IntRectangle;
import openfl.events.EventDispatcher;
import bindx.IBindable;
import openfl.display.DisplayObject;
import jive.geom.Metric;

class Component extends EventDispatcher implements IBindable {

    private var needsPaint: Bool;

    public var x: Metric;
    public var y: Metric;
    public var width: Metric;
    public var height: Metric;

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
    }

    public function calcSize(): IntDimension {
        return new IntDimension(0,0);
    }

    public function repaint() {
        needsPaint = true;
        if (parent != null) parent.repaint();
    }
}
