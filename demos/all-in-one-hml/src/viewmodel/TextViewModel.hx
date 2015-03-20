package viewmodel;

import bindx.IBindable;

class TextViewModel implements IBindable {

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
        return '$p bites $v.';
    }
    private function set_predatorVictimSentence(v: String): String { return v; }

    public function new() {}
}
