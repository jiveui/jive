package jive.hml;

#if macro
import haxe.macro.Context;
import hml.xml.typeResolver.IHaxeTypeResolver;
import hml.xml.Data;

class JiveTypeResolver implements IHaxeTypeResolver<Node, Type> {
    public var types:Map<String, Type>;

    public function new() {}

    public function getNativeType(node:Node):Null<haxe.macro.Type> { return null; }

    public function getFieldNativeType(node:Node, qName:XMLQName):Null<haxe.macro.Type> {
        return if ("dataContext" == qName.name)  Context.getType("Dynamic") else null;
    }
}
#end
