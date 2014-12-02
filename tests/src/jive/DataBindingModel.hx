package jive;

import bindx.IBindable;

class DataBindingModel implements IBindable {
    @bindable public var s: String = "initial";
    @bindable public var i: Int = 555;
    public function new() {}
}
