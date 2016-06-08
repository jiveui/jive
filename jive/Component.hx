package jive;

import jive.state.StateManager;
import jive.state.States;
import jive.state.State;
import haxe.ds.StringMap;
import jive.state.Statefull;
import jive.geom.MetricInsets;
import openfl.geom.Matrix;
import jive.geom.IntPoint;
import openfl.geom.Rectangle;
import bindx.IBindable;
import openfl.display.Sprite;
import openfl.events.EventDispatcher;
import openfl.display.DisplayObject;
import openfl.events.Event;
import openfl.geom.Point;

import jive.geom.IntDimension;
import jive.geom.Metric;
import jive.geom.MetricDimension;

using jive.geom.MetricHelper;

@:bindable
class Component extends EventDispatcher implements IBindable implements Statefull {

    private var needsPaint:Bool = true;

    public var state(get, set): String;
    private var _state: String;
    private function get_state(): String { return _state; }
    private function set_state(v: String): String {
        if (v == State.CHANGING || _state == State.CHANGING) {
            _state = v;
        } else {
            StateManager.changeTo(this, v);
        }
        return v;
    }

    public var name: String; // for debug
    public var states(get, set): States;
    private var _states: States;
    private function get_states(): States { return _states; }
    private function set_states(v: States): States {
        _states = v;
        return v;
    }

    public var x(get, set):Metric;
    private var _x:Metric;

    private function get_x():Metric { return _x; }

    private function set_x(v:Metric):Metric {
        _x = v;
        reposition();
        return v;
    }

    public var y(get, set):Metric;
    private var _y:Metric;

    private function get_y():Metric { return _y; }

    private function set_y(v:Metric):Metric {
        _y = v;
        reposition();
        return v;
    }

    public var width(get, set):Metric;
    private var _width:Metric;

    private function get_width():Metric { return _width; }

    private function set_width(v:Metric):Metric {
        if (_width != v) {
            repaint();
            _width = v;
        }
        return v;
    }

    public var height(get, set):Metric;
    private var _height:Metric;

    private function get_height():Metric { return _height; }

    private function set_height(v:Metric):Metric {
        if (_height != v) {
            repaint();
            _height = v;
        }
        return v;
    }

    public var margin:MetricInsets;

    public var dimension(get, never):IntDimension;

    private function get_dimension():IntDimension {
        return new IntDimension(Std.int(displayObject.width), Std.int(displayObject.height));
    }

    public var rotationAngle(get, set):Float;
    private var _rotationAngle:Float;

    private function get_rotationAngle():Float {
        return _rotationAngle;
    }

    private function set_rotationAngle(v:Float):Float {
        _rotationAngle = v;
        repaint();
        return v;
    }

    public var rotationPivot(get, set):IntPoint;
    private var _rotationPivot:IntPoint;

    private function get_rotationPivot():IntPoint { return _rotationPivot; }

    private function set_rotationPivot(v:IntPoint):IntPoint {
        _rotationPivot = v;
        repaint();
        return v;
    }

    public var alpha(get, set):Float;

    private function get_alpha():Float { return displayObject.alpha; }

    private function set_alpha(v:Float):Float {
        displayObject.alpha = v;
        return v;
    }

    public var displayObject(get, null):DisplayObject;

    private function get_displayObject():DisplayObject {
        if (null == displayObject) {
            displayObject = createDisplayObject();
        }
        return displayObject;
    }

    public var parent(default, set):Container;

    private function set_parent(c:Container):Container {
        return parent = c;
    }

    public var absoluteWidth(get, never):Int;

    private function get_absoluteWidth():Int {
        return _width.toAbsolute(if (parent == null) 0 else parent.absoluteWidth);
    }

    public var absoluteHeight(get, never):Int;

    private function get_absoluteHeight():Int {
        return _height.toAbsolute(if (parent == null) 0 else parent.absoluteHeight);
    }

    public var absoluteX(get, never):Int;

    private function get_absoluteX():Int {
        return _x.toAbsolute(if (parent == null) 0 else parent.absoluteWidth);
    }

    public var absoluteY(get, never):Int;

    private function get_absoluteY():Int {
        return _y.toAbsolute(if (parent == null) 0 else parent.absoluteHeight);
    }

    public function new() {
        super();
        x = Metric.absolute(0);
        y = Metric.absolute(0);
        width = Metric.none;
        height = Metric.none;
        margin = new MetricInsets();
    }

    private function createDisplayObject():DisplayObject {
        return new Sprite();
    }

    /**
    * destroy component
    * e.g. delete all bitmap graphics
    * and remove all listeners
    **/

    public function dispose() {
        for (l in listeners)
            displayObject.removeEventListener(l.type, l.listener, l.useCapture);
        listeners = null;
    }


    /**
    * start IEventDispatcher methods 
    **/

    private var listeners:Array<EventListenerInfo>;

    override public function addEventListener(type:String, listener:Dynamic -> Void, useCapture:Bool = false,
                                              priority:Int = 0, useWeakReference:Bool = false):Void {

        if (listeners == null) {
            listeners = new Array<EventListenerInfo>();
        }

        displayObject.addEventListener(type, listener, useCapture, priority, useWeakReference);

        listeners.push({
            type: type,
            listener: listener,
            useCapture: useCapture
        });
    }

    override public function dispatchEvent(event:Event):Bool {
        return displayObject.dispatchEvent(event);
    }

    override public function hasEventListener(type:String):Bool {
        return displayObject.hasEventListener(type);
    }

    override public function removeEventListener(type:String, listener:Dynamic -> Void, useCapture:Bool = false):Void {
        var found = listeners.filter(function(info:EventListenerInfo) {
            return info.type == type && info.listener == listener && info.useCapture == useCapture;
        });

        // should be only one
        for (f in found)
            listeners.remove(f);

        displayObject.removeEventListener(type, listener, useCapture);
    }

    override public function toString():String {
        return displayObject.toString();
    }

    override public function willTrigger(type:String):Bool {
        return displayObject.willTrigger(type);
    }

    /**
    * end IEventDispatcher methods
    **/

    public function paint(size: IntDimension): IntDimension {
        return processPaint(size);
    }

    private function processPaint(size: IntDimension): IntDimension {
        if (needsPaint) {
            needsPaint = false;
            // if there already is scrollRect adjust it width and height;
            if (displayObject.scrollRect != null) {
                var rect = displayObject.scrollRect;

                rect.width = absoluteWidth;
                rect.height = absoluteHeight;

                displayObject.scrollRect = rect;
            } else {
                displayObject.scrollRect = new Rectangle(0, 0, absoluteWidth, absoluteHeight);
            }

        }

        var insets = margin.toInsets(this);

        displayObject.x = x.toAbsolute(if (null != parent) parent.absoluteWidth else 0) + insets.left;
        displayObject.y = y.toAbsolute(if (null != parent) parent.absoluteHeight else 0) + insets.top;

        if (rotationPivot == null) {
            displayObject.rotation = rotationAngle;
        } else {
            var matrix:Matrix = new Matrix();
            matrix.translate(-rotationPivot.x, -rotationPivot.y);
            matrix.rotate((rotationAngle / 180) * Math.PI);
            matrix.translate(
                x.toAbsolute(if (null != parent) parent.absoluteWidth else 0) + rotationPivot.x,
                y.toAbsolute(if (null != parent) parent.absoluteHeight else 0) + rotationPivot.y);
            displayObject.transform.matrix = matrix;
        }


        return new IntDimension(Std.int(displayObject.width + insets.getMarginWidth()), Std.int(displayObject.height + insets.getMarginHeight()));
    }

    public function repaint() {
        needsPaint = true;
        if (parent != null) parent.repaintChildren();
    }

    public function reposition() {
        if (parent != null) parent.repaintChildren();
    }

    /**
    * Moved from old component
    **/
    public function globalToLocal(p:IntPoint):IntPoint{
        var np:Point = new Point(p.x, p.y);
        np = displayObject.globalToLocal(np);
        return new IntPoint(Std.int(np.x), Std.int(np.y));
    }

    /**
    * Converts local (inside component space) coordinates to the global space.
    *
    * @see Component.globalToLocal
    **/
    public function localToGlobal(p:IntPoint):IntPoint{
        var np:Point = new Point(p.x, p.y);
        np = displayObject.localToGlobal(np);
        return new IntPoint(Std.int(np.x), Std.int(np.y));
    }
}

typedef EventListenerInfo = {
    public var type:String;
    public var listener:Dynamic -> Void;
    public var useCapture:Bool;
}