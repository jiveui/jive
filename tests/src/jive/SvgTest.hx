package jive;

import jive.geom.Metric;
import jive.geom.PaintDimension;
import openfl.Lib;
import massive.munit.Assert;

class SvgTest {
    @Test
    public function testPaint() {
        var svg = new Svg();
        svg.content = '<svg>
                            <circle cx="50" cy="50" r="40" stroke="#000000" stroke-width="3" fill="#ff0000" />
                       </svg>';
        svg.paint(PaintDimension.none);
        Lib.current.addChild(svg.displayObject);
    }

    @Test
    public function testContentBinding() {
        var c: TemplatedComponent<SvgTestTemplate, SvgTestModel> = new TemplatedComponent<SvgTestTemplate, SvgTestModel>();
        c.template = SvgTestTemplate;
        c.templateModel = new SvgTestModel();
        c.paint(PaintDimension.none);
        Lib.current.addChild(c.displayObject);
    }
}
