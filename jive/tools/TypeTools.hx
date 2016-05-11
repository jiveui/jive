package jive.tools;
class TypeTools {
    inline public static function as<T>(v:Dynamic, c:Class<T>):Null<T> {
        if (Std.is(v, c)) {
            return cast v ;
        } else {
            return null;
        }
    }

    public static function lastObjectOfChain(o: Dynamic, memberChain: String): Dynamic {
        var members = memberChain.split(".");
        for (m in members) {
            if (null == o) return null;
            o = Reflect.field(o, m);
        }
        return o;
    }
}
