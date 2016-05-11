package jive;

class Scroll extends Container {

    public function new() {
        super();
    }

    override public function append(child:Component) {
        if (children.length > 0) {
            remove(children.get(0));
        }
        children.add(child);
        child.parent = this;
        displayObjectContainer.addChild(child.displayObject);
        child.repaint();
    }

    override public function insert(index:Int, child:Component) {
        append(child);
    }

    override public function remove(child:Component) {
        if (children.get(0) == child) {
            children.remove(child);
            displayObjectContainer.removeChild(child.displayObject);
            child.parent = null;
            repaint();
        }
    }
}
