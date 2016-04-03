package jive;

interface Container {
    private var children: Array<Component>;
    public var numChildren(default, null): Int;

    public function append(c: Component): Void;
    public function insert(index: Int, c: Component): Void;
    public function remove(c: Component): Void;
    public function removeAt(index: Int): Void;
    public function removeAll(): Void;
}