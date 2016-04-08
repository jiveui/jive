package jive;

import openfl.Assets;
import massive.munit.Assert;

class TemplatedComponentTest {
    @Test
    public function testBinding() {
        var t: TemplatedComponent<ExtendedComponentTemplate, DataBindingModel> = new TemplatedComponent<ExtendedComponentTemplate, DataBindingModel>();
        Assert.isNull(t.template);
        Assert.isNull(t.templateModel);
        Assert.isNull(t.templateInstance);

        t.template = DataBindingTestTemplate;
        t.templateModel = new DataBindingModel();
        Assert.areEqual("initial", t.templateModel.s);
        Assert.areEqual(555, t.templateModel.i);
        Assert.areEqual("initial", t.templateInstance.s);
        Assert.areEqual(555, t.templateInstance.i);

        var m = new DataBindingModel();
        m.i = 10;
        m.s = "qwe";
        t.templateModel = m;

        Assert.areEqual("qwe", t.templateInstance.s);
        Assert.areEqual(10, t.templateInstance.i);

        t.templateModel.i = 15;
        t.templateModel.s = "asd";

        Assert.areEqual("asd", t.templateInstance.s);
        Assert.areEqual(15, t.templateInstance.i);

        var old = t.templateInstance;
        t.template = DataBindingTestTemplate;
        Assert.isTrue(old == t.templateInstance);

        t.template = ExtendedComponentTemplate;
        Assert.isTrue(old != t.templateInstance);
        Assert.areEqual(null, t.templateInstance.s);
        Assert.areEqual(0, t.templateInstance.i);
    }
}
