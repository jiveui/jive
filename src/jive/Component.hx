package jive;

import openfl.display.DisplayObject;

class Component {
    public var x: Metric;
    public var y: Metric;
    public var width: Metric;
    public var height: Metric;

    public var displayObject(default, null): DisplayObject;

    public var parent(get, set): Container;
    private var _parent: Container;
    private function get_parent(): Container {
        return _parent;
    }
    private function set_parent(c: Component): Component {
        return _parent = c;
    }

    public function new() {}

    /**
    * destroy component
    * e.g. delete all bitmap graphics
    * and remove all listeners
    **/
    public function dispose() {}

    public function update(): Void {
        reposition();
        repaint();
    }

    /**
    * recalculate all sizes and positions
    **/
    public function reposition() {}

    public function repaint() {}
}
