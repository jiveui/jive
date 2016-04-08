package jive;

import jive.geom.IntDimension;

using jive.tools.TypeTools;

typedef Constructible = {
    public function new():Void;
}

@:generic
class TemplatedComponent<T: (Constructible, Component, DataContextControllable<V>), V: (Constructible, ViewModel)> extends Container {

    public var templateInstance(default, null): T;

    public var template(get, set): Class<T>;
    private var _template: Class<T>;
    private function get_template(): Class<T> { return _template; }
    private function set_template(v: Class<T>): Class<T> {
        _template = v;
        if (v != Type.getClass(templateInstance)) {
            if (null != templateInstance) { children.remove(templateInstance); }
            templateInstance = Type.createInstance(v, []);
            if (null != templateModel) { templateInstance.dataContext = templateModel; }
            children.add(templateInstance);
        }
        return v;
    }

    public var templateModel(get, set): V;
    private var _templateModel: V;
    private function get_templateModel(): V { return _templateModel; }
    private function set_templateModel(v: V): V {
        _templateModel = v;
        if (null != templateInstance) templateInstance.dataContext = v;
        return v;
    }

    public function new() {
        super();
    }


}
