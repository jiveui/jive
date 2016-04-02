package jive;

class DataBindingModel extends ViewModel {
    @bindable public var s: String = "initial";
    @bindable public var i: Int = 555;
    public function new() {}
}
