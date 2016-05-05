package jive;

import openfl.Lib;
import jive.geom.Metric;
import jive.geom.MetricDimension;

class SwiperTest {
	@Test
    public function testCommonBehaviour() {
        Jive.start();
        var w: SwiperTestTemplate = new SwiperTestTemplate();
        w.dataContext = new SvgTestModel();
        w.opened = true;
    }
}
