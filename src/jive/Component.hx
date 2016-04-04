package jive;

import openfl.display.DisplayObject;

class Component {
    public var x: Metric;
    public var y: Metric;
    public var width: Metric;
    public var height: Metric;

    public var displayObject(default, null): DisplayObject;

    public var parent(default, set): Container;
    private function set_parent(c: Container): Container {
        return parent = c;
    }

    public function new() {}

    /**
    * destroy component
    * e.g. delete all bitmap graphics
    * and remove all listeners
    **/
    public function dispose() {}
}
