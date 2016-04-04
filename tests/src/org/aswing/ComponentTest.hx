package org.aswing;

import flash.Lib;
import massive.munit.Assert;

class ComponentTest  {
    @Test
    public function testCurrent() {
        AsWingManager.initAsStandard(Lib.current);
        var c = new decl.ComponentTest();
        Assert.isNotNull(c);

        Assert.areEqual(0.3, c.alignmentX);
        Assert.areEqual(0.7, c.alignmentY);

        Assert.areEqual(0x123456, c.background.rgb);
        Assert.areEqual(0.5, c.background.alpha);
        Assert.areEqual(0x654321, c.foreground.rgb);
        Assert.areEqual(0.1, c.foreground.alpha);
        Assert.areEqual(0x123123, c.mideground.rgb);
        Assert.areEqual(0.4, c.mideground.alpha);

        Assert.areEqual("org.aswing.SolidBackground", Type.getClassName(Type.getClass(c.backgroundDecorator)));

        Assert.areEqual(15, c.bounds.x);
        Assert.areEqual(16, c.bounds.y);
        Assert.areEqual(95, c.bounds.width);
        Assert.areEqual(96, c.bounds.height);

        Assert.areEqual(11, c.clipBounds.x);
        Assert.areEqual(12, c.clipBounds.y);
        Assert.areEqual(98, c.clipBounds.width);
        Assert.areEqual(99, c.clipBounds.height);

        Assert.isTrue(c.dragEnabled);
        Assert.isTrue(c.dropTrigger);
        Assert.isFalse(c.enabled);
        Assert.isFalse(c.focusable);
        Assert.isTrue(c.focusableSet);

        Assert.areEqual("org.aswing.EmptyFont", Type.getClassName(Type.getClass(c.font)));

        Assert.areEqual(500, c.maximumSize.width);
        Assert.areEqual(600, c.maximumSize.height);
        Assert.areEqual(10, c.minimumSize.width);
        Assert.areEqual(10, c.minimumSize.height);
        Assert.areEqual(100, c.preferredSize.width);
        Assert.areEqual(100, c.preferredSize.height);

        Assert.isTrue(c.opaque);
        Assert.isTrue(c.uiElement);
        Assert.isTrue(c.visibility);

        Assert.areEqual("org.aswing.StyleTune", Type.getClassName(Type.getClass(c.styleTune)));

        Assert.areEqual("Tooltip text!", c.toolTipText);

        Assert.areEqual("org.aswing.plaf.basic.BasicLabelUI", Type.getClassName(Type.getClass(c.ui)));
    }
}