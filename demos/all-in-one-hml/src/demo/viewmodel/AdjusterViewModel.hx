package demo.viewmodel;

import openfl.Assets;
import jive.BaseCommand;
import jive.Command;
class AdjusterViewModel extends ComboBoxViewModel {

    @bindable public var isLoginDialogShowed: Bool;
    @bindable public var openLoginDialogCommand: Command;

    public function new() {
        super();
        xmlSource = Assets.getText("assets/source/AdjusterView.xml");
        haxeSource = Assets.getText("assets/source/AdjusterViewModel.hx");
        isLoginDialogShowed = false;
        openLoginDialogCommand = new BaseCommand(function() { isLoginDialogShowed = true; });
    }
}
