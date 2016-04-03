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
        c.parent = this;
        update();
    }

    public function insert(index: Int, c: Component): Void {
        children.insert(index, c);
        numChildren++;
        c.parent = this;
        update();
    }

    public function remove(c: Component): Void {
        if (children.remove(c)) {
            numChildren--;
            c.parent = null;
            update();
        }
    }

    public function removeAt(index: Int): Void {
        if (index >= 0 && index < children.length) {
            children[index].parent = null;
            numChildren = children.splice(index, 1).length;
            update();
        }
    }

    public function removeAll(): Void {
        if (numChildren > 0) {
            for (child in children) {
                child.parent = null;
            }
            children.splice(0, -1);
            numChildren = 0;
            update();
        }
    }

    /**
    * destroy all children
    **/
    public override function dispose() {
        for (child in children) {
            child.dispose();
        }

        removeAll();
    }

    /**
    * recalculate all sizes and positions for children
    **/
    public override function reposition() {}

    /**
    * repaint all children
    **/
    public override function repaint() {}
}