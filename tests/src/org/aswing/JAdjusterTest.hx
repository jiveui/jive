package org.aswing;

import haxe.Timer;
import flash.events.Event;
import org.aswing.border.EmptyBorder;
import flash.Lib;
import massive.munit.Assert;

class JAdjusterTest {
    @Test
    public function testXmlCreation() {
        AsWingManager.initAsStandard(Lib.current);
        var WINDOW: decl.JAdjusterTest = new decl.JAdjusterTest();
        var vm = new JAdjusterTestModel();
        WINDOW.dataContext = vm;
        vm.value = 5;

        var timer: Timer = new Timer(1000);
        timer.run = function() {
//            if (WINDOW.dataContext.value < 25) {
//                WINDOW.dataContext.value += 1;
//            } else {
//                WINDOW.dataContext.value = 0;
//            }
            untyped console.log(vm.value);
        }

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
