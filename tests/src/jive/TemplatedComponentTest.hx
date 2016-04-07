package jive;

import massive.munit.Assert;

class TemplatedComponentTest {
    @Test
    public function testBinding() {
        var t: TemplatedComponent<DataBindingTestTemplate, DataBindingModel> = new TemplatedComponent<DataBindingTestTemplate, DataBindingModel>();
        Assert.isNotNull(t.template);
        Assert.isNotNull(t.templateModel);
        Assert.areEqual("initial", t.templateModel.s);
        Assert.areEqual(555, t.templateModel.i);
        Assert.areEqual("initial", t.templateInstance.s);
        Assert.areEqual(555, t.templateInstance.i);
//        context.s = "new value";
//        context.i = 111;
//        Assert.areEqual("new value", t.s);
//        Assert.areEqual(111, t.i);
//        t.s = "two way value";
//        t.i = 333;
//        Assert.areEqual("new value", context.s);
//        Assert.areEqual(333, context.i);
    }
}
