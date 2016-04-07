package jive;

import jive.geom.IntDimension;

using jive.tools.TypeTools;

class TemplatedComponent<T: (Component, DataContextControllable<V>), V> extends Container {

    private var templateInstance: T;

    public var template(get, set): Class<T>;
    private var _template: Class<T>;
    private function get_template(): Class<T> { return _template; }
    private function set_template(v: Class<T>): Class<T> {
        _template = v;
        if (null != templateInstance) { children.remove(templateInstance); }
        templateInstance = Type.createEmptyInstance(v);
        if (null != templateModel) { templateInstance.dataContext = templateModel; }
        children.add(templateInstance);
        return v;
    }

    public var templateModel(get, set): V;
    private var _templateModel: V;
    private function get_templateModel(): V { return _templateModel; }
    private function set_templateModel(v: V): V {
        _templateModel = v;
        if (null != templateInstance) templateInstance.dataContext = templateModel;
        return v;
    }

    public function new() {
        super();
        templateInstance = Type.createEmptyInstance(Type.getClass(templateInstance));
        templateModel = Type.createEmptyInstance(Type.getClass(templateModel));
    }

    override private function calcPreferredSize(): IntDimension {
        return if (null != templateInstance) templateInstance.calcPreferredSize() else new IntDimension(0,0);
    }

    override private function set_paintSize(v: IntDimension): IntDimension {
        if (null != templateInstance) templateInstance.paintSize = v;
        return super.set_paintSize(v);
    }
}
