package jive.state;

import haxe.ds.StringMap;

interface Statefull {
    var state: String;
    var states: StringMap<State>;
}
