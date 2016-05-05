package jive.hml;

#if macro
import hml.xml.reader.IXMLParser;
import com.tenderowls.xml176.Xml176Parser.Xml176Document;
import hml.xml.Data;
import hml.xml.reader.DefaultXMLElementParser;
import hml.xml.Data;


using hml.base.MatchLevel;
using hml.xml.Data;
using StringTools;

class JiveXMLElementParser extends DefaultXMLElementParser {
    public function new() {
        super();
    }

    override function parseData(res:XMLData, xmlNode:Xml176Document, parent:XMLData, parser:IXMLParser<XMLData>) {
        var node = xmlNode.document;
        if (parent.name.name == "Svg" && node.nodeName == "content") {
            res.name = node.nodeName.toXMLQName();
            res.nodePos = posToXMLDataPos(xmlNode, xmlNode.getNodePosition(node));
            res.parent = parent;
            res.root = parent != null ? parent.root : null;
            for (c in node) {
                var data = c.toString();
                if (data.length > 0)
                    res.cData = res.cData == null ? data : res.cData + "\n" + data;
            }
            if (res.cData != null) {
                res.cData = "<svg>\n" + res.cData + "</svg>\n";
            }
            return res;
        } else {
            return super.parseData(res, xmlNode, parent, parser);
        }
    }
}
#end