package jive.tools;
class TypeTools {
    inline public static function as<T>(v:Dynamic, c:Class<T>):Null<T> {
        if (Std.is(v, c)) {
            return cast v ;
        } else {
            return null;
        }
    }

    inline public static function lastObjectOfChain(o: Dynamic, memberChain: String): Dynamic {
        var members = memberChain.split(".");
        for (m in members) {
            if (null == o) return null;
            if (Reflect.hasField(o, m)) {
                o = Reflect.getProperty(o, m);
            } else {
                return null;
            }
        }
        return o;
    }
}
