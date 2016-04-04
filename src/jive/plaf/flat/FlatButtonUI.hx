package jive.plaf.flat;

import org.aswing.AbstractButton;
import org.aswing.plaf.basic.BasicButtonUI;

/**
 * Flat Button implementation.
 */
class FlatButtonUI extends BasicButtonUI{
	public function new() { super(); }

    override private function installDefaults(b:AbstractButton):Void{
        super.installDefaults(b);
        if(!b.iconTextGapSet) {
            b.iconTextGap = getInt(getPropertyPrefix() + "textGap");
        }
    }
}