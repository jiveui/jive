package jive;

import jive.geom.MetricInsets;
import openfl.geom.Matrix;
import jive.geom.IntPoint;
import openfl.geom.Rectangle;
import bindx.IBindable;
import openfl.display.Sprite;
import openfl.events.EventDispatcher;
import openfl.display.DisplayObject;
import openfl.events.Event;

import jive.geom.IntDimension;
import jive.geom.Metric;
import jive.geom.MetricDimension;

using jive.geom.MetricHelper;

@:bindable
class Component extends EventDispatcher implements IBindable {

    private var needsPaint:Bool = true;

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
        return switch (_width) {
            case absolute(v) : v;
            case percent(v) : (parent != null) ? Std.int(Math.round(parent.absoluteWidth * v / 100)) : 0;
            case virtual(v) : 0; // TODO virtual pixels
            case none: 0;
        }
    }

    public var absoluteHeight(get, never):Int;

    private function get_absoluteHeight():Int {
        return switch (_height) {
            case absolute(v) : v;
            case percent(v) : (parent != null) ? Std.int(Math.round(parent.absoluteHeight * v / 100)) : 0;
            case virtual(v) : 0; // TODO virtual pixels
            case none: 0;
        }
    }

    public var absoluteX(get, never):Int;

    private function get_absoluteX():Int {
        return switch (_x) {
            case absolute(v) : v;
            case percent(v) : (parent != null) ? Std.int(Math.round(parent.absoluteWidth * v / 100)) : 0;
            case virtual(v) : 0; // TODO virtual pixels
            case none: 0;
        }
    }

    public var absoluteY(get, never):Int;

    private function get_absoluteY():Int {
        return switch (_y) {
            case absolute(v) : v;
            case percent(v) : (parent != null) ? Std.int(Math.round(parent.absoluteHeight * v / 100)) : 0;
            case virtual(v) : 0; // TODO virtual pixels
            case none: 0;
        }
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
        if (needsPaint) {
            needsPaint = false;
            displayObject.scrollRect = new Rectangle(0, 0, absoluteWidth, absoluteHeight);
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
}

typedef EventListenerInfo = {
    public var type:String;
    public var listener:Dynamic -> Void;
    public var useCapture:Bool;
}