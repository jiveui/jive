package org.aswing;

import massive.munit.Assert;

class GridLayoutTest {
    @Test
    public function testXmlCreation() {
        var gl: GridLayout = new decl.GridLayoutTest();
        Assert.areEqual(3, gl.columns);
        Assert.areEqual(2, gl.rows);
        Assert.areEqual(5, gl.hgap);
        Assert.areEqual(10, gl.vgap);
    }

}
