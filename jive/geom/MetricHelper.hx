package jive.geom;

import jive.nativetools.NativeTools;

class MetricHelper {
    static private var scale : Float = -1;

    static public function toAbsolute(m:Metric, d:Int = 0):Int {
        if (m == null) {
            return -1;
        } else {
            switch (m) {
                case virtual(v): { 
                    if (scale < 0) 
                        scale = NativeTools.getScale(); 
                    return Std.int(v * scale);
                };
                case percent(v): return Std.int(d * v / 100);
                case absolute(v) : return v;
                default: return 0;
            }
        }
    }

    static public function isAbsolute(m:Metric):Bool {
        if (m == null) {
            return false;
        } else {
            switch (m) {
                case absolute(v) : return true;
                default: return false;
            }
        }
    }

    static public function getAbsolute(m:Metric):Int {
        if (m == null) {
            return 0;
        } else {
            switch (m) {
                case absolute(v) : return v;
                default: return 0;
            }
        }
    }

    static public function absoluteWidth(c: Component):Int {
        return toAbsolute(c.width, if (c.parent == null) 0 else absoluteWidth(c.parent));
    }

    static public function absoluteHeight(c: Component):Int {
        return toAbsolute(c.height, if (c.parent == null) 0 else absoluteHeight(c.parent));
    }

    static public function absoluteX(c: Component):Int {
        return toAbsolute(c.x, if (c.parent == null) 0 else absoluteWidth(c.parent));
    }

    static public function absoluteY(c: Component):Int {
        return toAbsolute(c.y, if (c.parent == null) 0 else absoluteWidth(c.parent));
    }
}