package org.aswing;

import flash.events.Event;
import org.aswing.border.EmptyBorder;
import flash.Lib;
import massive.munit.Assert;

class BorderLayoutTest {
    @Test
    public function testXmlCreation() {
        AsWingManager.initAsStandard(Lib.current);
        var panel = new decl.BorderLayoutTest();

        Assert.isNotNull(panel);
        Assert.isNotNull(panel.layout);

        Assert.areEqual(10, cast(panel.layout, BorderLayout).hgap);
        Assert.areEqual(20, cast(panel.layout, BorderLayout).vgap);

        var WINDOW = new JWindow(Lib.current);

        WINDOW.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));

        WINDOW.setBorder(new EmptyBorder(null, Insets.createIdentic(10)));
        WINDOW.setContentPane(panel);
        WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        WINDOW.show();

        Lib.current.stage.addEventListener(Event.RESIZE, function(e) {
            WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        });
    }

}
