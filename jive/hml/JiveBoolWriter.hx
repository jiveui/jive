package jive.hml;

#if macro
import hml.xml.writer.DefaultStringWriter;
import hml.base.MatchLevel;
import hml.xml.Data;

class JiveBoolWriter extends DefaultStringWriter {
    override public function match(node:Node):MatchLevel {
        return node.superType == "Bool" ? ClassLevel : None;
    }

    override function writeFieldCtor(node:Node) {
        return node.cData != null ? node.cData : "false";
    }
}
#end