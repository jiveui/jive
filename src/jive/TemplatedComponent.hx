package jive;

import jive.geom.IntDimension;

class TemplatedComponent extends Container {

    private var templateInstance: Component;

    public var template(get, set): Class<Dynamic>;
    private var _template: Class<Dynamic>;
    private function get_template(): Class<Dynamic> { return _template; }
    private function set_template(v: Class<Dynamic>): Class<Dynamic> {
        _template = v;
        if (null != templateInstance) { children.remove(templateInstance); }
        templateInstance = Type.createEmptyInstance(v).as(Component);
        if (null != viewModel) { templateInstance.dataContext = viewModel; }
        children.add(templateInstance);
        return v;
    }

    public var viewModel(get, set): ViewModel;
    private var _viewModel: ViewModel;
    private function get_viewModel(): ViewModel { return _viewModel; }
    private function set_viewModel(v: ViewModel): ViewModel {
        _viewModel = v;
        if (null != templateInstance) templateInstance = viewModel;
        return v;
    }

    public function new() {
        super();
    }

    override public function calcSize(): IntDimension {
        return if (null != templateInstance) templateInstance.calcSize() else new IntDimension(0,0);
    }
}
