package jive;

import openfl.display.Sprite;
import openfl.text.TextField;

import jive.geom.IntDimension;
import jive.geom.DimensionRequest;
import jive.Color;
import jive.geom.Metric;

class Label extends Component {

    private var textField: TextField;

    public var text(get, set): String;
    private var _text:String;
    private function get_text(): String { return _text; }
    private function set_text(v: String): String { 
        if (_text != v) {
            _text = v;
            textField.text = text;
            repaint();
        }
        return v;
    }


    public function new(?text:String = "") {
        super();

        textField = new TextField();
        this.text = text;

        sprite.addChild(textField);
    }


	override public function paint(size: IntDimension) {
        if (needsPaint) {
            width = Metric.absolute(Std.int(textField.textWidth));
            height = Metric.absolute(Std.int(textField.textHeight));
        }

        super.paint(size);
    } 
}