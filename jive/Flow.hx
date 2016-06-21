package jive;

import jive.geom.IntDimension;

class Flow extends Container {

    public var orientation: Orientation;

    public function new() {
        super();
        orientation = Orientation.vertical;
    }

    override private function layout() {
        if (needsLayout) {
            needsLayout = false;
            var x:Float = 0.0;
            var y:Float = 0.0;
            for (child in children) {
                var insets = child.margin.toInsets(child);
                child.sprite.x = x + insets.left;
                child.sprite.y = y + insets.top;
                if (orientation == Orientation.vertical) {
                    y += child.preferredSize.value.height;
                    y += insets.bottom;
                } else {
                    x += child.preferredSize.value.width;
                    x += insets.right;
                }
            }
        }
    }

    override private function calcPaintComponentSize(c: Component, size: IntDimension): IntDimension {
        return new IntDimension(c.preferredSize.value.width, c.preferredSize.value.width);
    }

    override private function calcPreferredSize(): IntDimension {
        var w = 0.0;
        var h = 0.0;
        for (child in children) {
            var insets = child.margin.toInsets(child);
            if (orientation == Orientation.vertical) {
                w = Math.max(w, insets.left + child.preferredSize.value.width + insets.right);
                h += insets.top + child.preferredSize.value.height + insets.bottom;
            } else {
                w += insets.left + child.preferredSize.value.width + insets.right;
                h = Math.max(h, insets.top + child.preferredSize.value.height + insets.bottom);
            }
        }
        return new IntDimension(Std.int(w), Std.int(h));
    }
}