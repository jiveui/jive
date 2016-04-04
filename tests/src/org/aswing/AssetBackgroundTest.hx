package org.aswing;

import flash.events.Event;
import org.aswing.border.EmptyBorder;
import flash.Lib;
import massive.munit.Assert;

class AssetBackgroundTest {
    @Test
    public function testXmlCreation() {

        AsWingManager.initAsStandard(Lib.current);
        var bg: AssetBackground = new decl.AssetBackgroundTest();

        Assert.isNotNull(bg);
        Assert.isNotNull(bg.asset);

        var WINDOW = new JWindow(Lib.current);
        var panel = new JPanel();
        panel.append(new JButton("Test!"));
        panel.backgroundDecorator = bg;

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