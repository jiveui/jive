package jive;

import jive.geom.Metric;
import jive.geom.Metric;
import jive.geom.PaintDimension;
import openfl.Lib;
import massive.munit.Assert;

class WindowTest {
    @Test
    public function testOpened() {
        Jive.start();
        var w: TestWindow = new TestWindow();
        w.dataContext = new SvgTestModel();
        w.opened = true;
    }
}
