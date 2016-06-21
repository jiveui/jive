package jive;

import jive.geom.Metric;
import jive.geom.MetricDimension;
import openfl.display.DisplayObject;
import jive.geom.IntDimension;

using jive.tools.TypeTools;

typedef Constructible = {
    public function new():Void;
}

@:generic
class TemplatedComponent<T: (Constructible, Component, DataContextControllable<V>), V: (Constructible, ViewModel)> extends Component {

    override private function get_x():Metric { return if (null != templateInstance) templateInstance.x else super.get_x(); }

    override private function set_x(v:Metric):Metric { if (null != templateInstance) templateInstance.x = v else super.set_x(v); return v; }

    override private function get_y():Metric { return if (null != templateInstance) templateInstance.y else super.get_y(); }

    override private function set_y(v:Metric):Metric { if (null != templateInstance) templateInstance.y = v else super.set_y(v); return v; }

    override private function get_width():Metric { return if (null != templateInstance) templateInstance.width else super.get_width(); }

    override private function set_width(v:Metric):Metric {
        if (width != v) {
            repaint();
            if (null != templateInstance) templateInstance.width = v else width = v;
        }
        return v;
    }

    override private function get_height():Metric { return if (null != templateInstance) templateInstance.height else super.get_height(); }

    override private function set_height(v:Metric):Metric {
        if (height != v) {
            repaint();
            if (null != templateInstance) templateInstance.height = v else height = v;
        }
        return v;
    }

    public var templateInstance(default, null):T;

    public var template(get, set):Class<T>;
    private var _template:Class<T>;

    private function get_template():Class<T> { return _template; }

    private function set_template(v:Class<T>):Class<T> {
        _template = v;
        if (v != Type.getClass(templateInstance)) {
            templateInstance = Type.createInstance(v, []);
            sprite = templateInstance.sprite;
            if (null != templateModel) { templateInstance.dataContext = templateModel; }
            repaint();
        }
        return v;
    }

    public var templateModel(get, set):V;
    private var _templateModel:V;

    private function get_templateModel():V { return _templateModel; }

    private function set_templateModel(v:V):V {
        _templateModel = v;
        if (null != templateInstance) templateInstance.dataContext = v;
        repaint();
        return v;
    }

    public function new() {
        super();
    }

    override public function paint(size: IntDimension) {
        if (null != templateInstance) templateInstance.paint(size) else super.paint(size);
    }
}
