package jive.hml;

#if macro
import haxe.macro.Context;
import hml.xml.typeResolver.IHaxeTypeResolver;
import hml.xml.Data;


using jive.tools.TypeTools;

class JiveTypeResolver implements IHaxeTypeResolver<Node, Type> {
    static private var imports:String = "import openfl.Lib; import jive.*; import org.aswing.*; import org.aswing.geom.*;";


    public var types:Map<String, Type>;

    public function new() {}

    public function getNativeType(node:Node):Null<haxe.macro.Type> {
        var p = node;
        while (null != p && !Std.is(p, hml.xml.Type)) {
            p = p.parent;
        }
        if (p != null) {
            var t:hml.xml.Type = p.as(hml.xml.Type);
            if (null == t.script || t.script.indexOf(imports) < 0) {
                t.script = imports + "\n" + (if (null != t.script) t.script else "");
            }
        }
        return null;
    }

    public function getFieldNativeType(node:Node, qName:XMLQName):Null<haxe.macro.Type> {
        return if ("dataContext" == qName.name) Context.getType("Dynamic") else null;
    }
}
#end
