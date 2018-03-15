package jive;

@:bindable
class Command implements bindx.IBindable {
    public function action(): Void {};
    public var enabled: Bool = true;
}
