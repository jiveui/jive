package org.aswing;

import flash.events.Event;
import org.aswing.border.EmptyBorder;
import flash.Lib;
import massive.munit.Assert;

class JFrameTest {
    @Test
    public function testXmlCreation() {
        AsWingManager.initAsStandard(Lib.current);
        var WINDOW: decl.JFrameTest = new decl.JFrameTest();
        Assert.isNotNull(WINDOW);
        WINDOW.show();
    }

}
