package jive.hml;

#if macro
import haxe.macro.Context;
import lime.tools.MetaData;
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
		    new JMenuBarNodeAdapter(),
		    new JMenuNodeAdapter(),
		    new AbstractTabbedPaneAdapter(),
			new VectorListModelNodeAdapter(),
			new DefaultMutableTreeNodeAdapter(),
			new ContainerAdapter(),
			new ComponentAdapter(),
			new DisplayObjectAdapter(),
			new IEventDispatcherAdapter(),
			new JiveXMLAdapter(),
            new SvgIconAdapter(),
            new AssetIconAdapter(),
            new GradientBackgroundAdapter(),
            new AssetBackgroundAdapter(),
            new BaseCommandAdapter(),
            new DefaultTableColumnModelAdapter(),
            new AbstractTableModelAdapter(),
            new DecorateBorderAdapter(),
            new EmptyLayoutAdapter()
		]);
	}

	static public function register():Void {
		hml.Hml.registerProcessor(new JiveXmlProcessor([new JiveAdapter()]));
	}
}

class ComponentAdapter extends DisplayObjectAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
		if (baseType == null) baseType = macro : org.aswing.Component;
		if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 20);
		super(baseType, events, matchLevel);
    }

    override public function getNodeWriters():Array<IHaxeNodeWriter<Node>> {
        return [new ComponentWithMetaWriter(baseType, metaWriter, matchLevel)];
    }
}

class ComponentWithMetaWriter extends BaseNodeWithMetaWriter {
    function processBinding(childNode:Node, node:Node, scope:String, writer:IHaxeWriter<Node>, method:Array<String>) {
        var nodesToRemove = [];
        var n = childNode;
        if (n.cData != null && n.cData.indexOf('{Binding') == 0) {
            nodesToRemove.push(n);

            var binding:Binding = Binding.fromString(n.cData);

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
		if (baseType == null) baseType = macro : org.aswing.Container;
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
		if (t.indexOf("JPopup") >= 0 ||
            t.indexOf("JWindow") >= 0 ||
            t.indexOf("JFrame") >= 0 ||
            t.indexOf("Dialog") >= 0 ||
            t.indexOf("Dropdown") >= 0
        ) {
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

class StateAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : jive.state.State;
        if (matchLevel == null) matchLevel = ClassLevel;
        super(baseType, events, matchLevel);

    }
}

class TransformationAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : jive.state.Transformation;
        if (matchLevel == null) matchLevel = ClassLevel;
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
                var value:String = n.cData;
                value = value.replace("'", '"');

                var r:EReg = new EReg("{[^}]+}", "g");
                var startsWithLetter:EReg = new EReg("^[A-Za-z].*", "g");

                var expressions = [];
                r.map(value, function(r) {
                    var match:String = r.matched(0)
                    .replace("{", "")
                    .replace("}", "")
                    .trim();

                    var items = match.split(" ");
                    var expression = "";
                    for (item in items) {
                        expression +=
                            if (startsWithLetter.match(item)) {
                                "dataContext." + item + " ";
                            } else {
                                item + " ";
                            }
                    }
                    expressions.push(expression);
                    return "";
                });

                var svgPrefix = if (Std.is(node, hml.xml.Type)) "" else "res.";
                var generateContentName = svgPrefix + "generateContent";
                method.push(generateContentName + " = function() { var b = new StringBuf();");
                method.push("if (dataContext != null) { ");
                var parts = r.split(value);
                var i:Int = 0;
                for (p in parts) {
                    method.push('b.add(\'$p\');');
                    if (i < expressions.length) {
                        method.push('b.add(${expressions[i]});');
                        i += 1;
                    }
                }
                method.push("return b.toString();");
                method.push("} else { return null; }"); //dataContext nullness check
                method.push("}");

                if (expressions.length > 0) {
                    method.push("var onChange = function(from: Dynamic, to: Dynamic) { " + svgPrefix + "revalidate(); " + svgPrefix + "repaint(); } ");
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

class EmptyLayoutAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : org.aswing.EmptyLayout;
        if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 10);
        super(baseType, events, matchLevel);

    }
}

class AbstractTableModelAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : org.aswing.table.AbstractTableModel;
        if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 10);
        super(baseType, events, matchLevel);

    }
}


class DefaultTableColumnModelAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : org.aswing.table.DefaultTableColumnModel;
        if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 10);
        super(baseType, events, matchLevel);

    }
    override public function getNodeWriters():Array<IHaxeNodeWriter<Node>> {
        return [new DefaultTableColumnModelNodeWithMetaWriter(baseType, metaWriter, matchLevel)];
    }
}

class DefaultTableColumnModelNodeWithMetaWriter extends ComponentWithMetaWriter {
    override function child(node:Node, scope:String, child:Node, method:Array<String>, assign = false):Void {
        method.push('$scope.addColumn(${universalGet(child)});');
    }
}

class AbstractTabbedPaneAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
		if (baseType == null) baseType = macro : org.aswing.AbstractTabbedPane;
		if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 40);
		super(baseType, events, matchLevel);

    }
    override public function getNodeWriters():Array<IHaxeNodeWriter<Node>> {
		return [new AbstractTabbedPaneWithMetaWriter(baseType, metaWriter, matchLevel)];
	}
}

class AbstractTabbedPaneWithMetaWriter extends ComponentWithMetaWriter {
	override function child(node:Node, scope:String, child:Node, method:Array<String>, assign = false):Void {
		method.push('$scope.appendTabInfo(${universalGet(child)});');
	}
}

class DefaultMutableTreeNodeAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
		if (baseType == null) baseType = macro : org.aswing.tree.DefaultMutableTreeNode;
		if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 10);
		super(baseType, events, matchLevel);

    }
    override public function getNodeWriters():Array<IHaxeNodeWriter<Node>> {
		return [new DefaultMutableTreeNodeWithMetaWriter(baseType, metaWriter, matchLevel)];
	}
}

class DefaultMutableTreeNodeWithMetaWriter extends ComponentWithMetaWriter {
	override function child(node:Node, scope:String, child:Node, method:Array<String>, assign = false):Void {
		method.push('$scope.append(${universalGet(child)});');
	}
}

class VectorListModelNodeAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
		if (baseType == null) baseType = macro : org.aswing.VectorListModel;
		if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 10);
		super(baseType, events, matchLevel);

    }
    override public function getNodeWriters():Array<IHaxeNodeWriter<Node>> {
		return [new VectorListModelNodeWithMetaWriter(baseType, metaWriter, matchLevel)];
	}
}

class VectorListModelNodeWithMetaWriter extends ComponentWithMetaWriter {
	override function child(node:Node, scope:String, child:Node, method:Array<String>, assign = false):Void {
		method.push('$scope.append(${universalGet(child)});');
	}
}

class JMenuBarNodeAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
		if (baseType == null) baseType = macro : org.aswing.JMenuBar;
		if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 40);
		super(baseType, events, matchLevel);

    }
    override public function getNodeWriters():Array<IHaxeNodeWriter<Node>> {
		return [new JMenuBarNodeWithMetaWriter(baseType, metaWriter, matchLevel)];
	}
}

class JMenuBarNodeWithMetaWriter extends ComponentWithMetaWriter {
	override function child(node:Node, scope:String, child:Node, method:Array<String>, assign = false):Void {
		method.push('$scope.addMenu(${universalGet(child)});');
	}
}

class JMenuNodeAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
		if (baseType == null) baseType = macro : org.aswing.JMenu;
		if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 60);
		super(baseType, events, matchLevel);

    }
    override public function getNodeWriters():Array<IHaxeNodeWriter<Node>> {
		return [new JMenuNodeWithMetaWriter(baseType, metaWriter, matchLevel)];
	}
}

class JMenuNodeWithMetaWriter extends ComponentWithMetaWriter {
	override function child(node:Node, scope:String, child:Node, method:Array<String>, assign = false):Void {
		method.push('$scope.append(${universalGet(child)});');
	}
}

class AssetIconAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : org.aswing.AssetIcon;
        if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 10);
        super(baseType, events, matchLevel);

    }
}

class SvgIconAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : jive.SvgIcon;
        if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 20);
        super(baseType, events, matchLevel);

    }
}

class AssetBackgroundAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : org.aswing.AssetBackground;
        if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 10);
        super(baseType, events, matchLevel);

    }
}

class DecorateBorderAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : org.aswing.border.DecorateBorder;
        if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 10);
        super(baseType, events, matchLevel);

    }
}

class GradientBackgroundAdapter extends ComponentAdapter {
    public function new(?baseType:ComplexType, ?events:Map<String, MetaData>, ?matchLevel:MatchLevel) {
        if (baseType == null) baseType = macro : org.aswing.GradientBackground;
        if (matchLevel == null) matchLevel = CustomLevel(ClassLevel, 10);
        super(baseType, events, matchLevel);

    }
}

#end