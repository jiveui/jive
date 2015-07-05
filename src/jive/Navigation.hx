package jive;

import org.aswing.AsWingUtils;
import org.aswing.JMenuItem;
import haxe.ds.StringMap;
import org.aswing.MenuElement;
class Navigation {
    public static var instance(get, null): Navigation;
    private static var _instance: Navigation;
    private static function get_instance(): Navigation {
        if (null == _instance) {
            _instance = new Navigation();
        }
        return _instance;
    }

    private var routes: StringMap<(Void->Void)->Void>;

    public var activePath: Array<Dynamic>;

    private function new() {
        routes = new StringMap<(Void->Void)->Void>();
    }

    /**
    * @param path A path string
    * @param handler A function to make a navigation to a specific path. It gets a callback as a parameter.
    */
    public function addRoute(path: String, handler: (Void -> Void) -> Void) {
        if (null != handler) {
            routes.set(path, handler);
        }
    }

    public function navigate(path: Array<Dynamic>, ?after: Void -> Void, ?runHandler: Bool = true) {
        if (null != activePath)
            for (a in activePath)
                a.repaint();

        activePath = path;
        var pathString = getPathStringByMenuElements(path);
        if (routes.exists(pathString) && runHandler) {
            routes.get(pathString)(after);
        }

        if (null != path)
            for (a in path)
                a.repaint();
    }

    private function getPathStringByMenuElements(path: Array<Dynamic>): String {
        var res = "";
        for (me in path) {
            var mi: JMenuItem = AsWingUtils.as(me, JMenuItem);
            if (null == mi) continue;
            res += "/" + mi.subpath;
        }
        return res;
    }

    public function isMenuElementActive(me: MenuElement) {
        return null != activePath && Lambda.exists(activePath, function(e) { return e == me; });
    }
}
