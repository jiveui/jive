package jive;

import massive.munit.Assert;

class StateTest {
    @Test
    public function testOpened() {
        Jive.start();
        var w: TestWindow = new TestWindow();
        w.dataContext = new SvgTestModel();
        w.opened = true;
    }
}
