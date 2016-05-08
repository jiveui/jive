package jive.geom;

using jive.geom.MetricHelper;

class MetricDimension {
    public var width: Metric;
    public var height: Metric;

    public function new(width: Metric, height: Metric) {
        this.width = width;
        this.height = height;
    }

    public function toAbsolute(fullWidth: Int = 0, fullHeight: Int = 0): IntDimension {
        return new IntDimension(width.toAbsolute(fullWidth), height.toAbsolute(fullHeight));
    }

}