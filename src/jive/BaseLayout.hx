package jive;

class BaseLayout extends Component implements Container {
    private var children: Array<Component>;
    public var numChildren(default, null): Int;

    private function new() {
        super();

        children = new Array<Component>();
        numChildren = 0;
    }

    public function append(c: Component): Void {
        children.push(c);
        numChildren++;
    }

    public function insert(index: Int, c: Component): Void {
        children.insert(index, c);
        numChildren++;
    }

    public function remove(c: Component): Void {
        if (children.remove(c))
            numChildren--;
    }

    public function removeAt(index: Int): Void {
        numChildren = children.splice(index, 1).length;
    }

    public function removeAll(): Void {
        children.splice(0, -1);
        numChildren = 0;
    }
}