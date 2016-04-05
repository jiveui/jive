package jive;

@:bindable
class DataBindingModel extends ViewModel {
    public var s: String = "initial";
    public var i: Int = 555;
    public function new() {
        super();
    }
}
