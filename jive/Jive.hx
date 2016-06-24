package jive;

import jive.geom.DimensionRequest;
import openfl.display.DisplayObjectContainer;
import jive.themes.Theme;
import jive.geom.IntDimension;
import jive.geom.Metric;
import jive.geom.MetricDimension;
import openfl.Lib;
import openfl.events.Event;
import openfl.events.MouseEvent;

using jive.geom.MetricHelper;

class Jive {

    public static var theme:Theme;

    private static var windows:Array<Window> = [];
    private static var started:Bool;

    public static function openWindow(w:Window) {
        if (windows.indexOf(w) < 0) {
            Lib.current.addChild(w.sprite);
            windows.push(w);
        }
    }

    public static function closeWindow(w:Window) {
        if (windows.indexOf(w) >= 0) {
            Lib.current.removeChild(w.sprite);
            windows.remove(w);
        }

    }

    public static function start() {
        if (started) return;
        started = true;
        theme = new Theme();
        Lib.current.stage.addEventListener(Event.ENTER_FRAME, function(e) {
            for (w in windows) {
                w.paint(new IntDimension(w.absoluteWidth(), w.absoluteHeight()));
            }
        });

//        var stage = Lib.current.stage;
//
//        Lib.current.stage.addEventListener(MouseEvent.CLICK, function(e){
//             printChildren(Lib.current.stage, '');
//        });
    }

    public static function printChildren(doc: DisplayObjectContainer, ident: String) {
        trace(ident + ' ' + doc + ' name: ' + doc.name + ' ' + doc.numChildren);
        for(i in 0...doc.numChildren) {
            var child = doc.getChildAt(i);

            if (Std.is(child, DisplayObjectContainer)) {
                printChildren(cast(child, DisplayObjectContainer), ident == '' ? '  ' : ident + '  ');
            } else {
                trace(ident + ' ' + child + ' name: ' + child.name);
            }
        }
    }
}
