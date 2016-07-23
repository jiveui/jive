package jive;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

import jive.geom.IntDimension;
import jive.geom.DimensionRequest;
import jive.geom.Metric;
import jive.Font;

class Label extends Component {

    private var textField: TextField;

    public var font(default, set): Font;
    private function set_font(v: Font): Font {
        font = v;
        repaint();
        return v;
    }


    public var fontName(default, set): String;
    private function get_fontName(): String {
        return font.name;
    }
    private function set_fontName(v: String): String {
        font.name = v;
        repaint();
        return v;
    }


    public var fontSize(get, set): Int;
    private function get_fontSize(): Int {
        return font.size;
    }
    private function set_fontSize(v: Int): Int {
        font.size = v;
        repaint();
        return v;
    }


    public var text(get, set): String;
    private var _text:String;
    private function get_text(): String { return _text; }
    private function set_text(v: String): String { 
        if (_text != v) {
            _text = v;
            textField.text = text;
            textField.name = text;
            repaint();
        }
        return v;
    }


    public function new(?text:String = "") {
        super();

        textField = new TextField();
        textField.selectable = false;

        this.text = text;
        this.font = jive.Jive.theme.defaultFont.clone();

        sprite.addChild(textField);
    }


    override public function calcPreferredSize(request: DimensionRequest): IntDimension {
        var tf = new TextField();

        tf.text = textField.text;
        tf.setTextFormat(textField.getTextFormat());
        
        return new IntDimension(Std.int(tf.textWidth), Std.int(tf.textHeight));
    }


	override public function paint(size: IntDimension) {
        if (needsPaint) {
            font.apply(textField);

            // Do we really need next 2 lines?
            width = Metric.absolute(Std.int(textField.textWidth)); 
            height = Metric.absolute(Std.int(textField.textHeight));

            size.width = Std.int(textField.textWidth);
            size.height = Std.int(textField.textHeight);

            textField.width = textField.textWidth;
            textField.height = textField.textHeight;
        }

        super.paint(size);
    } 
}