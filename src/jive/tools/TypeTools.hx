package jive.tools;
class TypeTools {
    inline public static function as<T>( v : Dynamic, c : Class<T>) : Null<T> {
        if (Std.is(v, c)) {
            return cast v ;
        } else {
            return null;
        }
    }
}
