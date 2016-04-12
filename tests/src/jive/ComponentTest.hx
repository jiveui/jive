package jive;

import jive.geom.Metric;
import massive.munit.Assert;

class ComponentTest {
    @Test
    public function testMetrics() {
        var c1: Container = new Container();
        c1.width = Metric.absolute(500);
        c1.height = Metric.absolute(1000);

        var c2: Container = new Container();
        c2.width = Metric.percent(60);//300
        c2.height = Metric.percent(60);//600
        c1.append(c2);

        var c3: Component = new Component();
        c3.width = Metric.percent(50);//150
        c3.height = Metric.percent(50);//300
        c2.append(c3);

        Assert.areEqual(150, c3.absoluteWidth);
        Assert.areEqual(300, c3.absoluteHeight);
    }
}
