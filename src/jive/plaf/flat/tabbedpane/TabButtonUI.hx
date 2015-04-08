package jive.plaf.flat.tabbedpane;

import org.aswing.Component;
import org.aswing.AsWingUtils;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicButtonUI;

class TabButtonUI extends BasicButtonUI {
    public function new() { super(); }

    override private function getPropertyPrefix():String{
        return "TabButton.";
    }

    override public function installUI(c:Component):Void{
        super.installUI(c);

        var tb: FlatTabButton = cast c;

        var pp:String= getPropertyPrefix();

        if(null == tb.normalColor || Std.is(tb.normalColor , UIResource)) {
            tb.normalColor = (getColor(pp + "normalColor"));
        }

        if(null == tb.selectedColor || Std.is(tb.selectedColor , UIResource)) {
            tb.selectedColor = (getColor(pp + "selectedColor"));
        }

        if(null == tb.rolloverColor || Std.is(tb.rolloverColor , UIResource)) {
            tb.rolloverColor = (getColor(pp + "rolloverColor"));
        }

        if(null == tb.borderColor || Std.is(tb.borderColor , UIResource)) {
            tb.borderColor = (getColor(pp + "borderColor"));
        }
    }
}
