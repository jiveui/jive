package jive;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import jive.geom.*;
import jive.Font;
import jive.Jive;

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


    public var wordWrap(default, set): Bool;
    private var _wordWrap:Bool;
    private function get_wordWrap(): Bool { return _wordWrap; }
    private function set_wordWrap(v: Bool): Bool { 
        if (_wordWrap != v) {
            _wordWrap = v;
            repaint();
        }
        return v;
    }


    public var color(default, set): Int;
    private function set_color(v: Int): Int {
        color = v;
        repaint();
        return v;
    }


    public function new(?text:String = "") {
        super();

        textField = new TextField();
        textField.selectable = false;

        this.text = text;
        this.font = Jive.theme.defaultFont.clone();
        this.color = Jive.theme.defaultTextColor;

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
            textField.textColor = color;
            font.apply(textField);

            if (_wordWrap) {          
                textField.wordWrap = true;
                textField.width = size.width;
                textField.height = textField.textHeight + 3;
            } else {
                textField.width = textField.textWidth;
                textField.height = textField.textHeight;
            }
           
            // Do we really need next 2 lines?
            // width = Metric.absolute(Std.int(textField.width)); 
            // height = Metric.absolute(Std.int(textField.height));

            size.width = Std.int(textField.width);
            size.height = Std.int(textField.height);
        }

        super.paint(size);
    } 
}