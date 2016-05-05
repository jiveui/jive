package jive.hml;

#if macro
import hml.xml.typeResolver.DefaultXMLDataParser;
import haxe.macro.Context;
import hml.xml.typeResolver.IHaxeTypeResolver;

using hml.base.MacroTools;
using StringTools;

class JiveXMLDataParser extends DefaultXMLDataParser {
    public function new() { super(); }

    override function parseNode(node:Node, data:XMLData, parser:IXMLDataParser<XMLData, Node>) {
        node.superType = data.resolveType(data.name);
        if (node.superType == null)
            Context.error('can\'t resolve namespace', Context.makePosition(data.nodePos));

        if (node.superType.startsWith("empty.")) {
            node.superType = node.superType.substr(6);
        }

        node.model = data;
        node.name = data.name;
        node.cData = data.cData;

        processNode(node);

        parseAttributes(node, data, parser);

        if (node.name.name != "content" || node.parent.name.name != "Svg") {
            parseNodes(node, data, parser);
        }
    }
}
#end
