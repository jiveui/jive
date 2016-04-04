package org.aswing;

import flash.events.Event;
import org.aswing.border.EmptyBorder;
import flash.Lib;
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

    @Test
    public function testInAction() {
        AsWingManager.initAsStandard(Lib.current);
        var WINDOW = new decl.GridLayoutInAction();

        Assert.isNotNull(WINDOW);

        WINDOW.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
        WINDOW.setBorder(new EmptyBorder(null, Insets.createIdentic(10)));
        WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        WINDOW.show();

        Lib.current.stage.addEventListener(Event.RESIZE, function(e) {
            WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        });
    }

}
