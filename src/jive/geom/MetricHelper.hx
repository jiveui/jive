package jive.geom;

class MetricHelper {
    static public function toAbsolute(m: Metric, d: Int = 0): Int {
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
}