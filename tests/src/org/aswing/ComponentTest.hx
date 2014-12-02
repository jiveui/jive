package org.aswing;

import massive.munit.Assert;

class ComponentTest  {
    @Test
    public function testCurrent() {
        var c = new decl.ComponentTest();
        Assert.isNotNull(c);
    }
}