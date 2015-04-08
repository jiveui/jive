package viewmodel;

import openfl.Assets;
import jive.BaseCommand;
import jive.Command;
import bindx.IBindable;

class ButtonsViewModel implements IBindable {

    @bindable public var buttonsLog: String = "";

    @bindable public var defaultButtonCommand: Command;
    @bindable public var basicButtonCommand: Command;
    @bindable public var messagesButtonCommand: Command;
    @bindable public var weatherButtonCommand: Command;
    @bindable public var calendarButtonCommand: Command;

    @bindable public var xmlSource: String = Assets.getText("declarations/view/ButtonsView.xml");
    @bindable public var haxeSource: String = Assets.getText("src/viewmodel/ButtonsViewModel.hx");

    public function new() {

        var log = function(type) {
            buttonsLog += 'The $type button was pressed.\n';
        }

        defaultButtonCommand = new BaseCommand(function() { log("Default"); });
        basicButtonCommand = new BaseCommand(function() { log("Basic"); });
        messagesButtonCommand = new BaseCommand(function() { log("Messages"); });
        weatherButtonCommand = new BaseCommand(function() { log("Weather"); });
        calendarButtonCommand = new BaseCommand(function() { log("Calendar"); });
    }
}
