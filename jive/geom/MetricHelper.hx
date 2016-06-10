package jive.geom;

class MetricHelper {
    static public function toAbsolute(m:Metric, d:Int = 0):Int {
        if (m == null) {
            return -1;
        } else {
            switch (m) {
                //TODO: implement virtual
                case virtual(v): return 0;
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
}