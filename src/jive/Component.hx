package jive;

import openfl.display.DisplayObject;

class Component {
    public var x: Metric;
    public var y: Metric;
    public var width: Metric;
    public var height: Metric;

    public var displayObject(default, null): DisplayObject;

    public function new() {}

    public function dispose() {}
}
