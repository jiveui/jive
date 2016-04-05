package jive;

import openfl.events.EventDispatcher;
import bindx.IBindable;
import openfl.display.DisplayObject;
import jive.geom.Metric;

class Component extends EventDispatcher implements IBindable {
    public var x: Metric;
    public var y: Metric;
    public var width: Metric;
    public var height: Metric;

    public var displayObject(default, null): DisplayObject;

    public var parent(default, set): Container;
    private function set_parent(c: Container): Container {
        return parent = c;
    }

    public function new() {
        super();
    }

    /**
    * destroy component
    * e.g. delete all bitmap graphics
    * and remove all listeners
    **/
    public function dispose() {}
}
