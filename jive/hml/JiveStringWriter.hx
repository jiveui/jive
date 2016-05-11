package jive.hml;

#if macro
import hml.base.MatchLevel;
import hml.xml.writer.DefaultNodeWriter;
import hml.xml.Data;
import hml.xml.writer.IHaxeWriter;

class JiveStringWriter extends DefaultNodeWriter {
    override public function match(node:Node):MatchLevel {
        return isChildOf(node, macro : String) ? CustomLevel(ClassLevel, 10) : None;
    }

    override public function writeAttribute(node:Node, scope:String, child:Node, writer:IHaxeWriter<Node>, method:Array<String>):Void {
        writeNodePos(child, method);
        if (child.oneInstance && child.children.length > 0 || child.nodes.length > 0) {
            writer.writeNode(child);
            method.push(assignOrBind(node, scope, child, universalGet(child), writer));
        } else {
            method.push(assignOrBind(node, scope, child, "'" + child.cData + "'", writer));
        }
    }

    override function writeFieldCtor(node:Node) {
        return node.cData != null ? node.cData : "\"\"";
    }
}
#end