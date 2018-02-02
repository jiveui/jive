package jive.formatting;

import flash.text.TextFormat;

using jive.tools.TextFormatTools;

class HaxeRegExRules extends RegExRules {
    public function new() {
        super();
        rules.push(new RegExRule(
            new EReg("(public|private|override|@bindable)", "gm"),
            function(begin, end, textComponent) {
                var tf: TextFormat = textComponent.defaultTextFormat.clone();
                tf.color = 0x27ae60;
                textComponent.setTextFormat(tf, begin, end);
            }));
        rules.push(new RegExRule(
                new EReg("var|function|class|import", "mg"),
                function(begin, end, textComponent) {
                    var tf: TextFormat = textComponent.defaultTextFormat.clone();
                    tf.color = 0x2980b9;
                    textComponent.setTextFormat(tf, begin, end);
            }));

    }
}
