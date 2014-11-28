package org.aswing.hml;

#if macro
import hml.xml.writer.DefaultNodeWriter;
import hml.xml.writer.IHaxeWriter;
import hml.xml.adapters.base.MergedAdapter;

import hml.base.MatchLevel;
import hml.xml.Data;

import hml.xml.adapters.FlashAdapter;
import hml.xml.adapters.base.BaseMetaAdapter;

import haxe.macro.Expr;

using haxe.macro.Context;
using haxe.macro.Tools;

using StringTools;
using Lambda;
#end

#if macro
class AswingAdapter extends MergedAdapter<XMLData, Node, Type> {
	public function new() {
		super([
			new ContainerAdapter(),
			new ComponentAdapter(),
			new DisplayObjectAdapter(),
			new IEventDispatcherAdapter(),
			new hml.xml.adapters.DefaultXMLAdapter()
		]);
	}

	static public function register():Void {
		hml.Hml.registerProcessor(new hml.xml.XMLProcessor([new AswingAdapter()]));
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
	override function writeNodes(node:Node, scope:String, writer:IHaxeWriter<Node>, method:Array<String>) {
		var nodesToRemove = [];
		for (n in node.nodes) {
			if (n.cData != null && n.cData.indexOf('{Binding') >= 0) {
				nodesToRemove.push(n);

				var mode = 'oneway'; //once, oneway, twoway

                var trimmed = n.cData.replace('{Binding','').replace('}','').trim();
				var sourcePropertyName = trimmed;

				// set mode
				if (trimmed.indexOf(" ") >= 0) {
                    var splitted = trimmed.split(" ");
                    sourcePropertyName = splitted[0];
                    if (splitted[1].startsWith("mode=")) {
                    	var m = splitted[1].split("=");
                    	mode = m[1];
                    }
				}

				var valueSource = 'this.dataContext.' + sourcePropertyName;
				var propertyName = scope + "." + n.name.name;

				method.push('if (null != dataContext) { $propertyName = $valueSource; }');

				if (mode.indexOf("way") > 0) {
					method.push('var programmaticalyChange = false;');

					method.push('var sourcePropertyListener = function(_,_) {
						if (!programmaticalyChange) {
							programmaticalyChange = true;
							$propertyName = $valueSource;
							programmaticalyChange = false;
						}
					};');
					method.push('var bindSourceListener = function() { bindx.Bind.bindx($valueSource, sourcePropertyListener); }');
					method.push('if (null != dataContext) { bindSourceListener(); }');
					method.push('bindx.Bind.bindx(this.dataContext, function(old,_) {
							if (null != old) { bindx.Bind.unbindx(old.$sourcePropertyName, sourcePropertyListener);}
							if (null != this.dataContext) {
								$propertyName = $valueSource;
								bindSourceListener();
							}
						});
					');

					if (mode == "twoway") {
						method.push('var propertyListener = function(_,_) {
							if (!programmaticalyChange && null != this.dataContext) {
								programmaticalyChange = true;
								$valueSource = $propertyName;
								programmaticalyChange = false;
							}
						};');
						method.push('bindx.Bind.bindx($propertyName, propertyListener);');
						method.push('bindx.Bind.bindx(this.dataContext, function(old,_) {
						 	if (null != this.dataContext) {
								$valueSource = $propertyName;
							}
						});');
					}
				}
			}
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
		if (t.indexOf("JPopup") >= 0 || t.indexOf("JWindow") >= 0 || t.indexOf("JFrame") >= 0) return;

		method.push('$scope.append(${universalGet(child)});');
	}
}

#end