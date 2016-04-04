package org.aswing;

import massive.munit.Assert;
class ASFontTest {
    @Test
    public function testXmlCreation() {
        var f:ASFont = new decl.ASFontTest();
        Assert.isTrue(f.bold);
        Assert.isTrue(f.italic);
        Assert.isFalse(f.underline);
        Assert.areEqual(15, f.size);
        Assert.areEqual("Arial", f.name);
    }
}
