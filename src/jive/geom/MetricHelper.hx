package jive.geom;

class MetricHelper {
    static public function toAbsoluteWidth(m: Metric, c: Component): Int {
        switch (m) {
            case absolute(v) : return v;
            default: return toAbsolute(m, getFirstAbsoluteComponentWidth(c));
        }
    }

    static public function toAbsoluteHeight(m: Metric, c: Component): Int {
        switch (m) {
            case absolute(v) : return v;
            default: return toAbsolute(m, getFirstAbsoluteComponentHeight(c));
        }
    }

    static public function toAbsolute(m: Metric, d: Int): Int {
        switch (m) {
            case virtual(v): return 0;
            case percent(v): return Std.int(d * v / 100);
            case absolute(v) : return v;
            default: return -1;
        }
    }

    static public function isAbsolute(m: Metric): Bool {
        switch (m) {
            case absolute(v) : return true;
            default: return false;
        }
    }

    static public function getAbsolute(m: Metric): Int {
        switch (m) {
            case absolute(v) : return v;
            default: return 0;
        }
    }

    static public function getFirstAbsoluteComponentWidth(c: Component): Int {
        if (isAbsolute(c.width)) {
            return getAbsolute(c.width);
        }

        var parent: Component = c;
        while (parent.parent != null) {
            parent = cast(parent.parent, Component);
            if (isAbsolute(parent.width)) {
                return getAbsolute(parent.width);
            }
        }

        return 0;
    }

    static public function getFirstAbsoluteComponentHeight(c: Component): Int {
        if (isAbsolute(c.height)) {
            return getAbsolute(c.height);
        }

        var parent: Component = c;
        while (parent.parent != null) {
            parent = cast(parent.parent, Component);
            if (isAbsolute(parent.height)) {
                return getAbsolute(parent.height);
            }
        }

        return 0;
    }


}