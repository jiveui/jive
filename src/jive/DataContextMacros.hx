package jive;

#if macro
import haxe.macro.Type;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;
using Lambda;

class DataContextMacros {
	static var processed:Map<String, Bool> = new Map();

    public static function build():Array<Field> {
        var res = Context.getBuildFields();
        var type = Context.getLocalClass();
        var classType:ClassType = type.get();
        if (classType.isInterface) return res;

        var typeName = type.toString();
        if (processed.exists(typeName)) return res;
        processed[typeName] = true;

        var add = [];

        var contextInterfaces = classType.interfaces.filter(function(i) { return i.t.toString() == "jive.DataContextControllable"; });
        if (contextInterfaces.length > 0) {
            var param = contextInterfaces[0].params[0];
            var typeName = switch (param) {
                case TInst(name, _): Std.string(name);
                default: null;
            }
            add.push( {
                name: "dataContext",
                pos:Context.currentPos(),
                access: [APublic],
                meta: [ {pos: Context.currentPos(), params: null, name: ":bindable"}],
                doc: null,
                kind:FVar(Context.toComplexType(Context.getType(typeName)))
            });
        }

        return res.concat(add);
    }
}
#end
