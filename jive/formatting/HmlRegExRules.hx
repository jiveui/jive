package jive.formatting;

import flash.text.TextFormat;

using jive.tools.TextFormatTools;

class HmlRegExRules extends XmlRegExRules {
    public function new() {
        super();
        rules.push(new RegExRule(
            new EReg("({Binding[^}]+})", "gm"),
            function(begin, end, textComponent) {
                var tf: TextFormat = textComponent.defaultTextFormat.clone();
                tf.color = 0x27ae60;
                textComponent.setTextFormat(tf, begin, end);
            }));

    }
}
