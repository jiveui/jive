package org.aswing;

import flash.events.Event;
import org.aswing.border.EmptyBorder;
import flash.Lib;
import massive.munit.Assert;

class AssetIconTest {
    @Test
    public function testXmlCreation() {

        AsWingManager.initAsStandard(Lib.current);
        var icon: AssetIcon = new decl.AssetIconTest();

        Assert.isNotNull(icon);

        Assert.areEqual(30, icon.width);
        Assert.areEqual(40, icon.height);

        var WINDOW = new JWindow(Lib.current);
        var panel = new JPanel();
        panel.append(new JButton("Test!", icon));

        WINDOW.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));

        WINDOW.setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 4)));
        WINDOW.setContentPane(panel);
        WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        WINDOW.show();

        Lib.current.stage.addEventListener(Event.RESIZE, function(e) {
            WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        });
    }
}