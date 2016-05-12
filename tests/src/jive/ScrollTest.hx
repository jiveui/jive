package jive;

class ScrollTest {
    @Test
    public function testScroll() {
        Jive.start();
        var w: TestScroll = new TestScroll();
        w.dataContext = new SvgTestModel();
        w.opened = true;
    }
}