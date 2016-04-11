package jive;

import jive.geom.PaintDimension;
import openfl.display.DisplayObject;
import jive.geom.IntDimension;

using jive.tools.TypeTools;

typedef Constructible = {
    public function new():Void;
}

@:generic
class TemplatedComponent<T: (Constructible, Component, DataContextControllable<V>), V: (Constructible, ViewModel)> extends Component {

    public var templateInstance(default, null): T;

    public var template(get, set): Class<T>;
    private var _template: Class<T>;
    private function get_template(): Class<T> { return _template; }
    private function set_template(v: Class<T>): Class<T> {
        _template = v;
        if (v != Type.getClass(templateInstance)) {
            templateInstance = Type.createInstance(v, []);
            if (null != templateModel) { templateInstance.dataContext = templateModel; }
            repaint();
        }
        return v;
    }

    override private function get_displayObject(): DisplayObject {
        return if (null != templateInstance) return templateInstance.displayObject else super.get_displayObject();
    }

    public var templateModel(get, set): V;
    private var _templateModel: V;
    private function get_templateModel(): V { return _templateModel; }
    private function set_templateModel(v: V): V {
        _templateModel = v;
        if (null != templateInstance) templateInstance.dataContext = v;
        repaint();
        return v;
    }

    public function new() {
        super();
    }

    override public function paint(size: PaintDimension): IntDimension {
        return if (null != templateInstance) templateInstance.paint(size) else super.paint(size);
    }
}
