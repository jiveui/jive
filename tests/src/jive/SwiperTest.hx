package jive;

import openfl.Lib;
import jive.geom.Metric;
import jive.geom.MetricDimension;

class SwiperTest {
    public function new () {
        
    }
	// @Test
    public function test() {
        Jive.start();
        var w: SwiperTestTemplate = new SwiperTestTemplate();
        w.dataContext = new SvgTestModel();
        w.opened = true;
    }
}
