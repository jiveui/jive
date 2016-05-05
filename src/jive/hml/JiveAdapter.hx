package jive.hml;

#if macro
import haxe.macro.Context;
import lime.project.MetaData;
import haxe.rtti.CType.MetaData;
import hml.xml.writer.DefaultNodeWriter;
import hml.xml.writer.IHaxeWriter;
import hml.xml.adapters.base.MergedAdapter;

import hml.base.MatchLevel;
import hml.xml.Data;
import hml.xml.Data.XMLData;

import hml.xml.adapters.FlashAdapter;
import hml.xml.adapters.base.BaseMetaAdapter;

import haxe.macro.Expr;

using haxe.macro.Context;
using haxe.macro.Tools;

using StringTools;
using Lambda;
#end

#if macro
class JiveAdapter extends MergedAdapter<XMLData, Node, Type> {
	public function new() {
		super([
            new SvgAdapter(),
			new ContainerAdapter(),
			new ComponentAdapter(),
			new DisplayObjectAdapter(),
			new IEventDispatcherAdapter(),
			new JiveXMLAdapter(),
            new BaseCommandAdapter()
		]);
	}

	static public function register():Void {
		hml.Hml.registerProcessor(new hml.xml.XMLProcessor([new JiveAdapter()]));
	}
}

class ComponentAdapter extends DisplayObjectAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
		if (baseType == null) baseType = macro : jive.Component;
		if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 20);
		super(baseType, events, matchLevel);
    }

    override public function getNodeWriters():Array<IHaxeNodeWriter<Node>> {
		return [new ComponentWithMetaWriter(baseType, metaWriter, matchLevel)];
	}
}

class ComponentWithMetaWriter extends BaseNodeWithMetaWriter {
    function processBinding(childNode: Node, node:Node, scope:String, writer:IHaxeWriter<Node>, method:Array<String>) {
        var nodesToRemove = [];
        var n = childNode;
        if (n.cData != null && n.cData.indexOf('{Binding') == 0) {
            nodesToRemove.push(n);

            var binding: Binding = Binding.fromString(n.cData);

            var valueSource = 'this.dataContext.' + binding.propertyName;
            var propertyName = scope + "." + n.name.name;

            method.push('{');

            method.push('if (null != dataContext) { $propertyName = $valueSource; }');

            if (binding.mode == BindingMode.oneway || binding.mode == BindingMode.twoway) {
                method.push('var programmaticalyChange = false;');

                method.push('var sourcePropertyListener = function(_,_) {
						if (!programmaticalyChange) {
							programmaticalyChange = true;
							$propertyName = $valueSource;
							programmaticalyChange = false;
						}
					};');
                method.push('var bindSourceListener = function() { bindx.Bind.bind($valueSource, sourcePropertyListener); }');
                method.push('if (null != dataContext) { bindSourceListener(); }');
                method.push('bindx.Bind.bind(this.dataContext, function(old,_) {
							if (null != old) { bindx.Bind.unbind(old.${binding.propertyName}, sourcePropertyListener);}
							if (null != this.dataContext) {
								$propertyName = $valueSource;
								bindSourceListener();
							}
						});
					');

                if (binding.mode == BindingMode.twoway) {
                    method.push('var propertyListener = function(_,_) {
							if (!programmaticalyChange && null != this.dataContext) {
								programmaticalyChange = true;
								$valueSource = $propertyName;
								programmaticalyChange = false;
							}
						};');
                    method.push('bindx.Bind.bind($propertyName, propertyListener);');
                    method.push('bindx.Bind.bind(this.dataContext, function(old,_) {
						 	if (null != this.dataContext) {
								$valueSource = $propertyName;
							}
						});');
                }
            }

            method.push('}');
        }
        return nodesToRemove;
    }
	override function writeNodes(node:Node, scope:String, writer:IHaxeWriter<Node>, method:Array<String>) {
		var nodesToRemove = [];
		for (n in node.nodes) {
            nodesToRemove = nodesToRemove.concat(processBinding(n, node, scope, writer, method));
		}
		for (n in nodesToRemove) {
			node.nodes.remove(n);
		}
		super.writeNodes(node, scope, writer, method);
	}
}

class ContainerAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
		if (baseType == null) baseType = macro : jive.Container;
		if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 30);
		super(baseType, events, matchLevel);

    }
    override public function getNodeWriters():Array<IHaxeNodeWriter<Node>> {
		return [new ContainerWithMetaWriter(baseType, metaWriter, matchLevel)];
	}
}

class ContainerWithMetaWriter extends ComponentWithMetaWriter {
	override function child(node:Node, scope:String, child:Node, method:Array<String>, assign = false):Void {
		var t = child.superType;
		if (t.indexOf("Popup") >= 0 || t.indexOf("Window") >= 0 || t.indexOf("Frame") >= 0 || t.indexOf("Dialog") >= 0) {
            method.push('${universalGet(child)}.owner = null;');
        } else if (assign){
            method.push('$scope = ${universalGet(child)};');
        } else {
            method.push('$scope.append(${universalGet(child)});');
        }
	}
}

class BaseCommandAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : jive.BaseCommand;
        if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 10);
        super(baseType, events, matchLevel);

    }
}

class SvgAdapter extends DisplayObjectAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : jive.Svg;
        if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 30);
        super(baseType, events, matchLevel);
    }

    override public function getNodeWriters():Array<IHaxeNodeWriter<Node>> {
        return [new SvgWithMetaWriter(baseType, metaWriter, matchLevel)];
    }
}

class SvgWithMetaWriter extends ComponentWithMetaWriter {
    override function writeNodes(node:Node, scope:String, writer:IHaxeWriter<Node>, method:Array<String>) {

        var nodesToRemove = [];
        for (n in node.nodes) {

            nodesToRemove = nodesToRemove.concat(processBinding(n, node, scope, writer, method));

            //Process SVG content
            if (n.name.name == 'content') {
                nodesToRemove.push(n);
                var propertyName = scope + ".content";
                var value: String = n.cData;
                value = value.replace("'", '"');

                var r: EReg = new EReg("{[^}]+}", "g");
                var startsWithLetter: EReg = new EReg("^[A-Za-z].*", "g");

                var expressions = [];
                r.map(value, function(r) {
                    var match: String = r.matched(0)
                                            .replace("{", "")
                                            .replace("}", "")
                                            .trim();

                    var items = match.split(" ");
                    var expression = "";
                    for (item in items) {
                        expression +=
                            if (item.startsWith("virtual(") || item.startsWith("absolute(")) {
                                "jive.geom.MetricHelper.toAbsolute(jive.geom.Metric." + item + ") ";
                            } else if (item.startsWith("widthPercent(")) {
                                "jive.geom.MetricHelper.toAbsolute(jive.geom.Metric." + item.replace("widthP", "p") + ", " + scope + ".absoluteWidth) ";
                            } else if (item.startsWith("heightPercent(")) {
                                "jive.geom.MetricHelper.toAbsolute(jive.geom.Metric." + item.replace("heightP", "p") + ", " + scope + ".absoluteHeight) ";
                            } else if (startsWithLetter.match(item)){
                                "dataContext." + item + " ";
                            } else {
                                item + " ";
                            }

                    }
                    expressions.push(expression);
                    return "";
                });

                var svgPrefix = if (Std.is(node, hml.xml.Type)) "" else "res.";
                var generateContentName = svgPrefix +  "generateContent";
                method.push(generateContentName + " = function() { var b = new StringBuf();");
                var parts = r.split(value);
                var i: Int = 0;
                for (p in parts) {
                    method.push('b.add(\'$p\');');
                    if (i < expressions.length) {
                        method.push('b.add(${expressions[i]});');
                        i += 1;
                    }
                }
                method.push("return b.toString(); }");

                if (expressions.length > 0) {
                    method.push("var onChange = function(from: Dynamic, to: Dynamic) { " + svgPrefix+ "repaint(); } ");
                    method.push("var subscribe = function() {");
                    for (e in expressions) {
                        if (e.startsWith("dataContext.")) {
                            method.push("bindx.BindExt.chain(" + e + ", onChange);");
                        }
                    }
                    method.push("};");
                    method.push('if (null != dataContext) { subscribe(); }');
                    method.push('bindx.Bind.bind(this.dataContext, function(old,_) {
							if (null != this.dataContext) {
								subscribe();
							}
						});
					');
                }
            }
        }
        for (n in nodesToRemove) {
            node.nodes.remove(n);
        }
        super.writeNodes(node, scope, writer, method);
    }
}
#end