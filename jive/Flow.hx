package jive;

import jive.geom.DimensionRequest;
import jive.geom.IntRequest;
import jive.geom.DimensionRequest;
import jive.geom.IntDimension;

class Flow extends Container {

    public var orientation: Orientation;

    public function new() {
        super();
        orientation = Orientation.vertical;
    }

    override private function layout(size: IntDimension) {
        if (needsLayout) {
            needsLayout = false;
            var x:Float = 0.0;
            var y:Float = 0.0;
            var sizeRequest = new DimensionRequest(IntRequest.int(size.width), IntRequest.int(size.height));
            for (child in children) {
                var insets = child.margin.toInsets(child);
                child.updateSpriteTransformationMatrix(Std.int(x + insets.left), Std.int(y + insets.top));

                var size = child.getPreferredSize(sizeRequest);
                if (orientation == Orientation.vertical) {
                    y += size.height;
                    y += insets.bottom;
                } else {
                    x += size.width;
                    x += insets.right;
                }

                trace(size);
                trace(x);
                trace(y);
            }
        }
    }

    override private function calcPaintComponentSize(c: Component, size: IntDimension): IntDimension {
        return return c.getPreferredSize(new DimensionRequest(IntRequest.int(size.width), IntRequest.int(size.height)));
    }

    override public function calcPreferredSize(request: DimensionRequest): IntDimension {
        var w = 0.0;
        var h = 0.0;
        var sizeRequest = new DimensionRequest(IntRequest.auto, IntRequest.auto);
        for (child in children) {
            var insets = child.margin.toInsets(child);
            var size = child.getPreferredSize(sizeRequest);
            if (orientation == Orientation.vertical) {
                w = Math.max(w, insets.left + size.width + insets.right);
                h += insets.top + size.height + insets.bottom;
            } else {
                w += insets.left + size.width + insets.right;
                h = Math.max(h, insets.top + size.height + insets.bottom);
            }
        }
        trace(new IntDimension(Std.int(w), Std.int(h)));
        return new IntDimension(Std.int(w), Std.int(h));
    }
}