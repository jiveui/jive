package demo.viewmodel;

import bindx.IBindable;

class MainViewModel implements IBindable {

    @:bindable public var demoVM: DemoViewModel = new DemoViewModel();
    public function new() {}
}
