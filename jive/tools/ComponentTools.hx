package jive.tools;

import openfl.geom.Point;
import jive.geom.IntPoint;

class ComponentTools {
    /**
    * Moved from old component
    **/
    public static function globalToLocal(c: Component, p: IntPoint): IntPoint{
        var np:Point = new Point(p.x, p.y);
        np = c.sprite.globalToLocal(np);
        return new IntPoint(Std.int(np.x), Std.int(np.y));
    }

    /**
    * Converts local (inside component space) coordinates to the global space.
    *
    * @see Component.globalToLocal
    **/
    public static function localToGlobal(c: Component, p: IntPoint): IntPoint{
        var np:Point = new Point(p.x, p.y);
        np = c.sprite.localToGlobal(np);
        return new IntPoint(Std.int(np.x), Std.int(np.y));
    }}
