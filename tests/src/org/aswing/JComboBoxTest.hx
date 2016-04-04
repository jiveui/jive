package org.aswing;

import haxe.Timer;
import flash.events.Event;
import org.aswing.border.EmptyBorder;
import flash.Lib;
import massive.munit.Assert;

class JComboBoxTest {
    @Test
    public function testXmlCreation() {
        AsWingManager.initAsStandard(Lib.current);
        var WINDOW: decl.JComboBoxTest = new decl.JComboBoxTest();
        var vm = new JComboBoxTestModel();
        vm.selected = null;
        vm.index = -1;
        WINDOW.dataContext = vm;

        Assert.isNotNull(WINDOW);

        var timer: Timer = new Timer(1000);
        timer.run = function() {
            untyped console.log(vm.selected);
            untyped console.log(vm.index);
        }

        WINDOW.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
        WINDOW.setBorder(new EmptyBorder(null, Insets.createIdentic(10)));
        WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        WINDOW.show();

        Lib.current.stage.addEventListener(Event.RESIZE, function(e) {
            WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        });
    }

}
