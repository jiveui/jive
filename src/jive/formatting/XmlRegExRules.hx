package jive.formatting;

import flash.text.TextFormat;

using jive.tools.TextFormatTools;

class XmlRegExRules extends RegExRules{
    public function new() {
        super();
        rules.push(new RegExRule(
            new EReg("\\s([^ ]+)=", "mg"),
            function(begin, end, textComponent) {
                var tf: TextFormat = textComponent.defaultTextFormat.clone();
                tf.color = 0x2980b9;
                textComponent.setTextFormat(tf, begin, end-1);
            }));
    }
}
