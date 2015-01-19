package org.aswing;

import flash.events.Event;
import org.aswing.border.EmptyBorder;
import flash.Lib;
import massive.munit.Assert;

class SoftBoxTest {
    @Test
    public function testXmlCreation() {
        AsWingManager.initAsStandard(Lib.current);
        var WINDOW: decl.SoftBoxTest = new decl.SoftBoxTest();

        Assert.isNotNull(WINDOW);
        Assert.areEqual(SoftBoxLayout.X_AXIS, WINDOW.left.axis);
        Assert.areEqual(SoftBoxLayout.Y_AXIS, WINDOW.right.axis);

        WINDOW.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
        WINDOW.setBorder(new EmptyBorder(null, Insets.createIdentic(10)));
        WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        WINDOW.show();

        Lib.current.stage.addEventListener(Event.RESIZE, function(e) {
            WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        });
    }

}
