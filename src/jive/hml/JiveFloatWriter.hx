package jive.hml;

#if macro
import hml.xml.writer.DefaultStringWriter;
import hml.base.MatchLevel;

class JiveFloatWriter extends DefaultStringWriter {
    override public function match(node:Node):MatchLevel {
        return node.superType == "Float" ? ClassLevel : None;
    }

    override function writeFieldCtor(node:Node) {
        return node.cData != null ? node.cData : "0.0";
    }
}
#end