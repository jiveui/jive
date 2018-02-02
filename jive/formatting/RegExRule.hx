package jive.formatting;

import org.aswing.JTextComponent;

class RegExRule {
    public var regex: EReg;
    public var action: Int -> Int -> JTextComponent -> Void;

    public function new(regex: EReg, action: Int -> Int -> JTextComponent -> Void) {
        this.regex = regex;
        this.action = action;
    }
}
