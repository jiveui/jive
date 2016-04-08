package jive;

import massive.munit.Assert;

class DataBindingTest {
    @Test
    public function testBinding() {
        var t: DataBindingTestTemplate = new DataBindingTestTemplate();
        Assert.isNull(t.s);
        Assert.areEqual(0, t.i);
        var context = new DataBindingModel();
        t.dataContext = context;
        Assert.areEqual("initial", t.s);
        Assert.areEqual(555, t.i);
        context.s = "new value";
        context.i = 111;
        Assert.areEqual("new value", t.s);
        Assert.areEqual(111, t.i);
        t.s = "two way value";
        t.i = 333;
        Assert.areEqual("new value", context.s);
        Assert.areEqual(333, context.i);
    }
}
