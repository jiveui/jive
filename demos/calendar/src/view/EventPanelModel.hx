package view;
import bindx.IBindable;
import haxe.Timer;
class EventPanelModel implements IBindable {
    @bindable public var columns: Int;
    @bindable public var notes: String;

    public function new() {
        columns = 0;
        notes = "Hello world!!!";
        var timer: Timer = new Timer(50);
        timer.run = function() {
            if (columns < 30) {
                columns += 1;
            } else {
                columns = 0;
            }
        }
    }
}