package jive.hml;

import hml.xml.writer.DefaultNodeWriter;
import hml.base.MatchLevel;
import hml.xml.Data;

class JiveListWriter extends DefaultNodeWriter {
    override public function match(node:Node):MatchLevel {
        return isChildOf(node, macro : List) ? ClassLevel : None;
    }

    override function child(node:Node, scope:String, child:Node, method:Array<String>, assign = false) {
        if (assign) {
            method.push('$scope = ${universalGet(child)};');
        } else {
            method.push('$scope.push(${universalGet(child)});');
        }
    }
}