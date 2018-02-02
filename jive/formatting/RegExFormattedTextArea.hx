package jive.formatting;

import org.aswing.JTextArea;

class RegExFormattedTextArea extends JTextArea {

    public var rules(get, set): RegExRules;
    private var _rules: RegExRules;
    private function get_rules(): RegExRules { return _rules; }
    private function set_rules(v: RegExRules): RegExRules {
        _rules = v;
        reformat();
        return v; 
    }

    public function new() { super(); }

    private override function set_text(v: String): String {
        super.set_text(v);
        reformat();
        return v;
    }

    private function reformat() {
        updateUI();
        for (r in rules.rules) {
            var pos = 0;
            while (r.regex.matchSub(text, pos)) {
                var begin = r.regex.matchedPos().pos;
                var end = r.regex.matchedPos().pos + r.regex.matchedPos().len;
                r.action(begin, end, this);
                pos =  end + 1;
            }
        }
    }
}
