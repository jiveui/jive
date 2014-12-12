package org.aswing;

import massive.munit.Assert;

class ASColorTest {
    @Test
    public function testXmlCreation() {
        var c = new decl.ASColorTest();
        Assert.areEqual(0x123456, c.rgb);
        Assert.areEqual(0.3, c.alpha);
    }
}
