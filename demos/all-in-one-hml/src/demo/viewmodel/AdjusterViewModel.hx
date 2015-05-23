package demo.viewmodel;

import openfl.Assets;
import jive.BaseCommand;
import jive.Command;
class AdjusterViewModel extends ComboBoxViewModel {

    @bindable public var isLoginDialogShowed: Bool;
    @bindable public var openLoginDialogCommand: Command;

    @bindable public var iphoneQuantity(default, set): Int;
    private function set_iphoneQuantity(v: Int): Int { iphoneQuantity = v; bindx.Bind.notify(this.totalCost); return v;}

    @bindable public var galaxyQuantity(default, set): Int;
    private function set_galaxyQuantity(v: Int): Int { galaxyQuantity = v; bindx.Bind.notify(this.totalCost); return v;}

    @bindable public var lumiaQuantity(default, set): Int;
    private function set_lumiaQuantity(v: Int): Int { lumiaQuantity = v; bindx.Bind.notify(this.totalCost); return v;}

    @bindable public var totalCost(get, set):String;
    private function get_totalCost(): String {
        var cost: Float = 812.98 * iphoneQuantity + 1019.99 * galaxyQuantity + 342.49 * lumiaQuantity;
        return "$" + Std.string(Math.fround(cost * 100) / 100);
    }
    private function set_totalCost(v: String): String { return v; }

    public function new() {
        super();
        xmlSource = Assets.getText("assets/source/AdjusterView.xml");
        haxeSource = Assets.getText("assets/source/AdjusterViewModel.hx");
        isLoginDialogShowed = false;
        openLoginDialogCommand = new BaseCommand(function() { isLoginDialogShowed = true; });

        iphoneQuantity = 1;
        lumiaQuantity = 1;
        galaxyQuantity = 1;
    }
}
