package viewmodel;

import org.aswing.VectorListModel;
import jive.BaseCommand;
import jive.Command;
import bindx.IBindable;

class MainViewModel implements IBindable {

    @bindable public var buttonsLog: String = "";

    @bindable public var defaultButtonCommand: Command;
    @bindable public var basicButtonCommand: Command;
    @bindable public var messagesButtonCommand: Command;
    @bindable public var weatherButtonCommand: Command;
    @bindable public var calendarButtonCommand: Command;

    @bindable public var menuSelectedIndex: Int;
    @bindable public var menuListModel: VectorListModel;

    @bindable public var predator(get, set): String;
    private var _predator: String;
    private function get_predator(): String {
        return _predator;
    }
    private function set_predator(v:String): String {
        _predator = v;
        bindx.Bind.notify(this.predatorVictimSentence);
        return v;
    }

    @bindable public var victim(get, set): String;
    private var _victim: String;
    private function get_victim(): String {
        return _victim;
    }
    private function set_victim(v:String): String {
        _victim = v;
        bindx.Bind.notify(this.predatorVictimSentence);
        return v;
    }

    @bindable public var predatorVictimSentence(get, set): String;
    private function get_predatorVictimSentence(): String {
        var p = if (null == predator || '' == predator) "Lion" else predator;
        var v = if (null == victim || '' == victim) "Antelope" else victim;
        return '$p bytes $v.';
    }
    private function set_predatorVictimSentence(v: String): String { return v; }

    public function new() {

        var log = function(type) {
            buttonsLog += 'The $type button was pressed.\n';
        }

        defaultButtonCommand = new BaseCommand(function() { log("Default"); });
        basicButtonCommand = new BaseCommand(function() { log("Basic"); });
        messagesButtonCommand = new BaseCommand(function() { log("Messages"); });
        weatherButtonCommand = new BaseCommand(function() { log("Weather"); });
        calendarButtonCommand = new BaseCommand(function() { log("Calendar"); });

        menuListModel = new VectorListModel(["Buttons", "Text fields"]);
        menuSelectedIndex = 0;
    }
}
