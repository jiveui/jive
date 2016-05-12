package jive;

class ScrollTest {
    public function new () {}
    //@Test
    public function test() {
        Jive.start();
        var w: TestScroll = new TestScroll();
        w.dataContext = new SvgTestModel();
        w.opened = true;
    }
}