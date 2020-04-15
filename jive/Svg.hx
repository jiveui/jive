package jive;


import openfl.utils.Assets;
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
        revalidate();
        repaint();
        return v;
    }

    public var asset(default, set): String;
    private function set_asset(v: String): String {
        asset = v;
        _content = null;
        revalidate();
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

        updateContent();

        if (null != content)
            new SVG(content).render(graphics, 0, 0, preferredSize.width, preferredSize.height);
    }
    override public function countPreferredSize(): IntDimension {
        updateContent();
        if (null != content) {
            var data = new SVG(content).data;
            return new IntDimension(Std.int(data.width), Std.int(data.height));
        } else {
            return new IntDimension(0, 0);
        }
    }

    private function updateContent() {
        if (null != generateContent) _content = generateContent();
        if (null == content && asset != null) {
            _content = Assets.getText(asset);
        }
    }
}
