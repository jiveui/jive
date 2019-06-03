package demo.viewmodel;

import openfl.Assets;
import jive.BaseCommand;
import jive.Command;
class FrameViewModel extends ComboBoxViewModel {

    @:bindable public var isLoginDialogShowed: Bool;
    @:bindable public var openLoginDialogCommand: Command;

    public function new() {
        super();
        xmlSource = Assets.getText("assets/source/FrameView.hml");
        haxeSource = Assets.getText("assets/source/FrameViewModel.hx");
        isLoginDialogShowed = false;
        openLoginDialogCommand = new BaseCommand(function() { isLoginDialogShowed = true; });
    }
}
