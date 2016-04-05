package jive;

class TemplatedComponent extends Container {

    public var template: Class<Dynamic>;
    public var viewModel: ViewModel;

    public function new() {
        super();
    }
}
