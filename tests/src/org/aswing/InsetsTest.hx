package org.aswing;
import massive.munit.Assert;
class InsetsTest {
    @Test
    public function testXmlCreation() {
        var insets: Insets = new decl.InsetsTest();
        Assert.areEqual(1, insets.top);
        Assert.areEqual(2, insets.left);
        Assert.areEqual(3, insets.bottom);
        Assert.areEqual(4, insets.right);
    }
}
