package jive;

import jive.geom.IntRequest;
import jive.geom.DimensionRequest;
import jive.geom.IntDimension;

using jive.geom.MetricHelper;

class Window extends Container {
    public function new() {
        super();
    }

    public var opened(get, set):Bool;
    private var _opened:Bool;

    private function get_opened():Bool { return _opened; }

    private function set_opened(v:Bool):Bool {
        if (_opened != v) {
            _opened = v;
            if (_opened) {
                Jive.openWindow(this);
            } else {
                Jive.closeWindow(this);
            }
        }
        return v;
    }
}
