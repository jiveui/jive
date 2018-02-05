package jive.hml;

import hml.xml.Data.XMLData;
import hml.xml.XMLProcessor;
import hml.base.MatchLevel;
import hml.xml.adapters.base.MergedAdapter;
import hml.xml.adapters.IAdapter;
import hml.base.BaseFileProcessor;
import hml.xml.Data;
import hml.xml.TypeResolver;
import hml.xml.XMLReader;
import hml.xml.XMLWriter;

using hml.base.MatchLevel;


class JiveXmlProcessor extends XMLProcessor {
    static var HML_EXT = ~/.hml$/;

    public function new(adapters:Array<IAdapter<XMLData, Node, Type>>) {
        super(adapters);
    }

    override public function match(file:String):MatchLevel {
        return HML_EXT.match(file) ? GlobalLevel : None;
    }
}