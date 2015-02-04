package org.aswing;

import org.aswing.table.sorter.TableSorter;
import org.aswing.table.TableModel;
import org.aswing.table.DefaultTableModel;
import haxe.Timer;
import flash.events.Event;
import org.aswing.border.EmptyBorder;
import flash.Lib;
import massive.munit.Assert;

class JTableTest {
    @Test
    public function testXmlCreation() {
        AsWingManager.initAsStandard(Lib.current);
        var WINDOW: decl.JTableTest = new decl.JTableTest();

        var data: DefaultTableModel = new DefaultTableModel();
        data.initWithDataNames(
            [
                [1, "value1"],
                [2, "value2"],
                [3, "value3"],
                ["value4", 4],
                [5, "value5"],
                [1, "value1"],
                [2, "value2"],
                [3, "value3"],
                ["value4", 4],
                [5, "value5"],
                [1, "value1"],
                [2, "value2"],
                [3, "value3"],
                ["value4", 4],
                [5, "value5"],
                [1, "value1"],
                [2, "value2"],
                [3, "value3"],
                ["value4", 4],
                [5, "value5"],
                [1, "value1"],
                [2, "value2"],
                [3, "value3"],
                ["value4", 4],
                [5, "value5"],
                [1, "value1"],
                [2, "value2"],
                [3, "value3"],
                ["value4", 4],
                [5, "value5"],
                [1, "value1"],
                [2, "value2"],
                [3, "value3"],
                ["value4", 4],
                [5, "value5"],
                [1, "value1"],
                [2, "value2"],
                [3, "value3"],
                ["value4", 4],
                [5, "value5"],
                [1, "value1"],
                [2, "value2"],
                [3, "value3"],
                ["value4", 4],
                [5, "value5"],
                [1, "value1"],
                [2, "value2"],
                [3, "value3"],
                ["value4", 4],
                [5, "value5"]
            ],
            ["first", "second"]);

        var sorter: TableSorter = new TableSorter(data, WINDOW.table.tableHeader);

        WINDOW.table.dataModel = sorter;

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
