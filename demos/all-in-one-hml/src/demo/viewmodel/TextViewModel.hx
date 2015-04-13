package demo.viewmodel;

import openfl.Assets;
import bindx.IBindable;

class TextViewModel implements IBindable implements Spotable {

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

    @bindable public var prey(get, set): String;
    private var _prey: String;
    private function get_prey(): String {
        return _prey;
    }
    private function set_prey(v:String): String {
        _prey = v;
        bindx.Bind.notify(this.predatorVictimSentence);
        return v;
    }

    @bindable public var predatorVictimSentence(get, set): String;
    private function get_predatorVictimSentence(): String {
        var p = if (null == predator || '' == predator) "Lion" else predator;
        var v = if (null == prey || '' == prey) "Antelope" else prey;
        return '$p bites $v.';
    }
    private function set_predatorVictimSentence(v: String): String { return v; }

    @bindable public var xmlSource: String = Assets.getText("assets/source/TextView.xml");
    @bindable public var haxeSource: String = Assets.getText("assets/source/TextViewModel.hx");

    @bindable public var selectedSpotIndex(get, set): Int;
    private var _selectedSpotIndex: Int;
    private function get_selectedSpotIndex(): Int { return _selectedSpotIndex; }
    private function set_selectedSpotIndex(v: Int): Int {
        _selectedSpotIndex = v;
        return v;
    }
    public function new() {}
}
