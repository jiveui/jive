package jive.plaf.flat;

import org.aswing.AsWingUtils;
import org.aswing.JCheckBox;
import org.aswing.AbstractButton;
import org.aswing.plaf.basic.BasicRadioButtonUI;

class FlatCheckBoxUI extends BasicRadioButtonUI {

	public function new() {
		super();
	}
	
    override private function getPropertyPrefix():String{
        return "CheckBox.";
    }

    override private function installDefaults(b:AbstractButton):Void{
        super.installDefaults(b);
        var checkBox: JCheckBox = AsWingUtils.as(b, JCheckBox);
        if (null == checkBox) return;
        checkBox.tickColor = getColor(getPropertyPrefix() + "tickColor");
        checkBox.iconTextGap = getInt(getPropertyPrefix() + "textGap");
    }
}