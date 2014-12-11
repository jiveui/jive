package org.aswing;

import massive.munit.Assert;
import flash.Lib;

class BordersTest {
    @Test
    public function testEmptyBorder() {
        AsWingManager.initAsStandard(Lib.current);
        var c = new decl.EmptyBorderTest();
        Assert.isNotNull(c);

        Assert.areEqual(100, c.top);
        Assert.areEqual(200, c.left);
        Assert.areEqual(300, c.bottom);
        Assert.areEqual(400, c.right);
    }
}
