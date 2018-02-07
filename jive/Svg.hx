package jive;


import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import format.SVG;


class Svg extends org.aswing.Component {

    public var generateContent:Void -> String;

    /**
    * The content property is ignored if the generateContent function is set.
    **/
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

    override private function paint(b:IntRectangle): Void {
        super.paint(b);

        //Draw transparent rectangle to prevent glitches during animations
        graphics.beginFill(0, 0);
        graphics.drawRect(b.x, b.y, b.width, b.height);
        graphics.endFill();

        if (null != generateContent) _content = generateContent();
        new SVG(content).render(graphics);

        trace(b);
        trace(content);
    }

    override public function getPreferredSize(): IntDimension {
        if (null != generateContent) _content = generateContent();
        var data = new SVG(content).data;
        return new IntDimension(Std.int(data.width), Std.int(data.height));
    }
}
