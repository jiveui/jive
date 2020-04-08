package jive.plaf.flat;

import jive.Picker;
import org.aswing.Component;
import org.aswing.plaf.BaseComponentUI;
import org.aswing.LookAndFeel;
import org.aswing.AsWingUtils;

class FlatPickerUI extends BaseComponentUI {

    public function new() {
        super();
    }

    private function getPropertyPrefix():String{
        return "Picker.";
    }

    override public function installUI(c:Component):Void{
        installDefaults(AsWingUtils.as(c,Picker));
    }

    override public function uninstallUI(c:Component):Void{
        uninstallDefaults(AsWingUtils.as(c,Picker));
    }

    private function installDefaults(dp:Picker):Void{
        var pp:String= getPropertyPrefix();
        LookAndFeel.installColorsAndFont(dp, pp);
        LookAndFeel.installBorderAndBFDecorators(dp, pp);
    }

    private function uninstallDefaults(dp:Picker):Void{
        LookAndFeel.uninstallBorderAndBFDecorators(dp);
    }
}
