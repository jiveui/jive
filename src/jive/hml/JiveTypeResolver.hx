package jive.hml;

#if macro
import haxe.macro.Context;
import hml.xml.typeResolver.IHaxeTypeResolver;
import hml.xml.Data;

using jive.tools.TypeTools;

class JiveTypeResolver implements IHaxeTypeResolver<Node, Type> {
//    private var imports: String = "using jive.geom.MetricHelper;";


    public var types:Map<String, Type>;

    public function new() {}

    public function getNativeType(node:Node):Null<haxe.macro.Type> {
//        var p = node;
//        while (null != p && Std.is(p, hml.xml.Type)) {
//            p = p.parent;
//        }
//        if (p != null) {
//            var t: hml.xml.Type = p.as(hml.xml.Type);
//            if (t.script.indexOf())
//        }
        return null;
    }

    public function getFieldNativeType(node:Node, qName:XMLQName):Null<haxe.macro.Type> {
        return if ("dataContext" == qName.name)  Context.getType("Dynamic") else null;
    }
}
#end
