package jive;

import jive.geom.DimensionRequest;
import format.SVG;
import jive.geom.IntDimension;

class Svg extends Component {

    public var generateContent:Void -> String;

    public var content(get, set):String;
    private var _content:String;

    private function get_content():String { return _content; }

    private function set_content(v:String):String {
        _content = v;
        repaint();
        return v;
    }

    public function new() {
        super();
    }

    override public function doPaint(size: IntDimension) {

        sprite.graphics.clear();

        //Draw transparent rectangle to prevent glitches during animations
        sprite.graphics.beginFill(0, 0);
        sprite.graphics.drawRect(0, 0, size.width, size.height);
        sprite.graphics.endFill();

        if (null == content && null != generateContent) _content = generateContent();
        new SVG(content).render(sprite.graphics);

        super.doPaint(size);
    }

    override public function calcPreferredSize(request: DimensionRequest): IntDimension {
        if (null != generateContent) _content = generateContent();
        var data = new SVG(content).data;
        return new IntDimension(Std.int(data.width), Std.int(data.height));
    }
}
