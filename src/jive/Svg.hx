package jive;

import format.SVG;
import jive.geom.IntDimension;
import jive.geom.MetricDimension;
import openfl.display.DisplayObject;
import openfl.display.Shape;

class Svg extends Component {

    public var generateContent: Void -> String;

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

    override public function paint(size: MetricDimension): IntDimension {
        if (needsPaint) {
            needsPaint = false;
            shape.graphics.clear();

            //Draw transparent rectangle to prevent glitches during animations
            shape.graphics.beginFill(0,0);
            shape.graphics.drawRect(0, 0, absoluteWidth, absoluteHeight);
            shape.graphics.endFill();

            if (null != generateContent) _content = generateContent();
            new SVG(content).render(shape.graphics);
        }
        super.paint(size);
        return new IntDimension(Std.int(displayObject.width), Std.int(displayObject.height));
    }
}
