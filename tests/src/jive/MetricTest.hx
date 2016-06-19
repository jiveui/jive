package jive;

import jive.geom.Metric;
import massive.munit.Assert;

using jive.geom.MetricHelper;

class MetricTest {
    @Test
    public function test() {
        var m: Metric;

        m = Metric.virtual(5);
        Assert.areEqual(0, m.toAbsolute());

        m = Metric.percent(5);
        Assert.areEqual(5, m.toAbsolute(100));
        Assert.areEqual(25, m.toAbsolute(500));

        m = Metric.absolute(5);
        Assert.areEqual(5, m.toAbsolute(100));

        m = Metric.none;
        Assert.areEqual(0, m.toAbsolute());

    }
}