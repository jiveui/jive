package jive;

import format.SVG;
import jive.geom.IntDimension;
import jive.geom.PaintDimension;
import openfl.display.DisplayObject;
import openfl.display.Shape;

class Svg extends Component {
    var shape: Shape;

    public var content(get, set): String;
    private var _content: String;
    private function get_content(): String { return _content; }
    private function set_content(v: String): String {
        _content = v;
        repaint();
        return v;
    }

    public function new() {
        super();
        displayObject;
    }

    override private function createDisplayObject(): DisplayObject {
        shape = new Shape();
        return shape;
    }

    override public function paint(size: PaintDimension): IntDimension {
        if (needsPaint) {
            needsPaint = false;
            shape.graphics.clear();
            new SVG(content).render(shape.graphics);
        }
        return new IntDimension(Std.int(displayObject.width), Std.int(displayObject.height));
    }
}
