package jive;

class LayoutTest {
    @Test
    public function testEmptyLayout() {
        Jive.start();
        var w: TestLayout = new TestLayout();
        w.dataContext = new SvgTestModel();
        w.opened = true;
    }
}