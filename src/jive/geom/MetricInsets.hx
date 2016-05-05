package jive.geom;

using jive.geom.MetricHelper;

class MetricInsets {

    public var bottom:Metric;
    public var top:Metric;
    public var left:Metric;
    public var right:Metric;

    public function new(top:Metric = null, left:Metric = null, bottom:Metric = null, right:Metric = null) {
        var noneIfNull = function(m) { return if (null != m) m else Metric.none; };
        this.top = noneIfNull(top);
        this.left = noneIfNull(left);
        this.bottom = noneIfNull(bottom);
        this.right = noneIfNull(right);
    }

    public function toInsets(component:Component):Insets {
        var w = if (null != component && null != component.parent) component.parent.absoluteWidth else 0;
        var h = if (null != component && null != component.parent) component.parent.absoluteWidth else 0;
        return new Insets(top.toAbsolute(h), left.toAbsolute(w), bottom.toAbsolute(h), right.toAbsolute(w));
    }
}