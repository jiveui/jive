package jive;

import jive.themes.Theme;
import jive.geom.IntDimension;
import jive.geom.Metric;
import jive.geom.MetricDimension;
import openfl.Lib;
import openfl.events.Event;

class Jive {

    public static var theme:Theme;

    private static var windows:Array<Window> = [];
    private static var started:Bool;

    public static function openWindow(w:Window) {
        if (windows.indexOf(w) < 0) {
            Lib.current.addChild(w.displayObject);
            windows.push(w);
        }
    }

    public static function closeWindow(w:Window) {
        if (windows.indexOf(w) >= 0) {
            Lib.current.removeChild(w.displayObject);
            windows.remove(w);
        }

    }

    public static function start() {
        if (started) return;
        started = true;
        theme = new Theme();
        Lib.current.stage.addEventListener(Event.ENTER_FRAME, function(e) {
            for (w in windows) {
                w.paint(IntDimension.createNullDimension());
            }
        });
    }
}
