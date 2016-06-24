package jive;

import jive.geom.IntDimension;
import jive.geom.Metric;
import jive.geom.MetricDimension;
import openfl.Lib;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import massive.munit.util.Timer;

using jive.geom.MetricHelper;

class SvgTest {
    @Test
    public function testPaint() {
        var svg = new Svg();
        svg.content = '<svg>
                            <circle cx="50" cy="50" r="40" stroke="#000000" stroke-width="3" fill="#ff0000" />
                       </svg>';
        svg.paint(IntDimension.createNullDimension());
        Lib.current.addChild(svg.sprite);
    }

    @Test
    public function testContentBinding() {
        var c: TemplatedComponent<SvgTestTemplate, SvgTestModel> = new TemplatedComponent<SvgTestTemplate, SvgTestModel>();
        c.template = SvgTestTemplate;
        c.templateModel = new SvgTestModel();
        c.width = Metric.absolute(Lib.current.stage.stageWidth);
        c.height = Metric.absolute(Lib.current.stage.stageHeight);
        c.paint(IntDimension.createNullDimension());
        Lib.current.addChild(c.sprite);
    }

    @Test
    public function testMetricCalculations(factory: AsyncFactory) {
        Jive.start();
        var w: SvgMetricCalculationWindow = new SvgMetricCalculationWindow();
        w.opened = true;
        w.paint(IntDimension.createNullDimension());

        Assert.areEqual(0, w.svg.x);
        Assert.areEqual(0, w.svg.y);
        Assert.areEqual(Std.int(Lib.current.stage.stageWidth * 0.3), w.svg.absoluteWidth());
        Assert.areEqual(Std.int(Lib.current.stage.stageHeight * 0.3), w.svg.absoluteHeight());
        Assert.isTrue(w.svg.generateContent().indexOf('width="300"') >= 0);
        Assert.isTrue(w.svg.generateContent().indexOf('height="210"') >= 0);
    }
}
